    //
//  FSSlideViewController.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-10.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSSlideViewController.h"


@interface FSSlideInnerViewController : UIViewController {
@private	
	BOOL _presentModal;
	id _parentDelegate;
	SEL _selector;
}

- (void)setDelegate:(id)delegate selector:(SEL)selector;

@end

@implementation FSSlideInnerViewController

- (void)dealloc {
#ifdef MYDEBUG
	NSLog(@"%@.dealloc", self);
#endif
	[super dealloc];
}

- (void)loadView {
	CGRect rClient = [UIScreen mainScreen].applicationFrame;
	rClient.origin.x = 0.0f;
	rClient.origin.y = 0.0f;
	UIView *contentView = [[UIView alloc] initWithFrame:rClient];
	self.view = contentView;
	self.view.backgroundColor = [UIColor clearColor];
	[contentView release];
	
	self.view.userInteractionEnabled = NO;
	self.view.multipleTouchEnabled = NO;
	_presentModal = NO;
}

- (void)setDelegate:(id)delegate selector:(SEL)selector {
	_parentDelegate = delegate;
	_selector = selector;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[self.nextResponder touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[self.nextResponder touchesEnded:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.nextResponder touchesMoved:touches withEvent:event];
    
}

- (void)presentModalViewController:(UIViewController *)modalViewController animated:(BOOL)animated {
	_presentModal = YES;
	[super presentModalViewController:modalViewController animated:animated];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
#ifdef MYDEBUG
	NSLog(@"%@:%@", self, self.modalViewController);
#endif
	if (_presentModal) {
		[_parentDelegate performSelector:_selector withObject:nil afterDelay:0.1];
	}
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}

@end

#define LEFT_SILDE_CONTROLLER_ANIMATION_KEY @"LeftSlideAnimation"
#define RESET_LEFT_SILDE_CONTROLLER_ANIMATION_KEY @"ResetLeftSlideAnimation"
#define RIGHT_SLIDE_CONTROLLER_ANIMATION_KEY @"RightSlideAnimation"
#define RESET_RIGHT_SLIDE_CONTROLLER_ANIMATION_KEY @"ResetRightSlideAnimation"

@interface FSSlideViewController(PrivateMethod)
- (void)inner_CoverOffsetViewWithKind:(PushViewControllerKind)pushKind;
- (void)inner_PushAnimatinWithKey:(NSString *)animationKey withLayerOffset:(CGSize)layerOffset withShadowOffset:(CGSize)shadowOffset;
- (void)inner_ReleaseInnerController;
- (void)inner_SetSlideViewController:(UIViewController *)viewController;
@end


@implementation FSSlideViewController
@synthesize rootViewController = _rootViewController;
@synthesize leftViewController = _leftViewController;
@synthesize rightViewController = _rightViewController;

@synthesize pushViewControllerKind = _pushViewControllerKind;
@synthesize controllerViewOffset = _controllerViewOffset;
@synthesize currentAnimationKey = _currentAnimationKey;

- (id)init {
	self = [super init];
	if (self) {
		_pushViewControllerKind = PushViewControllerKind_Normal;
		_controllerViewOffset = 44.0f;
	}
	return self;
}

- (void)dealloc {
	[_rootViewController release];
	[_leftViewController release];
	[_rightViewController release];
	[_innerViewController release];
	
	[_layerShadowColor release];
	[_offsetView release];
	[_currentAnimationKey release];
    [super dealloc];
}

- (void)loadChildView {
	self.view.backgroundColor = [UIColor whiteColor];

	[self inner_SetSlideViewController:_rootViewController];
	[self.view addSubview:_rootViewController.view];
	
	_rootViewController.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
	_layerShadowColor = [[UIColor alloc] initWithRed:0.1372 green:0.1372 blue:0.1372 alpha:0.8];
}

- (void)inner_SetSlideViewController:(UIViewController *)viewController {
	if ([viewController isKindOfClass:[FSBaseViewController class]]) {
		((FSBaseViewController *)viewController).fsSlideViewController = self;
	} else if ([viewController isKindOfClass:[UINavigationController class]]) {
		UINavigationController *navRootController = (UINavigationController *)viewController;
		NSArray *childCtrls = [navRootController viewControllers];
		for (UIViewController *viewCtrl in childCtrls) {
			if ([viewCtrl isKindOfClass:[FSBaseViewController class]]) {
				((FSBaseViewController *)viewCtrl).fsSlideViewController = self;
			}
		}
	} else if ([viewController isKindOfClass:[UITabBarController class]]) {
		NSArray *childCtrls = [(UITabBarController *)viewController viewControllers];
		for (UIViewController *viewCtrl in childCtrls) {
			[self inner_SetSlideViewController:viewCtrl];
		}
	}
}

- (void)layoutControllerViewWithRect:(CGRect)rect {
	if (_innerViewController != nil) {
		_innerViewController.view.frame = CGRectMake(0.0f, 0.0f, rect.size.width, rect.size.height);
	}
	
	if (_pushViewControllerKind == PushViewControllerKind_Normal) {
		CGRect rRoot = CGRectMake(0.0f, 0.0f, rect.size.width, rect.size.height);
		_rootViewController.view.frame = rRoot;
	} else if (_pushViewControllerKind == PushViewControllerKind_Left) {
		_rootViewController.view.frame = CGRectMake(_controllerViewOffset - rect.size.width, 0.0f, rect.size.width, rect.size.height);
	} else if (_pushViewControllerKind == PushViewControllerKind_Right) {
		_rootViewController.view.frame = CGRectMake(rect.size.width - _controllerViewOffset, 0.0, rect.size.width, rect.size.height);
	}
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[_rootViewController viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[_rootViewController viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

- (void)slideViewController:(UIViewController *)viewController withKind:(PushViewControllerKind)pushKind withAnimation:(BOOL)animated {
	if (viewController == nil) {
		return;
	}
	
	[self inner_ReleaseInnerController];
	_pushViewControllerKind = pushKind;
	
	if (_pushViewControllerKind == PushViewControllerKind_Left) {
        
		if ([_leftViewController isEqual:viewController]) {
			NSLog(@"[_leftViewController isEqual:viewController]");
            _leftViewController.view.alpha = 1.0f;
			_rightViewController.view.alpha = 0.0f;
		} else {
			
			[_leftViewController.view removeFromSuperview];
			[_leftViewController release];
			_leftViewController = nil;
			
			_leftViewController = [viewController retain];
			[self.view addSubview:_leftViewController.view];
			[self.view sendSubviewToBack:_leftViewController.view];
			[self inner_SetSlideViewController:_leftViewController];
			_leftViewController.view.alpha = 1.0f;
			_rightViewController.view.alpha = 0.0f;
		}

		if (animated) {
			[_leftViewController viewWillAppear:YES];
			[self inner_PushAnimatinWithKey:LEFT_SILDE_CONTROLLER_ANIMATION_KEY 
							withLayerOffset:CGSizeMake(_rootViewController.view.frame.size.width - _controllerViewOffset, 0.0f) 
						   withShadowOffset:CGSizeMake(-10.0f, 0.0f)];
		} else {
			[_leftViewController viewWillAppear:NO];
			_rootViewController.view.frame = CGRectMake(_rootViewController.view.frame.size.width - _controllerViewOffset, 
														_rootViewController.view.frame.origin.y, 
														_rootViewController.view.frame.size.width, 
														_rootViewController.view.frame.size.height);
			[_leftViewController viewDidAppear:NO];
		}
		
	} else if (_pushViewControllerKind == PushViewControllerKind_Right) {
		if ([_rightViewController isEqual:viewController]) {
			_rightViewController.view.alpha = 1.0f;
            _leftViewController.view.alpha = 0.0f;
		} else {
			[_rightViewController.view removeFromSuperview];
			[_rightViewController release];
			_rightViewController = nil;
			
			_rightViewController = [viewController retain];
			[self.view addSubview:_rightViewController.view];
			[self.view sendSubviewToBack:_rightViewController.view];
			[self inner_SetSlideViewController:_rightViewController];
			
			_leftViewController.view.alpha = 0.0f;
			_rightViewController.view.alpha = 1.0f;
		}

		if (animated) {
			[_rightViewController viewWillAppear:YES];
			
			[self inner_PushAnimatinWithKey:RIGHT_SLIDE_CONTROLLER_ANIMATION_KEY 
							withLayerOffset:CGSizeMake(_controllerViewOffset - _rootViewController.view.frame.size.width, 0.0f) 
						   withShadowOffset:CGSizeMake(10.0f, 0.0f)];
		} else {
			[_rightViewController viewWillAppear:NO];
			_rootViewController.view.frame = CGRectMake(_controllerViewOffset - _rootViewController.view.frame.size.width, 
														_rootViewController.view.frame.origin.y, 
														_rootViewController.view.frame.size.width, 
														_rootViewController.view.frame.size.height);
			[_rightViewController viewDidAppear:NO];
		}
	}
}

- (void)resetViewControllerWithAnimated:(BOOL)animated {
    _offsetView.alpha = 0.0f;
	if (_pushViewControllerKind == PushViewControllerKind_Left) {
		[self inner_CoverOffsetViewWithKind:PushViewControllerKind_Normal];
		
		if (animated) {
			[self inner_PushAnimatinWithKey:RESET_LEFT_SILDE_CONTROLLER_ANIMATION_KEY 
							withLayerOffset:CGSizeMake(_controllerViewOffset - _rootViewController.view.frame.size.width, 0.0f) 
						   withShadowOffset:CGSizeMake(-10.0f, 0.0f)];
		} else {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.2];
			_rootViewController.view.frame = CGRectMake(0.0f, 0.0f, _rootViewController.view.frame.size.width, _rootViewController.view.frame.size.height);
            [UIView commitAnimations];
		}
	} else if (_pushViewControllerKind == PushViewControllerKind_Right) {
		[self inner_CoverOffsetViewWithKind:PushViewControllerKind_Normal];
		
		if (animated) {
			[self inner_PushAnimatinWithKey:RESET_RIGHT_SLIDE_CONTROLLER_ANIMATION_KEY 
							withLayerOffset:CGSizeMake(_rootViewController.view.frame.size.width - _controllerViewOffset, 0.0f) 
						   withShadowOffset:CGSizeMake(10.0f, 0.0f)];
		} else {
			[UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.2];
			_rootViewController.view.frame = CGRectMake(0.0f, 0.0f, _rootViewController.view.frame.size.width, _rootViewController.view.frame.size.height);
            [UIView commitAnimations];
		}
	}
}

-(void)resetViewControllerWithpiot:(CGPoint)poit{
    
    [self inner_CoverOffsetViewWithKind:PushViewControllerKind_Normal];
    
    if (_pushViewControllerKind == PushViewControllerKind_Left) {
        if (_rootViewController.view.frame.size.width-poit.x<44) {
            return;
        }
        _rootViewController.view.frame = CGRectMake(poit.x, 0.0f, _rootViewController.view.frame.size.width, _rootViewController.view.frame.size.height);
    }
    else if(_pushViewControllerKind == PushViewControllerKind_Right){
        
        if (poit.x<44) {
            return;
        }
        
        _rootViewController.view.frame = CGRectMake(poit.x-_rootViewController.view.frame.size.width, 0.0f, _rootViewController.view.frame.size.width, _rootViewController.view.frame.size.height);
    }
    
}


#pragma mark -
#pragma mark  CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim {
	if (_pushViewControllerKind == PushViewControllerKind_Left) {
		
	} else if (_pushViewControllerKind == PushViewControllerKind_Right) {

	}
}

#pragma mark -
#pragma mark Inherited
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	[super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
	
	[_rootViewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
	
	[_leftViewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];

	[_rightViewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	BOOL rst = [super shouldAutorotateToInterfaceOrientation:interfaceOrientation];
	
	return rst;
}

#pragma mark -
#pragma mark UIGestureRecognizer Handle Event
//- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer {
//    
//    CGPoint poit = [gestureRecognizer locationInView:self.view];
//    NSLog(@"gestureRecognizer:%f",poit.x);
//    
//	if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
//		if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
//			[self resetViewControllerWithAnimated:YES];
//            NSLog(@"1111111handleGesturehandleGesture");
//		}
//	}
//}


- (void)handleGesture:(UILongPressGestureRecognizer *)gestureRecognizer {
    
    CGPoint poit = [gestureRecognizer locationInView:self.view];
    
    [self resetViewControllerWithpiot:poit];
    
	if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
		if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
			[self resetViewControllerWithAnimated:NO];
            
		}
	}
}



-(void)swipeLeftAction:(id)sender{
    
    [self resetViewControllerWithAnimated:YES];
}

-(void)swipeRightAction:(id)sender{
    
    [self resetViewControllerWithAnimated:YES];
}



#pragma mark -
#pragma mark PrivateMethod
- (void)inner_PushAnimatinWithKey:(NSString *)animationKey withLayerOffset:(CGSize)layerOffset withShadowOffset:(CGSize)shadowOffset {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];	
	_rootViewController.view.layer.shadowOpacity = 0.6;
	_rootViewController.view.layer.shadowOffset = shadowOffset;
	_rootViewController.view.layer.shadowColor = _layerShadowColor.CGColor;
	
	animation.removedOnCompletion = NO;  
	animation.fillMode = kCAFillModeForwards; 
	animation.calculationMode = kCAAnimationCubicPaced;
	
	CGPoint rootPosition = _rootViewController.view.layer.position;
	_layerPostion = CGPointMake(rootPosition.x + layerOffset.width, rootPosition.y + layerOffset.height);
#ifdef MYDEBUG
	NSLog(@"animation.beofre.frame:%@", NSStringFromCGRect(_rootViewController.view.frame));
#endif
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint(path, NULL, rootPosition.x, rootPosition.y);
	CGPathAddLineToPoint(path, NULL, _layerPostion.x, _layerPostion.y);
	
	animation.delegate = self;
	animation.path = path;
	animation.duration = 0.24;
	
	//_rootViewController.view.layer.position = _layerPostion;
	self.currentAnimationKey = animationKey;
	[_rootViewController.view.layer addAnimation:animation forKey:animationKey];
	CGPathRelease(path);
	
	[pool release];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {	
	if (flag) {
		_rootViewController.view.layer.position = _layerPostion;
		if (_pushViewControllerKind == PushViewControllerKind_Left) {			
			if ([self.currentAnimationKey isEqualToString:LEFT_SILDE_CONTROLLER_ANIMATION_KEY]) {
				[self inner_CoverOffsetViewWithKind:PushViewControllerKind_Left];
				[_leftViewController viewDidAppear:YES];
			} else {
				[_leftViewController.view removeFromSuperview];
				[_leftViewController release];
				_leftViewController = nil;
				_pushViewControllerKind = PushViewControllerKind_Normal;
			}			
		} else if (_pushViewControllerKind == PushViewControllerKind_Right) {
			if ([self.currentAnimationKey isEqualToString:RIGHT_SLIDE_CONTROLLER_ANIMATION_KEY]) {
				[self inner_CoverOffsetViewWithKind:PushViewControllerKind_Right];
				[_rightViewController viewDidAppear:YES];
			} else {
				[_rightViewController.view removeFromSuperview];
				[_rightViewController release];
				_rightViewController = nil;
				_pushViewControllerKind = PushViewControllerKind_Normal;
			}
		} 
#ifdef MYDEBUG
		NSLog(@"animationKeys:%@", [_rootViewController.view.layer animationKeys]);
#endif
		if (self.currentAnimationKey != nil) {
			[_rootViewController.view.layer removeAnimationForKey:self.currentAnimationKey];
		}
	}

//#ifdef MYDEBUG
//	NSLog(@"animation.after.frame:%@", NSStringFromCGRect(_rootViewController.view.frame));
//	NSLog(@"animationKeys:%@", [_rootViewController.view.layer animationKeys]);
//	NSLog(@"self.subviews:%@", [self.view subviews]);
//#endif

}


- (void)inner_CoverOffsetViewWithKind:(PushViewControllerKind)pushKind {
	
	if (_offsetView == nil && (pushKind == PushViewControllerKind_Left || pushKind == PushViewControllerKind_Right)) {
		_offsetView = [[UIView alloc] initWithFrame:CGRectZero];
		
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		_offsetView.backgroundColor = [UIColor clearColor];
		[pool release];
        
        
        
        
        UILongPressGestureRecognizer *tapGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
		[_offsetView addGestureRecognizer:tapGes];
        tapGes.minimumPressDuration = 0.00;
		[tapGes release];
		
//		UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
//		[_offsetView addGestureRecognizer:tapGes];
//		[tapGes release];
        
        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftAction:)];
        swipeLeft.delegate = self;
        swipeLeft.direction = UISwipeGestureRecognizerDirectionRight;
        [_offsetView addGestureRecognizer:swipeLeft];
        [swipeLeft release];
        
        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightAction:)];
        swipeRight.delegate = self;
        swipeRight.direction = UISwipeGestureRecognizerDirectionLeft;
        [_offsetView addGestureRecognizer:swipeRight];
        [swipeRight release];
        
	}
	
	if (pushKind == PushViewControllerKind_Left ||
		pushKind == PushViewControllerKind_Right) {
		
		if (_pushViewControllerKind == PushViewControllerKind_Left) {
			_offsetView.frame = CGRectMake(_rootViewController.view.frame.origin.x, 
										   _rootViewController.view.frame.origin.y,
										   _controllerViewOffset, 
										   _rootViewController.view.frame.size.height);
		} else if (_pushViewControllerKind == PushViewControllerKind_Right) {
			_offsetView.frame = CGRectMake(0.0, 
										   _rootViewController.view.frame.origin.y, 
										   _controllerViewOffset, 
										   _rootViewController.view.frame.size.height);
		}
		
		if (![_offsetView.superview isEqual:self.view]) {
			[self.view addSubview:_offsetView];
		}
		_offsetView.alpha = 1.0f;
	} else {
        
//        if (_pushViewControllerKind == PushViewControllerKind_Left) {
//			_offsetView.frame = CGRectMake(_rootViewController.view.frame.origin.x,
//										   _rootViewController.view.frame.origin.y,
//										   _controllerViewOffset,
//										   _rootViewController.view.frame.size.height);
        
		_offsetView.alpha = 0.0f;
	}
}

- (void)presentModalViewController:(UIViewController *)modalViewController animated:(BOOL)animated {
	if (_innerViewController == nil) {
		_innerViewController = [[FSSlideInnerViewController alloc] init];
		_innerViewController.view.userInteractionEnabled = NO;
		_innerViewController.view.multipleTouchEnabled = NO;
		[self.view addSubview:_innerViewController.view];
	}
	
	[self.view bringSubviewToFront:_innerViewController.view];
	_innerViewController.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
#ifdef MYDEBUG
	NSLog(@"%@:presentModalViewController:%@", self, modalViewController);
#endif
	[(FSSlideInnerViewController *)_innerViewController setDelegate:self selector:@selector(inner_ReleaseInnerController)];
	[_innerViewController presentModalViewController:modalViewController animated:animated];
}

- (void)inner_ReleaseInnerController {
	if (_innerViewController != nil) {
		[_innerViewController.view removeFromSuperview];
		[_innerViewController release];
		_innerViewController = nil;
	} 
}

@end
