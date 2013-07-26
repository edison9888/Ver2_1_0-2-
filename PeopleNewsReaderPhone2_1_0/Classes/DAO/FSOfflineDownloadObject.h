//
//  FSOfflineDownloadObject.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-9-18.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface FSOfflineDownloadObject : NSObject {
@private
	NSManagedObjectContext *_managedObjectContext;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
