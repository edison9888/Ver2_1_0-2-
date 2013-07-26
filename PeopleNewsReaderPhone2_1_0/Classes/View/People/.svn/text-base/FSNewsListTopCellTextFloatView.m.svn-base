//
//  FSNewsListTopCellTextFloatView.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-9-26.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSNewsListTopCellTextFloatView.h"
#import "FSFocusTopObject.h"

@implementation FSNewsListTopCellTextFloatView

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
    
    _lab_description.backgroundColor = COLOR_CLEAR;
    _lab_description.font = [UIFont systemFontOfSize:12];
    _lab_description.textColor = COLOR_NEWSLIST_TITLE_WHITE;
    _lab_description.textAlignment = UITextAlignmentLeft;
    
}

-(void)doSomethingAtLayoutSubviews{
    
    FSFocusTopObject *o = (FSFocusTopObject *)_data;
    
    _lab_title.text = o.title;
    _lab_title.frame = CGRectMake(12, 0, self.frame.size.width-24, self.frame.size.height);
    
    
    _lab_description.text = o.picture;
    _lab_description.frame = CGRectMake(12, 20, self.frame.size.width-24, 15);
    _lab_description.alpha = 0.0f;
    
}


@end
