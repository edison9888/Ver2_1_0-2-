//
//  FSBaseNetworkDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-6.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSBaseNetworkDAO.h"
#import <zlib.h>
#import "FSCommonFunction.h"


#define COREDATA_MODEL_EXTENSION_STRING @"momd" 
#define COREDATA_LOCALSTORE_EXTENSION_STRING @".sqlite"

@interface FSBaseNetworkDAO(PrivateMethod)
- (void)exitNonMainThread;
- (void)interruptURLConnection;
- (NSURL *)applicationCachesDirectory;
@end

@implementation FSBaseNetworkDAO
@synthesize dataBuffer = _dataBuffer;

@synthesize managedObjectContext = _managedObjectContext;
@synthesize fetchRequest = _fetchRequest;

- (id)init {
	self = [super init];
	if (self) {
		
		self.managedObjectContext = [[GlobalConfig shareConfig] getApplicationManagedObjectContext];
	}
	return self;
}

- (void)dealloc {
	[_dataBuffer release];
	
	[_managedObjectContext release];
	[_fetchRequest release];
	[super dealloc];
}

- (void)doSomethingInDataReceiveComplete{
	
}

- (BOOL)saveCoreDataContext {
	BOOL result = NO;
    if (_managedObjectContext != nil) {
		NSError *error = nil;
        if ([_managedObjectContext hasChanges] && ![_managedObjectContext save:&error]) {
#ifdef MYDEBUG
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
#endif
			[self doSomethingInSaveCoreDataContextError:error];
        } else {
			result = YES;
		}
    }
	return result;
}

- (void)doSomethingInSaveCoreDataContextError:(NSError *)error {
//	[self.managedObjectContext undo];
//	[self.managedObjectContext rollback];
}


#pragma mark -
#pragma mark FSHTTPWebDataDelegate
- (void)fsHTTPWebDataDidFinished:(FSHTTPWebData *)sender withData:(NSData *)data {
	NSData *tempData = [[NSData alloc] initWithData:data];
	self.dataBuffer = data;
	[tempData release];
	dispatch_queue_t queue = dispatch_queue_create(NULL, NULL);
	dispatch_async(queue, ^(void) {

		[self doSomethingInDataReceiveComplete];
	});
	dispatch_release(queue);
	
}

- (void)fsHTTPWebDataStart:(FSHTTPWebData *)sender withTotalBytes:(long long)totalBytes {
	[self executeCallBackDelegateSyncBegin:totalBytes];
}

- (void)fsHTTPWebDataProgress:(FSHTTPWebData *)sender withCurrentBytes:(long long)currentBytes {
	[self executeCallBackDelegateSyncProgress:currentBytes];
}

- (void)fsHTTPWebDataDidFail:(FSHTTPWebData *)sender withError:(NSError *)error {
	dispatch_queue_t queue = dispatch_queue_create(NULL, NULL);
	dispatch_async(queue, ^(void) {
		if (checkNetworkIsValid()) {
			[self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_HostErrorStatus];
		} else {
			[self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_NetworkErrorStatus];
		}
	});
	dispatch_release(queue);
}

@end
