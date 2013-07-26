//
//  FSBaseRotateView.h
//  PeopleDailyReaderPhone
//
//  Created by people.com.cn on 12-7-27.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define FSROTATE_DISSMISS_ANIMATION_KEY @"Dismiss_Layer_Animation"

@protocol FSBaseRotateViewDelegate;


@interface FSBaseRotateView : UIView {
@private
	UIView *_clientView;
	UIDeviceOrientation _orientation;
	UIInterfaceOrientation _interfaceOrientation;
	
	NSObject<FSBaseRotateViewDelegate> *_parentDelegate;

	CGSize _clientSize;
	CGPoint _clientPosition;
}

@property (nonatomic, readonly) UIInterfaceOrientation interfaceOrientation;
@property (nonatomic, assign) NSObject<FSBaseRotateViewDelegate> *parentDelegate;
@property (nonatomic) CGSize clientSize;
@property (nonatomic) CGPoint clientPosition;
@property (nonatomic, readonly) UIView *clientView;

- (void)showWithUseModal;
- (void)dismiss;

- (void)showInViewAnimationWithStopSelector:(SEL)selector;
- (void)dismissAnimationWithStopSelector:(SEL)selector;

@end


@protocol FSBaseRotateViewDelegate<NSObject>
@optional
- (BOOL)shouldRotateWithInterfaceOrientation:(UIInterfaceOrientation)orientation;
@end

