//
//  FSChannelSettingForOneDayViewController.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-16.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSBaseDataViewController.h"
#import "FSChannelSettingForOneDayView.h"

typedef enum _FSChannelSettingForOneDayDismissKind {
	FSChannelSettingForOneDayDismissKind_DismissModalViewController,
	FSChannelSettingForOneDayDismissKind_ClipToLeft
} FSChannelSettingForOneDayDismissKind;

//@class FSUpdateNetworkFlagDAO;
@class FS_GZF_ChannelListDAO;
@class FSOneDayChannelSelectedDAO;
@class FS_GZF_ForOnedayNewsFocusTopDAO;
@class FSNewbieGuideView;

@interface FSChannelSettingForOneDayViewController : FSBaseDataViewController <FSBaseContainerViewDelegate> {
@private
	id _parentDelegate;
    
    FSChannelSettingForOneDayView *_fsChannelSettingForOneDayView;
	
	//FSUpdateNetworkFlagDAO *_updateNetworkFlagData;
	FS_GZF_ChannelListDAO *_fs_GZF_ChannelListDAO;
	FSOneDayChannelSelectedDAO *_channelSelectedData;
    
    
    FS_GZF_ForOnedayNewsFocusTopDAO *_fs_GZF_ForOnedayNewsFocusTopDAO;
    
    UINavigationBar *_navTopBar;
    BOOL _isReSetting;
    
    
    FSNewbieGuideView *_fsNewbieGuideView;
    
}

@property (nonatomic, assign) id parentDelegate;
@property (nonatomic,assign) BOOL isReSetting;

- (void)dismissWithKind:(FSChannelSettingForOneDayDismissKind)kind;



@end

@protocol FSChannelSettingForOneDayViewControllerDelegate
@optional
- (void)fsChannelSettingForOneDayViewControllerWillDisapear:(FSChannelSettingForOneDayViewController *)sender;
- (void)fsChannelSettingForOneDayViewControllerDidDisapper:(FSChannelSettingForOneDayViewController *)sender;
@end


