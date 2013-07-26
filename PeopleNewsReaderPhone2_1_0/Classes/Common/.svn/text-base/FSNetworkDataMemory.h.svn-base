//
//  FSNetworkDataMemory.h
//  PeopleDailyReader
//
//  Created by people.com.cn on 12-3-13.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSNetworkData.h"

@interface FSNetworkDataMemory : FSNetworkData {
@private
	id _parentDelegate;
}

@property (nonatomic, retain) id parentDelegate;

@end

@protocol FSNetworkDataMemoryDelegate
@optional
- (void)networkDataDownloadDataComplete:(FSNetworkDataMemory *)sender isError:(BOOL)isError data:(NSData *)data;
- (void)networkDataDownloading:(FSNetworkDataMemory *)sender maxLength:(long long)maxLength;
- (void)networkDataDownloadingProgressing:(FSNetworkDataMemory *)sender totalLength:(long long)totalLength;

@end

