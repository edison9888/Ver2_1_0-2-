//
//  FSCellImagesObject.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-22.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSCellImagesObject.h"

@implementation FSImageObject

@synthesize image_id = _image_id;
@synthesize image_name = _image_name;
@synthesize image_url = _image_url;



- (id) init {
	if (self = [super init]) {
		[self initMembers];
	}
	return self;
}

- (void) dealloc {
	[self destroyMembers];
	[super dealloc];
}



- (void) initMembers {
    _image_id = @"";
	_image_name = @"";
	_image_url = @"";
}

- (void) destroyMembers {
	[_image_id release];
	[_image_name release];
	[_image_url release];
}

@end

@implementation FSCellImagesObject

@synthesize channel_id = _channel_id;
@synthesize channel_name = _channel_name;
@synthesize channel_en = _channel_en;
@synthesize channel_url = _channel_url;
@synthesize channel_icons = _channel_icons;
@synthesize channel_kind = _channel_kind;

- (id) init {
	if (self = [super init]) {
		[self initMembers];
	}
	return self;
}

- (void) dealloc {
	[self destroyMembers];
	[super dealloc];
}



- (void) initMembers {
	_channel_id = @"";
	_channel_name = @"";
	_channel_en = @"";
	_channel_url = @"";
	_channel_icons = [[NSMutableArray alloc] init];
    _channel_kind = @"";
}

- (void) destroyMembers {
	[_channel_id release];
	[_channel_name release];
	[_channel_en release];
	[_channel_url release];
	[_channel_kind release];
    [_channel_icons removeAllObjects];
    [_channel_icons release];
}

@end

