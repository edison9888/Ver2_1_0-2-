//
//  FSContentTooBarView.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-20.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSContentTooBarView.h"

#define FSCONTENT_HEIGHT (44.0f + 64.0f)

@implementation FSContentTooBarView


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		_toolBar = [[UIToolbar alloc] initWithFrame:CGRectZero];
		[self addSubview:_toolBar];
    }
    return self;
}

- (void)dealloc {
	[_toolBar release];
    [super dealloc];
}

- (void)layoutSubviews {
	[super layoutSubviews];
}


@end
