//
//  FSChanelListDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-13.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSChanelListDAO.h"

#define CHANNEL_LIST_URL @"http://mobile.app.people.com.cn:81/news2/news.php?act=channellist&rt=xml"
#define CHANNEL_LASTUPDATE_DESC @"CHANNEL_OBJECT"

@implementation FSChanelListDAO

- (id)init {
	self = [super init];
	if (self) {

	}
	return self;
}

- (NSTimeInterval)bufferDataExpireTimeInterval {
	return 60 * 60 * 24;
}

- (void)dealloc {
	[super dealloc];
}

- (NSString *)lastUpdateTimestampPredicateValue {
	return CHANNEL_LASTUPDATE_DESC;
}

- (NSString *)entityName {
	return @"FSChannelObject";
}

- (NSString *)readDataURLStringFromRemoteHostWithGETDataKind:(GETDataKind)getDataKind {
	return CHANNEL_LIST_URL;
}
/*

-(NSString *)predicateStringWithQueryDataKind:(QueryDataKind)dataKind{
    if (dataKind == QueryDataKind_New) {
        return [NSString stringWithFormat:@"updata_date='%@'", dateToString_YMD([NSDate dateWithTimeIntervalSinceNow:0.0f])];
    }
    return nil;
}
 */

- (void)initializeSortDescriptions:(NSMutableArray *)descriptions {
	[self addSortDescription:descriptions withSortFieldName:@"channelid" withAscending:YES];
}

- (void)baseXMLParserFinishXMLObjectNode:(FSBaseXMLParserObject *)sender withXMLResultObject:(id)resultObject { 
	FSStoreInCoreDataObject *storeObj = [[FSStoreInCoreDataObject alloc] initWithResultObject:resultObject withContext:self.managedObjectContext withDelegate:self];
	[storeObj startStoreBlockEntityName:^(NSString *memberName) {
		if (memberName == nil) {
			return @"FSChannelObject";
		} else {
			return (NSString *)nil;
		}
	}
				blockRelationShipObject:NULL 
				blockDefineRelationShip:NULL 
				 blockAssignEntityValue:^(id currentObject, NSString *key, id value) {
					 if ([value isKindOfClass:[NSData class]]) {
						 NSString *result = [[NSString alloc] initWithData:value encoding:NSUTF8StringEncoding];
						 [currentObject setValue:result forKey:key];
						 [result release];
					 } else {
						 [currentObject setValue:key forKey:key];
					 }	
				 } 
		 blockAssignEntitySpecificValue: NULL];
	[storeObj release];
}


-(void)operateOldBufferData{
    if (self.currentGetDataKind == GETDataKind_Refresh) {
		NSArray *resultSets = self.objectList;
		if ([resultSets count] > 0) {
#ifdef MYDEBUG
            NSLog(@"resultSets:%@", resultSets);
#endif
            for (id entityObject in resultSets) {
#ifdef MYDEBUG
                NSLog(@"entityObject:%@", entityObject);
#endif
                [self.managedObjectContext deleteObject:entityObject];
            }
            [self saveCoreDataContext];
		}
	}
}

@end
