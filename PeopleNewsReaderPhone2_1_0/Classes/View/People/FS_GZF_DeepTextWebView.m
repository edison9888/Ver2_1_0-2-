//
//  FS_GZF_DeepTextWebView.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-2-5.
//
//

#import "FS_GZF_DeepTextWebView.h"
#import "FSCommonFunction.h"


#define FSDEEP_CONTENT_TEXT_TAG @"<div id='text_%d'>%@</div>"

#define FSDEEP_CONTENT_IMAGE_DIV_TAG @"<div id='image_%d' class='photo_section'></div>"

#define FSDEEP_CONTENT_DYNAMIC_IMAGE_TAG @"<a href='%@'><img src='%@' width='%.0f' height='%.0f' class='pictureBorder'/></a>"

#define FSDEEP_CONTENT_PICTURE_LEFT_RIGHT_SPACE 12.0f

#define FSDEEP_HTTP_SCHEME_PREFIX @"http"
#define FSDEEP_IMAGE_SCHEME_PREFIX @"image"
#define FSDEE_DYNAMIC_IMAGE_JS @"document.getElementById('image_%d').innerHTML=\"%@\""



@implementation FS_GZF_DeepTextWebView

@synthesize  title = _title;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



-(void)doSomethingAtInit{
    _webView = [[UIWebView alloc] init];
    _webView.delegate = self;
    _webView.backgroundColor = COLOR_NEWSLIST_TITLE_WHITE;
    
    _picURLs = [[NSMutableDictionary alloc] init];
    
    [self addSubview:_webView];
}

-(void)doSomethingAtDealloc{
    [_webView setDelegate:NULL];
    if ([_webView isLoading]){
        [_webView stopLoading];
    }
	
    [_webView release];
    [_picURLs release];
}

-(void)doSomethingAtLayoutSubviews{
    
    _contentObject = (FSDeepContentObject *)self.data;
    
    if (_contentObject == nil || self.title== nil) {
        return;
    }
    
    //_backGimage.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
    _webView.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height-30);
    
    
//title start**************************
    
    CGFloat clientWidth = self.frame.size.width - FSDEEP_CONTENT_PICTURE_LEFT_RIGHT_SPACE * 2.0f;
    CGSize sizeTmp = CGSizeZero;
    
    UIImageView *deep_titleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Deep_TextTitle.png"]];
    deep_titleImage.frame = CGRectMake(0.0f, 4.0f, deep_titleImage.image.size.width, deep_titleImage.image.size.height);
    [_webView.scrollView addSubview:deep_titleImage];
    
    UIImageView *deep_MtitleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Deep_textTitleM.png"]];
    deep_MtitleImage.frame = CGRectMake(0.0f, 4.0f, deep_titleImage.image.size.width, deep_titleImage.image.size.height);
    [_webView.scrollView addSubview:deep_MtitleImage];
    
    
    
    UILabel *labDeepTitle = [[UILabel alloc] init];
    labDeepTitle.backgroundColor = COLOR_CLEAR;
    labDeepTitle.textColor = COLOR_NEWSLIST_TITLE_WHITE;
    labDeepTitle.text = self.title;
    labDeepTitle.font = [UIFont systemFontOfSize:20];
    sizeTmp = [labDeepTitle.text sizeWithFont:labDeepTitle.font
                            constrainedToSize:CGSizeMake(clientWidth, 8192)
                                lineBreakMode:labDeepTitle.lineBreakMode];
    
    
    labDeepTitle.frame = CGRectMake(6.0f, 4.0f, sizeTmp.width, deep_titleImage.image.size.height);
    [_webView.scrollView addSubview:labDeepTitle];
    
    
    
    
    
    if (sizeTmp.width>deep_titleImage.image.size.width-4) {
        deep_titleImage.frame = CGRectMake(sizeTmp.width-deep_titleImage.image.size.width+14, 4.0f, deep_titleImage.image.size.width, deep_titleImage.image.size.height);
        deep_MtitleImage.frame = CGRectMake(0.0f, 4.0f, sizeTmp.width-deep_titleImage.image.size.width+14, deep_titleImage.image.size.height);
    }
    else{
        deep_titleImage.frame = CGRectMake(0, 4.0f, deep_titleImage.image.size.width, deep_titleImage.image.size.height);
        deep_MtitleImage.frame = CGRectZero;
    }
    
    
    [labDeepTitle release];
    [deep_titleImage release];
    [deep_MtitleImage release];
    
    
//title end**************************
    
    
    
    _ChildObjects = [[_contentObject.childContent allObjects] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        FSDeepContent_ChildObject *childObj1 = (FSDeepContent_ChildObject *)obj1;
        FSDeepContent_ChildObject *childObj2 = (FSDeepContent_ChildObject *)obj2;
        NSInteger obj1Index = [childObj1.orderIndex intValue];
        NSInteger obj2Index = [childObj2.orderIndex intValue];
        if (obj1Index < obj2Index) {
            return NSOrderedAscending;
        } else if (obj1Index > obj2Index) {
            return  NSOrderedDescending;
        } else {
            return NSOrderedSame;
        }
    }];
    

    NSError *error;
    NSStringEncoding enc;
    
    NSString *templatePath = [[NSBundle mainBundle] pathForResource:@"deep_content_template" ofType:@"html"];//新闻显示模版
    NSString *htmlTemplate = [NSString stringWithContentsOfFile:templatePath usedEncoding:&enc error:NULL];
    if ([htmlTemplate length]>0) {
        
        //STEP 1.
        NSString *contentTitle = _contentObject.title;
        //NSLog(@"bodyString1");
        //{{title}}
        NSString *htmlString = [htmlTemplate stringByReplacingOccurrencesOfString:@"{{title}}" withString:toHTMLString(contentTitle)];
        //STEP 2.
        //NSLog(@"bodyString2");
        NSString *subTitle = _contentObject.subjectTile;
        //{{subtitle}}
        //NSLog(@"bodyString3");
        if (subTitle == nil) {
            htmlString = [htmlString stringByReplacingOccurrencesOfString:@"{{subtitle}}" withString:@""];
        } else {
            htmlString = [htmlString stringByReplacingOccurrencesOfString:@"{{subtitle}}" withString:toHTMLString(subTitle)];
        }
        
        
        NSLog(@"bodyString4");
        
        //STEP 3.
        NSMutableString *bodyString = [[NSMutableString alloc] init];
        //NSLog(@"bodyString");
        [_picURLs removeAllObjects];
        for (int i = 0; i < [_ChildObjects count]; i++) {
            FSDeepContent_ChildObject *childObj = (FSDeepContent_ChildObject *)[_ChildObjects objectAtIndex:i];
            if ([childObj.flag intValue] == _pictureFlag) {
                //图片
                [_picURLs setObject:childObj.content forKey:childObj.orderIndex];
                
                NSString *picDivTag = [[NSString alloc] initWithFormat:FSDEEP_CONTENT_IMAGE_DIV_TAG,  [childObj.orderIndex intValue]];
                [bodyString appendString:picDivTag];
                [picDivTag release];
            } else if ([childObj.flag intValue] == _textFlag) {
                //文字
                NSString *textDivTag = [[NSString alloc] initWithFormat:FSDEEP_CONTENT_TEXT_TAG, [childObj.orderIndex intValue], toHTMLString(childObj.content)];
                
                [bodyString appendString:textDivTag];
                [textDivTag release];
            }
        }
        
        
        //{{body}}
        htmlString = [htmlString stringByReplacingOccurrencesOfString:@"{{body}}" withString:bodyString];
        
        //加载字符串
        NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
        [_webView loadHTMLString:htmlString baseURL:baseURL];
        
        //                dispatch_async(dispatch_get_main_queue(), ^{
        //                    //[self startDownloadPictures];
        //                    [self performSelector:@selector(startDownloadPictures) withObject:nil afterDelay:0.5];
        //                });
        
        [bodyString release];
    } else {
        FSLog(@"HTML Template error:%@", error);
    }
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


#pragma mark -
#pragma  mark FSNetworkDataDelegate


-(void)downloadImages{
    
    _allPICkey = [_picURLs allKeys];
    if (_downloaodIndex >= [_allPICkey count]) {
        return;
    }
        
    NSNumber *picKey = [_allPICkey objectAtIndex:_downloaodIndex];
    NSString *picURL = [_picURLs objectForKey:picKey];
    
    NSString *loaclFile = getFileNameWithURLString(picURL, getCachesPath());
    if (![[NSFileManager defaultManager] fileExistsAtPath:loaclFile]) {
        [FSNetworkData networkDataWithURLString:picURL withLocalStoreFileName:loaclFile withDelegate:self];
        //NSLog(@"loaclFile:%@",loaclFile);
    }
    else{
        
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:loaclFile];
        CGSize sizeTmp = scalImageSizeFixWidth(image, self.frame.size.width - FSDEEP_CONTENT_PICTURE_LEFT_RIGHT_SPACE * 2.0f);
        NSString *imgTag = [[NSString alloc] initWithFormat:FSDEEP_CONTENT_DYNAMIC_IMAGE_TAG, picURL, loaclFile, sizeTmp.width, sizeTmp.height];
        NSString *jsString = [[NSString alloc] initWithFormat:FSDEE_DYNAMIC_IMAGE_JS, [picKey intValue], imgTag];
        
        [_webView stringByEvaluatingJavaScriptFromString:jsString];
        [imgTag release];
        [jsString release];
        [image release];
        
        _downloaodIndex++;
        if (_downloaodIndex<[_allPICkey count]) {
            [self performSelector:@selector(downloadImages) withObject:nil afterDelay:0.0];//延迟下载下一张图片
        }
    }
    
}

-(void)networkDataDownloadDataComplete:(FSNetworkData *)sender isError:(BOOL)isError data:(NSData *)data{
    //FSLog(@"networkDataDownloadDataComplete...........");
    _allPICkey = [_picURLs allKeys];
    NSNumber *picKey = [_allPICkey objectAtIndex:_downloaodIndex];
    NSString *picURL = [_picURLs objectForKey:picKey];
    NSString *loaclFile = getFileNameWithURLString(picURL, getCachesPath());
    UIImage *image = [[UIImage alloc] initWithData:data];
    CGSize sizeTmp = scalImageSizeFixWidth(image, self.frame.size.width - FSDEEP_CONTENT_PICTURE_LEFT_RIGHT_SPACE * 2.0f);
    NSString *imgTag = [[NSString alloc] initWithFormat:FSDEEP_CONTENT_DYNAMIC_IMAGE_TAG, picURL, loaclFile, sizeTmp.width, sizeTmp.height];
    NSString *jsString = [[NSString alloc] initWithFormat:FSDEE_DYNAMIC_IMAGE_JS, [picKey intValue], imgTag];
    
    [_webView stringByEvaluatingJavaScriptFromString:jsString];
    [imgTag release];
    [jsString release];
    [image release];
    _downloaodIndex++;
    if (_downloaodIndex<[_allPICkey count]) {
        [self performSelector:@selector(downloadImages) withObject:nil afterDelay:0.2];//延迟下载下一张图片
    }
}

//*********************************************************************

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [_webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML=''"];
}


-(void)webViewDidFinishLoad:(UIWebView *)webView{
    _downloaodIndex = 0;
    
    [self downloadImages];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString* urlString = [[request URL] absoluteString];
    //NSLog(@"urlString:%@",urlString);
    if ([urlString hasPrefix:@"http://"]) {
        return NO;
    }
    
    return YES;
}




@end
