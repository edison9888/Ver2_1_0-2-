//
//  FSChannelListForNewsContentView.h
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-17.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSChannelIconsView.h"

@interface FSChannelListForNewsContentView : FSChannelIconsView{
@protected
    NSArray *_TitleobjectList;
    UIImageView *_background;
    NSString *_selected_channelID;
}

@property (nonatomic,retain) NSArray *TitleobjectList;
@property (nonatomic,retain) NSString *selected_channelID;

@end

@protocol FSChannelListForNewsContentViewDelegate

-(void)fsChannelListSelectFinish:(FSChannelListForNewsContentView *)sender;

@end