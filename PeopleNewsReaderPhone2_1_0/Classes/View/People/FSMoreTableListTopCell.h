//
//  FSMoreTableListTopCell.h
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-28.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSTableViewCell.h"


typedef  enum _TouchButton{
    TouchButton_Setting,
    TouchButton_About,
    TouchButton_Feedback,
    TouchButton_Score,
}TouchButton;



@interface FSMoreTableListTopCell : FSTableViewCell{
@protected
    UIButton *_bt_setting;
    UIButton *_bt_about;
    UIButton *_bt_feedback;
    UIButton *_bt_score;
    TouchButton _touchedBt;
}

@property (nonatomic,assign) TouchButton touchedBt;



-(void)respondToTableView;

@end
