//
//  FSRecommendListCell.h
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-28.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSTableViewCell.h"

//@class FSRecommendListCell;
//
//@protocol FSRecommendListCellDelegate<NSObject>
//@required
//- (void)TappedInAppRemmendListCell:(FSRecommendListCell *)cell downloadButton:(UIButton *)button;
//@end


@class FSAsyncImageView;

@interface FSRecommendListCell : FSTableViewCell{
@protected
    FSAsyncImageView *_image_Onleft;
    UILabel *_lab_title;
    UILabel *_lab_description;
    UIButton *_btn_download;
}

//@property (nonatomic, retain) id<FSRecommendListCellDelegate> deleaget;
@property (nonatomic, retain) UIButton *btnDownload;

@end
