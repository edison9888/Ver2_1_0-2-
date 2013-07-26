//
//  FSLastUpdateTimestampObject.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-9-5.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FSLastUpdateTimestampObject : NSObject {
@private
	NSManagedObjectContext *_managedObjectContext;
}
- (id)initWithContext:(NSManagedObjectContext *)context;
- (void)writeLastUpdateTimestamp:(NSString *)predicateValue timestamp:(NSTimeInterval)timestamp;
- (NSTimeInterval)readLastUpdateTimestamp:(NSString *)predicateValue;

@end
