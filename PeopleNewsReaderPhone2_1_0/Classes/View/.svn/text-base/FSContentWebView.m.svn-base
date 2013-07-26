//
//  FSContentWebView.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-20.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSContentWebView.h"


@implementation FSContentWebView
@synthesize contentPictureScaleStyle = _contentPictureScaleStyle;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.contentPictureScaleStyle = FSContentPictureScaleStyle_FixedRect;
		_config = [GlobalConfig shareConfig];
    }
    return self;
}


- (void)dealloc {
	
    [super dealloc];
}


- (void)loadContentData {
	//0-小 1-中 2-大 3-超大
	NSInteger fontDefaultIndex = [[_config readFontSize] intValue];
	if (fontDefaultIndex < 0 || fontDefaultIndex > 3) {
		
		fontDefaultIndex = 2;
		NSNumber *number = [[NSNumber alloc] initWithInt:fontDefaultIndex];
		[_config setFontSize:number];
		[number release];
	}
	
	
	
}

- (void)loadCommentData {
	
}

//****************************************************
//	允许同时存在多个手势
//****************************************************
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
	return YES;
}

//****************************************************
//	UIWebViewDelegate
//****************************************************
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
#ifdef MYDEBUG
	NSLog(@"FSContentWebView.request:%@", [[request URL] absoluteString]);
#endif
	if (navigationType == UIWebViewNavigationTypeLinkClicked) {
//		if ([[[request URL] absoluteString] isEqualToString:CONTENTWEBVIEW_COMMENT_MORE_LINK]) {
//			//评论链接
//#ifdef MYDEBUG
//			NSLog(@"评论链接");
//#endif
//			if ([(id)_parentDelegate respondsToSelector:@selector(contentWebViewAllCommentList:)]) {
//				[_parentDelegate contentWebViewAllCommentList:self];
//			}
//		} else {
//			if ([[[request URL] absoluteString] hasPrefix:CONTENTWEBVIEW_CONTENT_IMAGE_URL_NEW_PREFIX]) {
//				if ([(id)_parentDelegate respondsToSelector:@selector(contentWebViewPictureLink:withPictureURL:)]) {
//					NSString *oldURL = [[request URL] absoluteString];
//					NSRange range = {0, 5};
//					oldURL = [oldURL stringByReplacingCharactersInRange:range withString:CONTENTWEBVIEW_CONTENT_IMAGE_URL_OLD_PREFIX];
//					[_parentDelegate contentWebViewPictureLink:self withPictureURL:oldURL];
//				}
//			}
//		}
		return NO;
	}
	return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
	//[webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML=''"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	
}

@end
