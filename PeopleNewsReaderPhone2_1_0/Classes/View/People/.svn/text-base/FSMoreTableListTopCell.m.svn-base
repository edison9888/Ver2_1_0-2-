//
//  FSMoreTableListTopCell.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-28.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSMoreTableListTopCell.h"


@implementation FSMoreTableListTopCell

@synthesize touchedBt = _touchedBt;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

-(void)doSomethingAtInit{
    
//    UIImageView *bgr = [[UIImageView alloc] init];
//    bgr.image = [UIImage imageNamed:@"moreCellBGR.png"];
//    self.backgroundView = bgr; 
//    [bgr release];
    
    self.backgroundColor = COLOR_MORE_TOPCELL;
    
    _bt_setting = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_bt_setting setTitle:@"设置" forState:UIControlStateNormal];
    [_bt_setting setTitleColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1] forState:UIControlStateNormal];
    [_bt_setting setBackgroundImage:[UIImage imageNamed:@"btnSettingBg.png"] forState:UIControlStateNormal];
    _bt_setting.titleLabel.font = [UIFont systemFontOfSize:18];
    
    [_bt_setting addTarget:self action:@selector(popSettingController:) forControlEvents:UIControlEventTouchUpInside];
    
    _bt_about = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_bt_about setTitle:@"关于" forState:UIControlStateNormal];
    [_bt_about setTitleColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1] forState:UIControlStateNormal];
    [_bt_about setBackgroundImage:[UIImage imageNamed:@"btnSettingBg.png"] forState:UIControlStateNormal];
    _bt_about.titleLabel.font = [UIFont systemFontOfSize:18];
    [_bt_about addTarget:self action:@selector(popAboutController:) forControlEvents:UIControlEventTouchUpInside];
    
    _bt_feedback = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_bt_feedback setTitle:@"意见反馈" forState:UIControlStateNormal];
    [_bt_feedback setTitleColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1] forState:UIControlStateNormal];
    _bt_feedback.titleLabel.font = [UIFont systemFontOfSize:18];
    [_bt_feedback setBackgroundImage:[UIImage imageNamed:@"btnSettingBg.png"] forState:UIControlStateNormal];
    [_bt_feedback addTarget:self action:@selector(popFeedbackController:) forControlEvents:UIControlEventTouchUpInside];
    
    _bt_score = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_bt_score setTitle:@"应用评分" forState:UIControlStateNormal];
    [_bt_score setTitleColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1] forState:UIControlStateNormal];
    [_bt_score setBackgroundImage:[UIImage imageNamed:@"btnSettingBg.png"] forState:UIControlStateNormal];
    _bt_score.titleLabel.font = [UIFont systemFontOfSize:18];
    [_bt_score addTarget:self action:@selector(popScoreController:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:_bt_setting];
    [self.contentView addSubview:_bt_about];
    [self.contentView addSubview:_bt_feedback];
    [self.contentView addSubview:_bt_score];
    
    
}

-(void)doSomethingAtDealloc{
    
}

-(void)doSomethingAtLayoutSubviews{
    _bt_setting.frame = CGRectMake(10, 10, 148, 40);
    _bt_about.frame = CGRectMake(168, 10, 148, 40);
    _bt_feedback.frame = CGRectMake(10, 60, 148, 40);
    _bt_score.frame = CGRectMake(168, 60, 148, 40);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)popSettingController:(id)sender{
    _touchedBt = TouchButton_Setting;
    [self respondToTableView];
}

-(void)popAboutController:(id)sender{
    _touchedBt = TouchButton_About;
    [self respondToTableView];
}

-(void)popFeedbackController:(id)sender{
    _touchedBt = TouchButton_Feedback;
    [self respondToTableView];
}

-(void)popScoreController:(id)sender{
    _touchedBt = TouchButton_Score;
    [self respondToTableView];
}

-(void)respondToTableView{
    
    if ([(id)_parentDelegate respondsToSelector:@selector(tableViewCellTouchEvent:)]) {
        [(id)_parentDelegate tableViewCellTouchEvent:self];
    }
    
}


@end
