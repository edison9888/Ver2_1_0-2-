//
//  FSBaseGETXMLListExDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-9-4.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSBaseGETXMLListExDAO.h"


@implementation FSBaseGETXMLListExDAO
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

- (NSInteger)fetchLimitWithGETDDataKind:(GETDataKind)getDataKind {
	return 20;
}

- (void)executeFetchRequest:(NSFetchRequest *)request {
	if (self.fetchedResultsController == nil) {
		NSFetchedResultsController *fetchResult = [[NSFetchedResultsController alloc] initWithFetchRequest:request 
																					  managedObjectContext:self.managedObjectContext 
																						sectionNameKeyPath:[self fetchedResultsSectionKeyName] 
																								 cacheName:[self fetchedResultsCacheName]];
		self.fetchedResultsController = fetchResult;
		[fetchResult release];
	} else {
		if (self.fetchedResultsController.cacheName != nil) {
			[NSFetchedResultsController deleteCacheWithName:self.fetchedResultsController.cacheName];
		}
	}
	
	[request setFetchBatchSize:20];
	//继续触发
	NSError *error = nil;
	if ([self.fetchedResultsController performFetch:&error]) {
#ifdef MYDEBUG
		//NSLog(@"fetchedResultsController:%@", [self.fetchedResultsController fetchedObjects]);
#endif
	} else {
#ifdef MYDEBUG
		NSLog(@"%@.error:%@", self, error);
#endif
	}
}

- (void)operateOldBufferData {
    if (self.currentGetDataKind == GETDataKind_Refresh) {
//		NSArray *resultSets = self.objectList;
//		if ([resultSets count] > 0) {
//#ifdef MYDEBUG
//			NSLog(@"resultSets:%@", resultSets);
//#endif
//			for (id entityObject in resultSets) {
//#ifdef MYDEBUG
//				NSLog(@"entityObject:%@", entityObject);
//#endif
//                if (![entityObject isDeleted]) {
//                    [self.managedObjectContext deleteObject:entityObject];
//                    [self saveCoreDataContext];
//                }
//			}
//			
//		}
	}
}

- (NSString *)fetchedResultsSectionKeyName {
	return nil;
}

- (NSString *)fetchedResultsCacheName {
	return nil;
}

@end
