//
//  FSStoreObject.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-19.
//
//

#import "FSStoreObject.h"

@implementation FSStoreObject


- (id)init {
    self = [super init];
    if (self) {
        _context = [[[GlobalConfig shareConfig] newManagedObjectContext] retain];
        _entitiesDic = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)dealloc {
    [_entitiesDic release];
    [_context release];
    [super dealloc];
}

- (id)insertObjectWithEntityName:(NSString *)entityName {
    NSEntityDescription *entity = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:_context];
    [_entitiesDic setObject:entity forKey:entityName];
    return entity;
}

- (void)finalizeEntityWithEntityName:(NSString *)entityName {
    NSObject *obj = [_entitiesDic objectForKey:entityName];
    if (obj != nil) {
        [_entitiesDic removeObjectForKey:entityName];
    }
}

- (id)objectWithEntity:(NSString *)entityName {
    return [_entitiesDic  objectForKey:entityName];
}

- (id)objectWithObjectID:(NSManagedObjectID *)objectID withEntityName:(NSString *)entityName {
    id result = [_context objectWithID:objectID];
    if (result == nil) {
        result = [self insertObjectWithEntityName:entityName];
    }
    if (result) {
        [_entitiesDic setObject:result forKey:entityName];
    }
    return result;
}

- (id)objectWithPrimaryKeyName:(NSString *)primaryKeyName withPrimaryValue:(NSObject *)primaryValue withEntityName:(NSString *)entityName withNewEntity:(BOOL)newEntity {
    id result = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [[NSEntityDescription alloc] init];
    [entity setName:entityName];
    [request setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K=%@", primaryKeyName, primaryValue];
    [request setPredicate:predicate];
    
    [request setFetchLimit:1];
    NSError *error = nil;
    NSArray *recordSet = [_context executeFetchRequest:request error:&error];
    if ([recordSet count] > 0) {
        result = [recordSet objectAtIndex:0];
    } else {
        if (newEntity) {
            result = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:_context];
        }
        
    }
    if (result) {
        [_entitiesDic setObject:result forKey:entityName];
    }
    
    [entity release];
    [request release];
    return  result;
}

- (void)finalizeAllObjects:(void (^)(BOOL saveSuccessful))saveResult {
    BOOL saveRst = NO;
    if ([_context hasChanges]) {
        NSError *error = nil;
        if ([_context save:&error]) {
            saveRst = YES;
        } else {
#ifdef MYDEBUG
            NSLog(@"FSStoreObject.save.error:%@[%@]", error, self);
#endif
            [_context rollback];
        }
    }
    
    saveResult(saveRst);
}

- (void)finalizeEntityWithEntityName:(NSString *)entityName judageEntity:(judateEntityCanBeSave)judateEntity {
    id obj = [_entitiesDic objectForKey:entityName];
    if (obj) {
        BOOL canBeSave = YES;
        if (judateEntity) {
            canBeSave = judateEntity(obj);
        }
        if (!canBeSave) {
            [_context deleteObject:obj];
        }
        
        [_entitiesDic removeObjectForKey:entityName];
    }
    
}

@end
