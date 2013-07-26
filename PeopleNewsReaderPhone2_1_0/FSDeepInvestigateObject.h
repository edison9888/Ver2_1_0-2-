//
//  FSDeepInvestigateObject.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-1-6.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FSBatchAbsObject.h"

@class FSDeepInvestigate_OptionObject;

@interface FSDeepInvestigateObject : FSBatchAbsObject

@property (nonatomic, retain) NSString * subjectTile;
@property (nonatomic, retain) NSString * subjectid;
@property (nonatomic, retain) NSNumber * investigateOption;
@property (nonatomic, retain) NSString * investigateid;
@property (nonatomic, retain) NSNumber * investigateMultiCount;
@property (nonatomic, retain) NSNumber * haspost;
@property (nonatomic, retain) NSString * investigateTitle;
@property (nonatomic, retain) NSSet *investages;
@end

@interface FSDeepInvestigateObject (CoreDataGeneratedAccessors)

- (void)addInvestagesObject:(FSDeepInvestigate_OptionObject *)value;
- (void)removeInvestagesObject:(FSDeepInvestigate_OptionObject *)value;
- (void)addInvestages:(NSSet *)values;
- (void)removeInvestages:(NSSet *)values;
@end
