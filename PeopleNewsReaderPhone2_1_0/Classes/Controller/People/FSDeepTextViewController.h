//
//  FSDeepTextViewController.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-29.
//
//

#import <UIKit/UIKit.h>
#import "FSDeepBaseViewController.h"
#import "FSDeepTextDAO.h"
#import "FSDeepTextView.h"
#import "FSDeepContentTextView.h"

//#import "FS_GZF_DeepTextView.h"
#import "FS_GZF_DeepTextWebView.h"



@class FS_GZF_DeepTextDAO;


@interface FSDeepTextViewController : FSDeepBaseViewController {
@private
    
    //FSDeepTextDAO *_textData;
    
    //FS_GZF_DeepTextView *_fs_GZF_DeepTextView;
    FS_GZF_DeepTextWebView *_fs_GZF_DeepTextWebView;
    
    FS_GZF_DeepTextDAO *_fs_GZF_DeepTextDAO;
    
    NSString *_contentid;
//    FSDeepTextView *_textView;
//    FSDeepContentTextView *_textView;
}

@property (nonatomic, retain) NSString *contentid;

@end
