//
//  FSTabBar.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-6.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSTabBarItem.h"
#import <QuartzCore/QuartzCore.h>

@protocol FSTabBarDelegate;

@interface FSTabBar : UIView {
@private
	NSArray  *_fsItems;
	NSInteger _fsSelectedIndex;
	FSTabBarItem *_currentSelectedItem;
	
	NSObject<FSTabBarDelegate> *_parentDelegate;
}

@property (nonatomic, retain) NSArray *fsItems;
@property (nonatomic) NSInteger fsSelectedIndex;

@property (nonatomic, assign) NSObject<FSTabBarDelegate> *parentDelegate;

@end

@protocol FSTabBarDelegate<NSObject>
@optional
- (void)fsTabBarDidSelected:(FSTabBar*)sender withFsTabIndex:(NSInteger)fsTabIndex;

@end


