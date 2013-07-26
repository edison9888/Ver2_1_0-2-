//
//  FSTabBarViewCotnroller.h
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
#import "FSBaseViewController.h"
#import "FSTabBar.h"

@interface FSTabBarViewCotnroller : FSBaseViewController <FSTabBarDelegate> {
@private
	NSMutableArray *_fsViewControllers;
	FSTabBar *_fsTabBar;
	
	UIViewController *_fsSelectedViewController;
	
//	id _navigationControllerDelegate;
	BOOL _hideWhenNavigation;

}

@property (nonatomic, retain) NSMutableArray *fsViewControllers;
@property (nonatomic, readonly) UIViewController *fsSelectedViewController;
@property (nonatomic) BOOL hideWhenNavigation;
- (void)setHideTabBar:(BOOL)hide withAnimation:(BOOL)animation;
- (void)setTabBarHided:(BOOL)hide withAnimation:(BOOL)animation;

@end




