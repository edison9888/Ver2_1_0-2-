//
//  FSUpdateNetworkFlagDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-20.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSUpdateNetworkFlagDAO.h"


@implementation FSUpdateNetworkFlagDAO
@synthesize timestampKind = _timestampKind;
@synthesize updateFlag = _updateFlag;
@synthesize UPDATE_DESC = _UPDATE_DESC;
@synthesize UPDATE_TIME = _UPDATE_TIME;

- (id)init {
	self = [super init];
	if (self) {
		_UPDATE_TIME = 0;
		_timestampKind = TimestampKind_None;
	}
	return self;
}

- (void)dealloc {
	[_updateFlag release];
	[_UPDATE_DESC release];
	[super dealloc];
}

- (void)setTimestampKind:(TimestampKind)value {
	if (value != _timestampKind) {		
		_timestampKind = value;

		dispatch_queue_t queue = dispatch_queue_create(NULL, NULL);
		dispatch_async(queue, ^(void) {
			switch (_timestampKind) {
				case TimestampKind_Channel:
					self.UPDATE_DESC = UPDATE_DESC_CHANNEL_UPDATE;
					break;
				case TimestampKind_City:
					self.UPDATE_DESC = UPDATE_DESC_CITY_UPDATE;
					break;
				default:
					return;
					break;
			}
			//取数据，从
			NSFetchRequest *request = [[NSFetchRequest alloc] init];
			NSEntityDescription *entityDesc = [[NSEntityDescription alloc] init];
			[entityDesc setName:@"UpdateFlag"];
			[request setFetchLimit:1];
			[request setEntity:entityDesc];
			
			NSPredicate *predicate = [NSPredicate predicateWithFormat:@"FLAG_DESC=%@", self.UPDATE_DESC];
			[request setPredicate:predicate];
			NSError *error = nil;
			NSArray *resultSet = [self.managedObjectContext executeFetchRequest:request error:&error];
			if (!error) {
				if (resultSet && [resultSet count] > 0) {
					//有时间戳
					FSUpdateFlagObject *lastUpdateFlag = [resultSet objectAtIndex:0];
					self.UPDATE_TIME = [lastUpdateFlag.FLAG_TIMESTAMP doubleValue];
				} else {
					//没有时间戳
					self.UPDATE_TIME = 0;
				}
			} else {
			}
			
			[entityDesc release];
			[request release];
			
			//异步完成
			//[self HTTPGetDataWithKind:GETDataKind_Refresh];
		});
		dispatch_release(queue);
	}
}

- (BufferDataKind)isExistsBufferData {
	return BufferDataKind_None;
}


- (void)readDataFromBufferWithGETDataKind:(GETDataKind)getDataKind {
	
}

- (NSString *)readDataURLStringFromRemoteHostWithGETDataKind:(GETDataKind)getDataKind {
	return nil;
}

@end
