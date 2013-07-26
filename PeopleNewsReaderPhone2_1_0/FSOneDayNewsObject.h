//
//  FSOneDayNewsObject.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-3-27.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FSBatchNewsObject.h"


@interface FSOneDayNewsObject : FSBatchNewsObject

@property (nonatomic, retain) NSString * newsid;
@property (nonatomic, retain) NSString * news_abstract;
@property (nonatomic, retain) NSString * channelid;
@property (nonatomic, retain) NSNumber * timestamp;
@property (nonatomic, retain) NSString * picture;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * picdesc;
@property (nonatomic, retain) NSString * source;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * group;
@property (nonatomic, retain) NSNumber * browserCount;
@property (nonatomic, retain) NSNumber * commentCount;
@property (nonatomic, retain) NSString * channalIcon;
@property (nonatomic, retain) NSString * realtimeid;
@property (nonatomic, retain) NSString * kind;
@property (nonatomic, retain) NSString * UPDATE_DATE;

@end
