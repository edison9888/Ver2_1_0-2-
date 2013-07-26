//
//  FSUpdateFlagObject.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-9-27.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface FSUpdateFlagObject :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * FLAG_TIMESTAMP;
@property (nonatomic, retain) NSString * FLAG_DESC;

@end



