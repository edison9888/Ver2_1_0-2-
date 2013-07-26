//
//  FSCellContainerObject.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-22.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSCellContainerObject.h"


/*

@implementation FSImageObject

@synthesize image_id = _image_id;
@synthesize image_name = _image_name;
@synthesize image_url = _image_url;
@synthesize isSelect = _isSelect;
@synthesize canShowCover = _canShowCover;

- (void) initMembers {
    _image_id = @"";
	_image_name = @"";
	_image_url = @"";
    _isSelect = NO;
    _canShowCover = NO;
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
@synthesize news_id = _news_id;
@synthesize title = _title;
@synthesize descreption = _descreption;
@synthesize visitCount = _visitCount;
@synthesize news_kind = _news_kind;
@synthesize imagesArray = _imagesArray;
@synthesize cell_kind = _cell_kind;

- (void) initMembers {
    _channel_id = @"";
	_channel_name = @"";
	_channel_en = @"";
	_channel_url = @"";
    _news_id = @"";
    _title = @"";
    _descreption = @"";
    _visitCount = @"";
    _news_kind = @"";
	_imagesArray = [[NSMutableArray alloc] init];
    _cell_kind = @"";
}

- (void) destroyMembers {
	[_channel_id release];
	[_channel_name release];
	[_channel_en release];
	[_channel_url release];
    [_news_id release];
    [_title release];
    [_descreption release];
    [_visitCount release];
    [_news_kind release];
    [_imagesArray removeAllObjects];
    [_imagesArray release];
    [_cell_kind release];
}

@end

*/
@implementation FSCellContainerObject

@synthesize kind = _kind;
@synthesize obj = _obj;
@synthesize array = _array;


- (void) initMembers {
	_array = [[NSMutableArray alloc] init];
    
}

- (void) destroyMembers {
    [_array removeAllObjects];
	[_array release];
	
}

@end

