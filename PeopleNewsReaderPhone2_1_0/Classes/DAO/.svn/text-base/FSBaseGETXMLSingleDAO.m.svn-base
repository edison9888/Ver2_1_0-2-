//
//  FSBaseGETXMLSingleDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-9-4.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSBaseGETXMLSingleDAO.h"


@implementation FSBaseGETXMLSingleDAO
@synthesize contentObject =_contentObject;

- (id)init {
	self = [super init];
	if (self) {
	}
	return self;
}

- (void)dealloc {
	
	[super dealloc];
}

- (NSInteger)fetchLimitWithGETDDataKind:(GETDataKind)getDataKind {
	return 1;
}

- (void)executeFetchRequest:(NSFetchRequest *)request {
	NSError *error = nil;
	NSArray *resultSet = [self.managedObjectContext executeFetchRequest:request error:&error];
	if (!error) {
		if ([resultSet count] > 0) {
			self.contentObject = [resultSet objectAtIndex:0];
		}
	}
}

- (void)operateOldBufferData {
	if (self.currentGetDataKind == GETDataKind_Refresh) {
		if (self.contentObject != nil) {
			[self.managedObjectContext deleteObject:self.contentObject];
			[self saveCoreDataContext];
		}
	}
}

@end
