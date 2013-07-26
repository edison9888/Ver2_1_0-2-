//
//  FSNewsDitailObject.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-1-5.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FSBatchNewsObject.h"


@interface FSNewsDitailObject : FSBatchNewsObject

@property (nonatomic, retain) NSString * newsid;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * source;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSNumber * pictures;
@property (nonatomic, retain) NSString * timestamp;
@property (nonatomic, retain) NSString * updata_date;
@property (nonatomic, retain) NSString * shortUrl;

@end
