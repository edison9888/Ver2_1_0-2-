//
//  FSHTTPWebData.m
//  PeopleDailyReaderPhone
//
//  Created by people.com.cn on 12-8-29.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSHTTPWebData.h"
#import "FSCommonFunction.h"


@interface FSHTTPWebData(PrivateMethod)
- (void)interruptURLConnection;
@end


@implementation FSHTTPWebData
 
@synthesize URLConnection = _URLConnection;
@synthesize URLConnectionPort = _URLConnectionPort;
@synthesize URLConnectionRunLoop = _URLConnectionRunLoop;
@synthesize URLConnectionString = _URLConnectionString;
@synthesize parentDelegate = _parentDelegate;
@synthesize webDataBuffer = _webDataBuffer;

- (id)init {
	self = [super init];
	if (self) {
		_responseHeaderKey = @"Accepts-Encoding_people";
		_responseHeaderValue = @"gzip";
	}
	return self;
}


- (void)dealloc {
	FSLog(@"FSHTTPWebData.dealloc:%@:%@", self,_parentDelegate);
    if (self.URLConnection!=nil) {
        [self.URLConnection cancel];
    }
	[_responseHeaderKey release];
	[_responseHeaderValue release];
	
	[_URLConnection release];
	[_URLConnectionPort release];
	[_URLConnectionRunLoop release];
    [_URLConnectionString release];
	
	[_webDataBuffer release];
    
	[_parentDelegate release];
    NSLog(@"4444");
	[super dealloc];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	//FSLog(@"FSHTTPWebData.connection:didReceiveResponse:%@[%f]", self.URLConnectionString, [[NSDate date] timeIntervalSince1970]);
	if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
		NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
		NSDictionary *dicHeaders = [httpResponse allHeaderFields];

		//FSLog(@"dicHeaders:%@", dicHeaders);

		NSString *headerValue = [dicHeaders objectForKey:_responseHeaderKey];
		
		if (headerValue == nil) {
			_responseDataKind = HTTPResponseDataKind_Normal;
		} else {
			if ([[headerValue lowercaseString] isEqualToString:_responseHeaderValue]) {
				_responseDataKind = HTTPResponseDataKind_GZIP;
			} else {
				_responseDataKind = HTTPResponseDataKind_Normal;
			}
		}
		
	} else {
		_responseDataKind = HTTPResponseDataKind_Normal;
	}
	
	NSMutableData *data = [[NSMutableData alloc] init];
	self.webDataBuffer = data;
	[data release];
	
	_totalBytes = [response expectedContentLength];
	
	//已经在主线程运行了
//	dispatch_async(dispatch_get_main_queue(), ^(void) {
//
//	});
    
   
    
    if ([_parentDelegate respondsToSelector:@selector(fsHTTPWebDataStart:withTotalBytes:)]) {
        [_parentDelegate fsHTTPWebDataStart:self withTotalBytes:_totalBytes];
    }
}

////////////////////////////////////////////////////////////////////////
//	接收数据过程，数据量大，可能分段取得
////////////////////////////////////////////////////////////////////////
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[_webDataBuffer appendData:data];
	
	if (_totalBytes > 0.0f) {
//		dispatch_async(dispatch_get_main_queue(), ^(void) {
//
//		});
        
        if ([_parentDelegate respondsToSelector:@selector(fsHTTPWebDataProgress:withCurrentBytes:)]) {
            [_parentDelegate fsHTTPWebDataProgress:self withCurrentBytes:[_webDataBuffer length]];
        }
	}
}

////////////////////////////////////////////////////////////////////////
//	接收数据错误
////////////////////////////////////////////////////////////////////////
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	//接受数据错误，查看是网络错误还是连接超时，向界面显示消息
#ifdef MYDEBUG
	NSLog(@"FSHTTPWebData.connection didFailWithError.%@", [error localizedDescription]);
#endif	
//	dispatch_async(dispatch_get_main_queue(), ^(void) {
//
//	});
    if ([_parentDelegate respondsToSelector:@selector(fsHTTPWebDataDidFail:withError:)]) {
        [_parentDelegate fsHTTPWebDataDidFail:self withError:error];
    }
	[self interruptURLConnection];
}

////////////////////////////////////////////////////////////////////////
//	接受数据完成
////////////////////////////////////////////////////////////////////////
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
#ifdef MYDEBUG
	//NSLog(@"FSHTTPWebData.connectionDidFinishLoading.length=%d[%@][%f]", [_webDataBuffer length], self.URLConnectionString, [[NSDate date] timeIntervalSince1970]);
#endif
	if (_responseDataKind == HTTPResponseDataKind_GZIP) {
		//解压缩
#ifdef MYDEBUG
		NSLog(@"返回的数据为压缩数据");
#endif
//		dispatch_async(dispatch_get_main_queue(), ^(void) {
//			[_parentDelegate fsHTTPWebDataDidFinished:self withData:decompressionZipDataWithSource(_webDataBuffer)];
//			
//		});
        if ([_parentDelegate respondsToSelector:@selector(fsHTTPWebDataDidFinished:withData:)]) {
            [_parentDelegate fsHTTPWebDataDidFinished:self withData:decompressionZipDataWithSource(_webDataBuffer)];
        }
        
//        [self performSelectorOnMainThread:@selector(inner_CallBackDataWith:) withObject:decompressionZipDataWithSource(_webDataBuffer) waitUntilDone:YES];
        
	} else {
//		dispatch_async(dispatch_get_main_queue(), ^(void) {
//			[_parentDelegate fsHTTPWebDataDidFinished:self withData:_webDataBuffer];
//		});
        NSLog(@"返回的数据为XML");
        if ([_parentDelegate respondsToSelector:@selector(fsHTTPWebDataDidFinished:withData:)]) {
            [_parentDelegate fsHTTPWebDataDidFinished:self withData:_webDataBuffer];
        }
//        [self performSelectorOnMainThread:@selector(inner_CallBackDataWith:) withObject:_webDataBuffer waitUntilDone:YES];

	}
	
	[self interruptURLConnection];
}

- (void)inner_CallBackDataWith:(NSData *)data {
    if ([_parentDelegate respondsToSelector:@selector(fsHTTPWebDataDidFinished:withData:)]) {
        [_parentDelegate fsHTTPWebDataDidFinished:self withData:data];
    }
}

- (void)interruptURLConnection {
	if (self.URLConnectionRunLoop) {
		[self.URLConnection unscheduleFromRunLoop:self.URLConnectionRunLoop forMode:NSDefaultRunLoopMode];
	}
	if (self.URLConnectionPort) {
		[self.URLConnectionRunLoop removePort:self.URLConnectionPort forMode:NSDefaultRunLoopMode];
	}
	
	self.URLConnectionPort = nil;
	self.URLConnectionRunLoop = nil;
	self.URLConnection = nil;
	
	//释放自己
	[self release];
}



@end



