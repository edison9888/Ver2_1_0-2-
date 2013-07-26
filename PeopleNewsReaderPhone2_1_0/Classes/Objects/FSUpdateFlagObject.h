//
//  FSUpdateFlagObject.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-24.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FSUpdateFlagObject : NSManagedObject

@property (nonatomic, retain) NSNumber * FLAG_TIMESTAMP;
@property (nonatomic, retain) NSString * FLAG_DESC;

@end
