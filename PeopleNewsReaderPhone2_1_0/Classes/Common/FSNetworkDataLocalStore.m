//
//  FSNetworkDataLocalStore.m
//  PeopleDailyReader
//
//  Created by people.com.cn on 12-3-13.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSNetworkDataLocalStore.h"
#import "GlobalConfig.h"

#define URL_ARRAY_URL_KEY @"URL_ARRAY_URL_KEY_STRING"
#define URL_ARRAY_FULLPATH_KEY @"URL_ARRAY_FULLPATH_KEY_STRING"

static NSMutableArray *urls = nil;

@interface FSNetworkDataLocalStore(PrivateMethod)
- (void)removeURLs;
@end


@implementation FSNetworkDataLocalStore
@synthesize localStoreFilePath = _localStoreFilePath;

- (id)init {
	self = [super init];
	if (self) {
		@synchronized(self) {		
			if (urls == nil) {
				urls = [[NSMutableArray alloc] init];
			}
		}
	}
	return self;
}

- (void)dealloc {
	[_localStoreFilePath release];
	[super dealloc];
}

- (void)doSomethingAtFinishLoading {
	//本地存储
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	NSMutableDictionary *userinfo = [[NSMutableDictionary alloc] init];
	[userinfo setObject:_urlString forKey:FSNETWORKDATALOCALSTORE_DOWNLOAD_COMPLETE_URL_KEY];
	[userinfo setObject:_localStoreFilePath forKey:FSNETWORKDATALOCALSTORE_DOWNLOAD_COMPLETE_FULLPATH_KEY];
	
	if (![_bufferData writeToFile:_localStoreFilePath atomically:YES]) {
#ifdef MYDEBUG
		NSLog(@"FSNetworkDataLocalStore.writeFile.error:%@", _localStoreFilePath);
#endif
		
		[[NSNotificationCenter defaultCenter] postNotificationName:FSNETWORKDATALOCALSTORE_DOWNLOAD_ERROR_NOTIFICATION object:self userInfo:userinfo];
	} else {
		[[NSNotificationCenter defaultCenter] postNotificationName:FSNETWORKDATALOCALSTORE_DOWNLOAD_COMPLETE_NOTIFICATION object:self userInfo:userinfo];
	}

	[userinfo release];
	
	[pool release];
	
	[self removeURLs];
}

- (void)doSomethingAtFailWithError {
	
	NSMutableDictionary *userinfo = [[NSMutableDictionary alloc] init];
	[userinfo setObject:_urlString forKey:FSNETWORKDATALOCALSTORE_DOWNLOAD_COMPLETE_URL_KEY];
	[userinfo setObject:_localStoreFilePath forKey:FSNETWORKDATALOCALSTORE_DOWNLOAD_COMPLETE_FULLPATH_KEY];
	[[NSNotificationCenter defaultCenter] postNotificationName:FSNETWORKDATALOCALSTORE_DOWNLOAD_ERROR_NOTIFICATION object:self userInfo:userinfo];
	[userinfo release];
	
	[self removeURLs];
}

- (BOOL)checkCondition {
	BOOL rst = NO;
	
	BOOL isSameURLIsDownloading = NO;
#ifdef MYDEBUG
	NSLog(@"download.url=%@", _urlString);
#endif	
	@synchronized(urls) {

		for (NSDictionary *userinfo in urls) {
			if ([_urlString isEqualToString:[userinfo objectForKey:URL_ARRAY_URL_KEY]] &&
				[_localStoreFilePath isEqualToString:[userinfo objectForKey:URL_ARRAY_FULLPATH_KEY]]) {
				isSameURLIsDownloading = YES;
				break;
			}
		}
		
		//没有相通属性的url在下载中，则加入到下载的hash表中
		if (!isSameURLIsDownloading) {
			NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
			[userInfo setObject:_urlString forKey:URL_ARRAY_URL_KEY];
			[userInfo setObject:_localStoreFilePath forKey:URL_ARRAY_FULLPATH_KEY];
			
			[urls addObject:userInfo];
			
			[userInfo release];
		}
	}
	
	if (isSameURLIsDownloading) {
		//发通知
	} else {
		rst = YES;
	}
	
	return rst;
}

- (void)removeURLs {
	@synchronized(urls) {
		for (NSDictionary *userinfo in urls) {
			if ([_urlString isEqualToString:[userinfo objectForKey:URL_ARRAY_URL_KEY]] &&
				[_localStoreFilePath isEqualToString:[userinfo objectForKey:URL_ARRAY_FULLPATH_KEY]]) {
				[urls removeObject:userinfo];
				break;
			}
		}
	}
}

@end
