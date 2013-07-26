    //
//  FSBaseViewController.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-6.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSBaseViewController.h"
#import "FSTabBarItem.h"
#import "FSTabBarViewCotnroller.h"
#import "FSSlideViewController.h"

@interface FSBaseViewController(PrivateMethod)

@end


@implementation FSBaseViewController
@synthesize controllerViewState = _controllerViewState;
@synthesize monitorApplicationState = _monitorApplicationState;
@synthesize fsTabBarItem = _fsTabBarItem;
@synthesize fsTabBarViewController = _fsTabBarViewController;
@synthesize fsSlideViewController = _fsSlideViewController;

- (id)init {
	self = [super init];
	if (self) {
		_clientRect = CGRectZero;
		_controllerViewState = FSControllerViewUnknowState;
		_isFirstTimeShow = NO;
		_hidenTabBarOnNavigation = YES;
        //NSLog(@"FSBaseViewController:%@ :%d",self,[self retainCount]);
	}
	return self;
}

- (void)dealloc {
    //FSLog(@"FSBaseViewController.dealloc:%@", self);
//	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
//	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
//	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
	
//	[_fsTabBarViewController release];
//	[_fsSlideViewController release];
#ifdef MYDEBUG
	NSLog(@"%@.dealloc", self);
#endif
	[super dealloc];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    
    NSLog(@"didReceiveMemoryWarning:%@",self);
    
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)loadChildView {
}

- (void)loadView {
	UIView *contentView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
	self.view = contentView;
	[contentView release];
	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	self.view.backgroundColor = [UIColor whiteColor];
	[self loadChildView];
	[pool release];
	
	//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarFrameChanged:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

//- (void)statusBarFrameChanged:(NSNotification *)notification {
//	
//}

- (void)applicationBecomeActivie:(NSNotification *)notification {
	
}

- (void)applicationEnterBackground:(NSNotification *)notification {
	
}

- (void)setMonitorApplicationState:(BOOL)value {
	_monitorApplicationState = value;
	if (value) {
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationBecomeActivie:) name:UIApplicationDidBecomeActiveNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
	} else {
		[[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
		[[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
	}
}

- (void)layoutControllerViewWithRect:(CGRect)rect {
#ifdef MYDEBUG
	//NSLog(@"%@:layoutControllerViewWithRect:%d", self,[self retainCount]);
#endif
}

- (FSControllerAdjustLayout)isManualLayout {
	return FSControllerAdjustLayout_Auto;
}

- (CGRect)manualLayoutView {
	return CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)doSomethingForViewFirstTimeShow {
}

- (void)refreshControllerView {
	[self layoutControllerViewWithInterfaceOrientation:self.interfaceOrientation];
}

#pragma mark -
#pragma mark PrivateMethod
- (void)layoutControllerViewWithInterfaceOrientation:(UIInterfaceOrientation)willToOrientation {
	CGRect rClient = CGRectZero;
#ifdef MYDEBUG
	//NSLog(@"%@:layoutControllerViewWithInterfaceOrientation:%d", self,[self retainCount]);
#endif
    FSControllerAdjustLayout adjustLayout = [self isManualLayout];
	if (adjustLayout == FSControllerAdjustLayout_Self_Manual) {
		rClient = [self manualLayoutView];
	} else if (adjustLayout == FSControllerAdjustLayout_Auto) {
		rClient = getCurrentViewFrame(willToOrientation, self);
		if (self.fsSlideViewController != nil) {
			FSSlideViewController *slideViewController = self.fsSlideViewController;
			if ([slideViewController.rootViewController isEqual:self]) {
				if (slideViewController.pushViewControllerKind == PushViewControllerKind_Left) {
					rClient = CGRectMake(rClient.size.width - slideViewController.controllerViewOffset, 0.0f, rClient.size.width, rClient.size.height);
				} else if (slideViewController.pushViewControllerKind == PushViewControllerKind_Right) {
					rClient = CGRectMake(slideViewController.controllerViewOffset - rClient.size.width, 0.0f, rClient.size.width, rClient.size.height);
				} else {
					rClient = CGRectMake(rClient.origin.x, 0.0f, rClient.size.width, rClient.size.height);
				}
			} else if ([slideViewController.leftViewController isEqual:self]) {
				rClient = CGRectMake(0.0f, 0.0f, rClient.size.width - slideViewController.controllerViewOffset, rClient.size.height);
			} else if ([slideViewController.rightViewController isEqual:self]) {
				rClient = CGRectMake(slideViewController.controllerViewOffset, 0.0f, rClient.size.width - slideViewController.controllerViewOffset, rClient.size.height);
			}
		}
#ifdef MYDEBUG
		//NSLog(@"%@:rClient:%@", self, NSStringFromCGRect(rClient));
#endif
		
		if (_fsTabBarItem != nil) {
			rClient = CGRectMake(rClient.origin.x, 0.0f, rClient.size.width, rClient.size.height - _fsTabBarItem.tabBarHeight);
		}
		
	} else {
        return;
    }

	if (!CGRectEqualToRect(rClient, self.view.frame)) {
		self.view.frame = rClient;
	}

	if (!CGSizeEqualToSize(rClient.size, _clientRect.size)) {
		_clientRect = CGRectMake(0.0f, 0.0f, rClient.size.width, rClient.size.height);
		[self layoutControllerViewWithRect:_clientRect];
	}
}

#pragma mark -
#pragma mark Inherited
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	//默认
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		return (interfaceOrientation == UIInterfaceOrientationPortrait ||
				interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
	} else {
		return YES;
	}
}

- (BOOL)shouldAutorotate {//NS_AVAILABLE_IOS(6_0);
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {//NS_AVAILABLE_IOS(6_0);
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
	} else {
		return UIInterfaceOrientationMaskAll;
	}
}
//// Returns interface orientation masks.
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {// NS_AVAILABLE_IOS(6_0);
//    
//}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
#ifdef MYDEBUG
	//NSLog(@"FSTabBarItem:%@", _fsTabBarItem);
	//NSLog(@"%@.willRotateToInterfaceOrientation:%d", self,[self retainCount]);
#endif
	[self layoutControllerViewWithInterfaceOrientation:toInterfaceOrientation];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
#ifdef MYDEBUG
	//NSLog(@"viewWillAppear:%@[animated:%@]:%d", self, animated ? @"YES" : @"NO",[self retainCount]);
#endif
	
	if (self.navigationController != nil) {
		UIViewController *navRootController = nil;
		NSArray *navControllers = self.navigationController.viewControllers;
		if ([navControllers count] > 0) {
			navRootController = [navControllers objectAtIndex:0];
		}
		
		if (navRootController != nil) {
			if ([self isEqual:navRootController]) {
				if (self.fsTabBarViewController != nil && self.fsTabBarViewController.hideWhenNavigation) {
					[self.fsTabBarViewController setHideTabBar:NO withAnimation:animated];
				}
			} else {
				if ([navRootController isKindOfClass:[FSBaseViewController class]]) {
					FSBaseViewController *fsRootViewController = (FSBaseViewController *)navRootController;
					
					self.fsSlideViewController = fsRootViewController.fsSlideViewController;
					if (fsRootViewController.fsTabBarViewController != nil) {
						if (fsRootViewController.fsTabBarViewController.hideWhenNavigation) {
							self.fsTabBarViewController = nil;
							self.fsTabBarItem = nil;
							[fsRootViewController.fsTabBarViewController setHideTabBar:YES withAnimation:animated];
						} else {
							self.fsTabBarViewController = fsRootViewController.fsTabBarViewController;
							self.fsTabBarItem = fsRootViewController.fsTabBarItem;
						}
					}
				}
			}
		}
	}
	
	
	
	[self layoutControllerViewWithInterfaceOrientation:self.interfaceOrientation];
	
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
#ifdef MYDEBUG
	//NSLog(@"viewDidAppear:%@[animated:%@]:%d", self, animated ? @"YES" : @"NO",[self retainCount]);
#endif
	_controllerViewState = FSControllerViewAppearState;
	
	if (!_isFirstTimeShow) {
		_isFirstTimeShow = YES;
#ifdef MYDEBUG
		//NSLog(@"%@:doSomethingForViewFirstTimeShow", self);
#endif
		[self doSomethingForViewFirstTimeShow];
		
	}
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	_controllerViewState = FSControllerViewDisapperState;
}

@end
