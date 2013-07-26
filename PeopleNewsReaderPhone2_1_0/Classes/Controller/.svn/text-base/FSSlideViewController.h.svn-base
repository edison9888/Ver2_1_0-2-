//
//  FSSlideViewController.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-10.
//  Copyright 2012 people.com.cn. All rights reserved.
//////////////////////////////////////////////////////////////////
//	版本			时间				说明
//////////////////////////////////////////////////////////////////
//	1.0			2012-08-10		初版做成
//****************************************************************

#import <UIKit/UIKit.h>
#import "FSBaseViewController.h"

typedef enum _PushViewControllerKind {
	PushViewControllerKind_Normal,
	PushViewControllerKind_Left,
	PushViewControllerKind_Right,
} PushViewControllerKind;

@interface FSSlideViewController : FSBaseViewController <UIGestureRecognizerDelegate>{
@private
	UIViewController *_rootViewController;
	UIViewController *_leftViewController;
	UIViewController *_rightViewController;
	
	
	PushViewControllerKind _pushViewControllerKind;
	CGFloat _controllerViewOffset;
	
	UIView *_offsetView;
	UIViewController *_innerViewController;
	UIColor *_layerShadowColor;
	CGPoint _layerPostion;
	NSString *_currentAnimationKey;
}

@property (nonatomic, retain) UIViewController *rootViewController;
@property (nonatomic, retain, readonly) UIViewController *leftViewController;
@property (nonatomic, retain, readonly) UIViewController *rightViewController;

@property (nonatomic, readonly) PushViewControllerKind pushViewControllerKind;
@property (nonatomic, readonly) CGFloat controllerViewOffset;
@property (nonatomic, retain) NSString *currentAnimationKey;

- (void)resetViewControllerWithAnimated:(BOOL)animated;
- (void)resetViewControllerWithpiot:(CGPoint)poit;
- (void)slideViewController:(UIViewController *)viewController withKind:(PushViewControllerKind)pushKind withAnimation:(BOOL)animated;
																													

@end

