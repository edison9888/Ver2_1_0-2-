//
//  FSCityListDAO.m
//  PeopleNewsReaderPhone
//
//  Created by Xu dandan on 12-10-16.
//
//

#import "FSCityListDAO.h"
#import "FSCityObject.h"


#define FSCITYLIST_URL @"http://mobile.app.people.com.cn:81/news2/news.php?act=citylist&rt=xml"
#define FSCITYLIST_LAST_UPDATE_DESC @"FSCITYLIST"


@implementation FSCityListDAO


- (id)init {
	self = [super init];
	if (self) {
        
	}
	return self;
}

-(void)dealloc{
    [super dealloc];
}

-(NSTimeInterval)bufferDataExpireTimeInterval{
    return 10;
}

-(NSString *)entityName{
    return @"FSCityObject";
}


-(NSString *)readDataURLStringFromRemoteHostWithGETDataKind:(GETDataKind)getDataKind{
    NSLog(@"FSCITYLIST_URL:%@",FSCITYLIST_URL);
    return FSCITYLIST_URL;
}

-(NSString *)lastUpdateTimestampPredicateValue{
    return FSCITYLIST_LAST_UPDATE_DESC;
}


-(NSString *)predicateStringWithQueryDataKind:(QueryDataKind)dataKind{
    if (dataKind == QueryDataKind_New) {
        return [NSString stringWithFormat:@"updata_date='%@'", dateToString_YMD([NSDate dateWithTimeIntervalSinceNow:0.0f])];
    }
    return nil;
}



- (void)assignmentValue:(id)currentObject withKey:(NSString *)key withValue:(id)value {
	if ([value isKindOfClass:[NSData class]]) {
		NSString *result = [[NSString alloc] initWithData:value encoding:NSUTF8StringEncoding];
		[currentObject setValue:result forKey:key];
		[result release];
	} else {
		[currentObject setValue:key forKey:key];
	}
}

- (void)initializeSortDescriptions:(NSMutableArray *)descriptions {
	[self addSortDescription:descriptions withSortFieldName:@"kind" withAscending:YES];
}


- (void)baseXMLParserFinishXMLObjectNode:(FSBaseXMLParserObject *)sender withXMLResultObject:(id)resultObject {
    NSLog(@"FSCityObject  FSCityObject:%@", resultObject);
	FSStoreInCoreDataObject *storeObj = [[FSStoreInCoreDataObject alloc] initWithResultObject:resultObject withContext:self.managedObjectContext withDelegate:self];
	[storeObj startStoreBlockEntityName:^(NSString *memberName) {
		if (memberName == nil) {
			return @"FSCityObject";
		} else {
			return (NSString *)nil;
		}
	}
				blockRelationShipObject:NULL
				blockDefineRelationShip:NULL
				 blockAssignEntityValue:^(id currentObject, NSString *key, id value) {
					 NSString *tempValue;
					 if ([value isKindOfClass:[NSData class]]) {
						 NSString *result = [[NSString alloc] initWithData:value encoding:NSUTF8StringEncoding];
						 tempValue = [result retain];
						 [result release];
					 } else {
						 tempValue = [value retain];
					 }
                     //NSLog(@"tempValue:%@ key:%@",tempValue,key);
                     if ([key isEqualToString:@"kind"]) {
                         [currentObject setValue:[tempValue substringToIndex:1] forKey:key];
                     }
                     else{
                         [currentObject setValue:tempValue forKey:key];
                     }
                    
                     //[currentObject setValue:_group forKey:@"group"];
					 [tempValue release];
				 }
		 blockAssignEntitySpecificValue: ^(id currentObject) {[currentObject setValue:dateToString_YMD([NSDate dateWithTimeIntervalSinceNow:0.0f]) forKey:@"updata_date"];}
     ];
    
	[storeObj release];
}


- (void)executeFetchRequest:(NSFetchRequest *)request {
	NSError *error = nil;
	NSArray *resultSet = [self.managedObjectContext executeFetchRequest:request error:&error];
	if (!error) {
		NSArray *tempResultSet = [[NSArray alloc] initWithArray:resultSet];
		self.objectList = (NSArray *)tempResultSet;
        NSLog(@"self.objectList:%d",[self.objectList count]);
		self.isRecordListTail = [self.objectList count] < [self.fetchRequest fetchLimit];
		[tempResultSet release];
	}
}


-(void)operateOldBufferData{
    if (self.currentGetDataKind == GETDataKind_Refresh) {
		NSArray *resultSets = self.objectList;
		if ([resultSets count] > 0) {
#ifdef MYDEBUG
            NSLog(@"resultSets:%@", resultSets);
#endif
            for (FSCityObject *entityObject in resultSets) {
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
