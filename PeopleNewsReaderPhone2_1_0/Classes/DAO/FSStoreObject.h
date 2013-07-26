//
//  FSStoreObject.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-19.
//
//

#import <Foundation/Foundation.h>
#import "GlobalConfig.h"
#import <CoreData/CoreData.h>

typedef BOOL (^judateEntityCanBeSave)(id obj);

@interface FSStoreObject : NSObject {
@private
    NSManagedObjectContext *_context;
    NSMutableDictionary *_entitiesDic;

}

- (id)insertObjectWithEntityName:(NSString *)entityName;

- (id)objectWithEntity:(NSString *)entityName;

- (void)finalizeEntityWithEntityName:(NSString *)entityName;

- (void)finalizeAllObjects:(void (^)(BOOL saveSuccessful))saveResult;

- (id)objectWithObjectID:(NSManagedObjectID *)objectID withEntityName:(NSString *)entityName;

- (id)objectWithPrimaryKeyName:(NSString *)primaryKeyName withPrimaryValue:(NSObject *)primaryValue withEntityName:(NSString *)entityName withNewEntity:(BOOL)newEntity;

- (void)finalizeEntityWithEntityName:(NSString *)entityName judageEntity:(judateEntityCanBeSave)judateEntity;

@end
