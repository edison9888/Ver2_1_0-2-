//
//  FSNewsListTopCell.h
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-9-18.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSTableViewCell.h"
#import "FSImagesScrInRowView.h"

@class FSNewsListTopCellTextFloatView;

@interface FSNewsListTopCell : FSTableViewCell<FSBaseContainerViewDelegate>{
@protected
    UILabel *_lab_time;
    FSNewsListTopCellTextFloatView *_fsNewsListTopCellTextFloatView;
    FSImagesScrInRowView *_fsImagesScrInRowView;
    
    //UILabel *_lab_VisitVolume;
    UILabel *_lab_VVBackground;
    
    UILabel *_lab_NewsType;
    
    //UIImageView *_image_Footprint;
    
    NSInteger _typeMark;
    
    
    
}
@property (nonatomic,assign) NSInteger typeMark;

-(void)setCellKind;
@end
