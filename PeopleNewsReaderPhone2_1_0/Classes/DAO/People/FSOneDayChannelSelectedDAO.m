//
//  FSOneDayChannelSelectedDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-9-7.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSOneDayChannelSelectedDAO.h"
#import "GlobalConfig.h"

#define FS_ONEDAY_CHANNEL_SELECTED_URL @"http://mobile.app.people.com.cn:81/news2/news.php?act=channel_deliver&rt=xml"

@implementation FSOneDayChannelSelectedDAO
@synthesize channelIDs = _channelIDs;

- (id)init {
	self = [super init];
	if (self) {
		
	}
	return self;
}

- (void)dealloc {
	[_channelIDs release];
	[super dealloc];
}

- (NSString *)HTTPPostURLString {
	return FS_ONEDAY_CHANNEL_SELECTED_URL;
}

- (void)HTTPBuildPostItems:(NSMutableArray *)postItems withPostKind:(HTTPPOSTDataKind)postKind {
	FSHTTPPOSTItem *deviceItem = [[FSHTTPPOSTItem alloc] initWithName:@"deviceid" withValue:[[GlobalConfig shareConfig] getDeviceUnique_ID]];
	[postItems addObject:deviceItem];
	[deviceItem release];
	
	NSMutableString *strChannelIDs = [[NSMutableString alloc] init];
	for (NSString *channelID in _channelIDs) {
		[strChannelIDs appendFormat:@"%@#", channelID];
	}
	FSHTTPPOSTItem *channelItem = [[FSHTTPPOSTItem alloc] initWithName:@"channelid" withValue:strChannelIDs];
	[postItems addObject:channelItem];
	[channelItem release];
	[strChannelIDs release];
}


- (void)baseXMLParserFinishXMLObjectNode:(FSBaseXMLParserObject *)sender withXMLResultObject:(id)resultObject {
#ifdef MYDEBUG
	NSLog(@"resultObject:%@", resultObject);
#endif
	if ([resultObject isKindOfClass:[NSDictionary class]]) {
		NSString *strErrCode = [(NSDictionary *)resultObject objectForKey:@"errorCode"];
		self.errorCode = [strErrCode intValue];
		if (self.errorCode != 0) {
			/*
			 1、提交失败
			 2、设备id空
			 */
			self.errorMessage = NSLocalizedString(@"频道提交失败", nil);
		}
	}
}

@end
