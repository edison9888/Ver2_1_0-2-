//
//  FSOfflineDownloadObject.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-9-18.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSOfflineDownloadObject.h"


@implementation FSOfflineDownloadObject
@synthesize managedObjectContext = _managedObjectContext;

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc {
	[_managedObjectContext release];
	[super dealloc];
}

@end
