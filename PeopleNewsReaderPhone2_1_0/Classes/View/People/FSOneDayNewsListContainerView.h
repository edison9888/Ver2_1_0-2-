//
//  FSOneDayNewsListContainerView.h
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-20.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSTableContainerView.h"
#import "FSTableViewCell.h"

@class FSTimerView;

@interface FSOneDayNewsListContainerView : FSTableContainerView<UIScrollViewDelegate,FSTableViewCellDelegate>{
@protected
    FSTimerView *_timerView;
    NSObject *_timeArray;
    NSObject *_sectionArray;
    NSMutableArray *_heightArray;
}


@property (nonatomic, retain) NSObject *timeArray;
@property (nonatomic, retain) NSObject *sectionArray;


-(void)timerViewMove:(UIScrollView *)scrollView;

@end
