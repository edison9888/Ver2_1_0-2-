//
//  FSForNewsListFocusTopDAO.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-9-24.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSForNewsListFocusTopDAO.h"

#define FSFOUCS_URL @"http://mobile.app.people.com.cn:81/news2/news.php?act=focuspicture&rt=xml"
#define FSNEWSFOCUS_LAST_UPDATE_DESC @"FSFOCUS_NEWS_LIST"

@implementation FSForNewsListFocusTopDAO

- (id)init {
	self = [super init];
	if (self) {
         _group = @"news";
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
    return FSNEWSFOCUS_LAST_UPDATE_DESC;
}



@end
