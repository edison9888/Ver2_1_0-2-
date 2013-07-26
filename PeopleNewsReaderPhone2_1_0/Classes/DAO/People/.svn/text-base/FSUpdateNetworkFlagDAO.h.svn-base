//
//  FSUpdateNetworkFlagDAO.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-20.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSBaseGETXMLDAO.h"
#import "FSUpdateFlagObject.h"


#define UPDATE_DESC_CHANNEL_UPDATE @"CHANNEL_UPDATE_ID"
#define UPDATE_DESC_CITY_UPDATE @"CITY_UPDATE_ID"

typedef enum _TimestampKind {
	TimestampKind_None,
	TimestampKind_Channel,
	TimestampKind_City
} TimestampKind;

@interface FSUpdateNetworkFlagDAO : FSBaseGETXMLDAO {
@private
	TimestampKind _timestampKind;
	FSUpdateFlagObject *_updateFlag;
	NSString *_UPDATE_DESC;
	double _UPDATE_TIME;
}

@property (nonatomic) TimestampKind timestampKind;
@property (nonatomic, retain) NSString *UPDATE_DESC;
@property (nonatomic) double UPDATE_TIME;
@property (nonatomic, retain) FSUpdateFlagObject *updateFlag;


@end
