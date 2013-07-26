//
//  FSBaseDB.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-23.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSBaseDB.h"
#import "GlobalConfig.h"
#import "FSCommonFunction.h"
#import "FSChannelSelectedObject.h"
#import "FSVisitChannelObject.h"
#import "FSNewsDitailObject.h"
#import "FSTimestamps.h"
#import "FSDeepContentObject.h"
#import "FSDeepContent_ChildObject.h"
#import "FSNewsDitailPicObject.h"

static FSBaseDB *newsDbInstance = nil;

@implementation FSBaseDB
@synthesize managedObjectContext = _managedObjectContext;


+(FSBaseDB *)sharedFSBaseDB{
    @synchronized(self)
    {
		if (newsDbInstance == nil)
		{
			newsDbInstance = [[FSBaseDB alloc] init];
            //[newsDbInstance initManagedObjectContext];
		}
	}
    [newsDbInstance initManagedObjectContext];
	return newsDbInstance;
    
}

+(FSBaseDB *)sharedFSBaseDBWithNewContext{
    @synchronized(self)
    {
		if (newsDbInstance == nil)
		{
			newsDbInstance = [[FSBaseDB alloc] init];
            //[newsDbInstance initManagedObjectContext];
		}
	}
    
    GlobalConfig * shareConfig = [GlobalConfig shareConfig];
    newsDbInstance.managedObjectContext = [shareConfig newManagedObjectContext];
	return newsDbInstance;
}

+(FSBaseDB *)sharedFSBaseDBWithContext:(NSManagedObjectContext *)managedObjectContext{
    @synchronized(self)
    {
		if (newsDbInstance == nil)
		{
			newsDbInstance = [[FSBaseDB alloc] init];
            //[newsDbInstance initManagedObjectContext];
		}
	}
    newsDbInstance.managedObjectContext = managedObjectContext;
    return newsDbInstance;
}

-(void)initManagedObjectContext{
    GlobalConfig * shareConfig = [GlobalConfig shareConfig];
    self.managedObjectContext = [shareConfig getApplicationManagedObjectContext];
    //_managedObjectContext = [shareConfig newManagedObjectContext];
    
    if (_managedObjectContext==nil) {
        //访问本地数据失败
        self.managedObjectContext = [shareConfig newManagedObjectContext];
    }
    else{
       
    }
}


//-------------------------------------------------------------

-(NSObject *)insertObject:(NSString *)name{
    NSObject *obj = [NSEntityDescription insertNewObjectForEntityForName:name
                                                  inManagedObjectContext: _managedObjectContext];
    
    [self.managedObjectContext save:nil];
	
    return obj;
}


-(void)deleteObjectByKey:(NSString *)name key:(NSString *)key value:(NSString *)value{
    
    NSArray *arrays = [newsDbInstance getObjectsByKeyWithName:name key:key value:value];
    NSManagedObject *o = [arrays lastObject];
    [self.managedObjectContext deleteObject:o];
    NSError *error = nil;
    [self.managedObjectContext save:&error];
    
}

-(void)deleteObjectByObject:(NSManagedObject *)obj{

    [self.managedObjectContext deleteObject:obj];
   
    [self.managedObjectContext save:nil];
    
}

-(void)deleteObjectByObjectS:(NSArray *)array{
    for (NSManagedObject *obj in array) {
        [self.managedObjectContext deleteObject:obj];
    }
    [self.managedObjectContext save:nil];
}


-(NSArray *)getObjectsByKeyWithName:(NSString *)name key:(NSString *)key value:(NSString *)value{

    _EntityDescription = [[NSEntityDescription alloc] init];
    [_EntityDescription setName:name];
    
    //NSLog(@"name:%@,%@,%@",name,key,value);
    
    
    //NSString *predicateFormat = [[NSString alloc] initWithFormat:@"%@='%@'", key, value];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K=%@", key, value];
    
	//predicate = [NSPredicate predicateWithFormat:predicateFormat];
	NSFetchRequest * fetch = [[NSFetchRequest alloc] init];
	[fetch setEntity: _EntityDescription];
	[fetch setPredicate: predicate];
	NSArray *results = [self.managedObjectContext executeFetchRequest:fetch error:nil];
	[fetch release];
    //[predicateFormat release];
    [_EntityDescription release];
    return results;
    
}

-(NSArray *)getAllObjectsSortByKey:(NSString *)name key:(NSString *)key ascending:(BOOL)ascending{
    
    
    _EntityDescription = [[NSEntityDescription alloc] init];
    [_EntityDescription setName:name];
    
    NSFetchRequest * fetch = [[NSFetchRequest alloc] init];
	[fetch setEntity: _EntityDescription];
    
    
    NSSortDescriptor *sortDescriptor = nil;
    if (key!=nil) {
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending];
        [fetch setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        [sortDescriptor release];
    }
    else{
        [fetch setSortDescriptors:nil];
    }
	
	NSArray *results = [self.managedObjectContext executeFetchRequest:fetch error:nil];
	[fetch release];
    [_EntityDescription release];
	return results;
}


-(void)updata_visit_message:(NSString *)channelid{
    
    NSArray *visitArray = [self getObjectsByKeyWithName:@"FSVisitChannelObject" key:@"channelid" value:channelid];
    
    NSString *date = dateToString_YMD([NSDate dateWithTimeIntervalSinceNow:0.0f]);
    
    if ([visitArray count] >0) {
        FSVisitChannelObject *o = [visitArray lastObject];//更新访问信息
        if ([date isEqualToString:o.updata_date]) {
            NSInteger n = [o.date9 integerValue]+1;
            o.date9 = [NSNumber numberWithInteger:n];
        }
        else{
            o.date1 = o.date2;
            o.date2 = o.date3;
            o.date3 = o.date4;
            o.date4 = o.date5;
            o.date5 = o.date6;
            o.date6 = o.date7;
            o.date7 = o.date8;
            o.date8 = o.date9;
            o.date9 = [NSNumber numberWithInteger:1];
            o.updata_date = date;
            
        }
    }
    else{
        FSVisitChannelObject *o = (FSVisitChannelObject *)[self insertObject:@"FSVisitChannelObject"];
        o.channelid = channelid;
        o.date9 = [NSNumber numberWithInteger:1];
        o.updata_date = date;
    }
    [self.managedObjectContext save:nil];
}


-(void)updata_selectChannel_visit_message:(NSString *)channelid{

    NSArray *visitArray = [self getObjectsByKeyWithName:@"FSVisitChannelObject" key:@"channelid" value:channelid];
    
    if ([visitArray count] >0) {
        ;//更新访问信息
    }
    else{
        ;
    }
    [self.managedObjectContext save:nil];

}

-(void)updata_oneday_selectChannel_message:(NSString *)channelid{
     NSArray *selectArray = [self getObjectsByKeyWithName:@"FSChannelSelectedObject" key:@"channelid" value:channelid];
    if ([selectArray count]>0) {
        NSManagedObject *o = [selectArray lastObject];
        [self.managedObjectContext deleteObject:o];
        NSError *error = nil;
        [self.managedObjectContext save:&error];
    }
    else{
        FSChannelSelectedObject *o = (FSChannelSelectedObject *)[self insertObject:@"FSChannelSelectedObject"];
        o.channelid = channelid;
        [self.managedObjectContext save:nil];
    }
    
    [[GlobalConfig shareConfig] setOnedayChannalMark:YES];
}


//清理缓存
-(void)clearCache{
//    @"FSNewsDitailObject"
//    FSNewsDitailPicObject
//    @"FSTimestamps"
//    
//    FSDeepContentObject
//
//    FSDeepContent_ChildObject;
    
    
    NSArray *arrayFSNewsDitailObject = [self getAllObjectsSortByKey:@"FSNewsDitailObject" key:@"newsid" ascending:YES];
    NSArray *arrayFSDeepContentObject = [self getAllObjectsSortByKey:@"FSDeepContentObject" key:@"contentid" ascending:YES];
    for (FSNewsDitailObject *o in arrayFSNewsDitailObject) {
        NSArray *timeArray = [self getObjectsByKeyWithName:@"FSTimestamps" key:@"flag" value:[NSString stringWithFormat:@"FSNewsDitailObject_%@",o.newsid]];
        if ([timeArray count]>0) {
            [self deleteObjectByObjectS:timeArray];
        }
    }
    [self deleteObjectByObjectS:arrayFSNewsDitailObject];
    
    
    NSArray *arrayFSNewsDitailPicObject = [self getAllObjectsSortByKey:@"FSNewsDitailPicObject" key:@"newsid" ascending:YES];
    [self deleteObjectByObjectS:arrayFSNewsDitailPicObject];
    
    for (FSDeepContentObject *oo in arrayFSDeepContentObject) {
        NSArray *timeArray = [self getObjectsByKeyWithName:@"FSTimestamps" key:@"flag" value:[NSString stringWithFormat:@"FSDeepContentObject_%@",oo.contentid]];
        if ([timeArray count]>0) {
            [self deleteObjectByObjectS:timeArray];
        }
    }
    [self deleteObjectByObjectS:arrayFSDeepContentObject];
    
    NSArray *arrayFSDeepContent_ChildObject = [self getAllObjectsSortByKey:@"FSDeepContent_ChildObject" key:@"contentid" ascending:YES];
    [self deleteObjectByObjectS:arrayFSDeepContent_ChildObject];
    
    
}

@end









