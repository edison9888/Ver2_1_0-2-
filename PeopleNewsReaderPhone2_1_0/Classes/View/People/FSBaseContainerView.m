//
//  FSBaseContainerView.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-29.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSBaseContainerView.h"


@implementation FSBaseContainerView

@synthesize data = _data;
@synthesize objectList = _objectList;
@synthesize parentDelegate = _parentDelegate;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _data = nil;
        [self doSomethingAtInit];
    }
    return self;
}

-(void)dealloc{
    //NSLog(@"view dealloc:%@",self);
    _parentDelegate = nil;
    [_data release];
    [_objectList release];
    [self doSomethingAtDealloc];
    [super dealloc];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize currentSize = self.frame.size;
	if (!CGSizeEqualToSize(_clientSize, currentSize)) {
		_clientSize = currentSize;
		[self doSomethingAtLayoutSubviews];
	}
}


-(void)doSomethingAtInit{
    
}

-(void)doSomethingAtDealloc{
    
}

-(void)doSomethingAtLayoutSubviews{
    
}

- (void)setData:(NSObject *)value {
	if (value != _data && value != nil) {
        if ([_data retainCount]>1) {
            [_data release];
        }
		_data = [value retain];
        _clientSize = CGSizeZero;
		[self setNeedsLayout];
	}
}

-(void)setArray:(NSArray *)objectList{
    if (objectList != _objectList && objectList != nil) {
		[_objectList release];
		_objectList = [objectList retain];
        _clientSize = CGSizeZero;
		[self setNeedsLayout];
	}
}


-(void)sendTouchEvent{
//#ifndef MYDEBUG
    //NSLog(@"FSBaseView sendTouchEvent");
//#endif 
    if ([_parentDelegate respondsToSelector:@selector(fsBaseContainerViewTouchEvent:)]) {
        [_parentDelegate fsBaseContainerViewTouchEvent:self];
    }
}



@end
