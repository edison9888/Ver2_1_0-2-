//
//  FSBasePOSTDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-7.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSBasePOSTDAO.h"

#define POST_CONTENT_TYPE_KEY @"POST_CONTENT_TYPE_KEY_STRING"
#define POST_DATABODY_KEY @"POST_DATABODY_KEY_STRING"
#define POST_URLSTRING_KEY @"POST_URLSTRING_KEY_STRING"

@implementation FSBasePOSTDAO
@synthesize entitiesForUpdate = _entitiesForUpdate;
@synthesize stringEncoding = _stringEncoding;
@synthesize errorCode = _errorCode;
@synthesize errorMessage = _errorMessage;

- (id)init {
	self = [super init];
	if (self) {
		_entitiesForUpdate = [[NSMutableArray alloc] init];
		self.stringEncoding = NSUTF8StringEncoding;
		self.errorCode = 0;
	}
	return self;
}

- (void)dealloc {
	[_errorMessage release];
	[_entitiesForUpdate release];
	[super dealloc];
}

- (NSString *)HTTPPostURLString {
	return nil;
}

- (void)HTTPBuildPostItems:(NSMutableArray *)postItems withPostKind:(HTTPPOSTDataKind)postKind {
	
}

- (void)HTTPPostDataWithKind:(HTTPPOSTDataKind)httpPostKind {
	dispatch_queue_t queue = dispatch_queue_create(NULL, NULL);
	dispatch_async(queue, ^(void) {
		if (!checkNetworkIsValid()) {
			[self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_NetworkErrorStatus];
		} else {
			NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
			
			NSString *URLString = [self HTTPPostURLString];
			
			if (URLString == nil || [URLString isEqual:@""]) {
				[self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_URLErrorStatus];
			} else {
				[self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_WorkingStatus];
				
				NSMutableArray *postParameters = [[NSMutableArray alloc] init];
				[self HTTPBuildPostItems:postParameters withPostKind:httpPostKind];
				
				[FSHTTPPostWebData HTTPPOSTDataWithURLString:URLString withDelegate:self withParameters:postParameters withStringEncoding:_stringEncoding withHTTPPOSTDataKind:httpPostKind];
				
				[postParameters release];
						[pool release];
			}
		}
				
	});
	dispatch_release(queue);
}


@end

