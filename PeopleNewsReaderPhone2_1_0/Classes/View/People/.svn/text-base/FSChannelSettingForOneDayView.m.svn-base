//
//  FSChannelSettingForOneDayView.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-9-5.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSChannelSettingForOneDayView.h"
#import "FSImagesScrInRowView.h"
#import "FSChannelSettingtTOPCellTextFloatView.h"
#import "FSFocusTopObject.h"
#import "FSBaseDB.h"



#define VISITICON_BEGIN_X 220.0f

#define SETTING_TOP_CELL_HEIGHT 0

@implementation FSChannelSettingForOneDayView

@synthesize isSettingFinish = _isSettingFinish;
@synthesize touchImageNewsIndex = _touchImageNewsIndex;
@synthesize isReSetting = _isReSetting;
@synthesize layoutWithLocalData = _layoutWithLocalData;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.isReSetting = NO;
        _layoutWithLocalData = NO;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


-(void)doSomethingAtDealloc{
    [_fsChannelIconsContainerView release];
    [_lab_notic release];
    [_lab_VisitVolume release];
    [_image_Footprint release];
    [_image_channelBGR release];
    [_image_noticBGR release];
    [_fsImagesScrInRowView release];
    [_fsChannelSettingtTOPCellTextFloatView release];
    [_lab_title release];
    
    
}

-(void)doSomethingAtInit{
    
    self.backgroundColor = COLOR_NEWSLIST_TITLE_WHITE;
    
    _image_channelBGR = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ChannelSettingViewBGR.png"]];
    
    _image_noticBGR = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"灰条.png"]];
    //[self addSubview:_image_channelBGR];
    [self addSubview:_image_noticBGR];
    
    
    
    _fsImagesScrInRowView = [[FSImagesScrInRowView alloc] init];
    _fsImagesScrInRowView.parentDelegate= self;
    
    
    _fsChannelSettingtTOPCellTextFloatView = [[FSChannelSettingtTOPCellTextFloatView alloc] init];
    _fsChannelSettingtTOPCellTextFloatView.userInteractionEnabled = NO;
    
    
    _fsChannelIconsContainerView = [[FSChannelIconsContainerView alloc] init];
    _fsChannelIconsContainerView.parentDelegate = self;
    _fsChannelIconsContainerView.IconsInOneLine = 3;
    _fsChannelIconsContainerView.isForOrdinnews = NO;
    
    _lab_notic = [[UILabel alloc] init];
    _lab_notic.backgroundColor = COLOR_CLEAR;
    _lab_notic.textColor = COLOR_NEWSLIST_TITLE_WHITE;
    _lab_notic.text = @"请选择喜好的栏目";
    
    
//    _bt_settingFinish = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ChannelSettingFinish.png"]];
//    [_bt_settingFinish setBackgroundImage:[UIImage imageNamed:@"ChannelSettingFinish.png"] forState:UIControlStateNormal];
//    [image release];
//    
//    [_bt_settingFinish addTarget:self action:@selector(settingFinish:) forControlEvents:UIControlEventTouchUpInside];
//    [_bt_settingFinish setTitle:@"完成" forState:UIControlStateNormal];
//    _bt_settingFinish.titleLabel.font = [UIFont systemFontOfSize:12];
//    [_bt_settingFinish setTitleColor:COLOR_NEWSLIST_TITLE_WHITE forState:UIControlStateNormal];
//    
//    _bt_settingFinish.alpha = 0.0f;
    
    _lab_VisitVolume = [[UILabel alloc] init];
    _lab_title = [[UILabel alloc] init];
    
    _image_Footprint = [[UIImageView alloc] init];
    _image_Footprint.image = [UIImage imageNamed:@"xin.png"];
    
    _lab_VisitVolume.backgroundColor = COLOR_CLEAR;
    _lab_VisitVolume.textColor = COLOR_NEWSLIST_TITLE_WHITE;
    _lab_VisitVolume.textAlignment = UITextAlignmentLeft;
    _lab_VisitVolume.numberOfLines = 1;
    _lab_VisitVolume.font = [UIFont systemFontOfSize:LIST_BOTTOM_TEXT_FONT];
    
    _lab_title.backgroundColor = COLOR_CLEAR;
    _lab_title.textColor = COLOR_NEWSLIST_TITLE_WHITE;
    _lab_title.textAlignment = UITextAlignmentLeft;
    _lab_title.numberOfLines = 1;
    _lab_title.font = [UIFont systemFontOfSize:14.0f];
    
    
    //[self addSubview:_fsImagesScrInRowView];
    [self addSubview:_fsChannelIconsContainerView];
    [self addSubview:_lab_notic];
    //[self addSubview:_bt_settingFinish];
    //[self addSubview:_fsChannelSettingtTOPCellTextFloatView];
    //[self addSubview:_lab_VisitVolume];
    //[self addSubview:_lab_title];
    //[self addSubview:_image_Footprint];

    _isSettingFinish = NO;
    
}

-(void)doSomethingAtLayoutSubviews{
    
    
    _fsImagesScrInRowView.frame = CGRectMake(0, 0, self.frame.size.width, SETTING_TOP_CELL_HEIGHT);
    _fsImagesScrInRowView.imageSize = CGSizeMake(self.frame.size.width, SETTING_TOP_CELL_HEIGHT);
    _fsImagesScrInRowView.pageControlViewShow = YES;
    _fsImagesScrInRowView.spacing = 0.0f;
    _fsImagesScrInRowView.bottonHeigh = TODAYNEWSLIST_TOP_BOTTOM_HEIGHT;
    
//    if (!self.layoutWithLocalData) {
//        _fsImagesScrInRowView.objectList = [_data valueForKey:@"FSImagesScrInRowView"];
//    }
//    else{
//        _fsImagesScrInRowView.objectList = nil;
//    }
    

    
//    //_bt_settingFinish.frame = CGRectMake(self.frame.size.width-42, TODAYNEWSLIST_TOP_CELL_HEIGHT+2, 34, 27);
//    
//    if (self.isReSetting) {
//        _bt_settingFinish.alpha = 0.0f;
//    }
//    else{
//        _bt_settingFinish.alpha = 1.0f;
//    }
    
    _lab_notic.frame = CGRectMake(15, SETTING_TOP_CELL_HEIGHT-6, self.frame.size.width, 40);
    _image_noticBGR.frame = CGRectMake(0, SETTING_TOP_CELL_HEIGHT-4, self.frame.size.width, 44);
    
    
    _image_Footprint.frame = CGRectMake(VISITICON_BEGIN_X-5, SETTING_TOP_CELL_HEIGHT - 11-9, 11, 11);
    
    _lab_VisitVolume.frame = CGRectMake(VISITICON_BEGIN_X+9, SETTING_TOP_CELL_HEIGHT - TODAYNEWSLIST_TOP_BOTTOM_HEIGHT, self.frame.size.width, SETTING_TOP_CELL_HEIGHT);
    
    _lab_title.frame = CGRectMake(4, SETTING_TOP_CELL_HEIGHT - TODAYNEWSLIST_TOP_BOTTOM_HEIGHT, self.frame.size.width, TODAYNEWSLIST_TOP_BOTTOM_HEIGHT);
    
    
    //NSLog(@"_fsChannelIconsContainerView.objectList = self.objectList;");
    _fsChannelIconsContainerView.frame = CGRectMake(0, SETTING_TOP_CELL_HEIGHT +44, self.frame.size.width, self.frame.size.height -( SETTING_TOP_CELL_HEIGHT +44));
    _fsChannelIconsContainerView.layoutWithLocalData = self.layoutWithLocalData;
    if (self.layoutWithLocalData) {
        [self setChannelIntLocal];
    }
    else{
        _fsChannelIconsContainerView.objectList = (NSArray *)self.data;
    }
    
    
    
    _image_channelBGR.frame = _fsChannelIconsContainerView.frame;
    
    _fsChannelSettingtTOPCellTextFloatView.frame = CGRectMake(0, SETTING_TOP_CELL_HEIGHT-TODAYNEWSLIST_TOP_BOTTOM_HEIGHT-TODAYNEWSLIST_TOP_TITLE_HEIGHT, self.frame.size.width, TODAYNEWSLIST_TOP_TITLE_HEIGHT);
    
    if ([_fsImagesScrInRowView.objectList count]>0) {
        FSFocusTopObject *co = [_fsImagesScrInRowView.objectList objectAtIndex:0];
        //_fsChannelSettingtTOPCellTextFloatView.data = co;
        _lab_title.text = co.title;
        _lab_VisitVolume.text = [co.browserCount stringValue];
        _touchImageNewsIndex = 0;
    }
    else{
        //_fsChannelSettingtTOPCellTextFloatView.alpha = 0.0f;
    }
    
}



//*****************************************************************************************************

-(void)setChannelIntLocal{ //时政 国际 社会 观点 经济 军事 历史 娱乐 生活
    NSArray *channelList = [[NSArray alloc] initWithObjects:@"1_6",@"1_7",@"1_9",@"1_1",@"1_8",@"1_11",@"1_29",@"1_20",@"1_24", nil];
    NSArray *normalImage = [[NSArray alloc] initWithObjects:@"时政_n.png",@"国际_n.png",@"社会_n.png",@"观点_n.png",@"经济_n.png",@"军事_n.png",@"历史_n.png",@"娱乐_n.png",@"健康_n.png",nil];
    NSArray *selectedImage = [[NSArray alloc] initWithObjects:@"时政_s.png",@"国际_s.png",@"社会_s.png",@"观点_s.png",@"经济_s.png",@"军事_s.png",@"历史_s.png",@"娱乐_s.png",@"健康_s.png", nil];
    
    NSMutableDictionary *array = [[NSMutableDictionary alloc] init];
    [array setValue:channelList forKey:@"channelList"];
    [array setValue:normalImage forKey:@"normalImage"];
    [array setValue:selectedImage forKey:@"selectedImage"];
    
    
    for (int i = 0; i < [channelList count]; i++) {
        NSString *obj = [channelList objectAtIndex:i];
        //NSLog(@"channelListData.obj:");
        if (i>2) {
            break;
        }
        [[FSBaseDB sharedFSBaseDB] updata_oneday_selectChannel_message:obj];
    }
    [[GlobalConfig shareConfig] setPostChannel:YES];
    
    _fsChannelIconsContainerView.data = array;
}



-(void)settingFinish:(id)sender{
    _isSettingFinish = YES;
    [self sendTouchEvent];
}


-(void)sendTouchEvent{
    if ([_parentDelegate respondsToSelector:@selector(fsBaseContainerViewTouchEvent:)]) {
        [_parentDelegate fsBaseContainerViewTouchEvent:self];
    }
}

-(void)fsBaseContainerViewTouchEvent:(FSBaseContainerView *)sender{
//#ifndef MYDEBUG
    NSLog(@" fsBaseContainerViewTouchEvent fsBaseContainerViewTouchEvent ");
//#endif
    FSImagesScrInRowView *o = (FSImagesScrInRowView *)sender;
    if (o.isMove) {
        if ([_fsImagesScrInRowView.objectList count]>o.imageIndex) {
            FSFocusTopObject *co = [_fsImagesScrInRowView.objectList objectAtIndex:o.imageIndex];
            _lab_title.text = co.title;
            //_fsChannelSettingtTOPCellTextFloatView.data = co;
            _lab_VisitVolume.text = [co.browserCount stringValue];
        }
    }
    else{
        _touchImageNewsIndex = _touchImageNewsIndex = 0;
        [self sendTouchEvent];
    }
    
}



@end
