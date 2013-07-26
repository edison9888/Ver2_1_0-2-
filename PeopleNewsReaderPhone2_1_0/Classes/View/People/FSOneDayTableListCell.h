//
//  FSOneDayTableListCell.h
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-9-4.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSTableViewCell.h"

@interface FSOneDayTableListCell : FSTableViewCell{
@protected
    
    
    
    UILabel *_lab_title;
    UILabel *_lab_description;
    //UILabel *_lab_VisitVolume;
    //UILabel *_lab_newsType;
    
    FSAsyncImageView *_image_channelIcon;
    UIImageView *_image_Icon;
    FSAsyncImageView *_image_newsimage;
    
//    UIImageView *_cellbackground;
//    UIImageView *_labContainbackground;
    
//    UIImageView *_cellBOXtop;
//    UIImageView *_cellBOXmidle;
//    UIImageView *_cellBOXbottom;

    UIView *_contenBGRView;
    UIView *_lineView;
    UIView *_cellLeftLine;
    
    UIImageView *_oneday_eastImage;

    //UIImageView *_image_VisitIcon;
    
}

-(void)setContainer;

-(BOOL)isDownloadPic;

@end
