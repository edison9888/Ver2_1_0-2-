// 
//  FSMoreViewController.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-13.
//  Copyright 2012 people.com.cn. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "FSBasePeopleViewController.h"
#import "FSMoreContainerView.h"



#import <StoreKit/StoreKit.h>

@class FS_GZF_AppRecommendDAO,FSRecommentAPPObject;

@interface FSMoreViewController : FSBasePeopleViewController<FSTableContainerViewDelegate,UIGestureRecognizerDelegate,SKStoreProductViewControllerDelegate> {
@protected
    FSMoreContainerView *_fsMoreContainerView;
    FS_GZF_AppRecommendDAO *_fs_GZF_AppRecommendDAO;
    
    NSMutableArray *_peopleAPPS;
    NSMutableArray *_RecommentAPPS;
    
    NSTimeInterval _TimeInterval;
    
}

-(void)addMyWebView:(FSRecommentAPPObject *)obj;

-(void)yingyongpingfen;
//@property (nonatomic, retain)UIWebView *webView;

-(void)updateTableView;
@end
