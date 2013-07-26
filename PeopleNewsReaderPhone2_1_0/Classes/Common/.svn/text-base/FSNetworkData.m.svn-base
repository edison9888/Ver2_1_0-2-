//
//  FSNetworkData.m
//  PeopleDailyReader
//
//  Created by people.com.cn on 12-3-13.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSNetworkData.h"



////////////////////////////////////////////////
// FSNetworkData
////////////////////////////////////////////////
@interface FSNetworkData(PrivateMethod) 
- (void)interruptURLConnection;
- (void)inner_DownloadWithURLString:(NSString *)URLString withLocalStoreFileName:(NSString *)localStoreFileName withDelegate:(id)delegate;
@end

@implementation FSNetworkData

@synthesize URLConnection = _URLConnection;
@synthesize URLConnectionPort = _URLConnectionPort;
@synthesize URLConnectionRunLoop = _URLConnectionRunLoop;
@synthesize localStoreFilePath = _localStoreFileName;
@synthesize urlString = _urlString;


@synthesize threadPriority;

- (id)init {
	if (self = [super init]) {
		threadPriority = 1.0;
	}
	return self;
}

- (void)dealloc {
#ifdef MYDEBUG
	//NSLog(@"FSNetworkData.dealloc:[%@]{urlString:%@}", self, _urlString);
#endif
	[_urlString release];
	[_localStoreFileName release];
	[_bufferData release];

	[_URLConnectionPort release];
	[_URLConnectionRunLoop release];
	[_URLConnection release];
	
	[_parentDelegate release];

	[super dealloc];
}

+ (NSData *)networkDataWithURLString:(NSString *)URLString withLocalStoreFileName:(NSString *)localStoreFileName withDelegate:(id)delegate {
    if (URLString == nil) {
        return nil;
    }
	if ([[NSFileManager defaultManager] fileExistsAtPath:localStoreFileName]) {
		return [NSData dataWithContentsOfFile:localStoreFileName];
	} else {
		dispatch_queue_t queue = dispatch_queue_create(NULL, NULL);
		dispatch_async(queue, ^(void) {
#ifdef MYDEBUG
            //NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
			//NSLog(@"FSNetworkData networkDataWithURLString --begin:%f :%@",[date timeIntervalSince1970],URLString);
#endif
			FSNetworkData *networkData = [[FSNetworkData alloc] init];
            networkData.threadPriority = 1.0f;
			[networkData inner_DownloadWithURLString:URLString withLocalStoreFileName:localStoreFileName withDelegate:delegate];
			[networkData release];
			
		});
		dispatch_release(queue);
    
		return nil;
	}
}


//***********************************************

+ (NSData *)oprationNetworkDataWithURLString:(NSString *)URLString withLocalStoreFileName:(NSString *)localStoreFileName withDelegate:(id)delegate{
    if (URLString == nil) {
        return nil;
    }
#ifdef MYDEBUG
            //NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
			//NSLog(@"FSNetworkData networkDataWithURLString --begin:%f :%@",[date timeIntervalSince1970],localStoreFileName);
#endif
        FSNetworkData *networkData = [[FSNetworkData alloc] init];
       
        [networkData oprationNetWorkDataBegin:URLString withLocalStoreFileName:localStoreFileName withDelegate:delegate];
        [networkData release];
			
        return nil;
}

-(void)oprationNetWorkDataBegin:(NSString *)URLString withLocalStoreFileName:(NSString *)localStoreFileName withDelegate:(id)delegate{
    
    if (_parentDelegate != nil) {
		[_parentDelegate release];
	}
	_parentDelegate = [delegate retain];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:localStoreFileName]) {
        if ([_parentDelegate respondsToSelector:@selector(networkDataDownloadDataComplete:isError:data:)]) {
            [_parentDelegate networkDataDownloadDataComplete:self isError:NO data:[NSData dataWithContentsOfFile:localStoreFileName]];
        }
        return;
    }
    
    
    NSData *imageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:URLString]];
    
    BOOL isError = YES;
    
    if (localStoreFileName != nil && ![localStoreFileName isEqualToString:@""]) {
		NSString *filePath = [localStoreFileName stringByDeletingLastPathComponent];
		if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
			isError = ![imageData writeToFile:localStoreFileName atomically:YES];
		}
        
        if ([_parentDelegate respondsToSelector:@selector(networkDataDownloadDataComplete:isError:data:)]) {
			[_parentDelegate networkDataDownloadDataComplete:self isError:isError data:imageData];
		}
	}
	
}


//*******************************************

- (void)inner_DownloadWithURLString:(NSString *)URLString withLocalStoreFileName:(NSString *)localStoreFileName withDelegate:(id)delegate{
	[self retain];
	
	_urlString = [URLString retain];
	_localStoreFileName = [localStoreFileName retain];
	if (_parentDelegate != nil) {
		[_parentDelegate release];
	}
	_parentDelegate = [delegate retain];
	
	NSThread *connectionThread = [[NSThread alloc] initWithTarget:self selector:@selector(executeURLConnectionThread) object:nil];
    NSLog(@"self.threadPriority:%f",self.threadPriority);
    //[connectionThread setThreadPriority:self.threadPriority];//设置线程优先级别
	[connectionThread start];
	[connectionThread release];
}

- (void)executeURLConnectionThread {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	@try {
		
		NSURL *url = [[NSURL alloc] initWithString:_urlString];
#ifdef MYDEBUG
		//NSLog(@"urlString:%@", _urlString);
#endif
		NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
		NSURLConnection *connection  =[[NSURLConnection alloc] initWithRequest:request delegate:self];
		self.URLConnection = connection;
		
		//hold住线程
		NSPort *port = [NSPort port];
		self.URLConnectionPort = port;
		NSRunLoop *runloop = [NSRunLoop currentRunLoop];
		self.URLConnectionRunLoop = runloop;
		[runloop addPort:port forMode:NSDefaultRunLoopMode];
		[connection scheduleInRunLoop:runloop forMode:NSDefaultRunLoopMode];
		[connection start];
		[runloop run];
		
		[connection release];
		[request release];
		[url release];
		
	} @catch (NSException * e) {
#ifdef MYDEBUG
		NSLog(@"exception:%@", [e reason]);
#endif
		dispatch_async(dispatch_get_main_queue(), ^(void){
			
            
            [self interruptURLConnection];
            
			if ([_parentDelegate respondsToSelector:@selector(networkDataDownloadDataComplete:isError:data:)]) {
				[_parentDelegate networkDataDownloadDataComplete:self isError:YES data:_bufferData];
			}
			
			[self release];
		});
		
		[self release];
	}
	
	[pool release];
#ifdef MYDEBUG
	NSLog(@"FSNetworkData.NSThread exit.");
#endif
	[NSThread exit];
	
}

#pragma mark -
#pragma mark NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
#ifdef MYDEBUG
	NSLog(@"FSNetworkData.response----");
#endif
	if (_bufferData != nil) {
		[_bufferData setLength:0];
	} else {
		_bufferData = [[NSMutableData alloc] init];
	}
	
	dispatch_async(dispatch_get_main_queue(), ^(void) {
		if ([_parentDelegate respondsToSelector:@selector(networkDataDownloading:maxLength:)]) {
			[_parentDelegate networkDataDownloading:self maxLength:[response expectedContentLength]];
		}
	});
	
}

//接受数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
#ifdef MYDEBUG
	//NSLog(@"FSNetworkData.didReceiveData----:%@",_urlString);
#endif
	[_bufferData appendData:data];
	
	dispatch_async(dispatch_get_main_queue(), ^(void) {
		if ([_parentDelegate respondsToSelector:@selector(networkDataDownloadingProgressing:totalLength:)]) {
			[_parentDelegate networkDataDownloadingProgressing:self totalLength:[_bufferData length]];
		}
	});
}

//接受数据完成
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
#ifdef MYDEBUG
    //NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    //NSLog(@"FSNetworkData.connectionDidFinishLoading:%f :%@",[date timeIntervalSince1970],_urlString);
#endif
#ifdef MYDEBUG
	//NSLog(@"FSNetworkData.connectionDidFinishLoading----:%@", [NSThread isMainThread] ? @"mainThread" : @"noneThread");
#endif
	BOOL isError = YES;
	if (_localStoreFileName != nil && ![_localStoreFileName isEqualToString:@""]) {
		NSString *filePath = [_localStoreFileName stringByDeletingLastPathComponent];
		if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
			isError = ![_bufferData writeToFile:_localStoreFileName atomically:YES];
		}
	}
	
	[self interruptURLConnection];
	
	dispatch_async(dispatch_get_main_queue(), ^(void) {
 
		if ([_parentDelegate respondsToSelector:@selector(networkDataDownloadDataComplete:isError:data:)]) {
			[_parentDelegate networkDataDownloadDataComplete:self isError:isError data:_bufferData];
		}
		
		[self release];
		
	});
}

//接受数据错误
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
#ifdef MYDEBUG
	NSLog(@"FSNetworkData.didFailWithError[%@]----<%@>", [error localizedDescription], _urlString);
#endif
	[self interruptURLConnection];
	
	dispatch_async(dispatch_get_main_queue(), ^(void){
		
		if ([_parentDelegate respondsToSelector:@selector(networkDataDownloadDataComplete:isError:data:)]) {
			[_parentDelegate networkDataDownloadDataComplete:self isError:YES data:nil];
		}

		[self release];
	});

}

- (void)interruptURLConnection {
#ifdef MYDEBUG
	NSLog(@"interruptURLConnection:%@", [NSThread isMainThread] ? @"mainThread" : @"noneThread");
#endif
	if (self.URLConnection != nil && self.URLConnectionRunLoop != nil) {
		[self.URLConnection unscheduleFromRunLoop:self.URLConnectionRunLoop forMode:NSDefaultRunLoopMode];
	}
	
	if (self.URLConnectionRunLoop != nil && self.URLConnectionPort != nil) {
		[self.URLConnectionRunLoop removePort:self.URLConnectionPort forMode:NSDefaultRunLoopMode];
	}
	
	
	self.URLConnectionPort = nil;
	self.URLConnectionRunLoop = nil;
	
	
}

@end
