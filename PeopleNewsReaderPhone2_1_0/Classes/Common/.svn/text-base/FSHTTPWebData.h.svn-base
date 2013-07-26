//
//  FSHTTPWebData.h
//  PeopleDailyReaderPhone
//
//  Created by people.com.cn on 12-8-29.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum _HTTPResponseDataKind {
	HTTPResponseDataKind_Unknow,
	HTTPResponseDataKind_Normal,
	HTTPResponseDataKind_GZIP
} HTTPResponseDataKind;

@interface FSHTTPWebData : NSObject {
@protected
	NSString *_responseHeaderKey;
	NSString *_responseHeaderValue;
	
	NSURLConnection *_URLConnection;
	NSPort *_URLConnectionPort;
	NSRunLoop *_URLConnectionRunLoop;
	
	NSMutableData *_webDataBuffer;
	HTTPResponseDataKind _responseDataKind;
	
	long long _totalBytes;
	id _parentDelegate;
    
    NSString *_URLConnectionString;
}

@property (nonatomic, retain) NSURLConnection *URLConnection;
@property (nonatomic, retain) NSPort *URLConnectionPort;
@property (nonatomic, retain) NSRunLoop *URLConnectionRunLoop;
@property (nonatomic, retain) NSString *URLConnectionString;
@property (nonatomic, retain) id parentDelegate;
@property (nonatomic, retain) NSMutableData *webDataBuffer;

@end
 
@protocol FSHTTPWebDataDelegate
- (void)fsHTTPWebDataDidFinished:(FSHTTPWebData *)sender withData:(NSData *)data;
@optional
- (void)fsHTTPWebDataStart:(FSHTTPWebData *)sender withTotalBytes:(long long)totalBytes;
- (void)fsHTTPWebDataProgress:(FSHTTPWebData *)sender withCurrentBytes:(long long)currentBytes;
- (void)fsHTTPWebDataDidFail:(FSHTTPWebData *)sender withError:(NSError *)error;
@end



