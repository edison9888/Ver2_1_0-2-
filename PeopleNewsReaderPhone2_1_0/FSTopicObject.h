//
//  FSTopicObject.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-4-11.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FSBatchAbsObject.h"


@interface FSTopicObject : FSBatchAbsObject

@property (nonatomic, retain) NSString * deepid;
@property (nonatomic, retain) NSString * pictureLogo;
@property (nonatomic, retain) NSString * news_abstract;
@property (nonatomic, retain) NSNumber * sort;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * pictureLink;
@property (nonatomic, retain) NSString * pubDate;
@property (nonatomic, retain) NSNumber * timestamp;
@property (nonatomic, retain) NSString * createtime;

@end
