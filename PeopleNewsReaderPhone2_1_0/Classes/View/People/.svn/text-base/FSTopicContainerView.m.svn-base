//
//  FSTopicContainerView.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-29.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSTopicContainerView.h"
#import "FSFocusTopObject.h"



@implementation FSTopicContainerView

@synthesize selectedIndex = _selectedIndex;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)doSomethingAtDealloc{
    [_fsImagesScrInRowView release];
    
}

-(void)doSomethingAtInit{
    _fsImagesScrInRowView = [[FSImagesScrInRowView alloc] init];
    _fsImagesScrInRowView.parentDelegate = self;
    
    _lab_title = [[UILabel alloc] init];
    _lab_title.font = [UIFont systemFontOfSize:14];
    _lab_title.textColor = COLOR_NEWSLIST_TITLE_WHITE;
    _lab_title.backgroundColor = COLOR_CLEAR;
    _lab_description = [[UILabel alloc] init];
    _lab_description.font = [UIFont systemFontOfSize:10];
    _lab_description.textColor = COLOR_NEWSLIST_TITLE_WHITE;
    _lab_description.backgroundColor = COLOR_CLEAR;
    _lab_description.numberOfLines = 4;
    
    [self addSubview:_fsImagesScrInRowView];
    
    [self addSubview:_lab_title];
    [self addSubview:_lab_description];

    
}

-(void)doSomethingAtLayoutSubviews{
    
    _fsImagesScrInRowView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _fsImagesScrInRowView.imageSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    _fsImagesScrInRowView.pageControlViewShow = YES;
    _fsImagesScrInRowView.spacing = 0.0;
    _fsImagesScrInRowView.bottonHeigh = 100.0f;
    _fsImagesScrInRowView.objectList =  (NSArray *)_data;
    
    _lab_title.frame = CGRectMake(10, self.frame.size.height-90, self.frame.size.width-20, 30);
    _lab_description.frame = CGRectMake(10, self.frame.size.height-60, self.frame.size.width-20, 50);;
    if ([_fsImagesScrInRowView.objectList count]>0) {
        FSFocusTopObject *o = [_fsImagesScrInRowView.objectList objectAtIndex:0];
        _lab_title.text = o.title;
        _lab_description.text = o.picture;
        _selectedIndex = 0;
    }
   
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


-(void)fsBaseContainerViewTouchEvent:(FSBaseContainerView *)sender{
    FSImagesScrInRowView *o = (FSImagesScrInRowView *)sender;
    if (o.isMove) {
        //NSLog(@"FSTodayNewsListTopBigImageCell:%d",o.imageIndex);
        if ([_fsImagesScrInRowView.objectList count]>o.imageIndex) {
            FSFocusTopObject *o1 =[(NSArray *)_data objectAtIndex:o.imageIndex];
            
            _lab_title.text = o1.title;
            _lab_description.text = o1.picture;
        }
    }
    else{
        [self sendTouchEvent];
    }
    
    
}

@end
