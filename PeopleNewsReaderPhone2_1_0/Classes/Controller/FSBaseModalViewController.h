//
//  FSBaseModalViewController.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-28.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum _ModalViewAnimation {
	ModalViewAnimation_None,
	ModalViewAnimation_Default
} ModalViewAnimation;

@interface FSBaseModalViewController : UIViewController {
@private
	UIDeviceOrientation _deviceOrientation;
	UIView *_innerBackgroundView;
	ModalViewAnimation _modalViewAnimation;
	
	dispatch_queue_t _queue;
	
	BOOL _releaseWhenTouchNonClient;
}

@property (nonatomic) BOOL releaseWhenTouchNonClient;

- (void)showModalViewControllerWithAnimation:(ModalViewAnimation)animation;
- (void)releaseModalViewController;

- (void)layoutChildControllerViewWithRect:(CGRect)rect;
- (void)loadChildView;

@end
