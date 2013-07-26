//
//  FSNetworkData.h
//  PeopleDailyReader
//
//  Created by people.com.cn on 12-3-13.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>

@interface FSNetworkData : NSObject {
@protected
	NSString *_urlString;
	NSString *_localStoreFileName;
	NSMutableData *_bufferData;
	
	NSURLConnection *_URLConnection;
	NSPort *_URLConnectionPort;
	NSRunLoop *_URLConnectionRunLoop;
    
    CGFloat _threadPriority;
	
	id _parentDelegate;
   
}

@property (nonatomic, retain) NSURLConnection *URLConnection;
@property (nonatomic, retain) NSPort *URLConnectionPort;
@property (nonatomic, retain) NSRunLoop *URLConnectionRunLoop;
@property (nonatomic, retain, readonly) NSString *urlString;
@property (nonatomic, retain, readonly) NSString *localStoreFilePath;

@property (nonatomic, assign) CGFloat threadPriority;


//- (NSData *)networkDataWithURLString:(NSString *)URLString withLocalStoreFileName:(NSString *)localStoreFileName;
+ (NSData *)networkDataWithURLString:(NSString *)URLString withLocalStoreFileName:(NSString *)localStoreFileName withDelegate:(id)delegate;

+ (NSData *)oprationNetworkDataWithURLString:(NSString *)URLString withLocalStoreFileName:(NSString *)localStoreFileName withDelegate:(id)delegate;

-(void)oprationNetWorkDataBegin:(NSString *)URLString withLocalStoreFileName:(NSString *)localStoreFileName withDelegate:(id)delegate;

@end

@protocol FSNetworkDataDelegate
@optional
- (void)networkDataDownloadDataComplete:(FSNetworkData *)sender isError:(BOOL)isError data:(NSData *)data;
- (void)networkDataDownloading:(FSNetworkData *)sender maxLength:(long long)maxLength;
- (void)networkDataDownloadingProgressing:(FSNetworkData *)sender totalLength:(long long)totalLength;
@end


