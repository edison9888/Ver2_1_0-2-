//
//  FS_GZF_BasePOSTXMLDAO.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-11-8.
//
//

#import "FS_GZF_BasePOSTXMLDAO.h"

@implementation FS_GZF_BasePOSTXMLDAO

@synthesize entitiesForUpdate = _entitiesForUpdate;
@synthesize stringEncoding = _stringEncoding;
@synthesize errorCode = _errorCode;
@synthesize errorMessage = _errorMessage;
@synthesize currentElementName = _currentElementName;

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



- (void)doSomethingInDataReceiveComplete {
    //NSLog(@"FS_GZF_BasePOSTXMLDAO doSomethingInDataReceiveComplete");

//	NSString *tempXML = [[NSString alloc] initWithData:self.dataBuffer encoding:NSUTF8StringEncoding];
//	if (tempXML == NULL) {
//		tempXML = [[NSString alloc] initWithData:self.dataBuffer encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
//	}
//	NSLog(@"Current XML\r\n:%@", trimString(tempXML));
//	[tempXML release];

	
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:self.dataBuffer];
    xmlParser.delegate = self;
    @try {
        if ([xmlParser parse]) {
            //解析结果
            [self baseXMLParserComplete:self];
        } else {
            
        }
    }
    @catch (NSException * e) {
#ifdef MYDEBUG
        NSLog(@"NSXMLParser.Exception:%@", [e reason]);
#endif
    }
    @finally {
        
    }
    
    [xmlParser release];
	
	self.dataBuffer = nil;
}

#pragma mark -
#pragma mark FSBaseXMLParserObjectDelegate

- (void)baseXMLParserComplete:(FSBaseDAO *)sender {
    
	//[self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_SuccessfulStatus];
}


@end
