//
//  FSTodayNewsListTopBigImageCell.h
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-1.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSTableViewCell.h"
#import "FSImagesScrInRowView.h"

@class FSOneNewsListTopCellTextFloatView;

@interface FSTodayNewsListTopBigImageCell : FSTableViewCell<FSBaseContainerViewDelegate>{
@protected
    FSImagesScrInRowView *_fsImagesScrInRowView;
    
    //FSOneNewsListTopCellTextFloatView *_fsOneNewsListTopCellTextFloatView;
    //UILabel *_lab_VisitVolume;
    UILabel *_lab_VVBackground;
    
    UILabel *_lab_NewsType;
    
    //UIImageView *_image_Footprint;
    
    NSInteger _typeMark;
    
}
@property (nonatomic,assign) NSInteger typeMark;

-(void)setCellKind;

@end


