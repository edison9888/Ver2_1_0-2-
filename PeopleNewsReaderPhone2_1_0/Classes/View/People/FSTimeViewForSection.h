//
//  FSTimeViewForSection.h
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-9-13.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSBaseContainerView.h"

@interface FSTimeViewForSection : FSBaseContainerView{
@protected
    UILabel *_lab_day;
    UILabel *_lab_week;
    UILabel *_lab_YM;
    UIImageView *_image_backgroud;
    UIImageView *_baseBackground;
    UIImageView *_bottomImage;
    
}

@end
