//
//  FSDataTimestampObject.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-18.
//
//

#import <Foundation/Foundation.h>
#import "FSTimestamps.h"
#import "GlobalConfig.h"
#import <CoreData/CoreData.h>
#import "FSXMLParserObject.h"
#import "FSStoreObject.h"

typedef enum  _NetworkDataTimestampResult {
    NetworkDataTimestampResult_NoRequest,
    NetworkDataTimestampResult_Request,
} NetworkDataTimestampResult;

typedef enum _NetworkStatus {
    NetworkStatus_Working,
    NetworkStatus_NetworkError,
    NetworkStatus_Success
} NetworkStatus;

@class FSDataTimestampObject;

typedef void (^timestampCompletion)(NetworkDataTimestampResult result);
typedef void (^cleanOldDataFunction)(FSDataTimestampObject *sender, NSManagedObjectContext *context);
typedef void (^networkStatusFunction)(NetworkStatus status);

@interface FSDataTimestampObject : NSObject {
@private
    NSTimeInterval _localTimestamp;
    NSTimeInterval _networkTimestamp;
    
    NSString *_flagValue;
    NSManagedObjectContext *_context;
    __block FSTimestamps *_timestampObject;
    
    BOOL *_forceRefreshRemoteData;
}

- (id)initWithFlagValue:(NSString *)value;

@property (nonatomic, readonly) NSTimeInterval localTimestamp;
@property (nonatomic, readonly) NSTimeInterval networkTimestamp;
@property (nonatomic) BOOL *forceRefreshRemoteData;

- (void)saveTimestampWithCleanOldData:(cleanOldDataFunction)cleanOldData;

- (void)dataTimestampWithURLString:(NSString *)urlString networkRequestInterval:(double)interval networkTimestampCompletion:(timestampCompletion)networkTimestampCompletion networkStatus:(networkStatusFunction)networkStatus;

- (void)dataTimestampWithLocalData:(BOOL)hasOwnerData localInterval:(double)interval completion:(timestampCompletion)completion;

@end
