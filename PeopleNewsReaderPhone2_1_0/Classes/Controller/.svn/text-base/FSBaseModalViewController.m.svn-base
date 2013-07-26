    //
//  FSBaseModalViewController.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-28.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSBaseModalViewController.h"

#define FSBASE_MODAL_VIEW_CONTROLLER_SHOW_ANIMATION_KEY @"FSBASE_MODAL_VIEW_CONTROLLER_SHOW_ANIMATION_KEY_STRING"
#define FSBASE_MODAL_VIEW_CONTROLLER_DISMISS_ANIMATION_KEY @"FSBASE_MODAL_VIEW_CONTROLLER_DISMISS_ANIMATION_KEY_STRING"

@interface FSBaseModalViewController(PrivateMethod)
- (void)rotatingViewWithOrientation:(UIInterfaceOrientation)toOrientation;
@end


@implementation FSBaseModalViewController
@synthesize releaseWhenTouchNonClient = _releaseWhenTouchNonClient;

- (id)init {
	self = [super init];
	if (self) {
		_queue = dispatch_queue_create(NULL, NULL);
		self.releaseWhenTouchNonClient = YES;
	}
	return self;
}

- (void)dealloc {
#ifdef MYDEBUG
	NSLog(@"%@.dealloc", self);
#endif
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
	dispatch_release(_queue);
	
	[_innerBackgroundView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)loadView {
	UIView *contentView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
	self.view = contentView;
	self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
	[contentView release];
	
	
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
	
	[self loadChildView];
}

- (void)deviceOrientationDidChange:(NSNotification *)notification {
#ifdef MYDEBUG
	NSLog(@"deviceOrientationDidChange:%@", notification);
#endif
	dispatch_async(_queue, ^(void) {
		UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
		if (orientation != _deviceOrientation) {
			if (orientation == UIDeviceOrientationPortrait ||
				orientation == UIDeviceOrientationPortraitUpsideDown ||
				orientation == UIDeviceOrientationLandscapeLeft ||
				orientation == UIDeviceOrientationLandscapeRight) {

				UIInterfaceOrientation toInterfaceOrientation = orientation;
				if ([self shouldAutorotateToInterfaceOrientation:toInterfaceOrientation]) {
					//允许旋转
					_deviceOrientation = orientation;
					[self rotatingViewWithOrientation:toInterfaceOrientation];
				}
			} else {
				//不符合旋转的设备
			}
		} else {
			//相同不进行处理
		}
	});
}

- (void)showModalViewControllerWithAnimation:(ModalViewAnimation)animation {
	UIWindow *window = [UIApplication sharedApplication].keyWindow;
	if (window) {
		[self retain];
		
		_innerBackgroundView = [[UIView alloc] initWithFrame:window.bounds];
		[window addSubview:_innerBackgroundView];
		
		UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
		[_innerBackgroundView addGestureRecognizer:tapGes];
		[tapGes release];
		
		[_innerBackgroundView addSubview:self.view];
		[self rotatingViewWithOrientation:[UIApplication sharedApplication].statusBarOrientation];
		
		_modalViewAnimation = animation;
		if (_modalViewAnimation == ModalViewAnimation_Default) {
			CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
			CGMutablePathRef path = CGPathCreateMutable();
			CGPoint currentPosition = self.view.layer.position;
			CGPathMoveToPoint(path, NULL, currentPosition.x - self.view.frame.size.width, currentPosition.y);
			CGPathAddLineToPoint(path, NULL, currentPosition.x, currentPosition.y);
			keyAnimation.path = path;
			CGPathRelease(path);
			
			keyAnimation.removedOnCompletion = NO;
			keyAnimation.delegate = self;
			keyAnimation.fillMode = kCAFillModeForwards; 
			keyAnimation.calculationMode = kCAAnimationCubicPaced;
			keyAnimation.duration = 0.24;
			
			[self.view.layer addAnimation:keyAnimation forKey:FSBASE_MODAL_VIEW_CONTROLLER_SHOW_ANIMATION_KEY];
		}
	}
}

- (void)releaseModalViewController {
	if (_modalViewAnimation == ModalViewAnimation_Default) {
		CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
		CGMutablePathRef path = CGPathCreateMutable();
		CGPoint currentPosition = self.view.layer.position;
		CGPathMoveToPoint(path, NULL, currentPosition.x, currentPosition.y);
		CGPathAddLineToPoint(path, NULL, currentPosition.x - self.view.frame.size.width, currentPosition.y);
		keyAnimation.path = path;
		CGPathRelease(path);
		
		keyAnimation.removedOnCompletion = NO;
		keyAnimation.delegate = self;
		keyAnimation.fillMode = kCAFillModeForwards; 
		keyAnimation.calculationMode = kCAAnimationCubicPaced;
		keyAnimation.duration = 0.24;
		
		[self.view.layer addAnimation:keyAnimation forKey:FSBASE_MODAL_VIEW_CONTROLLER_DISMISS_ANIMATION_KEY];
	} else if (_modalViewAnimation == ModalViewAnimation_None) {
		[_innerBackgroundView removeFromSuperview];
		[self.view removeFromSuperview];
		[self release];
	}
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
	if ([[self.view.layer animationForKey:FSBASE_MODAL_VIEW_CONTROLLER_SHOW_ANIMATION_KEY] isEqual:anim]) {
		[self.view.layer removeAnimationForKey:FSBASE_MODAL_VIEW_CONTROLLER_SHOW_ANIMATION_KEY];
	} else if ([[self.view.layer animationForKey:FSBASE_MODAL_VIEW_CONTROLLER_DISMISS_ANIMATION_KEY] isEqual:anim]) {
		[self.view.layer removeAnimationForKey:FSBASE_MODAL_VIEW_CONTROLLER_DISMISS_ANIMATION_KEY];
		[_innerBackgroundView removeFromSuperview];
		[self.view removeFromSuperview];
		[self release];
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		return (toInterfaceOrientation == UIInterfaceOrientationPortrait ||
				toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
	} else {
		return YES;
	}

}

- (void)rotatingViewWithOrientation:(UIInterfaceOrientation)toOrientation {
	
	CGFloat angle = 0.0f;
	CGRect rect = CGRectMake(0.0, 0.0, self.view.window.bounds.size.width, self.view.window.bounds.size.height);
	
	if (toOrientation == UIInterfaceOrientationPortrait) {
		//normal
	} else if (toOrientation == UIDeviceOrientationPortraitUpsideDown) {
		angle = M_PI;
	} else if (toOrientation == UIInterfaceOrientationLandscapeLeft) {
		angle = M_PI / 2.0f;
		rect.size.width = self.view.window.bounds.size.height;
		rect.size.height = self.view.window.bounds.size.width;
	} else if (toOrientation == UIInterfaceOrientationLandscapeRight) {
		angle = M_PI * 3.0f / 2.0f;
		rect.size.width = self.view.window.bounds.size.height;
		rect.size.height = self.view.window.bounds.size.width;
	} else {
		return;
	}
	
	_innerBackgroundView.frame = self.view.window.bounds;
	_innerBackgroundView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, angle);
	
	self.view.frame = rect;
	[self layoutChildControllerViewWithRect:self.view.bounds];
}

- (void)layoutChildControllerViewWithRect:(CGRect)rect {
	
}

- (void)loadChildView {
}

- (void)handleGesture:(UIGestureRecognizer *)gesture {
	if (gesture.state == UIGestureRecognizerStateEnded) {
		if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
			if (self.releaseWhenTouchNonClient && [gesture.view isEqual:_innerBackgroundView]) {
				[self releaseModalViewController];
			}
		}
	}
}

#pragma mark -
#pragma mark UIGestureRecognizerDelegate
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer

// called when the recognition of one of gestureRecognizer or otherGestureRecognizer would be blocked by the other
// return YES to allow both to recognize simultaneously. the default implementation returns NO (by default no two gestures can be recognized simultaneously)
//
// note: returning YES is guaranteed to allow simultaneous recognition. returning NO is not guaranteed to prevent simultaneous recognition, as the other gesture's delegate may return YES
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//	return YES;
//}
//
//// called before touchesBegan:withEvent: is called on the gesture recognizer for a new touch. return NO to prevent the gesture recognizer from seeing this touch
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//	return NO;
//}

@end
