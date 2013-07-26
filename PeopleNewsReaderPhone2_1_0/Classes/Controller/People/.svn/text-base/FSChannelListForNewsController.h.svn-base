//
//  FSChannelListForNewsController.h
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-17.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSBaseDataViewController.h"
#import "FSTitleView.h"

#import "FSChannelListForNewsContentView.h"

#import "FSChannelIconsView.h"

@class FSUserSelectObject,FS_GZF_ChannelListDAO;

@interface FSChannelListForNewsController : FSBaseDataViewController<FSTitleViewDelegate,FSBaseContainerViewDelegate>{
@protected
    FSTitleView *_titleView;
    FSChannelListForNewsContentView *_fsChannelListForNewsContentView;
    FSChannelIconsView *_fsChannelIconsView;
    FS_GZF_ChannelListDAO *_fs_GZF_ChannelListDAO;
}

-(FSUserSelectObject *)getUserChannelSelectedObject;
-(void)insertUserSelected:(NSString *)channelid;

@end
