//
//  FSCheckAppStoreVersionDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-9-12.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSCheckAppStoreVersionDAO.h"

#define APPSTORE_ITUNES_LOOKUP_URL @"http://itunes.apple.com/lookup?id=%@"

@interface FSCheckAppStoreVersionDAO(PrivateMethod)
- (BOOL)compareVersionWithAppStoreVersion:(NSString *)version;
@end


@implementation FSCheckAppStoreVersionDAO
@synthesize applicationID = _applicationID;
@synthesize appStoreVersion = _appStoreVersion;
@synthesize appStoreReleaseNotes = _appStoreReleaseNotes;
@synthesize appStoreTrackViewUrl = _appStoreTrackViewUrl;
@synthesize hasNewsAppStoreVersion = _hasNewsAppStoreVersion;

- (id)init {
	self = [super init];
	if (self) {
		_hasNewsAppStoreVersion = NO;
        _isNewsAppStoreVersion = NO;
	}
	return self;
}

- (void)dealloc {
	[_applicationID release];
	[_appStoreVersion release];
	[_appStoreReleaseNotes release];
	[_appStoreTrackViewUrl release];
	[super dealloc];
}

- (BufferDataKind)isExistsBufferData {
	return BufferDataKind_None;
}

- (NSString *)readDataURLStringFromRemoteHostWithGETDataKind:(GETDataKind)getDataKind  {
	return [NSString stringWithFormat:APPSTORE_ITUNES_LOOKUP_URL, _applicationID];
}

- (void)doSomethingWithResult:(id)result {
	if ([result isKindOfClass:[NSDictionary class]]) {
		NSArray *results = [(NSDictionary *)result objectForKey:@"results"];
		if ([results count] > 0) {
			NSDictionary *lastObject = [results objectAtIndex:[results count] - 1];
			self.appStoreVersion = [lastObject objectForKey:@"version"];
			self.appStoreReleaseNotes = [lastObject objectForKey:@"releaseNotes"];
			self.appStoreTrackViewUrl = [lastObject objectForKey:@"trackViewUrl"];
//#ifdef MYDEBUG
//			NSLog(@"self.appStoreVersion:%@", self.appStoreVersion);
//			NSLog(@"self.appStoreReleaseNotes:%@", self.appStoreReleaseNotes);
//#endif
			if (self.appStoreVersion != nil && self.appStoreTrackViewUrl != nil) {
				
				if ([self compareVersionWithAppStoreVersion:self.appStoreVersion]) {
					//弹
					_hasNewsAppStoreVersion = YES;
				} else {
                    _isNewsAppStoreVersion = YES;
				}
				
			} else {
#ifdef MYDEBUG
				NSLog(@"appStore没返回版本号，可能是错误，或者apple已经修改了结果键值");
#endif
			}
			
		} else {
#ifdef MYDEBUG
			NSLog(@"appstore搜索不到结果");
#endif
		}
		
		
	} else {
#ifdef MYDEBUG
		NSLog(@"不是字典的返回结果");
#endif
	}
}

- (BOOL)compareVersionWithAppStoreVersion:(NSString *)version {
	BOOL rst = NO;
	NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
#ifdef MYDEBUG
	NSLog(@"currentVersion:%@", currentVersion);
#endif
	NSArray *curVersions = [currentVersion componentsSeparatedByString:@"."];
	NSArray *remoteVersions = [version componentsSeparatedByString:@"."];
#ifdef MYDEBUG
	NSLog(@"currentVersion:%@[%@]", curVersions, remoteVersions);
#endif		
	NSInteger verIndex = 0;
	BOOL hasResult = NO;
	for (int i = 0; i < MIN([curVersions count], [remoteVersions count]); i++) {
		NSInteger curVerTag = [[curVersions objectAtIndex:i] intValue];
		NSInteger remoteVerTag = [[remoteVersions objectAtIndex:i] intValue];
		if (remoteVerTag > curVerTag) {
			rst = YES;
			hasResult = YES;
			break;
		} else if (remoteVerTag < curVerTag) {
			rst = NO;
			hasResult = YES;
			break;
		}
		verIndex++;
	}
	
	if (!hasResult && !rst) {
		if (verIndex < [remoteVersions count]) {
			rst = YES;
		}
	}
	return rst;
}

@end
