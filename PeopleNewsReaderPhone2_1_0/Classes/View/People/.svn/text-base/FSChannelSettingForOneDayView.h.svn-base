//
//  FSChannelSettingForOneDayView.h
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-9-5.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSBaseContainerView.h"
#import "FSChannelIconsContainerView.h"


@class FSImagesScrInRowView;
@class FSChannelSettingtTOPCellTextFloatView;


@interface FSChannelSettingForOneDayView : FSBaseContainerView<FSBaseContainerViewDelegate>{
@protected
        
    FSImagesScrInRowView *_fsImagesScrInRowView;
    FSChannelSettingtTOPCellTextFloatView *_fsChannelSettingtTOPCellTextFloatView;
    FSChannelIconsContainerView *_fsChannelIconsContainerView;
    
    UILabel *_lab_notic;
    //UIButton *_bt_settingFinish;
    BOOL _isSettingFinish;
    
    UIImageView *_image_channelBGR;
    UIImageView *_image_noticBGR;
    
    UILabel *_lab_VisitVolume;
    UIImageView *_image_Footprint;
    UILabel *_lab_title;
    NSInteger _touchImageNewsIndex;
    
    BOOL _isReSetting;
    
    BOOL _layoutWithLocalData;
    
}

@property (nonatomic, assign) BOOL isSettingFinish;
@property (nonatomic, assign) BOOL isReSetting;
@property (nonatomic, assign) BOOL layoutWithLocalData;
@property (nonatomic,assign) NSInteger touchImageNewsIndex;


-(void)setChannelIntLocal;

@end

