//
//  FSBaseGETXMLListDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-8.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSBaseGETXMLListDAO.h"


@implementation FSBaseGETXMLListDAO
@synthesize objectList = _objectList;

- (id)init {
	self = [super init];
	if (self) {
		
	}
	return self;
}

- (void)dealloc {
	[_objectList release];
	[super dealloc];
}

- (NSInteger)fetchLimitWithGETDDataKind:(GETDataKind)getDataKind {
	if (getDataKind == GETDataKind_Refresh) {
		return 20;
	} else {
		return [self.objectList count] + 20;
	}
}

- (void)executeFetchRequest:(NSFetchRequest *)request {
	NSError *error = nil;
	NSArray *resultSet = [self.managedObjectContext executeFetchRequest:request error:&error];
	if (!error) {
		NSArray *tempResultSet = [[NSArray alloc] initWithArray:resultSet];
		self.objectList = tempResultSet;
		self.isRecordListTail = [self.objectList count] < [self.fetchRequest fetchLimit];
		[tempResultSet release];
	}
}

- (void)operateOldBufferData {
	if (self.currentGetDataKind == GETDataKind_Refresh) {
		NSArray *resultSets = self.objectList;
		if ([resultSets count] > 0) {
#ifdef MYDEBUG
			NSLog(@"resultSets:%@", resultSets);
#endif
			for (id entityObject in resultSets) {
#ifdef MYDEBUG
				NSLog(@"entityObject:%@", entityObject);
#endif
                if (![entityObject isDeleted]) {
                    [self.managedObjectContext deleteObject:entityObject];
                    //NSLog(@"MOC:OperateOldBufferData2");
                    [self saveCoreDataContext];
                }
			}
			
		}
	}
}

@end
