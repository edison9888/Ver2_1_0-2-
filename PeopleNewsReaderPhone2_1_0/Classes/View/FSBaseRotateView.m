//
//  FSBaseRotateView.m
//  PeopleDailyReaderPhone
//
//  Created by people.com.cn on 12-7-27.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSBaseRotateView.h"

@interface FSBaseRotateOperation : NSOperation {
@private
	FSBaseRotateView *_rotateView;
	UIInterfaceOrientation _orientation;
}

@property (nonatomic, retain) FSBaseRotateView *rotateView;
@property (nonatomic) UIInterfaceOrientation orientation;

@end


///////////////////////////////////////////////////////////////////////////
//
///////////////////////////////////////////////////////////////////////////

@interface FSBaseRotateView(PrivateMethod)
- (void)getOrientationInformation;
- (void)rotateFrame;

@end


@implementation FSBaseRotateView
@synthesize interfaceOrientation = _interfaceOrientation;
@synthesize parentDelegate = _parentDelegate;
@synthesize clientSize = _clientSize;
@synthesize clientPosition = _clientPosition;
@synthesize clientView = _clientView;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(deviceOrientationDidChange:) 
													 name:UIDeviceOrientationDidChangeNotification 
												   object:nil];
		//[self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
		[self setBackgroundColor:[UIColor clearColor]];
		
		_clientSize = CGSizeZero;
		_clientPosition = CGPointZero;
		
		_clientView = [[UIView alloc] initWithFrame:CGRectZero];
		_clientView.backgroundColor = [UIColor clearColor];
		[self addSubview:_clientView];
		
		[pool release];
    }
    return self;
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
	
	[_clientView release];
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////
//	设备方向改变
///////////////////////////////////////////////////////////////////////
- (void)deviceOrientationDidChange:(NSNotification *)notification {
	
	[self getOrientationInformation];
	
}

///////////////////////////////////////////////////////////////////////
//	私有方法
///////////////////////////////////////////////////////////////////////
- (void)getOrientationInformation {
	                                                          
	UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
	if (orientation != _orientation) {
		if (orientation == UIDeviceOrientationPortrait ||
			orientation == UIDeviceOrientationPortraitUpsideDown ||
			orientation == UIDeviceOrientationLandscapeLeft ||
			orientation == UIDeviceOrientationLandscapeRight) {
			
			if ([_parentDelegate respondsToSelector:@selector(shouldRotateToOrientation:)]) {
				if ([_parentDelegate shouldRotateWithInterfaceOrientation:orientation]) {
					_orientation = orientation;
					[self rotateFrame];
				}
			} else {
				if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
					_orientation = orientation;
					[self rotateFrame];
				} else {
					if (orientation == UIDeviceOrientationPortrait ||
						orientation == UIDeviceOrientationPortraitUpsideDown) {
						_orientation = orientation;
						[self rotateFrame];
					}
				}
			}
		}
	}
}

///////////////////////////////////////////////////////////////////////
//	旋转
///////////////////////////////////////////////////////////////////////
- (void)rotateFrame {
	CGFloat angle = 0.0f;
	UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
	CGRect rect = CGRectMake(0.0, 0.0, self.window.bounds.size.width, self.window.bounds.size.height);
	
	if (orientation == UIDeviceOrientationPortrait) {
		_clientPosition = CGPointMake(0.0f, [UIApplication sharedApplication].statusBarFrame.size.height);
	} else if (orientation == UIDeviceOrientationPortraitUpsideDown) {
		angle = M_PI;
		_clientPosition = CGPointMake(0.0f, [UIApplication sharedApplication].statusBarFrame.size.height);
	} else if (orientation == UIDeviceOrientationLandscapeLeft) {
		angle = M_PI / 2.0f;
		rect.size.width = self.window.bounds.size.height;
		rect.size.height = self.window.bounds.size.width;
		_clientPosition = CGPointMake(0.0f, [UIApplication sharedApplication].statusBarFrame.size.width);
	} else if (orientation == UIDeviceOrientationLandscapeRight) {
		angle = M_PI * 3.0f / 2.0f;
		rect.size.width = self.window.bounds.size.height;
		rect.size.height = self.window.bounds.size.width;
		_clientPosition = CGPointMake(0.0f, [UIApplication sharedApplication].statusBarFrame.size.width);
	} else {
		return;
	}
	//动画随状态栏
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:[UIApplication sharedApplication].statusBarOrientationAnimationDuration];
	self.transform = CGAffineTransformRotate(CGAffineTransformIdentity, angle);
	self.frame = self.window.bounds;
	_clientSize = rect.size;
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationStopForShow)];
	[UIView commitAnimations];
}

- (void)showWithUseModal {
	
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
	if (!window)
    {
		window = [[UIApplication sharedApplication].windows objectAtIndex:0];
	}
  	[window addSubview:self];
	
	if (!window) {
		return;
	}
	
	_orientation = UIDeviceOrientationUnknown;
	
	self.frame = CGRectMake(0.0f, 0.0f, window.frame.size.width, window.frame.size.height);
	[window addSubview:self];
	
	//启动情况下旋转屏幕
	CGFloat angle = 0.0f;
	UIInterfaceOrientation statusOrientation = [UIApplication sharedApplication].statusBarOrientation;
	
	CGRect rect = CGRectMake(0.0, 0.0, window.bounds.size.width, window.bounds.size.height);
	if (statusOrientation == UIInterfaceOrientationPortrait) {
		_clientPosition = CGPointMake(0.0f, [UIApplication sharedApplication].statusBarFrame.size.height);
	} else if (statusOrientation == UIInterfaceOrientationPortraitUpsideDown) {
		angle =  M_PI;
		_clientPosition = CGPointMake(0.0f, [UIApplication sharedApplication].statusBarFrame.size.height);
	} else if (statusOrientation == UIInterfaceOrientationLandscapeLeft) {
		angle = M_PI / -2.0f;
		rect.size.width = window.bounds.size.height;
		rect.size.height = window.bounds.size.width;
		_clientPosition = CGPointMake(0.0f, [UIApplication sharedApplication].statusBarFrame.size.width);
	} else if (statusOrientation == UIInterfaceOrientationLandscapeRight) {
		angle = M_PI * 3.0f / -2.0f;
		rect.size.width = window.bounds.size.height;
		rect.size.height = window.bounds.size.width;
		_clientPosition = CGPointMake(0.0f, [UIApplication sharedApplication].statusBarFrame.size.width);
	}
	
	_clientSize = rect.size;
	self.transform = CGAffineTransformRotate(CGAffineTransformIdentity, angle);
	self.frame = window.bounds;

	
	[self layoutSubviews];
	//显示动画
	[self showInViewAnimationWithStopSelector:@selector(animationStopForShow)];
	
}

- (void)dismiss {
	[self dismissAnimationWithStopSelector:@selector(animationStop)];
}

- (void)showInViewAnimationWithStopSelector:(SEL)selector {
	self.alpha = 0.0f;
	[UIView beginAnimations:nil context:NULL];
	self.alpha = 1.0f;
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.3];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:selector];
	[UIView commitAnimations];
}

- (void)dismissAnimationWithStopSelector:(SEL)selector {
	[UIView beginAnimations:nil context:NULL];
	self.alpha = 0.0f;
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.3];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:selector];
	[UIView commitAnimations];
}

- (void)animationStop {
	self.alpha = 0.0f;
	[self removeFromSuperview];
}

- (void)animationStopForShow {
	[self setNeedsLayout];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
	if (flag) {
		if ([[_clientView.layer animationForKey:FSROTATE_DISSMISS_ANIMATION_KEY] isEqual:anim]) {
			[self removeFromSuperview];
		}
	}
}

@end

@implementation FSBaseRotateOperation
@synthesize orientation = _orientation;
@synthesize rotateView = _rotateView;

- (void)main {
	CGFloat angle = 0.0f;
	UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
	CGRect rect = CGRectMake(0.0, 0.0, _rotateView.window.bounds.size.width, _rotateView.window.bounds.size.height);
	
	if (orientation == UIDeviceOrientationPortrait) {
		
	} else if (orientation == UIDeviceOrientationPortraitUpsideDown) {
		angle = M_PI;
	} else if (orientation == UIDeviceOrientationLandscapeLeft) {
		angle = M_PI / 2.0f;
		rect.size.width = _rotateView.window.bounds.size.height;
		rect.size.height = _rotateView.window.bounds.size.width;
	} else if (orientation == UIDeviceOrientationLandscapeRight) {
		angle = M_PI * 3.0f / 2.0f;
		rect.size.width = _rotateView.window.bounds.size.height;
		rect.size.height = _rotateView.window.bounds.size.width;
	} else {
		return;
	}
	
	_rotateView.clientSize = rect.size;
	//动画随状态栏
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:[UIApplication sharedApplication].statusBarOrientationAnimationDuration];
	_rotateView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, angle);
	_rotateView.frame = _rotateView.window.bounds;
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(rotateComplete)];
	[UIView commitAnimations];
	
#ifdef MYDEBUG
	NSLog(@"%@.isFinish.", self);
#endif
}

- (void)rotateComplete {
	[_rotateView setNeedsLayout];
}

- (void)dealloc {
	[_rotateView release];
	[super dealloc];
}

@end




