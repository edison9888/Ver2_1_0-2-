//
//  FSNewsListDAO.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-9-25.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSNewsListDAO.h"

#define FS_NEWS_URL @"http://mobile.app.people.com.cn:81/news2/news.php?act=dailylist&rt=xml&deviceid=%@&lastnewsid=%@&count=%d"

#define FSNEWS_LAST_UPDATE_DESC @"FS_NEWS_LIST"

@implementation FSNewsListDAO

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
    return FS_NEWS_URL;
}

-(NSString *)lastUpdateTimestampPredicateValue{
    return FSNEWS_LAST_UPDATE_DESC;
}



@end
