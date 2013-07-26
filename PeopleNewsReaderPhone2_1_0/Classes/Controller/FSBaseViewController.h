//
//  FSBaseViewController.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-6.
//  Copyright 2012 people.com.cn. All rights reserved.
//////////////////////////////////////////////////////////////////
//	版本			时间				说明
//////////////////////////////////////////////////////////////////
//	1.0			2012-08-06		初版做成
//****************************************************************

#import <UIKit/UIKit.h>
#import "UniversalEx.h"
#import <QuartzCore/QuartzCore.h>
#import "FSControllerLayout.h"

typedef enum _FSControllerViewState {
	FSControllerViewUnknowState,
	FSControllerViewAppearState,
	FSControllerViewDisapperState
} FSControllerViewState;



@class FSTabBarItem;
@class FSTabBarViewCotnroller;
@class FSSlideViewController;

@interface FSBaseViewController : UIViewController <FSControllerLayout> {
@private
	FSControllerViewState _controllerViewState;
	BOOL _monitorApplicationState;
	BOOL _isFirstTimeShow;
	CGRect _clientRect;
	
	FSTabBarItem *_fsTabBarItem;
	BOOL _hidenTabBarOnNavigation;
	FSTabBarViewCotnroller *_fsTabBarViewController;
	FSSlideViewController *_fsSlideViewController;
}

@property (readonly) FSControllerViewState controllerViewState;
@property (nonatomic) BOOL monitorApplicationState;

@property (nonatomic, retain) FSTabBarItem *fsTabBarItem;
@property (nonatomic, assign) FSTabBarViewCotnroller *fsTabBarViewController;
@property (nonatomic, assign) FSSlideViewController *fsSlideViewController;

- (void)loadChildView;

- (void)doSomethingForViewFirstTimeShow;
- (void)layoutControllerViewWithInterfaceOrientation:(UIInterfaceOrientation)willToOrientation;
- (void)layoutControllerViewWithRect:(CGRect)rect;
- (void)refreshControllerView;
//手工设置视图大小
- (FSControllerAdjustLayout)isManualLayout;
- (CGRect)manualLayoutView;
@end
