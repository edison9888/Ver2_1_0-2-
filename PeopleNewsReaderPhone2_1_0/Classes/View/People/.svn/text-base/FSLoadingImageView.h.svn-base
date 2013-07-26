//
//  FSLoadingImageView.h
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-4.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FS_GZF_ForLoadingImageDAO;

@interface FSLoadingImageView : UIView{
@protected
    id _parentDelegate;
    NSTimer *_timer;
    BOOL firstTime;
    FS_GZF_ForLoadingImageDAO *_fs_GZF_ForLoadingImageDAO;
    
    UIButton *_returnButton;
    
}

-(void)imageLoadingComplete;

@property (nonatomic,assign) id parentDelegate;


@end

@protocol FSLoadingImageViewDelegate
@optional
- (void)fsLoaddingImageViewWillDisappear:(FSLoadingImageView *)sender;
- (void)fsLoaddingImageViewDidDisappear:(FSLoadingImageView *)sender;
@end
