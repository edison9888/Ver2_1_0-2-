//
//  FSOneNewsListTopCellTextFloatView.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-9-19.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSOneNewsListTopCellTextFloatView.h"
#import "FSFocusTopObject.h"

@implementation FSOneNewsListTopCellTextFloatView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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


-(void)reSetLabelSty{
    _lab_title.backgroundColor = COLOR_CLEAR;
    _lab_title.font = [UIFont systemFontOfSize:18];
    _lab_title.textColor = COLOR_NEWSLIST_TITLE_WHITE;
    _lab_title.textAlignment = UITextAlignmentLeft;
    _lab_title.numberOfLines = 2;
    
    _lab_description.backgroundColor = COLOR_CLEAR;
    _lab_description.font = [UIFont systemFontOfSize:10];
    _lab_description.textColor = COLOR_NEWSLIST_TITLE_WHITE;
    _lab_description.textAlignment = UITextAlignmentLeft;
    _lab_description.numberOfLines = 3;
}

-(void)doSomethingAtLayoutSubviews{
    
    FSFocusTopObject *o = (FSFocusTopObject *)_data;
    NSLog(@"o.title:%@",o.title);
    _lab_title.text = o.title;
    _lab_title.frame = CGRectMake(16, 0, self.frame.size.width-32, self.frame.size.height);
    
    _lab_description.text = o.picture;
    _lab_description.alpha = 0.0f;
    _lab_description.frame = CGRectMake(0, 40, self.frame.size.width, 45);
}

@end
