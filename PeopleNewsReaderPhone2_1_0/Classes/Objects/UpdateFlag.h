//
//  UpdateFlag.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-16.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface UpdateFlag : NSManagedObject {

}

@property (retain) NSString *FLAG_DESC;
@property double_t FLAG_TIME;

@end
