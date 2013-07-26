//
//  FSNewsViewController.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-13.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSBasePeopleViewController.h"
#import "FSTitleView.h"
#import "FSRoutineNewsListContentView.h"

@class FS_GZF_ForOnedayNewsFocusTopDAO,FS_GZF_ForNewsListDAO,FSUserSelectObject,FS_GZF_ChannelListDAO;

@interface FSNewsViewController : FSBasePeopleViewController <FSTitleViewDelegate,FSTableContainerViewDelegate,UIGestureRecognizerDelegate>{
@protected
    FSRoutineNewsListContentView *_routineNewsListContentView;
    FSTitleView *_titleView;
    
    FS_GZF_ForOnedayNewsFocusTopDAO *_fs_GZF_ForOnedayNewsFocusTopDAO;
    FS_GZF_ChannelListDAO *_fs_GZF_ChannelListDAO;
    FS_GZF_ForNewsListDAO *_fs_GZF_ForNewsListDAO;
    NSDate *_reFreshDate;
    
    BOOL _isfirstShow;
}

-(FSUserSelectObject *)getUserChannelSelectedObject;

-(BOOL)channleISexp:(FSUserSelectObject *)obj;


@end
