//
//  FSTimeViewForSection.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-9-13.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSTimeViewForSection.h"
#import "FSSectionObject.h"

@implementation FSTimeViewForSection

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)doSomethingAtDealloc{
    [_lab_day release];
    [_lab_week release];
    [_lab_YM release];
    [_baseBackground release];
    [_image_backgroud release];
}

-(void)doSomethingAtInit{
    self.backgroundColor = COLOR_WHITE_9;
    
    _bottomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"OneDaySection_shadow.png"]];
    _bottomImage.frame = CGRectZero;
    
    
    //_image_backgroud = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"time.png"]];
    _image_backgroud = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"oneday_time.png"]];
    _image_backgroud.frame = CGRectZero;
    
    _baseBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"oneday_timeline.png"]];
    _baseBackground.frame = CGRectZero;
    
    
    _lab_day = [[UILabel alloc] init];
    _lab_week = [[UILabel alloc] init];
    _lab_YM = [[UILabel alloc] init];
    
    //[self addSubview:_bottomImage];
    [self addSubview:_baseBackground];
    [self addSubview:_image_backgroud];
    [self addSubview:_lab_day];
    [self addSubview:_lab_week];
    [self addSubview:_lab_YM];
    
    
    _lab_day.font = [UIFont systemFontOfSize:20];
    _lab_day.backgroundColor = COLOR_CLEAR;
    _lab_day.textColor = COLOR_BLACK;
    _lab_day.textAlignment = UITextAlignmentCenter;
    
    _lab_week.font = [UIFont systemFontOfSize:12];
    _lab_week.backgroundColor = COLOR_CLEAR;
    _lab_week.textColor = COLOR_NEWSLIST_DESCRIPTION;
    
    _lab_YM.font = [UIFont systemFontOfSize:12];
    _lab_YM.backgroundColor = COLOR_CLEAR;
    _lab_YM.textColor = COLOR_NEWSLIST_DESCRIPTION;
    
}

-(void)doSomethingAtLayoutSubviews{
    
    FSSectionObject *o = (FSSectionObject *)_data;
    if (o==nil) {
        return;
    }
    
    _lab_day.text = [o.day substringFromIndex:8];
    _lab_week.text = o.week;
    _lab_YM.text = [o.day substringToIndex:7];
    
    _lab_day.frame = CGRectMake(113, 0, 37, 37);
    _lab_week.frame = CGRectMake(46, 4, 60, 14);
    _lab_YM.frame = CGRectMake(46, 20, 60, 14);
    _image_backgroud.frame = CGRectMake(0, 0, _image_backgroud.image.size.width, _image_backgroud.image.size.height);
    _baseBackground.frame = CGRectMake(26.0f, 0, 2.0f, self.frame.size.height);
    
    _bottomImage.frame = CGRectMake(0, self.frame.size.height-4, self.frame.size.width, 4);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
