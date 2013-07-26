//
//  FSTimestamps.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-24.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FSTimestamps : NSManagedObject

@property (nonatomic, retain) NSString * flag;
@property (nonatomic, retain) NSNumber * localtimestamp;
@property (nonatomic, retain) NSNumber * networktimestamp;

@end
