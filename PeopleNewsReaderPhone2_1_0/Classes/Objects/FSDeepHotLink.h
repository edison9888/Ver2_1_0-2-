//
//  FSDeepHotLink.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-24.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FSDeepHotLink : NSManagedObject

@property (nonatomic, retain) NSString * hotId;
@property (nonatomic, retain) NSString * hotTitle;
@property (nonatomic, retain) NSString * source;
@property (nonatomic, retain) NSNumber * batchtimestamp;
@property (nonatomic, retain) NSString * hotURL;

@end
