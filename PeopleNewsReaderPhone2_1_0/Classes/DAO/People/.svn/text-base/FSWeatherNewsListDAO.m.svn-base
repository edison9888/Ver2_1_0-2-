//
//  FSWeatherNewsListDAO.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-9-25.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSWeatherNewsListDAO.h"

#define FSWEATHER_NEWS_URL @"http://mobile.app.people.com.cn:81/news2/news.php?act=dailylist&rt=xml&deviceid=%@&lastnewsid=%@&count=%d"

#define FSWEATHER_LAST_UPDATE_DESC @"FSWEATHER_NEWS_LIST"


@implementation FSWeatherNewsListDAO

- (id)init {
	self = [super init];
	if (self) {
        
	}
	return self;
}

-(void)dealloc{
    [super dealloc];
}


-(NSString *)readDataURLStringFromRemoteHostWithGETDataKind:(GETDataKind)getDataKind{
    return FSWEATHER_NEWS_URL;
}

-(NSString *)lastUpdateTimestampPredicateValue{
    return FSWEATHER_LAST_UPDATE_DESC;
}


@end
