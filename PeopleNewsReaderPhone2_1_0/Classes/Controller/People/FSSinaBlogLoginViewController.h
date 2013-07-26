//
//  FSSinaBlogLoginViewController.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-12-13.
//
//

#import <UIKit/UIKit.h>
#import "FSBaseLoginViewController.h"

//新浪微博
#import "WBEngine.h"
#import "WBSendView.h"
#import "WBLogInAlertView.h"

@interface FSSinaBlogLoginViewController : FSBaseLoginViewController<WBEngineDelegate,WBSendViewDelegate>{
@protected
    WBEngine *_sinaWBEngine;
}

@property (nonatomic, assign) WBEngine *sinaWBEngine;

@end
