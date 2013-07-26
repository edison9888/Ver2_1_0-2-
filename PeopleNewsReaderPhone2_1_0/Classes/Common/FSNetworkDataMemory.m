//
//  FSNetworkDataMemory.m
//  PeopleDailyReader
//
//  Created by people.com.cn on 12-3-13.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSNetworkDataMemory.h"

@interface FSNetworkDataMemory(PrivateMethod)
- (void)doSomethingAtCallBackWithError:(BOOL)error;
@end


@implementation FSNetworkDataMemory
@synthesize parentDelegate = _parentDelegate;

- (id)init {
	self = [super init];
	if (self) {
	}
	return self;
}

- (void)dealloc {
	[_parentDelegate release];
	[super dealloc];
}

- (void)doSomethingAtReceiveResponse:(long long)totalLength {
	dispatch_async(dispatch_get_main_queue(), ^(void) {
		if ([_parentDelegate respondsToSelector:@selector(networkDataDownloading:maxLength:)]) {
			[_parentDelegate networkDataDownloading:self maxLength:totalLength];
		}
	});

}

- (void)doSomethingAtReceiveData:(long long)currentLength {
	dispatch_async(dispatch_get_main_queue(), ^(void) {
		if ([_parentDelegate respondsToSelector:@selector(networkDataDownloadingProgressing:totalLength:)]) {
			[_parentDelegate networkDataDownloadingProgressing:self totalLength:currentLength];
		}
	});

}

- (void)doSomethingAtFinishLoading {
	[self doSomethingAtCallBackWithError:NO];
}

- (void)doSomethingAtFailWithError {
	[self doSomethingAtCallBackWithError:YES];
}

- (void)doSomethingAtCallBackWithError:(BOOL)error {
	dispatch_async(dispatch_get_main_queue(), ^(void) {
		if ([_parentDelegate respondsToSelector:@selector(networkDataDownloadDataComplete:isError:data:)]) {
			[_parentDelegate networkDataDownloadDataComplete:self isError:error data:_bufferData];
		}
	});
}

- (BOOL)checkCondition {
	return YES;
}

@end
