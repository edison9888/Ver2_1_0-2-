/*
 *  UniversalEx.h
 *  PartyTopics
 *
 *  Created by people.com.cn on 11-5-24.
 *  Copyright 2011 people.com.cn. All rights reserved.
 *
 */
#import <Foundation/Foundation.h>

#define HORIZONTAL_DIRECTION 1	//横
#define VERTICAL_DIRECTION 2	//竖

#define IS_IPAD ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)] && [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) 


FOUNDATION_EXTERN int getDirection(UIInterfaceOrientation orientation);

FOUNDATION_EXTERN CGFloat getStatusBarHeight();

FOUNDATION_EXTERN CGFloat getCurrentWidth(UIInterfaceOrientation orientation);

FOUNDATION_EXTERN CGFloat getTotalControllerBarHeight(UIViewController *controller);

FOUNDATION_EXTERN CGFloat getCurrentHeight(UIInterfaceOrientation orientation, UIViewController *controller);

FOUNDATION_EXTERN CGRect getCurrentViewFrame(UIInterfaceOrientation orientation, UIViewController *controller);

FOUNDATION_EXTERN CGSize getCurrentViewFrameWithKeyboardSize(CGSize keyboardSize, UIInterfaceOrientation orientation, UIViewController *controller);

