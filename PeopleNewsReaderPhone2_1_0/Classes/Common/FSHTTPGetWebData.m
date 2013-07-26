//
//  FSHTTPGetWebData.m
//  PeopleDailyReaderPhone
//
//  Created by people.com.cn on 12-8-29.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSHTTPGetWebData.h"
@interface FSHTTPGetWebData(PirvateMethod)
- (void)inner_HTTPGETDataWithURLString:(NSString *)URLString;
@end


@implementation FSHTTPGetWebData

///////////////////////////////////////////////////////////////////////////////////
//	GET数据
///////////////////////////////////////////////////////////////////////////////////
+ (void)HTTPGETDataWithURLString:(NSString *)URLString withDelegate:(id)delegate {
//	dispatch_queue_t queue = dispatch_queue_create("cn.com.people.FSHTTPWebData.GET", NULL);
//	dispatch_async(queue, ^(void) {
//		FSHTTPGetWebData *httpGetData = [[FSHTTPGetWebData alloc] init];
//		httpGetData.parentDelegate = delegate;
//		[httpGetData inner_HTTPGETDataWithURLString:URLString];
//		[httpGetData release];		
//	});
//	dispatch_release(queue);
    FSHTTPGetWebData *httpGetData = [[FSHTTPGetWebData alloc] init];
    httpGetData.parentDelegate = delegate;
    [httpGetData inner_HTTPGETDataWithURLString:URLString];
    [httpGetData release];
}

- (void)inner_HTTPGETDataWithURLString:(NSString *)URLString {
	[self retain];
    FSLog(@"%@[urlString:%@]", self, URLString);
    if (URLString==nil) {
        if ([_parentDelegate respondsToSelector:@selector(fsHTTPWebDataDidFail:withError:)]) {
            [_parentDelegate fsHTTPWebDataDidFail:self withError:nil];
        }
        return;
    }
    
    //FSLog(@"%@[self.URLConnectionString:%@]", self, self.URLConnectionString);
    self.URLConnectionString = URLString;
    if (self.URLConnection!=nil) {
        [self.URLConnection cancel];
    }
	NSThread *httpGetThread = [[NSThread alloc] initWithTarget:self selector:@selector(URLConnectionThreadWithURLString:) object:URLString];
	[httpGetThread start];
	[httpGetThread release];
}

- (void)URLConnectionThreadWithURLString:(NSString *)urlString {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	NSURL *url = [[NSURL alloc] initWithString:urlString];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
	[request setTimeoutInterval:15];
	
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	self.URLConnection = connection;
	
	//hold住线程
	self.URLConnectionPort = [NSPort port];
	self.URLConnectionRunLoop = [NSRunLoop currentRunLoop];
	[self.URLConnectionRunLoop addPort:self.URLConnectionPort forMode:NSDefaultRunLoopMode];
	[self.URLConnection scheduleInRunLoop:self.URLConnectionRunLoop forMode:NSDefaultRunLoopMode];
	[self.URLConnection start];
	[self.URLConnectionRunLoop run];
	
	[connection release];
	[request release];
	
	[url release];
	
	[pool release];
	
	[NSThread exit];
}


@end
