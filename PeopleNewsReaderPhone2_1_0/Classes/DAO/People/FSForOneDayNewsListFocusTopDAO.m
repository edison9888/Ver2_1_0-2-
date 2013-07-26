//
//  FSForOneDayNewsListFocusTopDAO.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-9-21.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSForOneDayNewsListFocusTopDAO.h"
#define FSFOUCS_URL @"http://mobile.app.people.com.cn:81/news2/news.php?act=focuspicture&rt=xml"
#define FSFOCUS_LAST_UPDATE_DESC @"FSFOCUS_ONEDAY_NEWS_LIST"

@implementation FSForOneDayNewsListFocusTopDAO


- (id)init {
	self = [super init];
	if (self) {
        _group = @"oneday";
	}
    
	return self;
}

-(void)dealloc{
    [super dealloc];
}


-(NSString *)readDataURLStringFromRemoteHostWithGETDataKind:(GETDataKind)getDataKind{
    return FSFOUCS_URL;
}

-(NSString *)lastUpdateTimestampPredicateValue{
    return FSFOCUS_LAST_UPDATE_DESC;
}


@end
