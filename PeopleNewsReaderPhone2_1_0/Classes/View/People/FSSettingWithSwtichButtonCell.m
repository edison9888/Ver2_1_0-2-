//
//  FSWithSwitchButtonCell.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-9-14.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSSettingWithSwitchButtonCell.h"
#import "GlobalConfig.h"
#import "PeopleNewsReaderPhoneAppDelegate.h"
@implementation FSSettingWithSwitchButtonCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}



-(void)doSomethingAtDealloc{
    [_swichButton release];
    [_lab_title release];
}

-(void)doSomethingAtInit{
    
    
    //    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CellBackground.png"]];
    //    self.backgroundView = image;
    //    [image release];
    
    self.backgroundColor = COLOR_NEWSLIST_TITLE_WHITE;
    
    _swichButton = [[UISwitch alloc] init];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) {
        _swichButton.onTintColor = [UIColor colorWithRed:204.0/255.0 green:102.0/255 blue:102.0/255.0 alpha:1];
    }
    
    [_swichButton addTarget:self action:@selector(ButtonSelect:) forControlEvents:UIControlEventTouchUpInside];
    _lab_title = [[UILabel alloc] init];
    _lab_title.backgroundColor = COLOR_CLEAR;
    _lab_title.textColor = COLOR_NEWSLIST_TITLE;//[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
    
    
    
    
    //[self.contentView addSubview:_lab_title];
    [self.contentView addSubview:_swichButton];
}

-(void)doSomethingAtLayoutSubviews{
    
    _lab_title.text = (NSString *)_data;
    self.textLabel.text = (NSString *)_data;
    self.textLabel.backgroundColor = COLOR_CLEAR;
    _lab_title.frame = CGRectMake(10, 0, self.frame.size.width - 50, self.frame.size.height);
    _swichButton.frame = CGRectMake(self.frame.size.width - 105, 5, 20, 30);
    [self setButtonState];
}

-(void)setButtonState{
    switch (self.rowIndex) {
        case 4:
            [_swichButton setOn:[[GlobalConfig shareConfig] readImportantNewsPush]];
            break;
        case 0://正文全屏 与更多页不同
            [_swichButton setOn:[[GlobalConfig shareConfig] readContentFullScreen]];
            break;
        case 1://加载图片
            [_swichButton setOn:![[GlobalConfig shareConfig] isDownloadPictureUseing2G_3G]];
            break;
        default:
            break;
    }
}

-(void)ButtonSelect:(id)sender{
    UISwitch *b = (UISwitch *)sender;
    if (b.on == YES) {
        [self setYes:self.rowIndex];
        NSLog(@"ButtonSelect yes:%d",self.rowIndex);
    }
    else{
        [self setNO:self.rowIndex];
        NSLog(@"ButtonSelect OFF:%d",self.rowIndex);
    }
    //更新更多
    PeopleNewsReaderPhoneAppDelegate* appDelegate = (PeopleNewsReaderPhoneAppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate updateMoreControllerView];
}

-(void)setYes:(NSInteger)row{
    switch (row) {
        case 4:
            [[GlobalConfig shareConfig] setImportantNewsPush:YES];
            //注册推送
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes: (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
            break;
        case  0:
            [[GlobalConfig shareConfig] setContentFullScreen:YES];
            break;
        case 1:
            [[GlobalConfig shareConfig] setDownloadPictureUseing2G_3G:NO];
            break;
        default:
            break;
    }
}

-(void)setNO:(NSInteger)row{
    switch (row) {
        case 4:
            [[GlobalConfig shareConfig] setImportantNewsPush:NO];
            //注销推送
            [[UIApplication sharedApplication] unregisterForRemoteNotifications];
            break;
        case 0:
            [[GlobalConfig shareConfig] setContentFullScreen:NO];
            break;
        case 1:
            [[GlobalConfig shareConfig] setDownloadPictureUseing2G_3G:YES];
            break;
        default:
            break;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
