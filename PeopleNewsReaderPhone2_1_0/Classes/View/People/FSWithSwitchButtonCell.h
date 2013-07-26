//
//  FSWithSwitchButtonCell.h
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-9-14.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSTableViewCell.h"

@interface FSWithSwitchButtonCell : FSTableViewCell{
@protected
    UISwitch *_swichButton; 
    UILabel *_lab_title;
  }

-(void)setYes:(NSInteger)row;
-(void)setNO:(NSInteger)row;

-(void)setButtonState;

@end
