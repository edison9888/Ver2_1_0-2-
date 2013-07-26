//
//  FSDeepContentTextView.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-13.
//
//

#import <UIKit/UIKit.h>
#import "FSDeepContentObject.h"
#import "FSDeepContent_ChildObject.h"
#import "FSNetworkData.h"

@interface FSDeepContentTextView : UIView <UIWebViewDelegate,FSNetworkDataDelegate> {
@private
    UIWebView *_webView;
    
    FSDeepContentObject *_contentObject;
    NSInteger _pictureFlag;
    NSInteger _textFlag;
    NSMutableDictionary *_picURLs;
    
    id _delegate;
}

@property (nonatomic, retain) FSDeepContentObject *contentObject;
@property (nonatomic) NSInteger pictureFlag;
@property (nonatomic) NSInteger textFlag;
@property (nonatomic, assign) id delegate;

@end

@protocol FSDeepContentTextView <NSObject>
@optional
- (void)deepContentTextViewURLLink:(NSString *)linkURLString;
@end

