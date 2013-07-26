//
//  FSNetworkDataManager.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-13.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSNetworkData.h"

#define FSNETWORKDATA_MANAGER_BEGIN_DOWNLOADING_NOTIFICATION @"FSNETOWRKDATA_MANAGER_BEGIN_DOWNLOADING_NOTIFICATION_STRING"
#define FSNETWORKDATA_MANAGER_END_DOWNLOADING_COMPLETE_NOTIFICATION @"FSNETWORKDATA_MANAGER_END_DOWNLOADING_NOTIFICATION_STRING"
#define FSNETWORKDATA_MANAGER_END_DOWNLOADING_ERROR_NOTIFICATION @"FSNETWORKDATA_MANAGER_END_DOWNLOADING_ERROR_NOTIFICATION_STRING"

#define FSNETWORKDATA_MANAGER_URLSTRING_KEY @"FSNETWORKDATA_MANAGER_URLSTRING_KEY_STRING"
#define FSNETWORKDATA_MANAGER_LOCALFILEPATH_KEY @"FSNETWORKDATA_MANAGER_LOCALFILEPATH_KEY_STRING"


@interface FSNetworkDataManager : NSObject {
@private
	NSMutableDictionary *_networkDataList;
    NSOperationQueue *_queue;
}

+ (FSNetworkDataManager *)shareNetworkDataManager;

- (NSData *)networkDataWithURLString:(NSString *)URLString withLocalFilePath:(NSString *)localFilePath withDelegate:(id)delegate;

-(void)CancelAllOpration;

@end
