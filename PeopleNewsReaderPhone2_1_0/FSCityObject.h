//
//  FSCityObject.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-1-28.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FSBatchNewsObject.h"


@interface FSCityObject : FSBatchNewsObject

@property (nonatomic, retain) NSString * cityId;
@property (nonatomic, retain) NSString * kind;
@property (nonatomic, retain) NSString * cityName;
@property (nonatomic, retain) NSString * provinceId;
@property (nonatomic, retain) NSString * updata_date;
@property (nonatomic, retain) NSString * provinceName;

@end
