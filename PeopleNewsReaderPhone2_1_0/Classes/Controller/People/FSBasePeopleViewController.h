//
//  FSBasePeopleViewController.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-13.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSBaseDataViewController.h"
#import "FSTabBarItem.h"
#import "FSWeatherView.h"


@interface FSBasePeopleViewController : FSBaseDataViewController <FSTabBarItemDelegate> {
@protected 
    FSWeatherView *_fsWeatherView;
    BOOL _right_lock;
    BOOL _left_lock;
}

-(void)updataWeatherMessage;

@end
