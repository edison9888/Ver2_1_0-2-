//
//  FSFeedbackViewController.h
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-31.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSBaseDataViewController.h"
#import "FSFeedbackContainerView.h"

@class FS_GZF_FeedbackPOSTXMLDAO;

@interface FSFeedbackViewController : FSBaseDataViewController<FSBaseContainerViewDelegate>{
@protected
    UINavigationBar *_navTopBar; 
    FSFeedbackContainerView *_fsFeedbackContainerView;
    FS_GZF_FeedbackPOSTXMLDAO *_fs_GZF_FeedbackPOSTXMLDAO;
}

@end
