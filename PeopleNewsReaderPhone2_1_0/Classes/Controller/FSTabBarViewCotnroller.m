//
//  FSTabBarViewCotnroller.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-6.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSTabBarViewCotnroller.h"

#define FSTABBAR_HEIGHT 49.0f

@interface FSTabBarViewCotnroller(PrivateMethod)
- (void)inner_releaseFSViewControllers;
- (void)inner_initializeFSViewControllers;
- (void)inner_initializeController:(UIViewController *)controller withFSTabBarItem:(FSTabBarItem *)fsItem;

@end


@implementation FSTabBarViewCotnroller
@synthesize fsViewControllers = _fsViewControllers;
@synthesize fsSelectedViewController = _fsSelectedViewController;
@synthesize hideWhenNavigation = _hideWhenNavigation;

- (id)init {
	self = [super init];
	if (self) {
		_fsSelectedViewController = nil;
		self.hideWhenNavigation = YES;
	}
	return self;
}

- (void)dealloc {
	[_fsTabBar release];
    [super dealloc];
}

- (void)loadChildView {
	_fsTabBar = [[FSTabBar alloc] initWithFrame:CGRectMake(0.0f, self.view.frame.size.height - FSTABBAR_HEIGHT, self.view.frame.size.width, FSTABBAR_HEIGHT)];
	[_fsTabBar setParentDelegate:self];
	[self.view addSubview:_fsTabBar];
	
	self.view.backgroundColor = [UIColor blackColor];
	
	[self inner_initializeFSViewControllers];
	_fsTabBar.fsSelectedIndex = 0;
}

- (void)setFsViewControllers:(NSMutableArray *)value {
	//
	[self inner_releaseFSViewControllers];
	[_fsViewControllers release];
	
	_fsViewControllers = [value retain];
	
	[self inner_initializeFSViewControllers];
}

- (void)layoutControllerViewWithRect:(CGRect)rect {
	_fsTabBar.frame = CGRectMake(0.0f, rect.size.height - FSTABBAR_HEIGHT, rect.size.width, FSTABBAR_HEIGHT);
	
	CGRect rClient = CGRectMake(0.0f, 0.0f, rect.size.width, rect.size.height - FSTABBAR_HEIGHT);
	if (!CGRectEqualToRect(rClient, _fsSelectedViewController.view.frame)) {
		_fsSelectedViewController.view.frame = rClient;
	}
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

#pragma mark -
#pragma mark 代理
- (void)fsTabBarDidSelected:(FSTabBar*)sender withFsTabIndex:(NSInteger)fsTabIndex {
	if (fsTabIndex >= 0 && fsTabIndex < [_fsViewControllers count]) {
		FSBaseViewController *fsViewController = (FSBaseViewController *)[_fsViewControllers objectAtIndex:fsTabIndex];
		if (![fsViewController isEqual:_fsSelectedViewController]) {
			//移除以前的
			[_fsSelectedViewController viewWillDisappear:NO];
			[_fsSelectedViewController.view removeFromSuperview];
			[_fsSelectedViewController viewDidDisappear:NO];
			
			//新选择的
			
			if ([fsViewController isKindOfClass:[UINavigationController class]]) {
				fsViewController.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height - FSTABBAR_HEIGHT);
			}
			
			
			//继承触发
			
			[self.view addSubview:fsViewController.view];
            [self.view bringSubviewToFront:_fsTabBar];
			[fsViewController viewWillAppear:NO];			
			[fsViewController viewDidAppear:NO];
			
			_fsSelectedViewController = fsViewController;
		}
	}
}

- (void)fsViewControllerViewDidAppear:(UIViewController *)viewController {
	[viewController viewDidAppear:NO];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	[super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
	[_fsSelectedViewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[_fsSelectedViewController viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[_fsSelectedViewController viewDidAppear:animated];
}

#pragma mark -
#pragma mark PrivateMethod
- (void)inner_releaseFSViewControllers {
	for (FSBaseViewController *fsViewController in _fsViewControllers) {
		[fsViewController.view removeFromSuperview];
		[fsViewController release];
	}
}

- (void)inner_initializeFSViewControllers {
	if (_fsTabBar == nil) {
		return;
	}
	
	NSMutableArray *fsItems = [[NSMutableArray alloc] init];
	for (UIViewController *viewController in _fsViewControllers) {
		FSTabBarItem *fsItem = [[FSTabBarItem alloc] initWithFrame:CGRectZero];

		[self inner_initializeController:viewController withFSTabBarItem:fsItem];
		[fsItems addObject:fsItem];
		
		[fsItem release];
	}
	[_fsTabBar setFsItems:fsItems];
	[fsItems release];
}

- (void)inner_initializeController:(UIViewController *)controller withFSTabBarItem:(FSTabBarItem *)fsItem {
	if ([controller isKindOfClass:[FSBaseViewController class]]) {
		FSBaseViewController *fsViewController = (FSBaseViewController *)controller;
		fsViewController.fsTabBarViewController = self;
		fsViewController.fsSlideViewController = self.fsSlideViewController;
		fsViewController.fsTabBarItem = fsItem;
		if ([fsViewController conformsToProtocol:@protocol(FSTabBarItemDelegate)]) {
			id<FSTabBarItemDelegate> itemDelegate = (id<FSTabBarItemDelegate>)fsViewController;
			UIImage *normalImage = [itemDelegate tabBarItemNormalImage];
			UIImage *selectedImage = [itemDelegate tabBarItemSelectedImage];
			NSString *text = [itemDelegate tabBarItemText];
			[fsItem setTabBarItemWithNormalImage:normalImage withSelectedImage:selectedImage withText:text];
		}
		
	} else if ([controller isKindOfClass:[UINavigationController class]]) {
		UINavigationController *navController = (UINavigationController *)controller;
		NSArray *arrCtrls = navController.viewControllers;
		for (UIViewController *childViewController in arrCtrls) {
			[self inner_initializeController:childViewController withFSTabBarItem:fsItem];
		}
	}
}

- (void)setHideTabBar:(BOOL)hide withAnimation:(BOOL)animation {
    _fsTabBar.alpha = 1.0f;
	if (animation) {
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationDuration:0.3];
	}
	if (hide) {
		_fsTabBar.frame = CGRectMake(0.0 - _fsTabBar.frame.size.width, _fsTabBar.frame.origin.y, _fsTabBar.frame.size.width, _fsTabBar.frame.size.height);
        //_fsTabBar.frame = CGRectMake(0.0, self.view.frame.size.height, _fsTabBar.frame.size.width, _fsTabBar.frame.size.height);
	} else {
		_fsTabBar.frame = CGRectMake(0.0, _fsTabBar.frame.origin.y, _fsTabBar.frame.size.width, _fsTabBar.frame.size.height);
        //_fsTabBar.frame = CGRectMake(0.0, self.view.frame.size.height - _fsTabBar.frame.size.height, _fsTabBar.frame.size.width, _fsTabBar.frame.size.height);
	}
	
	if (animation) {
		[UIView commitAnimations];
	}
	
	if (hide) {
		_fsSelectedViewController.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
	} else {
		_fsSelectedViewController.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height - _fsTabBar.frame.size.height);
	}
}

-(void)setTabBarHided:(BOOL)hide withAnimation:(BOOL)animation{
    
    if (hide) {
        _fsTabBar.alpha = 0.0f;
		_fsSelectedViewController.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
	} else {
        _fsTabBar.alpha = 1.0f;
		_fsSelectedViewController.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height - _fsTabBar.frame.size.height);
	}
}

@end

