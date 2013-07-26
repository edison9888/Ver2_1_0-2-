//
//  FSGetListDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-23.
//
//

#import "FSGetListDAO.h"

#import "FSBaseDB.h"


#define DEFAULT_BATCH_KEY @"batchtimestamp"

@implementation FSGetListDAO
@synthesize fetchedResultsController = _fetchedResultsController;

- (id)init {
    self = [super init];
    if (self) {
        
        
    }
    return self;
}

- (void)dealloc {
    [_fetchedResultsController release];
    [super dealloc];
}

- (NSString *)sectionName {
    return nil;
}

- (NSString *)cacheName {
    return nil;
}

- (NSString *)batchKeyName {
    return DEFAULT_BATCH_KEY;
}

- (NSUInteger)listLimited {
    return  0;
}

- (void)initializeBufferData {
    if ([_fetchedResultsController.fetchedObjects count] <= 0) {
        FSLog(@"owner buffer data.");
        [self readDataFromCoreData];
        [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_BufferSuccessfulStatus];
    } else {
        FSLog(@"non buffer data.");
    }
}

- (void)readDataFromCoreData {
    
    NSArray *array = [[FSBaseDB sharedFSBaseDB] getAllObjectsSortByKey:@"FSTopicPriorObject" key:[self batchKeyName] ascending:YES];

    NSLog(@"%@\r\n:%@",[self entityName],array);
    
//******************************************************************************
    NSMutableArray *sorts = [[NSMutableArray alloc] init];
    NSString *fieldName = @"timestamp";
    BOOL asscending = NO;
    [self sortFieldName:&fieldName ascending:&asscending];
    NSSortDescriptor *sortDes = [[NSSortDescriptor alloc] initWithKey:fieldName ascending:asscending];
    [sorts addObject:sortDes];
    [self.request setSortDescriptors:sorts];
    [sortDes release];
    [sorts release];
    
    [self.request setFetchLimit:[self listLimited]];
    
    NSString *keyName = [self contentPrimaryKeyName];
    NSObject *keyValue = [self contentPrimaryValue];
    
    NSNumber *batchKey = [[NSNumber alloc] initWithDouble:self.timestampObject.networkTimestamp];
    NSPredicate *predicate = nil;
    if (keyName != nil && keyValue != nil && ![keyName isEqualToString:@""]) {
        predicate = [NSPredicate predicateWithFormat:@"%K=%@ AND %K=%@", keyName, keyValue, [self batchKeyName], batchKey];
    } else {
        predicate = [NSPredicate predicateWithFormat:@"%K=%@", [self batchKeyName], batchKey];
    }
    
    [self.request setPredicate:predicate];
    [batchKey release];

    if (_fetchedResultsController == nil) {
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:self.request managedObjectContext:self.managedObjectContext sectionNameKeyPath:[self sectionName] cacheName:[self cacheName]];
    }
    
    NSError *error = nil;
    if ([self.fetchedResultsController performFetch:&error]) {
        
    } else {
#ifdef MYDEBUG
        NSLog(@"_fetchedController.error:%@", error);
#endif
    }
}

- (void)sortFieldName:(NSString **)fieldName ascending:(BOOL *)ascending {
    *fieldName = @"timestamp";
    *ascending = NO;
}

- (void)deleteOldDataWith:(NSManagedObjectContext *)context withOldBatchValue:(double)batchValue {
    NSFetchRequest *requestOfOld = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityOfOld = [[NSEntityDescription alloc] init];
    [entityOfOld setName:[self entityName]];
    [requestOfOld setEntity:entityOfOld];
    
    
    NSNumber *batchKeyOfOld = [[NSNumber alloc] initWithDouble:batchValue];
    NSPredicate *predicate = nil;
    NSString *keyName = [self contentPrimaryKeyName];
    NSObject *keyValue = [self contentPrimaryValue];
    if (keyName != nil && keyValue != nil && ![keyName isEqualToString:@""]) {
        predicate = [NSPredicate predicateWithFormat:@"%K=%@ AND %K!=%@", keyName, keyValue, [self batchKeyName], batchKeyOfOld];
    } else {
        predicate = [NSPredicate predicateWithFormat:@"%K!=%@", [self batchKeyName], batchKeyOfOld];
    }
    
    [requestOfOld setPredicate:predicate];
    
    
    [batchKeyOfOld release];
    
    
    
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
