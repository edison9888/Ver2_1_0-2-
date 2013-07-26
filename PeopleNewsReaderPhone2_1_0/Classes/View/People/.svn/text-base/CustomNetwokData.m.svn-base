//
//  CustomNetwokData.m
//  PeopleNewsReader
//
//  Created by bo bo on 11-2-20.
//  Copyright 2011 www.people.com.cn. All rights reserved.
//

#import "CustomNetwokData.h"

#define MAX_DOWNLOAD_COUNT_ON_ERROR 3

#define MAX_DOWNLOADING_COUNT 5

///////////////////////////////////////
// 控制重复下载的管理器，内部使用
///////////////////////////////////////
@interface CustomNetwokDataManager : NSObject {
@private
	NSMutableDictionary *_dicDownloadURLs;
}

- (void) downloadData:(NSInteger)dataFlag dataURL:(NSString *)dataURL group:(NSString *)group;
- (void) executeDownloadData;

@end

@implementation CustomNetwokDataManager

- (id) init {
	if (self = [super init]) {
		_dicDownloadURLs = [[NSMutableDictionary alloc] init];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dowloadDataError:) name:NETWORK_DATA_STAR_ERROR_NOTIFICATION object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadComplete:) name:NETWORK_DATA_DOWNLOAD_COMPLETE_NOTIFICATION object:nil];
	}
	return self;
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:NETWORK_DATA_STAR_ERROR_NOTIFICATION object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:NETWORK_DATA_DOWNLOAD_COMPLETE_NOTIFICATION object:nil];
	
	[_dicDownloadURLs removeAllObjects];
	[_dicDownloadURLs release];
	[super dealloc];
}


- (void) downloadData:(NSInteger)dataFlag dataURL:(NSString *)dataURL  group:(NSString *)group {
	if ([_dicDownloadURLs objectForKey:dataURL] == nil) {
		CustomNetwokData *networkData = [[CustomNetwokData alloc] init];
		networkData.tag = dataFlag;
		networkData.urlString = dataURL;
		networkData.groupKey = group;
		[_dicDownloadURLs setObject:networkData forKey:dataURL];
		[self executeDownloadData];
		[networkData release];
	}
}

- (void) executeDownloadData {
	NSArray *urls = [_dicDownloadURLs allKeys];
	
	NSInteger totalDownloading = 0;
	NSMutableArray *nextExecute = [[NSMutableArray alloc] init];
	
	for (NSString *url in urls) {
		CustomNetwokData *data = (CustomNetwokData *)[_dicDownloadURLs objectForKey:url];
		if (data != nil) {
			if (data.isDownloading) {
				totalDownloading++;
			} else {
				[nextExecute addObject:data];
			}
		}
	}
	
	if (totalDownloading < MAX_DOWNLOADING_COUNT) {
		NSInteger needDownload = MAX_DOWNLOADING_COUNT - totalDownloading;
		for (CustomNetwokData *data in nextExecute) {
			if (needDownload <= 0) {
				break;
			}
			needDownload--;
			[data startDownloadData];
		}
	}
	[nextExecute removeAllObjects];
	[nextExecute release];
}

- (void) dowloadDataError:(NSNotification *)notification {
	NSDictionary *dic = [notification userInfo];
	NSString *url = [dic objectForKey:DOWNLOAD_URL_KEY];
	if (url != nil) {
		[_dicDownloadURLs removeObjectForKey:url];
		[self executeDownloadData];
	}
}

- (void) downloadComplete:(NSNotification *)notification {
	NSDictionary *dic = [notification userInfo];
	NSString *url = [dic objectForKey:DOWNLOAD_URL_KEY];
	if (url != nil) {
		[_dicDownloadURLs removeObjectForKey:url];
		[self executeDownloadData];
	}
}

- (void) downloadComplete:(CustomNetwokData *)sender data:(NSData *)data isError:(BOOL)isError {
	@try {
		[_dicDownloadURLs removeObjectForKey:sender.urlString];
		[self executeDownloadData];
	}
	@catch (NSException * e) {
		NSLog(@"removeObjectForKeyError:%@", [e reason]);
	}
}

@end


static CustomNetwokDataManager *downloadManager = nil;
////////////////////////////////////////////////
// CustomNetworkData
////////////////////////////////////////////////
@interface CustomNetwokData(PrivateMethod) 

- (void)notificationDowloadStatus:(BOOL)isError;

- (void)downloadData;

@end


@implementation CustomNetwokData

@synthesize tag = _tag;
@synthesize urlString = _urlString;
@synthesize maxDownloadCountOnError = _maxDownloadCountOnError;
@synthesize isDownloading = _isDownloading;
@synthesize parentDelegate = _parentDelegate;
@synthesize isUseNotification = _isUseNotification;
@synthesize groupKey = _groupKey;
@synthesize webSeverErrorHTMLTag =_webSeverErrorHTMLTag;

- (id)init {
	if (self = [super init]) {
		_tag = 0;
		_maxDownloadCountOnError = MAX_DOWNLOAD_COUNT_ON_ERROR;
		_downloadCountOnError = 1;
		_isDownloading = NO;
		_isUseNotification = YES;
		_groupKey = @"";
		_webSeverErrorHTMLTag = @"404 Not Found";
		_buffer = [[NSMutableData alloc] init];
	}
	return self;
}

- (void) dealloc {
	NSLog(@"CustomNetworkData[%@]dealloc", self);
	[_urlString release];
	[_buffer release];
	//[_parentDelegate release];
	[_groupKey release];
	[_webSeverErrorHTMLTag release];
	[super dealloc];
}

#pragma mark -
#pragma mark PUBLIC METHOD
- (void) startDownloadData {
	if (_urlString == nil || [_urlString isEqualToString:@""]) {
		[self notificationDowloadStatus:YES];
		return;
	}
	[self retain];
	[self downloadData];
}

#pragma mark -
#pragma mark NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	if (_isUseNotification) {
		NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
		[dic setObject:_urlString forKey:DOWNLOAD_URL_KEY];
		NSString *_flag = [[NSString alloc] initWithFormat:@"%d", _tag];
		[dic setObject:_flag forKey:DOWNLOAD_TAG_KEY];
		[_flag release];
		NSNumber *number = [[NSNumber alloc] initWithLongLong:[response expectedContentLength]];
		[dic setObject:number forKey:DOWNLOAD_MAX_LENGTH_KEY];
		[number release];
		[dic setObject:_groupKey forKey:DOWNLOAD_GROUPKEY_KEY];
		[[NSNotificationCenter defaultCenter] postNotificationName:NETWORK_DATA_DOWNLOAD_MAX_PROCESS object:self userInfo:dic];
		[dic release];
	} else {
		if ([_parentDelegate respondsToSelector:@selector(downloadMaxProcess:maxLength:)]) {
			[_parentDelegate downloadMaxProcess:self maxLength:[response expectedContentLength]];
		}
	}
	NSLog(@"response----");
	if (_buffer != nil && [_buffer length] > 0) {
		[_buffer release];
		_buffer = nil;
	}
	if (_buffer == nil) {
		_buffer = [[NSMutableData alloc] init];
	}
}

//接受数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	//NSLog(@"data-----");
	[_buffer appendData:data];
	if (_isUseNotification) {
		NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
		[dic setObject:_urlString forKey:DOWNLOAD_URL_KEY];
		NSString *_flag = [[NSString alloc] initWithFormat:@"%d", _tag];
		[dic setObject:_flag forKey:DOWNLOAD_TAG_KEY];
		[_flag release];
		NSNumber *number = [[NSNumber alloc] initWithLongLong:[_buffer length]];
		[dic setObject:number forKey:DOWNLOAD_TOTAL_LENGTH_KEY];
		[number release];
		[dic setObject:_groupKey forKey:DOWNLOAD_GROUPKEY_KEY];
		[[NSNotificationCenter defaultCenter] postNotificationName:NETWORK_DATA_DOWNLOAD_PROCESSING object:self userInfo:dic];
		[dic release];
	} else {
		if ([_parentDelegate respondsToSelector:@selector(downloadProcessing:totalLength:)]) {
			[_parentDelegate downloadProcessing:self totalLength:[_buffer length]];
		}
	}
}

//接受数据完成
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	BOOL isError = NO;
	NSString *str = [[NSString alloc] initWithData:_buffer encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
	if (str != nil && ![str isEqualToString: @""] && ![str isEqualToString:@"null"]) {
		NSRange range = [str rangeOfString:_webSeverErrorHTMLTag];
		if (range.location != NSNotFound) {
			isError = YES;
		}
	}
	[str release];
	[self notificationDowloadStatus:isError];
	[self release];
}

//接受数据错误
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"CustomNetworkData[%@];error=%@",self, [error localizedDescription]);
	_downloadCountOnError++;
	if (_downloadCountOnError <= _maxDownloadCountOnError) {
		[self downloadData];
	} else {
		[self notificationDowloadStatus:YES];
		[self release];
	}
}

#pragma mark -
#pragma mark PrivateMethod
- (void)notificationDowloadStatus:(BOOL)isError {
	_isDownloading = NO;
	if (_isUseNotification) {
		NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
		[dic setObject:_urlString forKey:DOWNLOAD_URL_KEY];
		[dic setObject:_buffer forKey:DOWNLOAD_DATA_KEY];
		NSString *_flag = [[NSString alloc] initWithFormat:@"%d", _tag];
		[dic setObject:_flag forKey:DOWNLOAD_TAG_KEY];
		[_flag release];
		NSLog(@"groupKey=%@", _groupKey);
		[dic setObject:_groupKey forKey:DOWNLOAD_GROUPKEY_KEY];
		if (isError) {
			[[NSNotificationCenter defaultCenter] postNotificationName:NETWORK_DATA_STAR_ERROR_NOTIFICATION object:self userInfo:dic];
		} else {
			[[NSNotificationCenter defaultCenter] postNotificationName:NETWORK_DATA_DOWNLOAD_COMPLETE_NOTIFICATION object:self userInfo:dic];
		}
		[dic release];
	} else {
		if ([_parentDelegate respondsToSelector:@selector(downloadDataComplete:isError:data:)]) {
			[_parentDelegate downloadDataComplete:self isError:isError data:_buffer];
		}
	}
}

- (void)downloadData {
	@try {
		NSLog(@"download.url=%@", _urlString);
		_isDownloading = YES;
		NSURL *url = [[NSURL alloc] initWithString:_urlString];
		NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
		NSURLConnection *connection  =[[NSURLConnection alloc] initWithRequest:request delegate:self];
		
		[connection release];
		[request release];
		[url release];
	}
	@catch (NSException * e) {
		NSLog(@"exception=%@", [e reason]);
		[self notificationDowloadStatus:YES];
		[self release];
	}
}

#pragma mark -
#pragma mark Class Method
+ (void) downloadData:(id)target dataFlag:(NSInteger)dataFlag dataURL:(NSString *)dataURL  group:(NSString *)group {
	 if (downloadManager == nil) {
		 downloadManager = [[CustomNetwokDataManager alloc] init];
	 }
	[downloadManager downloadData:dataFlag dataURL:dataURL group:group];
}

@end
