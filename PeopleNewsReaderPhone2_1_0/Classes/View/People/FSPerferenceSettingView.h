//
//  FSPerferenceSettingView.h
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-7.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSTableContainerView.h"
#import "FSTableViewCell.h"

@interface FSPerferenceSettingView : FSTableContainerView<FSTableViewCellDelegate>{
@protected
    UIButton *_ok_button;
    UILabel *_lab_text;
    

}



@end

@protocol FSPerferenceSettingView
@optional
- (void)fsPerferenceSettingViewDidFinish:(FSPerferenceSettingView *)sender withChanels:(NSArray *)chanels;
@end

