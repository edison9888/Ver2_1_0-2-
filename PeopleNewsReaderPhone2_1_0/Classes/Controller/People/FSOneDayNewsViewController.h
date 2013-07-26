//
//  FSOneDayNewsViewController.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-13.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSBasePeopleViewController.h"
#import "FSOneDayNewsListContainerView.h"


@class FS_GZF_ForOnedayNewsFocusTopDAO,FS_GZF_ForOneDayNewsListDAO,FS_GZF_GetWeatherMessageDAO;

@interface FSOneDayNewsViewController : FSBasePeopleViewController <FSTableContainerViewDelegate,UIGestureRecognizerDelegate>{
@protected
    FSOneDayNewsListContainerView *_fsOneDayNewsListContainerView;
	
	FS_GZF_ForOneDayNewsListDAO *_newsListData;
    FS_GZF_ForOnedayNewsFocusTopDAO *_fsForOneDayNewsListFocusTopData;
    
    FS_GZF_GetWeatherMessageDAO *_fs_GZF_GetWeatherMessageDAO;
    
    NSMutableArray *_sectionMessage;
    
    NSDate *_reFreshDate;
    NSTimeInterval _TimeInterval;
}

-(void)reSetSectionMessage;

@end
