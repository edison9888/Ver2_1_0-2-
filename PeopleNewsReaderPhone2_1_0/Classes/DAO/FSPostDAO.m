//
//  FSPostDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-24.
//
//

#import "FSPostDAO.h"

@implementation FSPostDAO
@synthesize stringEncoding = _stringEncoding;
@synthesize errorCode = _errorCode;
@synthesize errorMessage = _errorMessage;

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}


- (void)POSTData:(HTTPPOSTDataKind)postKind {
/*
 sample
    dispatch_queue_t queue = dispatch_queue_create("cn.com.people.FSBasPOSTDAO", NULL);
	dispatch_async(queue, ^(void) {
		if (!checkNetworkIsValid()) {
			[self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_NetworkErrorStatus];
		} else {
			NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
			
			NSString *URLString = @"some post url";
			
			if (URLString == nil || [URLString isEqual:@""]) {
				[self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_URLErrorStatus];
			} else {
				[self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_WorkingStatus];
				
				NSMutableArray *postParameters = [[NSMutableArray alloc] init];
				加入参数
				
                [FSHTTPWebExData HTTPPostDataWithURLString:URLString
                                            withParameters:postParameters
                                        withStringEncoding:_stringEncoding
                                      withHTTPPOSTDataKind:postKind
                                           blockCompletion:^(NSData *data, BOOL success) {
                                               返回数据解析处理
                                           }];
				
				[postParameters release];
                [pool release];
			}
		}
        
	});
	dispatch_release(queue);
*/
}


@end
