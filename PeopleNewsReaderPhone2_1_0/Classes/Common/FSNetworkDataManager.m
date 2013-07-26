//
//  FSNetworkDataManager.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-13.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSNetworkDataManager.h"
#import "FSOpration.h"


@interface FSNetworkDataManager(PrivateMethod)
- (BOOL)existsNetworkDataWithURLString:(NSString *)URLString withLocalFilePath:(NSString *)localFilePath;
- (void)initializeNetworkDataList;
@end


@implementation FSNetworkDataManager

static FSNetworkDataManager *_globalNetworkManager = nil;

- (id)init {
	self = [super init];
	if (self) {
		//_networkDataList
        _queue = [[NSOperationQueue alloc] init];
        [_queue  setMaxConcurrentOperationCount:3];
	}
	return self;
}

+ (FSNetworkDataManager *)shareNetworkDataManager {
	@synchronized(self) {
		if (_globalNetworkManager == nil) {
			_globalNetworkManager = [[self alloc] init];
			[_globalNetworkManager initializeNetworkDataList];
		}
	}
	return _globalNetworkManager;
}

/////////////////////////////////////////////////////////////////
//覆盖父类的方法
/////////////////////////////////////////////////////////////////
+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (_globalNetworkManager == nil) {
            _globalNetworkManager = [super allocWithZone:zone];
			return _globalNetworkManager;  // assignment and return on first allocation
		}
	}
	
	return nil; //on subsequent allocation attempts return nil
}

/////////////////////////////////////////////////////////////////
//	不允许拷贝
/////////////////////////////////////////////////////////////////
- (id)copyWithZone:(NSZone *)zone {
	return self;
}

/////////////////////////////////////////////////////////////////
//	不允许保留
/////////////////////////////////////////////////////////////////
- (id)retain {
	return self;
}

/////////////////////////////////////////////////////////////////
//	返回最大引用计数
/////////////////////////////////////////////////////////////////
- (unsigned)retainCount {
	return UINT_MAX;  //denotes an object that cannot be released
}

/////////////////////////////////////////////////////////////////
//	全局的不允许释放
/////////////////////////////////////////////////////////////////
- (void)release {
	//do nothing
}

/////////////////////////////////////////////////////////////////
//	自动释放返回自己
/////////////////////////////////////////////////////////////////
- (id)autorelease {
	return self;
}

/////////////////////////////////////////////////////////////////
- (NSData *)networkDataWithURLString:(NSString *)URLString withLocalFilePath:(NSString *)localFilePath withDelegate:(id)delegate{
//	if ([self existsNetworkDataWithURLString:URLString withLocalFilePath:localFilePath]) {
//		return nil;
//	} else {
//		return [FSNetworkData networkDataWithURLString:URLString withLocalStoreFileName:localFilePath withDelegate:self];
//	}
    
    if ([self existsNetworkDataWithURLString:URLString withLocalFilePath:localFilePath]) {
		return nil;
	} else {
        if ([[NSFileManager defaultManager] fileExistsAtPath:localFilePath]) {
            return [NSData dataWithContentsOfFile:localFilePath];
        }
        else{
            //NSLog(@"addOperation:%d",[_queue operationCount]);
            FSOpration *opration = [[FSOpration alloc] initWithURL:URLString withLocalFilePath:localFilePath withDelegate:delegate];
            [_queue addOperation:opration];
            [opration release];
        }
		return nil;
	}
}

-(void)CancelAllOpration{
    [_queue cancelAllOperations];
}

- (void)networkDataDownloadDataComplete:(FSNetworkData *)sender isError:(BOOL)isError data:(NSData *)data {
#ifdef MYDEBUG
    //NSLog(@"networkDataDownloadDataComplete");
#endif
	dispatch_queue_t queue = dispatch_queue_create(NULL, NULL);
	dispatch_async(queue, ^(void) {
		@synchronized(_networkDataList) {
			[_networkDataList removeObjectForKey:sender.urlString];
		}
		
		dispatch_async(dispatch_get_main_queue(), ^(void) {
			NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
            if (sender.urlString == nil) {
                [userInfo setObject:@"" forKey:FSNETWORKDATA_MANAGER_URLSTRING_KEY];
            }
            else{
                [userInfo setObject:sender.urlString forKey:FSNETWORKDATA_MANAGER_URLSTRING_KEY];
            }
			[userInfo setObject:sender.localStoreFilePath forKey:FSNETWORKDATA_MANAGER_LOCALFILEPATH_KEY];
			[[NSNotificationCenter defaultCenter] postNotificationName:(isError ? FSNETWORKDATA_MANAGER_END_DOWNLOADING_ERROR_NOTIFICATION : FSNETWORKDATA_MANAGER_END_DOWNLOADING_COMPLETE_NOTIFICATION) object:self userInfo:userInfo];
			[userInfo release];
		});

	});
	dispatch_release(queue);
}

- (void)networkDataDownloading:(FSNetworkData *)sender maxLength:(long long)maxLength {
	dispatch_queue_t queue = dispatch_queue_create(NULL, NULL);
	dispatch_async(queue, ^(void) {
		@synchronized(_networkDataList) {
			[_networkDataList setObject:sender forKey:sender.urlString];
		}
		
		dispatch_async(dispatch_get_main_queue(), ^(void) {
			NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
            if (sender.urlString == nil) {
                [userInfo setObject:@"" forKey:FSNETWORKDATA_MANAGER_URLSTRING_KEY];
            }
            else{
                [userInfo setObject:sender.urlString forKey:FSNETWORKDATA_MANAGER_URLSTRING_KEY];
            }
            
			
			[userInfo setObject:sender.localStoreFilePath forKey:FSNETWORKDATA_MANAGER_LOCALFILEPATH_KEY];
			[[NSNotificationCenter defaultCenter] postNotificationName:FSNETWORKDATA_MANAGER_BEGIN_DOWNLOADING_NOTIFICATION object:self userInfo:userInfo];
			[userInfo release];
		});
	});
	dispatch_release(queue);
}

- (void)networkDataDownloadingProgressing:(FSNetworkData *)sender totalLength:(long long)totalLength {
	
}

- (BOOL)existsNetworkDataWithURLString:(NSString *)URLString withLocalFilePath:(NSString *)localFilePath {
	BOOL result = NO;
	@synchronized(_networkDataList) {
		FSNetworkData *networkData = (FSNetworkData *)[_networkDataList objectForKey:URLString];
		result = (networkData != nil);
	}
	return result;
}

- (void)initializeNetworkDataList {
	_networkDataList = [[NSMutableDictionary alloc] init];
}

@end
