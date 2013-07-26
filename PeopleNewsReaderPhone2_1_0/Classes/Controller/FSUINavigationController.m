    //
//  FSUINavigationController.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-9.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSUINavigationController.h"

#ifndef __IPHONE_5_0

@implementation UINavigationBar(CustomBackground)

- (void)drawRect:(CGRect)rect {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	UIImage *image = [UIImage imageNamed: @"navigatorBar.png"];
	[image drawInRect:CGRectMake((self.frame.size.width - image.size.width) / 2.0f, 0, image.size.width, self.frame.size.height)];
	[pool release];
}
@end

#endif

@implementation FSUINavigationController

- (id)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
#ifdef __IPHONE_5_0
        [self.navigationBar setBackgroundImage:[UIImage imageNamed: @"navigatorBar.png"] forBarMetrics:UIBarMetricsDefault];
#endif
    }
    return self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
	[super pushViewController:viewController animated:animated];
}



@end
