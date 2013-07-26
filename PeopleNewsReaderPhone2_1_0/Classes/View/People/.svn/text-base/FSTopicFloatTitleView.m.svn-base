//
//  FSTopicFloatTitleView.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-30.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSTopicFloatTitleView.h"

@implementation FSTopicFloatTitleView

@synthesize buttonSelectType = _buttonSelectType;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = COLOR_FLOAT_BACKGROUND;
    }
    return self;
}

-(void)doSomethingAtDealloc{
    [_lab_title release];
    [_lab_time release];
    [_image_left release];
    [_image_right release];
}


-(void)doSomethingAtInit{
    _lab_title = [[UILabel alloc] init];
    _lab_title.backgroundColor = COLOR_CLEAR;
    _lab_title.textColor = COLOR_NEWSLIST_TITLE_WHITE;
    _lab_title.textAlignment = UITextAlignmentLeft;
    
    
    _lab_time = [[UILabel alloc] init];
    _lab_time.backgroundColor = COLOR_CLEAR;
    _lab_time.textColor = COLOR_NEWSLIST_TITLE_WHITE;
    _lab_time.textAlignment = UITextAlignmentRight;
    
    
    _image_left = [[UIImageView alloc] init];
    _image_left.image = [UIImage imageNamed:@"xin.png"];
    _image_right = [[UIImageView alloc] init];
    _image_right.image = [UIImage imageNamed:@"xin.png"];
    
    _bt_left = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_bt_left addTarget:self action:@selector(btLeft:) forControlEvents:UIControlEventTouchUpInside];
    _bt_left.alpha = 0.02;
    
    _bt_right = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_bt_right addTarget:self action:@selector(btRight:) forControlEvents:UIControlEventTouchUpInside];
    _bt_right.alpha = 0.02;
    
    
    [self addSubview:_lab_title];
    [self addSubview:_lab_time];
    [self addSubview:_image_left];
    [self addSubview:_image_right];
    [self addSubview:_bt_left];
    [self addSubview:_bt_right];
    
    
    
}

-(void)doSomethingAtLayoutSubviews{
    _lab_title.text = @"标题 标题 标题";
    _lab_title.font = [UIFont systemFontOfSize:20];
    _lab_title.frame = CGRectMake(15, 0, self.frame.size.width-15, self.frame.size.height-10);
    
    _lab_time.text = @"2012-8-30";
    _lab_time.font = [UIFont systemFontOfSize:14];
    _lab_time.frame = CGRectMake(15, 0, self.frame.size.width-25, 25);
    
    _image_left.frame = CGRectMake(0, self.frame.size.height-30, 30, 30);
    _bt_left.frame = CGRectMake(0, self.frame.size.height-30, 30, 30);
    
    _image_right.frame = CGRectMake(self.frame.size.width-30, self.frame.size.height-30, 30, 30);
    _bt_right.frame = CGRectMake(self.frame.size.width-30, self.frame.size.height-30, 30, 30);
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


-(void)btLeft:(id)sender{
    _buttonSelectType = ButtonSelectType_Left;
    if ([_parentDelegate respondsToSelector:@selector(fsBaseContainerViewTouchEvent:)]) {
        [_parentDelegate fsBaseContainerViewTouchEvent:self];
    }
}



-(void)btRight:(id)sender{
    _buttonSelectType = ButtonSelectType_Right;
    if ([_parentDelegate respondsToSelector:@selector(fsBaseContainerViewTouchEvent:)]) {
        [_parentDelegate fsBaseContainerViewTouchEvent:self];
    }
}




@end
