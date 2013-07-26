/*
 *  UniversalEx.c
 *  PartyTopics
 *
 *  Created by people.com.cn on 11-5-24.
 *  Copyright 2011 people.com.cn. All rights reserved.
 *
 */

#include "UniversalEx.h"


int getDirection(UIInterfaceOrientation orientation) 
{
	if (orientation == UIInterfaceOrientationLandscapeLeft ||
		orientation == UIInterfaceOrientationLandscapeRight) {
		return HORIZONTAL_DIRECTION;
	} else {
		return VERTICAL_DIRECTION;
	}
}

CGFloat getStatusBarHeight() 
{
	UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
	/*
	 #define GET_STAUS_HEIGHT (GET_DIRECTION(STATUS_ORIENTATION) == HORIZONTAL_DIRECTION ? \
	 [UIApplication sharedApplication].statusBarFrame.size.width : \
	 [UIApplication sharedApplication].statusBarFrame.size.height)
	 */
	int direction = getDirection(orientation);
	return direction == HORIZONTAL_DIRECTION ? [UIApplication sharedApplication].statusBarFrame.size.width : [UIApplication sharedApplication].statusBarFrame.size.height;
}

CGFloat getCurrentWidth(UIInterfaceOrientation orientation) 
{
	int direction = getDirection(orientation);
	
	return direction == HORIZONTAL_DIRECTION ? [UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].bounds.size.width;
}

CGFloat getCurrentHeight(UIInterfaceOrientation orientation, UIViewController *controller) {
	int direction = getDirection(orientation);	
	CGFloat totalHeight = getStatusBarHeight() + getTotalControllerBarHeight(controller);
	return (direction == HORIZONTAL_DIRECTION ? [UIScreen mainScreen].bounds.size.width : [UIScreen mainScreen].bounds.size.height) - totalHeight;
}

CGRect getCurrentViewFrame(UIInterfaceOrientation orientation, UIViewController *controller) {
	CGFloat ctrlHeight = getTotalControllerBarHeight(controller);
	return CGRectMake(0.0f, (ctrlHeight > 0 ? 0.0f : getStatusBarHeight()), getCurrentWidth(orientation), getCurrentHeight(orientation, controller));
}


CGFloat getTotalControllerBarHeight(UIViewController *controller) {
	CGFloat rst = 0.0f;
	if (controller.tabBarController != nil && !controller.tabBarController.tabBar.hidden) {
		rst += controller.tabBarController.tabBar.frame.size.height;
	}

	if (controller.navigationController != nil && !controller.navigationController.navigationBar.hidden) {
		rst += controller.navigationController.navigationBar.frame.size.height;
	}

	return rst;
}

CGSize getCurrentViewFrameWithKeyboardSize(CGSize keyboardSize, UIInterfaceOrientation orientation, UIViewController *controller) {
	int direction = getDirection(orientation);
	if (controller.modalPresentationStyle != UIModalPresentationFormSheet && 
		controller.navigationController.modalPresentationStyle != UIModalPresentationFormSheet) {
		CGFloat ctrlHeight = 0.0;
		if (controller.navigationController != nil) {
			ctrlHeight = controller.navigationController.navigationBar.frame.size.height;
		}
		
		CGFloat clientHeight = (direction == HORIZONTAL_DIRECTION ? 
								[UIScreen mainScreen].bounds.size.width : 
								[UIScreen mainScreen].bounds.size.height);
		clientHeight -= getStatusBarHeight();
		clientHeight -= ctrlHeight;
		clientHeight -= (direction == HORIZONTAL_DIRECTION ? keyboardSize.width : keyboardSize.height);
		return CGSizeMake(getCurrentWidth(orientation), clientHeight);
	} else {
		CGFloat clientHeight = 0.0f;
		if (direction == HORIZONTAL_DIRECTION) {
			clientHeight = [UIScreen mainScreen].bounds.size.width;
			clientHeight -= getStatusBarHeight();
			if (controller.navigationController != nil) {
				clientHeight -= controller.navigationController.navigationBar.frame.size.height;
			}

			clientHeight -= keyboardSize.width;
		} else {

			CGFloat ctrlHeight = (controller.navigationController != nil ? controller.navigationController.navigationBar.frame.size.height : 0.0f);
			clientHeight = [UIScreen mainScreen].bounds.size.height;
			clientHeight -= ([UIScreen mainScreen].bounds.size.height - controller.view.frame.size.height - ctrlHeight) / 2.0f;
			clientHeight -= keyboardSize.height;
			clientHeight -= ctrlHeight;
			clientHeight -= getStatusBarHeight() / 2.0f;
		}
		return CGSizeMake(controller.view.frame.size.width, clientHeight);
	}
}


