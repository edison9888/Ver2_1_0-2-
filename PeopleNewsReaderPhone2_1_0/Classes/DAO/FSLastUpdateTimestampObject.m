//
//  FSLastUpdateTimestampObject.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-9-5.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSLastUpdateTimestampObject.h"

#define LASTUPDATEINFO_ENTITYNAME @"FSUpdateFlagObject"
#define LASTUPDATEINFO_INDEX_FIELD @"FLAG_DESC"
#define LASTUPDATEINFO_INDEX_FIELD_FORMAT @"FLAG_DESC=%@"
#define LASTUPDATEINFO_VALUE_TIMESTAMP_FIELD @"FLAG_TIMESTAMP"

@implementation FSLastUpdateTimestampObject

- (id)initWithContext:(NSManagedObjectContext *)context {
	self = [super init];
	if (self) {
		_managedObjectContext = [context retain];
	}
	return self;
}

- (void)dealloc {
	[_managedObjectContext release];
	[super dealloc];
}

- (void)writeLastUpdateTimestamp:(NSString *)predicateValue timestamp:(NSTimeInterval)timestamp {
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	
	NSEntityDescription *entity = [[NSEntityDescription alloc] init];
	[entity setName:LASTUPDATEINFO_ENTITYNAME];
	[request setEntity:entity];
	[request setPredicate:[NSPredicate predicateWithFormat:LASTUPDATEINFO_INDEX_FIELD_FORMAT, predicateValue]];
	
	NSError *error = nil;
	NSArray *resultSet = [_managedObjectContext executeFetchRequest:request error:&error];
	if (error) {
#ifdef MYDEBUG
		NSLog(@"error:%@", error);
#endif
	} else {
#ifdef MYDEBUG
		NSLog(@"resultSet:%@", resultSet);
#endif
		if ([resultSet count] > 0) {
			id updateObject = [resultSet objectAtIndex:0];
			[updateObject setValue:[NSNumber numberWithDouble:timestamp] forKey:LASTUPDATEINFO_VALUE_TIMESTAMP_FIELD];
		} else {
			
			id updateObject = [NSEntityDescription insertNewObjectForEntityForName:LASTUPDATEINFO_ENTITYNAME inManagedObjectContext:_managedObjectContext];
			[updateObject setValue:predicateValue forKey:LASTUPDATEINFO_INDEX_FIELD];
			[updateObject setValue:[NSNumber numberWithDouble:timestamp] forKey:LASTUPDATEINFO_VALUE_TIMESTAMP_FIELD];
			
		}
	}
	
	if ([_managedObjectContext hasChanges] && ![_managedObjectContext save:&error]) {
#ifdef MYDEBUG
		NSLog(@"%@.save.write.error:%@", self, error);
#endif
	}
	[entity release];
	[request release];
}

- (NSTimeInterval)readLastUpdateTimestamp:(NSString *)predicateValue {
	NSTimeInterval lastUpdateTimestamp = 0;
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	
	NSEntityDescription *entity = [[NSEntityDescription alloc] init];
	[entity setName:LASTUPDATEINFO_ENTITYNAME];
	[request setEntity:entity];
	[request setPredicate:[NSPredicate predicateWithFormat:LASTUPDATEINFO_INDEX_FIELD_FORMAT, predicateValue]];
	
	NSError *error = nil;
	NSArray *resultSet = [_managedObjectContext executeFetchRequest:request error:&error];
	if (error) {
#ifdef MYDEBUG
		NSLog(@"error:%@", error);
#endif
	} else {
#ifdef MYDEBUG
		NSLog(@"resultSet:%@", resultSet);
#endif
		if ([resultSet count] > 0) {
			id updateObject = [resultSet objectAtIndex:0];
			lastUpdateTimestamp = [[updateObject valueForKey:LASTUPDATEINFO_VALUE_TIMESTAMP_FIELD] doubleValue];
		}
	}
	
	[entity release];
	[request release];
	
	return lastUpdateTimestamp;
}

@end
