//
//  FSTopicAbstractObject.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-24.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FSBatchAbsObject.h"

@class FSDeepHotLink;

@interface FSTopicAbstractObject : FSBatchAbsObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * editorTopic;
@property (nonatomic, retain) NSString * deepid;
@property (nonatomic, retain) NSSet *hotLinks;
@end

@interface FSTopicAbstractObject (CoreDataGeneratedAccessors)

- (void)addHotLinksObject:(FSDeepHotLink *)value;
- (void)removeHotLinksObject:(FSDeepHotLink *)value;
- (void)addHotLinks:(NSSet *)values;
- (void)removeHotLinks:(NSSet *)values;
@end
