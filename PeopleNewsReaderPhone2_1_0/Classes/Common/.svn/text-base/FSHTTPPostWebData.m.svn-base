//
//  FSHTTPPostWebData.m
//  PeopleDailyReaderPhone
//
//  Created by people.com.cn on 12-8-29.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSHTTPPostWebData.h"

#define BOUNDARY_STRING @"-----------------7da2ced220a6a"
#define POST_NORMAL_FORM_ITEM @"Content-Disposition: form-data; name=\"%@\"\r\n\r\n"
#define POST_FILE_FORM_ITEM @"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\nContent-Type:%@\r\n\r\n"

#define POST_PARAMETER_URLSTRING_KEY @"POST_PARAMETER_URLSTRING_KEY_STRING"
#define POST_PARAMETER_BODYITEM_KEY	@"POST_PARAMETER_BODYITEM_KEY_STRING"
#define POST_PARAMETER_CONTENTTYPE_KEY @"POST_PARAMETER_CONTENTTYPE_KEY_STRING"

@interface FSHTTPPostWebData(PrivateMethod)
- (void)inner_HTTPPOSTDataWithURLString:(NSString *)URLString withParameters:(NSArray *)parameters withStringEncoding:(NSStringEncoding)stringEncoding withHTTPPOSTDataKind:(HTTPPOSTDataKind)postDataKind;
@end


@implementation FSHTTPPostWebData

///////////////////////////////////////////////////////////////////////////////////
//	POST数据
///////////////////////////////////////////////////////////////////////////////////
+ (void)HTTPPOSTDataWithURLString:(NSString *)URLString withDelegate:(id)delegate withParameters:(NSArray *)parameters withStringEncoding:(NSStringEncoding)stringEncoding withHTTPPOSTDataKind:(HTTPPOSTDataKind)postDataKind {
	FSHTTPPostWebData *httpPostData = [[FSHTTPPostWebData alloc] init];
	httpPostData.parentDelegate = delegate;
	[httpPostData inner_HTTPPOSTDataWithURLString:URLString withParameters:parameters withStringEncoding:stringEncoding withHTTPPOSTDataKind:postDataKind];
	[httpPostData release];
}

- (void)inner_HTTPPOSTDataWithURLString:(NSString *)URLString withParameters:(NSArray *)parameters withStringEncoding:(NSStringEncoding)stringEncoding withHTTPPOSTDataKind:(HTTPPOSTDataKind)postDataKind {
	[self retain];
    self.URLConnectionString = URLString;
	dispatch_queue_t queue = dispatch_queue_create(NULL, NULL);
	dispatch_async(queue, ^(void) {
		NSString *contentType;
		
		if (postDataKind == HTTPPOSTDataKind_MultiPart) {
			//带附件的
			contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", BOUNDARY_STRING];
			
			NSMutableData *dataBody = [[NSMutableData alloc] init];
			for (FSHTTPPOSTItem *postItem in parameters) {
				if (postItem.postItemKind == HTTPPOSTItemKind_Binary) {
					NSMutableString *strFileItem = [[NSMutableString alloc] init];
					
					[strFileItem appendString:@"--"];
					[strFileItem appendString:BOUNDARY_STRING];
					[strFileItem appendString:@"\r\n"];
					
					[strFileItem appendFormat:POST_FILE_FORM_ITEM, postItem.fieldName, postItem.fieldFileName, postItem.fieldContentType];
					[dataBody appendData:[strFileItem dataUsingEncoding:stringEncoding]];
					[strFileItem release];
					
					[dataBody appendData:postItem.fieldData];
					
					[dataBody appendData:[@"\r\n" dataUsingEncoding:stringEncoding]];
				} else {
					NSMutableString *strNormal = [[NSMutableString alloc] init];
					
					[strNormal appendString:@"--"];
					[strNormal appendString:BOUNDARY_STRING];
					[strNormal appendString:@"\r\n"];
					
					[strNormal appendFormat:POST_NORMAL_FORM_ITEM, postItem.fieldName];
					
					[strNormal appendString:postItem.fieldValue];
					
					[strNormal appendString:@"\r\n"];
					
					[dataBody appendData:[strNormal dataUsingEncoding:stringEncoding]];
					[strNormal release];
				}
			}
			
			//封装结尾
			NSMutableString *dataTail = [[NSMutableString alloc] init];
			[dataTail appendString:@"--"];
			[dataTail appendString:BOUNDARY_STRING];
			[dataTail appendString:@"--\r\n\r\n"];
			[dataBody appendData:[dataTail dataUsingEncoding:stringEncoding]];
			[dataTail release];
			
			
			NSMutableDictionary *dicParameters = [[[NSMutableDictionary alloc] init] autorelease];
			[dicParameters setObject:dataBody forKey:POST_PARAMETER_BODYITEM_KEY];
			[dicParameters setObject:contentType forKey:POST_PARAMETER_CONTENTTYPE_KEY];
			[dicParameters setObject:URLString forKey:POST_PARAMETER_URLSTRING_KEY];
			
			NSThread *connectionThread = [[NSThread alloc] initWithTarget:self selector:@selector(URLConnectionThreadWithParameters:) object:dicParameters];
			[connectionThread start];
			[connectionThread release];
			
			[dataBody release];
		} else {
			//普通的post，忽略所有文件item
			contentType = @"application/x-www-form-urlencoded";
			
			NSMutableData *dataBody = [[NSMutableData alloc] init];
			NSMutableString *strNoraml = [[NSMutableString alloc] init];
			for (int i = 0; i < [parameters count]; i++) {
				FSHTTPPOSTItem *item = (FSHTTPPOSTItem *)[parameters objectAtIndex:i];
				if (item.postItemKind == HTTPPOSTItemKind_Normal) {
					[strNoraml appendFormat:@"%@=%@", item.fieldName, item.fieldValue];
					[strNoraml appendString:@"&"];
				}
			}
			
			if ([strNoraml hasSuffix:@"&"]) {
				NSRange range;
				range.location = [strNoraml length] - 1;
				range.length = 1;
				[strNoraml deleteCharactersInRange:range];
			}
#ifdef MYDEBUG
			NSLog(@"strNoraml:%@", strNoraml);
#endif
			[dataBody appendData:[strNoraml dataUsingEncoding:stringEncoding]];
			[strNoraml release];
			
			NSMutableDictionary *dicParameters = [[[NSMutableDictionary alloc] init] autorelease];
			[dicParameters setObject:dataBody forKey:POST_PARAMETER_BODYITEM_KEY];
			[dicParameters setObject:contentType forKey:POST_PARAMETER_CONTENTTYPE_KEY];
			[dicParameters setObject:URLString forKey:POST_PARAMETER_URLSTRING_KEY];
			
			NSThread *connectionThread = [[NSThread alloc] initWithTarget:self selector:@selector(URLConnectionThreadWithParameters:) object:dicParameters];
			[connectionThread start];
			[connectionThread release];
			
			[dataBody release];
		}
		
	});
	dispatch_release(queue);
}

- (void)URLConnectionThreadWithParameters:(NSMutableDictionary *)dicParameters {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	NSString *URLString = [dicParameters objectForKey:POST_PARAMETER_URLSTRING_KEY];
	NSData *dataBody = [dicParameters objectForKey:POST_PARAMETER_BODYITEM_KEY];
	NSString *contentType = [dicParameters objectForKey:POST_PARAMETER_CONTENTTYPE_KEY];
	
	NSURL *url = [[NSURL alloc] initWithString:URLString];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	NSString *dataLength = [[NSString alloc] initWithFormat:@"%d", [dataBody length]];
	[request setURL:url];  
	[request setHTTPMethod:@"POST"]; 
	[request setValue:contentType forHTTPHeaderField:@"Content-Type"];
	[request setValue:dataLength forHTTPHeaderField:@"Content-Length"]; 
	[request setHTTPBody:dataBody];  
	[request setHTTPShouldHandleCookies:YES];	
	[request setTimeoutInterval:60];
	
	//异步向服务器提交数据
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	self.URLConnection = connection;
	
	//hold住线程
	self.URLConnectionPort = [NSPort port];
	self.URLConnectionRunLoop = [NSRunLoop currentRunLoop];
	[self.URLConnectionRunLoop addPort:self.URLConnectionPort forMode:NSDefaultRunLoopMode];
	[self.URLConnection scheduleInRunLoop:self.URLConnectionRunLoop forMode:NSDefaultRunLoopMode];
	[self.URLConnection start];
	[self.URLConnectionRunLoop run];
	
	//释放对象
	[connection release];
	[request release];
	[dataLength release];
	[url release];
	//[contentType release];
	
	[pool release];
	
	[NSThread exit];
}


@end

@implementation FSHTTPPOSTItem
@synthesize postItemKind = _postItemKind;
@synthesize fieldName = _fieldName;
@synthesize fieldValue = _fieldValue;
@synthesize fieldFileName = _fieldFileName;
@synthesize fieldContentType = _fieldContentType;
@synthesize fieldData = _fieldData;

- (id)initWithName:(NSString *)name withValue:(NSString *)value {
	self = [super init];
	if (self) {
		_postItemKind = HTTPPOSTItemKind_Normal;
		_fieldName = [name retain];
		_fieldValue = [value retain];
	}
	return self;
}

- (id)initWithName:(NSString *)name withFileName:(NSString *)fileName withContentType:(NSString *)contentType withData:(NSData *)data {
	self = [super init];
	if (self) {
		_postItemKind = HTTPPOSTItemKind_Binary;
		_fieldName = [name retain];
		_fieldFileName = [fileName retain];
		_fieldContentType = [contentType retain];
		_fieldData = [data retain];
	}
	return self;
}


- (void)dealloc {
    if (_postItemKind == HTTPPOSTItemKind_Normal) {
        [_fieldName release];
        [_fieldValue release];
    }
    
    if (_postItemKind == HTTPPOSTItemKind_Binary) {
        [_fieldName release];
        [_fieldFileName release];
        [_fieldContentType release];
        [_fieldData release];
    }

	[super dealloc];
}

@end
