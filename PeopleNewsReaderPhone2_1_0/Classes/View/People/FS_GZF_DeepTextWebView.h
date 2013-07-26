//
//  FS_GZF_DeepTextWebView.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-2-5.
//
//

#import <UIKit/UIKit.h>
#import "FSBaseContainerView.h"
#import "FSDeepContentObject.h"
#import "FSDeepContent_ChildObject.h"
#import "FSNetworkData.h"

@interface FS_GZF_DeepTextWebView : FSBaseContainerView<UIWebViewDelegate,FSNetworkDataDelegate>{
@protected
    UIWebView *_webView;
    FSDeepContentObject *_contentObject;
    NSInteger _pictureFlag;
    NSInteger _textFlag;
    NSMutableDictionary *_picURLs;
    NSInteger _downloaodIndex;
    NSArray *_ChildObjects;
    NSArray *_allPICkey;
    
    CGFloat _clientHeight;
    
    NSString *_title;
}

@property (nonatomic) NSInteger pictureFlag;
@property (nonatomic) NSInteger textFlag;
@property (nonatomic,retain) NSString *title;



-(void)downloadImages;



@end
