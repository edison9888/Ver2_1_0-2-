//
//  FSAuthorizationViewController.h
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-9-12.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSBaseSettingViewController.h"
#import "WBEngine.h"
#import "NetEaseEngine.h"
#import "FSBaseLoginViewController.h"


@interface FSAuthorizationViewController : FSBaseSettingViewController<WBEngineDelegate,FSBaseLoginViewControllerDelegate>{
@protected
    WBEngine *_engine;
	
	NetEaseEngine *_netEaseEngine;
}

- (void)showSinaBlogLoginController;
- (void)showPeopleLoginController;
- (void)showNetEaseBlogLoginController;

-(NSObject *)BulCellObject:(NSInteger)row;


@end
