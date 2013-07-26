//
//  FSNewsCommentListView.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-1-17.
//
//

#import <UIKit/UIKit.h>
#import "FSBaseContainerView.h"

@interface FSNewsCommentListView : FSBaseContainerView<UIWebViewDelegate,UIScrollViewDelegate>{
@protected
    UIWebView *_webContent;
    NSInteger _oldCount;
    CGFloat _scorllOffsetY;
}

-(void)loadWebPageWithContent:(NSString *)contentFile;

-(NSString *)processCommentList:(NSString *)templateString;

-(NSString *)replayString:(NSString *)baseString oldString:(NSString *)oldString newString:(NSString *)newString;

-(NSString *)returnFontSizeName:(NSInteger)n;

@end
