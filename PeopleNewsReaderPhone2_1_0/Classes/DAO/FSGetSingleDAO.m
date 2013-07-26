//
//  FSGetSingleDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-24.
//
//

#import "FSGetSingleDAO.h"

#define SINGLE_DEFAULT_BATCH_KEY @"batchtimestamp"

@implementation FSGetSingleDAO
@synthesize contentObject  = _contentObject;

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc {
    [_contentObject release];
    [super dealloc];
}

- (NSString *)batchKeyName {
    return SINGLE_DEFAULT_BATCH_KEY;
}


- (void)readDataFromCoreData {
    
    [self.request setFetchLimit:1];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K=%@", [self contentPrimaryKeyName], [self contentPrimaryValue]];
    [self.request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *resultSet = [self.managedObjectContext executeFetchRequest:self.request error:&error];
    FSLog(@"resultSet:%@", resultSet);
    if (!error) {
        if ([resultSet count] > 0) {
            [_contentObject release];
            _contentObject = [[resultSet objectAtIndex:0] retain];
        }
    } else {
#ifdef MYDEBUG
        NSLog(@"FSGetSingleDAO.error:%@", error);
#endif
    }
}

- (void)deleteOldDataWith:(NSManagedObjectContext *)context withOldBatchValue:(double)batchValue {
    NSFetchRequest *requestOfOld = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityOfOld = [[NSEntityDescription alloc] init];
    [entityOfOld setName:[self entityName]];
    [requestOfOld setEntity:entityOfOld];
    
    
    NSNumber *batchKeyOfOld = [[NSNumber alloc] initWithDouble:batchValue];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K=%@ AND %K!=%@", [self contentPrimaryKeyName], [self contentPrimaryValue], [self batchKeyName], batchKeyOfOld];
    [batchKeyOfOld release];
    
    [requestOfOld setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:requestOfOld error:&error];
#ifdef MYDEBUG
    NSLog(@"DeleteOldResult.delete:%@", result);
#endif
    if (!error) {
        for (NSManagedObject *entityObj in result) {
            [context deleteObject:entityObj];
        }
        
        if ([context hasChanges] && ![context save:&error]) {
#ifdef MYDEBUG
            NSLog(@"deleteOldData.error:%@", error);
#endif
        }
    }
    
    [entityOfOld release];
    [requestOfOld release];
}

@end
