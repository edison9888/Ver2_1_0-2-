//
//  FSTabBarItem.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-6.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FSTabBarItemDelegate;

@interface FSTabBarItem : UIControl {
@private
	CGFloat _tabBarHeight;
	
	UILabel *_lblText;
	UIImageView *_ivPicture;
	UIImage *_normalImage;
	UIImage *_selectedImage;
}

@property (nonatomic) CGFloat tabBarHeight;

- (void)setTabBarItemWithNormalImage:(UIImage *)normalImage withSelectedImage:(UIImage *)selectedImage withText:(NSString *)text;

@end


@protocol FSTabBarItemDelegate<NSObject>
- (UIImage *)tabBarItemNormalImage;
- (NSString *)tabBarItemText;
- (UIImage *)tabBarItemSelectedImage;
@end


