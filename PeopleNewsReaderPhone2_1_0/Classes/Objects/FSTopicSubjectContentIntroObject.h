//
//  FSTopicSubjectContentIntroObject.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-24.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FSBatchAbsObject.h"


@interface FSTopicSubjectContentIntroObject : FSBatchAbsObject

@property (nonatomic, retain) NSString * pictureURL;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * subid;
@property (nonatomic, retain) NSString * news_abstract;

@end
