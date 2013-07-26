//
//  FSBaseDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-6.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSBaseDAO.h"


@implementation FSBaseDAO
@synthesize parentDelegate = _parentDelegate;

- (id)init {
	self = [super init];
	if (self) {
		
	}
	return self;
}

- (void)dealloc {
    
    //[_parentDelegate release];
    //_parentDelegate = NULL;
#ifdef MYDEBUG
	NSLog(@"DAO.dealloc:%@", self);
#endif
	[super dealloc];
}

- (void)executeCallBackDelegateWithStatus:(FSBaseDAOCallBackStatus)status {
	//GCD
    //NSLog(@"333333");
//	//dispatch_async(dispatch_get_main_queue(), ^(void) {
//		if ([_parentDelegate respondsToSelector:@selector(dataAccessObjectSync:withStatus:)]) {
//			[_parentDelegate dataAccessObjectSync:self withStatus:status];
//            NSLog(@"333333111");
//		}
//        else{
//            NSLog(@"3333332222");
//        }
//	///});
    
    [self performSelectorOnMainThread:@selector(inner_ExecuteCallBackDelegateWithStatus:) withObject:[NSNumber numberWithInt:status] waitUntilDone:[NSThread isMainThread]];
}

- (void)inner_ExecuteCallBackDelegateWithStatus:(NSNumber *)status {
    if ([_parentDelegate respondsToSelector:@selector(dataAccessObjectSync:withStatus:)]) {
        [_parentDelegate dataAccessObjectSync:self withStatus:[status intValue]];
        
    }
    else{
        
    }
}

- (void)executeCallBackDelegateSyncBegin:(long long)totalBytes {
//	dispatch_async(dispatch_get_main_queue(), ^(void) {
//		if ([_parentDelegate respondsToSelector:@selector(dataAccessObjectSyncBegin:withTotalBytes:)]) {
//			[_parentDelegate dataAccessObjectSyncBegin:self withTotalBytes:totalBytes];
//		}
//	});
    [self performSelectorOnMainThread:@selector(inner_ExecuteCallBackDelegateWithTotalBytes:) withObject:[NSNumber numberWithLongLong:totalBytes] waitUntilDone:NO];
}

- (void)inner_ExecuteCallBackDelegateWithTotalBytes:(NSNumber *)value {
    if ([_parentDelegate respondsToSelector:@selector(dataAccessObjectSyncBegin:withTotalBytes:)]) {
        [_parentDelegate dataAccessObjectSyncBegin:self withTotalBytes:[value longLongValue]];
    }
}

- (void)executeCallBackDelegateSyncProgress:(long long)receiveBytes {
//	dispatch_async(dispatch_get_main_queue(), ^(void) {
//		if ([_parentDelegate respondsToSelector:@selector(dataAccessObjectSyncProgress:withReceiveBytes:)]) {
//			[_parentDelegate dataAccessObjectSyncProgress:self withReceiveBytes:receiveBytes];
//		}
//	});
    [self performSelectorOnMainThread:@selector(inner_ExecuteCallbackDelegateWithReceiveBytes:) withObject:[NSNumber numberWithLongLong:receiveBytes] waitUntilDone:NO];
}

- (void)inner_ExecuteCallbackDelegateWithReceiveBytes:(NSNumber *)value {
    if ([_parentDelegate respondsToSelector:@selector(dataAccessObjectSyncProgress:withReceiveBytes:)]) {
        [_parentDelegate dataAccessObjectSyncProgress:self withReceiveBytes:[value longLongValue]];
    }
}

- (void)executeCallBackDelegateSyncEnd {
//	dispatch_async(dispatch_get_main_queue(), ^(void) {
//		if ([_parentDelegate respondsToSelector:@selector(dataAccessObjectSyncEnd:)]) {
//			[_parentDelegate dataAccessObjectSyncEnd:self];
//		}
//	});
    [self performSelectorOnMainThread:@selector(inner_ExecuteCallBackDelegateWithEnd) withObject:nil waitUntilDone:NO];
}

- (void)inner_ExecuteCallBackDelegateWithEnd {
    if ([_parentDelegate respondsToSelector:@selector(dataAccessObjectSyncEnd:)]) {
        [_parentDelegate dataAccessObjectSyncEnd:self];
    }
}

/*
 
- (void)inner_executeCallBackDelegateWithStatus:(NSNumber *)status {
	if ([_parentDelegate respondsToSelector:@selector(dataAccessObjectSync:withStatus:)]) {
		[_parentDelegate dataAccessObjectSync:self withStatus:[status intValue]];
	}
}
 
 */

@end
