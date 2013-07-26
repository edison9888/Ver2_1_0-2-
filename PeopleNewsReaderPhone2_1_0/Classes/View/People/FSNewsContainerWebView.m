//
//  FSNewsContainerWebView.m
//  PeopleNewsReaderPhone
//
//  Created by Xu dandan on 12-10-26.
//
//

#import "FSNewsContainerWebView.h"
#import "FSNewsDitailObject.h"
#import "FSNewsDitailPicObject.h"
#import "FSCommonFunction.h"
#import <QuartzCore/QuartzCore.h>
#import "FSCommentObject.h"

#import "FSNetworkDataManager.h"

//评论块
#define CONTENTWEBVIEW_COMMENT_BLOCK @"<div class='comment_block_even'>" \
"<div class='comment_title_row'>" \
"<span class='comment_nickname'>%@</span><span class='comment_datetime'>%@</span>" \
"</div>" \
"<div class='comment_body'>%@</div>" \
"<div class='comment_comefrom'>%@</div>" \
"</div>" \
"<HR class='comment_HR' width='100%'>"

//管理员回复块
#define CONTENTWEBVIEW_COMMENT_RE_BLOCK @"<div class='comment_block_even'>" \
"<div class='comment_title_row'>" \
" <a class='photo_admin'><img src='Comment_talk@2x.png' width=20 height=20 /></a> <span class='comment_admin'>%@</span><span class='comment_datetime'>%@</span>" \
"</div>" \
"<div class='comment_REbody'>%@</div>" \
"<div class='comment_comefrom'>%@</div>" \
"</div>" \
"<HR class='comment_REHR' width='100%'>"



//评论描述
#define CONTENTWEBVIEW_COMMENT_TITLE_DESC @"<div id='comment_desc'>" \
"<span id='comment_title_desc'>网友热评</span>" \
"</div>"

#define CONTENTWEBVIEW_COMMENT_TITLE_NODESC @"<div id='comment_desc'>" \
"<span id='comment_title_desc'>暂无评论</span>" \
"</div>"

//更多评论按钮
#define CONTENTWEBVIEW_COMMENT_MORE @"<div id='comment_more_list'>" \
"<a href='more://comment.list'><button class='comment_more_list' title='更多'>查看更多评论</button></a>" \
"</div>"

#define CONTENTWEBVIEW_COMMENT_MORE_LINK @"more://comment.list"



@implementation FSNewsContainerWebView

@synthesize height = _height;
@synthesize isSizeChange = _isSizeChange;
@synthesize touchEvenKind = _touchEvenKind;
@synthesize hasebeenLoad = _hasebeenLoad;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/



-(void)doSomethingAtDealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:FSNETWORKDATA_MANAGER_END_DOWNLOADING_ERROR_NOTIFICATION object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:FSNETWORKDATA_MANAGER_END_DOWNLOADING_COMPLETE_NOTIFICATION object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:FSNETWORKDATA_MANAGER_BEGIN_DOWNLOADING_NOTIFICATION object:nil];
    
    [_webContent setDelegate:NULL];
    if ([_webContent isLoading]){
        [_webContent stopLoading];
    }
	
    [_webContent release];
    
}

-(void)doSomethingAtInit{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginDownloading:) name:FSNETWORKDATA_MANAGER_BEGIN_DOWNLOADING_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endDownloadingComplete:) name:FSNETWORKDATA_MANAGER_END_DOWNLOADING_COMPLETE_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endDownloadingError:) name:FSNETWORKDATA_MANAGER_END_DOWNLOADING_ERROR_NOTIFICATION object:nil];
    
    _height = 480.0f;
    _isSizeChange = NO;
    _hasebeenLoad = NO;
    _webContent = [[UIWebView alloc] initWithFrame:CGRectZero];
	[self addSubview:_webContent];
    _webContent.scrollView.delegate = self;
	_webContent.delegate = self;
    //webContent.userInteractionEnabled = YES;
	//_webContent.autoresizingMask = UIViewAutoresizingFlexibleHeight;
	_webContent.dataDetectorTypes = UIDataDetectorTypeNone;
    
    _adImageUrl = @"";//@"http://58.68.130.168/thumbs/640/320/data/newsimages/1_6_14_1/130312/F201303121363053500242313.jpg";
	
}


-(void)doSomethingAtLayoutSubviews{
    
    _webContent.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    //NSLog(@":::%@",NSStringFromCGRect(_webContent.frame));
    if (!_hasebeenLoad) {
        [self loadWebPageWithContent:nil];
    }
    
    
    //设置字体大小
   // [webContent stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('body_section').className='%@'", [self returnFontSizeName:self.fontSize]]];
    //FSLog(@"FSNewsContainerWebView doSomethingAtLayoutSubviews");
}

//****************************************************************************

- (void)loadWebPageWithContent:(NSString *)contentFile{
    
    _hasebeenLoad  = YES;
    FSNewsDitailObject *cobj = [self.data valueForKey:@"NewsContainerDAO"];
    _imageList = [self.data valueForKey:@"objectList"];
    
    NSObject *array = [self.data valueForKey:@"CommentListDAO"];
    self.objectList = (NSArray *)array;
    
    NSLog(@"self.objectList:%d",[self.objectList count]);
    NSString *templatePath;
    if ([_imageList count]>1) {
        //多图模板
        templatePath = [[NSBundle mainBundle] pathForResource:@"content_template" ofType:@"html"];//新闻显示模版
    }else{
        //单图模板
        templatePath = [[NSBundle mainBundle] pathForResource:@"content_template_onePIC" ofType:@"html"];//新闻显示模版
    }
    
    
	NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
	
    
    
    
    NSStringEncoding enc;
    NSString *templateString = [NSString stringWithContentsOfFile:templatePath usedEncoding:&enc error:NULL];
    
    
    if (cobj==nil) {
        templateString = [self replayString:templateString oldString:@"{{title}}" newString:@"此文章不存在"];
        templateString = [self replayString:templateString oldString:@"{{ptime}}" newString:@""];
        templateString = [self replayString:templateString oldString:@"{{source}}" newString:@""];
        templateString = [self replayString:templateString oldString:@"{{fontClass}}" newString:[self returnFontSizeName:0]];
        templateString = [self replayString:templateString oldString:@"{{body}}" newString:@""];
        //FSLog(@"templateString:%@",templateString);
    }
    else{
        templateString = [self replayString:templateString oldString:@"{{title}}" newString:cobj.title];
        
        
        NSString *timeStr;
        
        if ([cobj.date length]>3) {
            timeStr = [cobj.date substringToIndex:[cobj.date length]-3];
        }
        else{
            timeStr = cobj.date;
        }
        
        templateString = [self replayString:templateString oldString:@"{{ptime}}" newString:timeStr];
        
        templateString = [self replayString:templateString oldString:@"{{source}}" newString:cobj.source];
        templateString = [self replayString:templateString oldString:@"{{fontClass}}" newString:[self returnFontSizeName:0]];
        
        
        
        NSString *imageString = @"";
        if ([_imageList count]>0 && [self isDownloadPic]) {
            imageString = [self processBodyImages:imageString];
        }
        NSString *content = [cobj.content stringByReplacingOccurrencesOfString:@"\n\n" withString:@"<p>"];
        imageString = [NSString stringWithFormat:@"%@%@",imageString,content];
        if ([_adImageUrl length]>0) {
            //添加广告图片
            NSString *adString = [self processBodyADImages:nil];
            imageString = [NSString stringWithFormat:@"%@%@",imageString,adString];
        }
        
        templateString = [self replayString:templateString oldString:@"{{body}}" newString:imageString];
        NSString *commentListStr = @"";
        if ([self.objectList count]>0) {
            commentListStr = [self processCommentList:commentListStr];
            templateString = [self replayString:templateString oldString:@"{{commentList}}" newString:commentListStr];
        }
        else{
            templateString = [self replayString:templateString oldString:@"{{commentList}}" newString:CONTENTWEBVIEW_COMMENT_TITLE_NODESC];
        }
        
    }

    [_webContent loadHTMLString:templateString baseURL:baseURL];
    //UIFont *font = [UIFont fontWithName:@"" size:20];
    
    
}
-(BOOL)isDownloadPic{
    
    BOOL rest = NO;
    
    if (![[GlobalConfig shareConfig] isSettingDownloadPictureUseing2G_3G]) {
        rest = YES;
        return rest;
    }
    
    if ([[GlobalConfig shareConfig] isDownloadPictureUseing2G_3G]) {
        rest = YES;
    }
    else{
        if (!checkNetworkIsOnlyMobile()) {
            rest = YES;
        }
    }
    return rest;
}



//处理正文中的图片信息
-(NSString *)processBodyImages:(NSString *)templateString{
    ;
    //插入图片的xml描述string
    //
    NSInteger k=0;
    for (FSNewsDitailPicObject *o in _imageList) {
        UIImage *cachedImage = nil;
        //NSLog(@"o.picture:%@",o.picture);
        NSString *loaclFile = getFileNameWithURLString(o.picture, getCachesPath());
        if ([[NSFileManager defaultManager] fileExistsAtPath:loaclFile]) {
            cachedImage = [UIImage imageWithContentsOfFile:loaclFile];
        }
        if (cachedImage)
        {
            // Use the cached image
           
            NSString *imageString = [NSString stringWithFormat:@"<div class=\"photo\">%@</div>",[self generateImageHTML:cachedImage url:o.picture]];
            FSLog(@"imageString:%@",imageString);
            templateString = [NSString stringWithFormat:@"%@%@",templateString,imageString];
        }
        else
        {
            NSString *imageString = [NSString stringWithFormat:@"<div class=\"photo\" id=\"image_%d\"></div>",k];
            FSLog(@"imageString:%@",imageString);
            templateString = [NSString stringWithFormat:@"%@%@",templateString,imageString];
            
        }
        k++;
        
    }
    
    return templateString;
}

-(NSString *)processBodyADImages:(NSString *)templateString{
    NSString *adimageString = @"";
    
   
    if (1) {
        UIImage *cachedImage = nil;
        //NSLog(@"o.picture:%@",o.picture);
        NSString *loaclFile = getFileNameWithURLString(_adImageUrl, getCachesPath());
        if ([[NSFileManager defaultManager] fileExistsAtPath:loaclFile]) {
            cachedImage = [UIImage imageWithContentsOfFile:loaclFile];
        }
        if (cachedImage)
        {
            // Use the cached image
            
            NSString *imageString = [NSString stringWithFormat:@"<div class=\"photo_ad\">%@</div>",[self generateADImageHTML:cachedImage url:_adImageUrl]];
            // FSLog(@"imageString:%@",imageString);
            adimageString = [NSString stringWithFormat:@"%@%@",adimageString,imageString];
        }
        else
        {
            NSString *imageString = [NSString stringWithFormat:@"<div class=\"photo_ad\" id=\"image_%@\"></div>",@"ad"];
            //FSLog(@"imageString:%@",imageString);
            adimageString = [NSString stringWithFormat:@"%@%@",adimageString,imageString];
            
        }
    }
    
    return adimageString;
}

-(void)reSetCommentString:(NSString *)commentStr{
    commentStr = @"";
    commentStr = [self processCommentList:@""];
    [_webContent performSelector:@selector(stringByEvaluatingJavaScriptFromString:) withObject:[NSString stringWithFormat:@"document.getElementById('comment').innerHTML=\"%@\"", commentStr] afterDelay:0.2];
    
}

-(NSString *)processCommentList:(NSString *)templateString{
    
    if ([self.objectList count]==0) {
        return CONTENTWEBVIEW_COMMENT_TITLE_NODESC;
    }
    
    templateString = [NSString stringWithFormat:@"%@%@",templateString,CONTENTWEBVIEW_COMMENT_TITLE_DESC];
    
    NSArray *array = (NSArray *)self.objectList;
    if ([array count]>5) {
        for (int i = 0; i < 5; i++) {
            FSCommentObject *o = [array objectAtIndex:i];
            NSString *nickName = o.nickname;
            
            NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:[o.timestamp doubleValue]];
            
            NSString *datetime = timeIntervalStringSinceNow(date);
            [date release];
            NSString *body = o.content;
            body = [body stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"];
            body = [body stringByReplacingOccurrencesOfString:@"\r\n" withString:@"<br>"];
            body = [body stringByReplacingOccurrencesOfString:@"\n\r" withString:@"<br>"];
            body = [body stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
            body = [body stringByReplacingOccurrencesOfString:@"\r" withString:@"<br>"];
            NSString *comefrom = @"";
            NSString *strCommentBlock = [NSString stringWithFormat:CONTENTWEBVIEW_COMMENT_BLOCK, nickName, datetime, body, comefrom];
            templateString = [NSString stringWithFormat:@"%@%@",templateString,strCommentBlock];
            
            if ([o.adminNickname length]>0) {
                NSString *admin = o.adminNickname;
                NSDate *REdate = [[NSDate alloc] initWithTimeIntervalSince1970:[o.adminTimestamp doubleValue]];
                NSString *REdatetime = timeIntervalStringSinceNow(REdate);
                NSString *REbody = o.adminContent;
                NSString *strCommentREBlock = [NSString stringWithFormat:CONTENTWEBVIEW_COMMENT_RE_BLOCK, admin, REdatetime, REbody, comefrom];
                templateString = [NSString stringWithFormat:@"%@%@",templateString,strCommentREBlock];
            }
            
        }
        templateString = [NSString stringWithFormat:@"%@%@",templateString,CONTENTWEBVIEW_COMMENT_MORE];
    }
    else{
        for (FSCommentObject *o in array) {
            NSString *nickName = o.nickname;
            
            NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:[o.timestamp doubleValue]];
            
            NSString *datetime = timeIntervalStringSinceNow(date);
            [date release];
            
            NSString *body = o.content;
            body = [body stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"];
            body = [body stringByReplacingOccurrencesOfString:@"\r\n" withString:@"<br>"];
            body = [body stringByReplacingOccurrencesOfString:@"\n\r" withString:@"<br>"];
            body = [body stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
            body = [body stringByReplacingOccurrencesOfString:@"\r" withString:@"<br>"];
            NSString *comefrom = @"";
            NSString *strCommentBlock = [NSString stringWithFormat:CONTENTWEBVIEW_COMMENT_BLOCK, nickName, datetime, body, comefrom];
            templateString = [NSString stringWithFormat:@"%@%@",templateString,strCommentBlock];
            
            if ([o.adminNickname length]>0) {
                NSString *admin = o.adminNickname;
                NSDate *REdate = [[NSDate alloc] initWithTimeIntervalSince1970:[o.adminTimestamp doubleValue]];
                NSString *REdatetime = timeIntervalStringSinceNow(REdate);
                NSString *REbody = o.adminContent;
                NSString *strCommentREBlock = [NSString stringWithFormat:CONTENTWEBVIEW_COMMENT_RE_BLOCK, admin, REdatetime, REbody, comefrom];
                templateString = [NSString stringWithFormat:@"%@%@",templateString,strCommentREBlock];
            }
        }
    
    }
    
    
    return templateString;
}

-(NSString *) generateImageHTML:(UIImage *)image url:(NSString *)url{
    
    float rule = 90;
	float height = image.size.height;
	float width = image.size.width;
    
    if ([_imageList count]>1) {
        if (width>height) {
            width = width/height*rule;
            height = rule;
        }else {
            height = height/width*rule;
            width = rule;
        }
    }
    else{
        width = 300;
        height = 300/image.size.width*image.size.height;
    }
    
	
	//如果高度或宽度有小于100的, 那就不点击展开了
	//BOOL canClick = height>=100 && width >=100;
	
	
	NSString *realPath = getFileNameWithURLString(url, getCachesPath());//图片存放位置
	
	
    return [NSString stringWithFormat:@"<div class='plus'></div><a class='photo_box' href='javascript:void(0)' onclick=extend_image('%@')><img src='%@' width='%.0f' height='%.0f' /></a>",url,realPath,width,height];
	
}

-(NSString *) generateADImageHTML:(UIImage *)image url:(NSString *)url{
    
    
	float height = image.size.height;
	float width = image.size.width;
    
    width = 300;
    height = 300/image.size.width*image.size.height;
    
	
	//如果高度或宽度有小于100的, 那就不点击展开了
	//BOOL canClick = height>=100 && width >=100;
	
	
	NSString *realPath = getFileNameWithURLString(url, getCachesPath());//图片存放位置
	
	
    return [NSString stringWithFormat:@"<div class='plus'></div><a class='photo_box_ad' href='javascript:void(0)' onclick=extend_image('%@')><img src='%@' width='%.0f' height='%.0f' /></a>",url,realPath,width,height];
	
}


//这个方法是下载完图片后被调用的
- (void)webImageManager:(UIImage *)image index:(NSInteger)index
{
    // Do something with the downloaded image
    if ([_imageList count]>index) {
        FSNewsDitailPicObject *imageObj = [_imageList objectAtIndex:index];
        NSString *newHtml =[self generateImageHTML:image url:imageObj.picture];
        //NSLog(@"newHtml:%@",newHtml);
       
        //广告？？？
        //NSString *newHtml =[self generateADImageHTML:image url:imageObj.picture];
        
        //这里添加延时是因为直接调用有时候还没有存储到硬盘上
        [_webContent performSelector:@selector(stringByEvaluatingJavaScriptFromString:) withObject:[NSString stringWithFormat:@"document.getElementById('image_%d').innerHTML=\"%@\"", index,newHtml] afterDelay:0.5];
        //NSLog(@"_webContent:%@",_webContent.);
    }
   
}

-(void)webADImageManager:(UIImage *)image index:(NSInteger)index{
    // Do something with the downloaded image
    
    //广告？？？
    NSString *newHtml =[self generateADImageHTML:image url:_adImageUrl];
    //这里添加延时是因为直接调用有时候还没有存储到硬盘上
    [_webContent performSelector:@selector(stringByEvaluatingJavaScriptFromString:) withObject:[NSString stringWithFormat:@"document.getElementById('image_%@').innerHTML=\"%@\"", @"ad",newHtml] afterDelay:0.5];
}

#pragma mark -
#pragma UIScrollViewDelegate mark

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
   
    
    if (scrollView.contentOffset.y > _oldContentOfset+5 && scrollView.contentOffset.y > 44) {
        //上
        _oldContentOfset = scrollView.contentOffset.y;
        if (self.touchEvenKind != TouchEvenKind_ScrollUp) {
            self.touchEvenKind = TouchEvenKind_ScrollUp;
            [self sendTouchEvent];
        }
    }
    
    if (scrollView.contentOffset.y < _oldContentOfset-5 && scrollView.contentOffset.y<scrollView.contentSize.height-self.frame.size.height-44) {
        //下
        _oldContentOfset = scrollView.contentOffset.y;
        if (self.touchEvenKind != TouchEvenKind_ScrollDown) {
            self.touchEvenKind = TouchEvenKind_ScrollDown;
            [self sendTouchEvent];
        }
    }
}



#pragma mark -
#pragma mark webView delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
	//NSLog(@"should start load ");
	
        NSString* urlString = [[request URL] absoluteString];
        //NSLog(@"urlString:%@",urlString);
        
        if ([urlString isEqualToString:CONTENTWEBVIEW_COMMENT_MORE_LINK]) {
            //更多评论
            NSLog(@"更多评论......");
            self.touchEvenKind = TouchEvenKind_PopCommentList;
            [self sendTouchEvent];
            return NO;
        }
        else{
            if ([urlString hasPrefix:@"image://"]) {
                if ([urlString isEqualToString:_adImageUrl]) {
                    NSLog(@"点击广告");//点击广告
                }
                else{
                    //浮动显示大图
                    if ([_imageList count]>0) {
                        CGRect rect = CGRectZero;
                        [self expandImagefrom:rect withImageUrl:urlString];
                    }
                }
                return NO;
            }
            
        }
    
    

	return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    //FSLog(@"webViewDidStartLoad");
	[_webContent stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML=''"];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
	
    //[self heightChange];
    
   NSLog(@"webViewDidFinishLoad...........:%d  %f",self.isSizeChange,self.height);
    
    //FSLog(@"webViewDidFinishLoad:%f",self.height);
    
	//如果只有列表只有一项, 就不提示1/1了
	;
    
    //加载html完毕，开始下载图片
    _downloaodIndex = 0;
    if ([_imageList count]>0) {
        [self downloadImages];
    }
    
    if(0){
        [self downloadADImage];
    }
   
}

-(void)fontSizeChange{
    FSLog(@"1fontSizeChange..........%f",_webContent.scrollView.contentSize.height);
    
    //_webContent.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*0.55);
    
    //[_webContent.scrollView setContentSize:CGSizeMake(320, _webContent.scrollView.contentSize.height*0.5)];
//    [UIView animateWithDuration:0.1 animations:^{
//
//        
//    }];
//    CGRect rWebView = _webContent.frame;
//    rWebView.size.height = 120;
//    _webContent.frame = rWebView;
    
    [_webContent stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('body_section').className='%@'", [self returnFontSizeName:0]]];


//    [self performSelector:@selector(heightChange) withObject:nil afterDelay:0.00];
    
//    FSLog(@"2fontSizeChange..........%f",_webContent.scrollView.contentSize.height);
//    NSInteger scrollHeight = [[_webContent stringByEvaluatingJavaScriptFromString: @"document.body.scrollHeight"] intValue];
//    
//    NSInteger clientHeight = [[_webContent stringByEvaluatingJavaScriptFromString: @"document.body.clientHeight"] intValue];
//    NSInteger offsetHeight = [[_webContent stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"] intValue];
//    NSLog(@"scrollHeight:%d",scrollHeight);
//    NSLog(@"clientHeight:%d",clientHeight);
//    NSLog(@"offsetHeight:%d",offsetHeight);
}


-(void)heightChange{
    
    CGFloat scrollViewHeight = [[_webContent stringByEvaluatingJavaScriptFromString: @"document.body.scrollHeight"] floatValue];
    
     NSLog(@"scrollViewHeight:%f",scrollViewHeight);
    NSLog(@"contentSize:%@", NSStringFromCGSize(_webContent.scrollView.contentSize) );
    
    if (self.height != scrollViewHeight) {
        self.height = scrollViewHeight;
        self.isSizeChange = YES;
    }
    else{
        self.isSizeChange = NO;
    }
    
    
    //FSLog(@"webViewDidFinishLoad11:%f",self.height);
    
    [self sendTouchEvent];
}


//*****************************************
//正文浮动大图实现
- (void)expandImagefrom:(CGRect)startRect withImageUrl:(NSString *)urlStr{
    
	CGFloat t = 0.4;
	if (_imgContainer) {
		return;
	}
    
    //获取图片
    NSString *imageUrl;
    //[urlStr substringToIndex:5]
    NSRange a = NSMakeRange(12, 1);
    NSString *aa = [urlStr substringWithRange:a];
    if ([aa isEqualToString:@":"]) {
        imageUrl = @"http";
    }
    else{
        imageUrl = @"http:";
    }
    
    imageUrl = [imageUrl stringByAppendingString:[urlStr substringFromIndex:12]];
    NSString *imageLocalPath = getFileNameWithURLString(imageUrl, getCachesPath());
    
	UIImage *newsImg;
    if ([[NSFileManager defaultManager] fileExistsAtPath:imageLocalPath]) {
        newsImg = [UIImage imageWithContentsOfFile:imageLocalPath];
    }
    else{
        newsImg = [UIImage imageNamed:@"AsyncImage.png"];//此处可以保证可以获取到缓存
    }
    NSLog(@"imageLocalPath");
    
    startRect = [self getStarRect:imageUrl];
    
	UIWindow *topWindow = [[[UIApplication sharedApplication] windows] lastObject];
	CGRect superRect = [UIScreen mainScreen].applicationFrame;//CGRectMake(0, 20, 320, 460);
	
	CGSize newsImgSize;
	CGFloat flag = (superRect.size.width - 20.0f)/newsImg.size.width;//startRect
	if (newsImg.size.height * flag > superRect.size.height - 140) {
		
		CGFloat flag1 = (superRect.size.height - 140.0f)/newsImg.size.height;//startRect
		newsImgSize = CGSizeMake(newsImg.size.width* flag1, superRect.size.height - 140);
		
	}
	else {
		newsImgSize = CGSizeMake(superRect.size.width - 20.0f, newsImg.size.height * flag);
	}
    
    
	
	
	CGFloat xExp = newsImgSize.width/startRect.size.width;//startRect
	CGFloat yExp = newsImgSize.height/startRect.size.height;
	

	FSNewsDitailPicObject *o = [_imageList objectAtIndex:_expendImageIndex];
	NSString *imageNote = o.picdesc;//图片简单说明
	

	float size = [imageNote sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(newsImgSize.width-16, 9999)].height;
	if (size <= 25.0) {
		size = 25.0;
	}
	CGFloat conW = newsImgSize.width + 5;
	CGFloat conH = newsImgSize.height +5;//CGFloat conH = newsImgSize.height + size+5;
	//CGFloat conW = newsImg.size.width + 5;
	//CGFloat conH = newsImg.size.height + size+5;
	CGRect containerRect = CGRectMake((superRect.size.width - conW)/2, (superRect.size.height - conH)/2, conW, conH);
	
	//半透明全屏衬底
	UIView *substrateView = [[UIView alloc] initWithFrame:superRect];
	substrateView.backgroundColor = RGBACOLOR(0,0,0,0.8);
	[topWindow addSubview:substrateView];
	[substrateView release];
    
	//全屏相应按钮
	UIButton *respondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	respondBtn.frame = superRect;
	[respondBtn addTarget:self action:@selector(shrinkHtmlImage:) forControlEvents:UIControlEventTouchUpInside];
	[substrateView addSubview:respondBtn];
    
	//图片衬底
	_imgContainer = [[UIView alloc] initWithFrame:containerRect];
	_imgContainer.backgroundColor = RGBACOLOR(0,0,0,0.9);//[UIColor blackColor];
	[_imgContainer.layer setCornerRadius:5];
	[substrateView addSubview:_imgContainer];
	[_imgContainer release];
    
    
    //新闻图
	UIImageView *expedImgView = [[UIImageView alloc] initWithImage:newsImg];
	//expedImgView.frame = CGRectMake(2.5, 2.5, newsImg.size.width, newsImg.size.height);
	expedImgView.frame = CGRectMake(2.5, 2.5, newsImgSize.width,newsImgSize.height);
	expedImgView.alpha = 1.0;
	expedImgView.tag = 100;
	//expedImgView.backgroundColor = [UIColor greenColor];
	[_imgContainer addSubview:expedImgView];
	[expedImgView release];
	
	//新闻图片说明区域
	//UILabel *expedImgDescription = [[UILabel alloc] initWithFrame:CGRectMake(0.0, newsImg.size.height, newsImg.size.width-40, imgContainer.frame.size.height - expedImgView.frame.size.height)];
    
	UILabel *expedImgDescription = [[UILabel alloc] initWithFrame:CGRectMake(0.0, newsImgSize.height, newsImgSize.width-40, _imgContainer.frame.size.height - expedImgView.frame.size.height)];
	expedImgDescription.font = [UIFont systemFontOfSize:12];
	expedImgDescription.text = imageNote;
	expedImgDescription.textAlignment = UITextAlignmentCenter;
	expedImgDescription.textColor = [UIColor whiteColor];
	expedImgDescription.backgroundColor = [UIColor clearColor];
	expedImgDescription.numberOfLines = 0;
	//[_imgContainer addSubview:expedImgDescription];
	[expedImgDescription release];
	
	_imgContainer.alpha = 0.0;
	//新闻图片区背景按钮
	//UIButton *imgBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	//imgBackBtn.frame = CGRectMake(0, 0, containerRect.size.width-16, containerRect.size.height);
	//[imgBackBtn addTarget:self action:@selector(shrinkHtmlImage) forControlEvents:UIControlEventTouchUpInside];
	//[imgContainer addSubview:imgBackBtn];
	//下载按钮
	UIButton *pickimgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[pickimgBtn setImage:[UIImage imageNamed:@"toolbar_save.png"] forState:UIControlStateNormal];
	pickimgBtn.frame = CGRectMake(containerRect.size.width - 20-12, containerRect.size.height-12- 20, 40, 40);
	[pickimgBtn setTitle:urlStr forState:UIControlStateNormal];
	pickimgBtn.titleLabel.font = [UIFont systemFontOfSize:0.0];
	[pickimgBtn addTarget:self action:@selector(saveImage:) forControlEvents:UIControlEventTouchUpInside];
	//[pickimgBtn addTarget:self action:@selector(shrinkHtmlImage) forControlEvents:UIControlEventTouchUpInside];
	//[_imgContainer addSubview:pickimgBtn];
    
	//关闭提示按钮
	UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[closeBtn setImage:[UIImage imageNamed:@"contentview_image_close.png"] forState:UIControlStateNormal];
	closeBtn.frame = CGRectMake(-8, -8, 20, 20);
	[closeBtn addTarget:self action:@selector(shrinkHtmlImage:) forControlEvents:UIControlEventTouchUpInside];
	//[_imgContainer addSubview:closeBtn];
	
	//
	CABasicAnimation *expandAnimation = [CABasicAnimation
                                         animationWithKeyPath:@"transform"];
	expandAnimation.duration = t;
	expandAnimation.fromValue = [NSValue valueWithCATransform3D:
                                 CATransform3DScale(_imgContainer.layer.transform,1.0/xExp, 1.0/yExp, 1.0)];
	expandAnimation.toValue = [NSValue valueWithCATransform3D:
                               CATransform3DScale(_imgContainer.layer.transform,1.0, 1.0, 1.0)];
	
	CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
	alphaAnimation.duration = t;
	alphaAnimation.fromValue = [NSNumber numberWithFloat:0.0];
	alphaAnimation.toValue = [NSNumber numberWithFloat:1.0];
	
	CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation
										  animationWithKeyPath:@"position"];
	moveAnimation.duration = t;
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint(path,NULL,startRect.origin.x + startRect.size.width/2, startRect.origin.y + startRect.size.height/2);
	CGPathAddLineToPoint(path, NULL, superRect.size.width/2, superRect.size.height/2);
	[moveAnimation setPath:path];
	CFRelease(path);
	
	CAAnimationGroup *theGroup = [CAAnimationGroup animation];
	theGroup.removedOnCompletion = NO;
	theGroup.duration = t;
	//theGroup.delegate = self;
	theGroup.animations = [NSArray arrayWithObjects:alphaAnimation,expandAnimation,moveAnimation,nil];
	theGroup.autoreverses = NO;
	theGroup.repeatCount = 1;
	
	[_imgContainer.layer addAnimation:theGroup forKey:@"imageShowUp"];
	_imgContainer.layer.transform = CATransform3DScale(_imgContainer.layer.transform,1.0, 1.0, 1.0);
	_imgContainer.layer.position = CGPointMake(superRect.size.width/2,superRect.size.height/2);
	_imgContainer.layer.opacity = 1.0;
	
}


- (void)shrinkHtmlImage:(id)sender{
	UIButton *button = (UIButton *)sender;
	button.enabled = NO;
    FSNewsDitailPicObject *o = [_imageList objectAtIndex:_expendImageIndex];
	[self shrinkImagetoRect:[self getStarRect:o.picture]];
}

- (void)shrinkImagetoRect:(CGRect)endRect{
	//点击任一关闭按钮均禁止再交互

	_imgContainer.superview.userInteractionEnabled = NO;
    
	UIImageView *newsImg = (UIImageView *)[_imgContainer viewWithTag:100];
	CGRect superRect = [UIScreen mainScreen].applicationFrame;
	
	CGFloat t = 0.3;
	CGFloat xExp = newsImg.frame.size.width/endRect.size.width;//startRect
	CGFloat yExp = newsImg.frame.size.height/endRect.size.height;
	
	UIView *substrateView = _imgContainer.superview;
	substrateView.backgroundColor = [UIColor clearColor];
	
	CABasicAnimation *shrinkAnimation = [CABasicAnimation
										 animationWithKeyPath:@"transform"];
	shrinkAnimation.duration = t;
	shrinkAnimation.fromValue = [NSValue valueWithCATransform3D:
								 CATransform3DScale(_imgContainer.layer.transform,1.0, 1.0, 1.0)];
	shrinkAnimation.toValue = [NSValue valueWithCATransform3D:
							   CATransform3DScale(_imgContainer.layer.transform,1/xExp, 1/yExp, 1.0)];
	
	CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
	alphaAnimation.duration = t;
	alphaAnimation.fromValue = [NSNumber numberWithFloat:1.0];
	alphaAnimation.toValue = [NSNumber numberWithFloat:0.0];
	
	CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation
										  animationWithKeyPath:@"position"];
	moveAnimation.duration = t;
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint(path,NULL,superRect.size.width/2, superRect.size.height/2);
	CGPathAddLineToPoint(path, NULL, endRect.origin.x + endRect.size.width/2,endRect.origin.y + endRect.size.height/2);
	[moveAnimation setPath:path];
	CFRelease(path);
	
	CAAnimationGroup *theGroup = [CAAnimationGroup animation];
	theGroup.removedOnCompletion = NO;
	theGroup.duration = t;
	theGroup.delegate = self;
	theGroup.animations = [NSArray arrayWithObjects:alphaAnimation,shrinkAnimation,moveAnimation,nil];
	theGroup.autoreverses = NO;
	theGroup.repeatCount = 1;
	
	[_imgContainer.layer addAnimation:theGroup forKey:@"imageShrinkBack"];
	_imgContainer.layer.transform = CATransform3DScale(_imgContainer.layer.transform,xExp, yExp, 1.0);
	_imgContainer.layer.position = CGPointMake(endRect.origin.x + endRect.size.width/2,endRect.origin.y + endRect.size.height/2);
	_imgContainer.layer.opacity = 0.0;
}


- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag{
    
	if (theAnimation == [_imgContainer.layer animationForKey:@"imageShrinkBack"]) {
		[_imgContainer.layer removeAnimationForKey:@"imageShrinkBack"];
		[_imgContainer.superview removeFromSuperview];
		_imgContainer = nil;
	}
	//theAnimation.delegate = nil;//release last and reatin a nil
}


-(CGRect)getStarRect:(NSString *)imageUrl{
    NSInteger i=0;
    
    CGFloat contentOffsetY = _webContent.scrollView.contentOffset.y;
    
        
    //获取图片
    NSString *imageLocalPath = getFileNameWithURLString(imageUrl, getCachesPath());
    
	UIImage *newsImg;
    if ([[NSFileManager defaultManager] fileExistsAtPath:imageLocalPath]) {
        newsImg = [UIImage imageWithContentsOfFile:imageLocalPath];
    }
    else{
        newsImg = [UIImage imageNamed:@"AsyncImage.png"] ;//此处可以保证可以获取到缓存
    }
    
    
    if ([_imageList count]==1) {
        _expendImageIndex = 0;
        
        CGFloat w,h;
        
        w = 300.0f;
        h = newsImg.size.height*300/newsImg.size.width;
        return CGRectMake(10, 90-contentOffsetY, w, h);
    }
    
    for (FSNewsDitailPicObject *o in _imageList) {
        if ([o.picture isEqualToString:imageUrl]) {
            _expendImageIndex = i;
            return CGRectMake(320-100, 90*(i+2)-contentOffsetY, 90, 90);
        }
        i++;
    }
    return CGRectZero;
}

//*****************************************


#pragma mark -
#pragma  mark FSNetworkDataDelegate 

-(void)downloadADImage{
    NSString *loaclFile = getFileNameWithURLString(_adImageUrl, getCachesPath());
    if (![[NSFileManager defaultManager] fileExistsAtPath:loaclFile]) {
        
        [[FSNetworkDataManager shareNetworkDataManager] networkDataWithURLString:_adImageUrl withLocalFilePath:loaclFile withDelegate:self];
        
        //[FSNetworkData networkDataWithURLString:_adImageUrl withLocalStoreFileName:loaclFile withDelegate:self];
        //NSLog(@"loaclFile:%@",loaclFile);
        if (_indicator == nil) {
            _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [self addSubview:_indicator];
        }
        [_indicator setCenter:CGPointMake(self.frame.size.width / 2.0f, self.frame.size.height / 2.0f)];
        if (![_indicator isAnimating]) {
            [_indicator startAnimating];
        }
    }
}

-(void)downloadImages{
    FSNewsDitailPicObject *imageObj = [_imageList objectAtIndex:_downloaodIndex];
    NSString *loaclFile = getFileNameWithURLString(imageObj.picture, getCachesPath());
    if (![[NSFileManager defaultManager] fileExistsAtPath:loaclFile]) {
        //NSLog(@"loaclFile:%@",loaclFile);
       [[FSNetworkDataManager shareNetworkDataManager] networkDataWithURLString:imageObj.picture withLocalFilePath:loaclFile withDelegate:self];
	
        //[FSNetworkData networkDataWithURLString:imageObj.picture withLocalStoreFileName:loaclFile withDelegate:self];
        
        if (_indicator == nil) {
            _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [self addSubview:_indicator];
        }
        [_indicator setCenter:CGPointMake(self.frame.size.width / 2.0f, self.frame.size.height / 2.0f)];
        if (![_indicator isAnimating]) {
            [_indicator startAnimating];
        }
    }
    else{
//        NSLog(@"111111111");
//        NSLog(@"loaclFile:%@",loaclFile);
        _downloaodIndex++;
        if (_downloaodIndex<[_imageList count]) {
            [self performSelector:@selector(downloadImages) withObject:nil afterDelay:0.0];//延迟下载下一张图片
        }
    }

}

//-(void)networkDataDownloadDataComplete:(FSNetworkData *)sender isError:(BOOL)isError data:(NSData *)data{
//    //FSLog(@"networkDataDownloadDataComplete...........");
//    if ([_indicator isAnimating]) {
//        [_indicator stopAnimating];
//        [_indicator removeFromSuperview];
//        [_indicator release];
//        _indicator = nil;
//    }
//    if (_webContent==nil) {
//        return;
//    }
//    if ([sender.urlString isEqualToString:_adImageUrl]) {
//        UIImage *imageOri = [[UIImage alloc] initWithData:data];
//        [self webADImageManager:imageOri index:_downloaodIndex];
//        [imageOri release];
//    }
//    else{
//        UIImage *imageOri = [[UIImage alloc] initWithData:data];
//        [self webImageManager:imageOri index:_downloaodIndex];
//        [imageOri release];
//        _downloaodIndex++;
//        if (_downloaodIndex<[_imageList count]) {
//            [self performSelector:@selector(downloadImages) withObject:nil afterDelay:0.2];//延迟下载下一张图片
//        }
//    }
//}


//通知模式的图片下载
#pragma mark -
#pragma mark Notification
- (void)beginDownloading:(NSNotification *)notification {
//	NSDictionary *userInfo = [notification userInfo];
//	NSString *urlStr = [userInfo objectForKey:FSNETWORKDATA_MANAGER_URLSTRING_KEY];
//	NSString *filePath = [userInfo objectForKey:FSNETWORKDATA_MANAGER_LOCALFILEPATH_KEY];
//	if ([urlStr isEqualToString:@""] && [filePath isEqualToString:@""]) {
//		if (_indicator == nil) {
//			_indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//			[self addSubview:_indicator];
//            [_indicator release];
//		}
//		[_indicator setCenter:CGPointMake(self.frame.size.width / 2.0f, self.frame.size.height / 2.0f)];
//		if (![_indicator isAnimating]) {
//			[_indicator startAnimating];
//		}
//	}
}

- (void)endDownloadingComplete:(NSNotification *)notification {
#ifdef MYDEBUG
    NSLog(@"endDownloadingComplete");
#endif
	
	NSDictionary *userInfo = [notification userInfo];
	NSString *urlStr = [userInfo objectForKey:FSNETWORKDATA_MANAGER_URLSTRING_KEY];
	NSString *filePath = [userInfo objectForKey:FSNETWORKDATA_MANAGER_LOCALFILEPATH_KEY];
	if ([_indicator isAnimating]) {
        [_indicator stopAnimating];
    }
    if ([urlStr isEqualToString:_adImageUrl]) {
        UIImage *imageOri = [[UIImage alloc] initWithContentsOfFile:filePath];
        [self webADImageManager:imageOri index:_downloaodIndex];
        [imageOri release];
    }
    else{
        UIImage *imageOri = [[UIImage alloc] initWithContentsOfFile:filePath];
        [self webImageManager:imageOri index:_downloaodIndex];
        [imageOri release];
        _downloaodIndex++;
        if (_downloaodIndex<[_imageList count]) {
            [self performSelector:@selector(downloadImages) withObject:nil afterDelay:0.2];//延迟下载下一张图片
        }
    }
}

- (void)endDownloadingError:(NSNotification *)notification {
	NSDictionary *userInfo = [notification userInfo];
	NSString *urlStr = [userInfo objectForKey:FSNETWORKDATA_MANAGER_URLSTRING_KEY];
	NSString *filePath = [userInfo objectForKey:FSNETWORKDATA_MANAGER_LOCALFILEPATH_KEY];
	if ([urlStr isEqualToString:@""] && [filePath isEqualToString:@""]) {
		if ([_indicator isAnimating]) {
			[_indicator stopAnimating];
		}
	}
}

 

//****************************************************************
-(NSString *)replayString:(NSString *)baseString oldString:(NSString *)oldString newString:(NSString *)newString{
    baseString = [baseString stringByReplacingOccurrencesOfString:oldString withString:newString];
    return baseString;
}

-(NSString *)returnFontSizeName:(NSInteger)n{
    NSNumber *m = [[GlobalConfig shareConfig] readFontSize];
    n = [m integerValue];
    switch (n) {
        case 0:
            return @"font_small";
            break;
            
        case 1:
            return @"font_normal";
            break;
            
        case 2:
            return @"font_large";
            break;
            
        case 3:
            return @"font_largeb";
            break;
        default:
            return @"font_normal";
            break;
    }
}


@end
