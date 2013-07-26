//
//  CustomNetwokData.h
//  PeopleNewsReader
//
//  Created by bo bo on 11-2-20.
//  Copyright 2011 www.people.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NETWORK_DATA_STAR_ERROR_NOTIFICATION @"NetwokDataStartError_Notification"
#define NETWORK_DATA_DOWNLOAD_COMPLETE_NOTIFICATION @"NetworkDataDownloadComplete_Notification"
#define NETWORK_DATA_DOWNLOAD_MAX_PROCESS @"NetworkDataDownloadMaxProcess_Notification"
#define NETWORK_DATA_DOWNLOAD_PROCESSING @"NetworkDataDownloadProcessing_Notification"

#define DOWNLOAD_URL_KEY @"download_url"
#define DOWNLOAD_DATA_KEY @"download_data"
#define DOWNLOAD_TAG_KEY @"download_tag"

#define DOWNLOAD_MAX_LENGTH_KEY @"download_maxlength"
#define DOWNLOAD_TOTAL_LENGTH_KEY @"download_totallength"

#define DOWNLOAD_GROUPKEY_KEY @"download_groupkey"

@interface CustomNetwokData : NSObject {
@private
	NSInteger _tag;
	NSString *_urlString;
	NSMutableData *_buffer;
	
	NSInteger _downloadCountOnError;
	NSInteger _maxDownloadCountOnError;
	BOOL _isDownloading;
	
	id _parentDelegate;
	BOOL _isUseNotification;
	NSString *_groupKey;
	
	NSString *_webSeverErrorHTMLTag;
}

@property (nonatomic) NSInteger tag;
@property (nonatomic, retain) NSString *urlString;
@property (nonatomic) NSInteger maxDownloadCountOnError;
@property (nonatomic, readonly) BOOL isDownloading;
@property (nonatomic, assign) id parentDelegate;
@property (nonatomic) BOOL isUseNotification;
@property (nonatomic, retain) NSString *groupKey;
@property (nonatomic, retain) NSString *webSeverErrorHTMLTag;

- (void) startDownloadData;

+ (void) downloadData:(id)target dataFlag:(NSInteger)dataFlag dataURL:(NSString *)dataURL group:(NSString *)group;

@end

@protocol CustomNetwokDataDelegate

- (void) downloadDataComplete:(CustomNetwokData *)sender isError:(BOOL)isError data:(NSData *)data;
//- (void) downloadMaxProcess:(CustomNetwokData *)sender maxLength:(long long)maxLength;
- (void) downloadProcessing:(CustomNetwokData *)sender totalLength:(long long)totalLength;

@end


