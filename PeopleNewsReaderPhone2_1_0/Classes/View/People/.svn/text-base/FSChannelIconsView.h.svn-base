//
//  FSChannelIconsView.h
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-9-10.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSBaseContainerView.h"
#import "FSAsyncCheckImageView.h"

@interface FSChannelIconsView : FSBaseContainerView<UIScrollViewDelegate>{
@protected
    UIScrollView *_scrollView;
    NSInteger _IconsInOneLine;
    ImageCheckType _oldType;
    FSAsyncCheckImageView *_oldfsAsyncCheckImageView;
    NSString *_channelForNewsList;
    BOOL _isForOrdinnews;
    NSString *_selectChannelid;
    
    BOOL _layoutWithLocalData;
}

@property (nonatomic,retain) NSString *channelForNewsList;

@property (nonatomic,retain)  NSString *selectChannelid;

@property (nonatomic, assign) NSInteger IconsInOneLine;

@property (nonatomic,assign) BOOL isForOrdinnews;

@property (nonatomic,assign) BOOL layoutWithLocalData;

-(ImageCheckType)getChannelCheckType:(NSString *)channelid;

-(void)layoutIcons;

-(void)layoutLocalIcons;

@end
