//
//  FSDeepLeadObject.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-1-6.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FSBatchAbsObject.h"


@interface FSDeepLeadObject : FSBatchAbsObject

@property (nonatomic, retain) NSString * deepTitle;
@property (nonatomic, retain) NSString * picture;
@property (nonatomic, retain) NSString * deepid;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * leadContent;

@end
