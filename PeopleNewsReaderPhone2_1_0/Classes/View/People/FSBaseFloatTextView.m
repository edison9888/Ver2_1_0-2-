//
//  FSBaseFloatTextView.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-9-19.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSBaseFloatTextView.h"

@implementation FSBaseFloatTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = COLOR_FLOAT_BACKGROUND;
        self.userInteractionEnabled = NO;
    }
    return self;
}

-(void)doSomethingAtDealloc{
    [_lab_description release];
    [_lab_title release];
}

-(void)doSomethingAtInit{
    _lab_title = [[UILabel alloc] init];
    _lab_description = [[UILabel alloc] init];
    
    [self addSubview:_lab_title];
    [self addSubview:_lab_description];
    [self reSetLabelSty];
}

-(void)doSomethingAtLayoutSubviews{
    
}

-(void)reSetLabelSty{
    
}

@end
