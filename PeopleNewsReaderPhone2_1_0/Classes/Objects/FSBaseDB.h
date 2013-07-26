//
//  FSBaseDB.h
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-23.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSBaseDB : NSObject{
@protected
    NSManagedObjectContext *_managedObjectContext;
    NSEntityDescription *_tempEntity;
    NSEntityDescription *_channelEntity;
    NSEntityDescription *_oneDayNewsEntity;
    
    NSEntityDescription *_EntityDescription;
}
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

+ (FSBaseDB *) sharedFSBaseDB;
+ (FSBaseDB *) sharedFSBaseDBWithContext:(NSManagedObjectContext *)managedObjectContext;
+ (FSBaseDB *) sharedFSBaseDBWithNewContext;

-(void)initManagedObjectContext;


-(NSObject *)insertObject:(NSString *)name;
-(void)deleteObjectByKey:(NSString *)name key:(NSString *)key value:(NSString *)value;
-(void)deleteObjectByObject:(NSManagedObject *)obj;

-(void)deleteObjectByObjectS:(NSArray *)array;

-(NSArray *)getObjectsByKeyWithName:(NSString *)name key:(NSString *)key value:(NSString *)value;

-(NSArray *)getAllObjectsSortByKey:(NSString *)name key:(NSString *)key ascending:(BOOL)ascending;


-(void)updata_visit_message:(NSString *)channelid;

-(void)updata_selectChannel_visit_message:(NSString *)channelid;

-(void)updata_oneday_selectChannel_message:(NSString *)channelid;


-(void)clearCache;

@end
