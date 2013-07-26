//
//  FSDeepContentObject.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-1-7.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FSBatchAbsObject.h"

@class FSDeepContent_ChildObject;

@interface FSDeepContentObject : FSBatchAbsObject

@property (nonatomic, retain) NSString * source;
@property (nonatomic, retain) NSString * subjectTile;
@property (nonatomic, retain) NSString * subjectid;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * pubDate;
@property (nonatomic, retain) NSString * contentid;
@property (nonatomic, retain) NSNumber * timestamp;
@property (nonatomic, retain) NSString * subjectPic;
@property (nonatomic, retain) NSSet *childContent;
@end

@interface FSDeepContentObject (CoreDataGeneratedAccessors)

- (void)addChildContentObject:(FSDeepContent_ChildObject *)value;
- (void)removeChildContentObject:(FSDeepContent_ChildObject *)value;
- (void)addChildContent:(NSSet *)values;
- (void)removeChildContent:(NSSet *)values;
@end
