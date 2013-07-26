//
//  FSOneDayNewsListDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-9-20.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSOneDayNewsListDAO.h"

#define FSONEDAY_NEWS_URL @"http://mobile.app.people.com.cn:81/news2/news.php?act=dailylist&rt=xml&deviceid=%@&lastnewsid=%@&count=%d"

#define FSONEDAY_LAST_UPDATE_DESC @"ONEDAY_NEWS_LIST"

#define FSONEDAY_NEWS_PAGECOUNT 20

@implementation FSOneDayNewsListDAO

- (id)init {
	self = [super init];
	if (self) {
		
	}
	return self;
}

- (void)dealloc {
	
	[super dealloc];
}

- (NSString *)readDataURLStringFromRemoteHostWithGETDataKind:(GETDataKind)getDataKind {
	if (getDataKind == GETDataKind_Refresh) {
		return [NSString stringWithFormat:FSONEDAY_NEWS_URL, [[GlobalConfig shareConfig] getDeviceUnique_ID], @"", FSONEDAY_NEWS_PAGECOUNT];
	} else {
		FSOneDayNewsObject *obj = [self.objectList lastObject];
		if (obj == nil) {
			return [NSString stringWithFormat:FSONEDAY_NEWS_URL, [[GlobalConfig shareConfig] getDeviceUnique_ID], @"", FSONEDAY_NEWS_PAGECOUNT];
		} else {
			return [NSString stringWithFormat:FSONEDAY_NEWS_URL, [[GlobalConfig shareConfig] getDeviceUnique_ID], obj.newsid, FSONEDAY_NEWS_PAGECOUNT];
		}
	}
}

- (NSTimeInterval)bufferDataExpireTimeInterval {
	return 60 * 10;
}

//查询数据
- (NSString *)predicateStringWithQueryDataKind:(QueryDataKind)dataKind {
	if (dataKind == QueryDataKind_New) {
		return [NSString stringWithFormat:@"UPDATE_DATE='%@'", dateToString_YMD([NSDate dateWithTimeIntervalSinceNow:0.0f])];
	} else {
		return nil;
	}
}

- (NSInteger)fetchLimitWithGETDDataKind:(GETDataKind)getDataKind {
	if (getDataKind == GETDataKind_Refresh) {
		return FSONEDAY_NEWS_PAGECOUNT;
	} else {
		return [self.objectList count] + FSONEDAY_NEWS_PAGECOUNT;
	}
}

- (NSString *)lastUpdateTimestampPredicateValue {
	return FSONEDAY_LAST_UPDATE_DESC;
}

- (NSString *)entityName {
	return @"FSOneDayNewsObject";
}

- (void)initializeSortDescriptions:(NSMutableArray *)descriptions {
	[self addSortDescription:descriptions withSortFieldName:@"timestamp" withAscending:YES];
}

- (void)baseXMLParserFinishXMLObjectNode:(FSBaseXMLParserObject *)sender withXMLResultObject:(id)resultObject { 
#ifdef MYDEBUG
	NSLog(@"FSOneDayNewsListDAO.resultObject:%@", resultObject);
#endif
	
	
	FSStoreInCoreDataObject *storeObj = [[FSStoreInCoreDataObject alloc] initWithResultObject:resultObject withContext:self.managedObjectContext withDelegate:self];
	[storeObj startStoreBlockEntityName:^(NSString *memberName) {
		if (memberName == nil) {
			return @"FSOneDayNewsObject";
		} else {
			return (NSString *)nil;
		}
	}
				blockRelationShipObject:NULL 
				blockDefineRelationShip:NULL 
				 blockAssignEntityValue:^(id currentObject, NSString *key, id value) {
					 NSString *tempKey = key;
					 if ([tempKey isEqualToString:@"abstract"]) {
						 tempKey = @"news_abstract";
					 }
					 
					 NSString *tempValue;
					 if ([value isKindOfClass:[NSData class]]) {
						 NSString *result = [[NSString alloc] initWithData:value encoding:NSUTF8StringEncoding];
						 tempValue = [result retain];
						 [result release];
					 } else {
						 tempValue = [value retain];
					 }	
					 
					 if ([tempKey isEqualToString:@"browserCount"] ||
						 [tempKey isEqualToString:@"commentCount"]) {
						 NSNumber *tempNumber = [[NSNumber alloc] initWithInt:[tempValue intValue]];
						 [currentObject setValue:tempNumber forKey:tempKey];
						 [tempNumber release];
					 } else if ([tempKey isEqualToString:@"timestamp"]) {
						 NSNumber *tempNumber = [[NSNumber alloc] initWithInt:[tempValue doubleValue]];
						 [currentObject setValue:tempNumber forKey:tempKey];
						 [tempNumber release];
					 } else {
						 [currentObject setValue:tempValue forKey:tempKey];
					 }
					 [tempValue release];
				 } 
		 blockAssignEntitySpecificValue: ^(id currentObject) {
			 [currentObject setValue:dateToString_YMD([NSDate dateWithTimeIntervalSinceNow:0.0f]) forKey:@"UPDATE_DATE"];
		 }];
	[storeObj release];
}


@end
