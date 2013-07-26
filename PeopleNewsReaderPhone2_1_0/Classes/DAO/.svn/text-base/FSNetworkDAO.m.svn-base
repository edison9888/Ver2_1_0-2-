//
//  FSNetworkDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-22.
//
//

#import "FSNetworkDAO.h"

@implementation FSNetworkDAO
@synthesize managedObjectContext = _managedObjectContext;

- (id)init {
    self = [super init];
    if (self) {
        _managedObjectContext = [[[GlobalConfig shareConfig] getApplicationManagedObjectContext] retain];
    }
    return self;
}

- (void)dealloc {
    [_managedObjectContext release];
    [super dealloc];
}



@end
