//
//  FSDeepOuterLinkListObject.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-1-6.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FSBatchAbsObject.h"


@interface FSDeepOuterLinkListObject : FSBatchAbsObject

@property (nonatomic, retain) NSNumber * flag;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * newsid;
@property (nonatomic, retain) NSNumber * orderIndex;
@property (nonatomic, retain) NSString * outerid;
@property (nonatomic, retain) NSString * link;

@end
