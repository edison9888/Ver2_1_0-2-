//
//  FSGetDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-18.
//
//

#import "FSGetDAO.h"
#import "FSDataTimestampObject.h"

#define DEFAULT_BATCH_KEY @"batchtimestamp"

@interface FSGetDAO()
- (void)initializeTimestamp;
@end

@implementation FSGetDAO
@synthesize currentReadDataKind = _currentReadDataKind;
@synthesize request = _request;
@synthesize entity = _entity;
@synthesize foreceRefreshRemoteData = _forceRefreshRemoteData;

- (id)init {
    self = [super init];
    if (self) {
        _request = [[NSFetchRequest alloc] init];
        _entity = [[NSEntityDescription alloc] init];
        [_entity setName:[self entityName]];
        [_request setEntity:_entity];
    }
    return self;
}

- (void)dealloc {
    [_timestampObject release];
    [_request release];
    [_entity release];
    [super dealloc];
}

- (NSString *)timestampFlag {
    return nil;
}

- (NSString *)entityName {
    return nil;
}


- (NSString *)contentPrimaryKeyName {
    return nil;
}

- (NSObject *)contentPrimaryValue {
    return nil;
}

- (NSString *)batchKeyName {
    return DEFAULT_BATCH_KEY;
}

- (void)GETData {
    
    [self initializeTimestamp];
   
    self.timestampObject.forceRefreshRemoteData = _forceRefreshRemoteData;
    
}

- (void)readDataFromCoreData {
    NSLog(@"readDataFromCoreData");
}

- (void)initializeTimestamp {
    if (_timestampObject == nil) {
        NSString *flag = [self timestampFlag];
        if (flag != nil && ![flag isEqualToString:@""]) {
            _timestampObject = [[FSDataTimestampObject alloc] initWithFlagValue:flag];
        }
    }
}

- (void)deleteOldDataWith:(NSManagedObjectContext *)context withOldBatchValue:(double)batchValue {

}


@end
