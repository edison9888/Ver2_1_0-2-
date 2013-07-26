//
//  FSNewsCommentListView.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-1-17.
//
//

#import "FSNewsCommentListView.h"
#import "FSCommentObject.h"
#import "FSCommonFunction.h"


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
"<a href='more://comment.list'><button class='comment_more_list' title='更多'>加载更多</button></a>" \
"</div>"

#define CONTENTWEBVIEW_COMMENT_MORE_LINK @"more://comment.list"


@implementation FSNewsCommentListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _oldCount =0;
        _scorllOffsetY = 0;
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
    [_webContent release];
    
}

-(void)doSomethingAtInit{
    _webContent = [[UIWebView alloc] initWithFrame:CGRectZero];
	[self addSubview:_webContent];
    _webContent.scrollView.delegate = self;
   	_webContent.delegate = self;
    //webContent.userInteractionEnabled = YES;
	//_webContent.autoresizingMask = UIViewAutoresizingFlexibleHeight;
	_webContent.dataDetectorTypes = UIDataDetectorTypeNone;
}


-(void)doSomethingAtLayoutSubviews{
    _webContent.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self loadWebPageWithContent:nil];

}

//****************************************************************************

- (void)loadWebPageWithContent:(NSString *)contentFile{
    

    NSArray *array = (NSArray *)self.data;
    if ([array count]==0) {
        return;
    }
    
    NSString *templatePath;
    
    templatePath = [[NSBundle mainBundle] pathForResource:@"content_template_comment" ofType:@"html"];//新闻显示模版
    
	NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
	
    
    
    
    NSStringEncoding enc;
    NSString *templateString = [NSString stringWithContentsOfFile:templatePath usedEncoding:&enc error:NULL];

   
    NSString *commentListStr = @"";
    if (1) {
        commentListStr = [self processCommentList:commentListStr];
        templateString = [self replayString:templateString oldString:@"{{commentList}}" newString:commentListStr];
    }
    else{
        templateString = [self replayString:templateString oldString:@"{{commentList}}" newString:CONTENTWEBVIEW_COMMENT_TITLE_NODESC];
    }
    
    
    NSLog(@"templateString:%@",templateString);
    _scorllOffsetY = _webContent.scrollView.contentOffset.y;
    [_webContent loadHTMLString:templateString baseURL:baseURL];
    
}

-(NSString *)processCommentList:(NSString *)templateString{
    
    NSArray *array = (NSArray *)self.data;
    
    templateString = [NSString stringWithFormat:@"%@%@",templateString,CONTENTWEBVIEW_COMMENT_TITLE_DESC];
    for (FSCommentObject *o in array) {
        NSString *nickName = o.nickname;
        
        NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:[o.timestamp doubleValue]];
        
        NSString *datetime = timeIntervalStringSinceNow(date);
        
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
    if (_oldCount==[array count]) {
        ;
    }
    else{
        _oldCount = [array count];
        templateString = [NSString stringWithFormat:@"%@%@",templateString,CONTENTWEBVIEW_COMMENT_MORE];
    }
	
    
    return templateString;
}

#pragma mark -
#pragma mark webView delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
	NSLog(@"should start load ");
    
	if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        NSString* urlString = [[request URL] absoluteString];
        //NSLog(@"urlString:%@",urlString);
        
        if ([urlString isEqualToString:CONTENTWEBVIEW_COMMENT_MORE_LINK]) {
            //更多评论
            NSLog(@"更多评论......");
            [self sendTouchEvent];
        }
        return NO;
    }
    
	return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    //FSLog(@"webViewDidStartLoad");
	[_webContent stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML=''"];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
	NSLog(@"webViewDidFinishLoad...........:%f",_scorllOffsetY);
    [_webContent.scrollView setContentOffset:CGPointMake(0.0f, _scorllOffsetY)];
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



//*************************************
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    
    NSLog(@"scrollViewDidScroll...........:%f",_scorllOffsetY);
}


@end
