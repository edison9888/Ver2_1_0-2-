//
//  FSDeepContent_ChildObject.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-1-6.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FSBatchNewsObject.h"


@interface FSDeepContent_ChildObject : FSBatchNewsObject

@property (nonatomic, retain) NSNumber * flag;
@property (nonatomic, retain) NSString * contentid;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSNumber * orderIndex;

@end
