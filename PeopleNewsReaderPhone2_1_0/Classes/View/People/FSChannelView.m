//
//  FSChannelView.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-16.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSChannelView.h"
#import "FSNetworkData.h"

@implementation FSChannelView


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		
		[pool release];
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)networkDataDownloadDataComplete:(FSNetworkData *)sender isError:(BOOL)isError data:(NSData *)data {
	
}

@end
