//
//  FSForChannelSettingFocusTopDAO.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-9-20.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSForChannelSettingFocusTopDAO.h"
#import "FSFocusTopObject.h"

#define FSFOUCS_URL @"http://mobile.app.people.com.cn:81/news2/news.php?act=focuspicture&rt=xml"
#define FSFOCUS_LAST_UPDATE_DESC @"FSFOCUS_NEWS_LIST"

@implementation FSForChannelSettingFocusTopDAO

- (id)init {
	self = [super init];
	if (self) {
        _group = @"channel";
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
    return @"FSFocusTopObject";
}

-(NSString *)readDataURLStringFromRemoteHostWithGETDataKind:(GETDataKind)getDataKind{
    return FSFOUCS_URL;
}

-(NSString *)lastUpdateTimestampPredicateValue{
    return FSFOCUS_LAST_UPDATE_DESC;
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
	[self addSortDescription:descriptions withSortFieldName:@"newsid" withAscending:YES];
}


- (void)baseXMLParserFinishXMLObjectNode:(FSBaseXMLParserObject *)sender withXMLResultObject:(id)resultObject { 
    
	FSStoreInCoreDataObject *storeObj = [[FSStoreInCoreDataObject alloc] initWithResultObject:resultObject withContext:self.managedObjectContext withDelegate:self];
	[storeObj startStoreBlockEntityName:^(NSString *memberName) {
		if (memberName == nil) {
			return @"FSFocusTopObject";
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
                     
                     if ([key isEqualToString:@"browserCount"]) {
                         NSNumber *tempNumber = [[NSNumber alloc] initWithInt:[tempValue intValue]];
						 [currentObject setValue:tempNumber forKey:key];
						 [tempNumber release];
                     }else if ([key isEqualToString:@"timestamp"]) {
						 NSNumber *tempNumber = [[NSNumber alloc] initWithInt:[tempValue doubleValue]];
						 [currentObject setValue:tempNumber forKey:key];
						 [tempNumber release];
					 }else{
                        [currentObject setValue:tempValue forKey:key]; 
                     }
                     [currentObject setValue:_group forKey:@"group"];
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
        NSMutableArray *array = [[NSMutableArray alloc] init]; 
        for (FSFocusTopObject *o in tempResultSet) {
            if ([o.group isEqualToString:_group]) {
                [array addObject:o];
            }
        }
		self.objectList = (NSArray *)array;
		self.isRecordListTail = [self.objectList count] < [self.fetchRequest fetchLimit];
		[tempResultSet release];
        [array release];
	}
}


-(void)operateOldBufferData{
    if (self.currentGetDataKind == GETDataKind_Refresh) {
		NSArray *resultSets = self.objectList;
		if ([resultSets count] > 0) {
            #ifdef MYDEBUG
            			NSLog(@"resultSets:%@", resultSets);
            #endif
            			for (FSFocusTopObject *entityObject in resultSets) {
            #ifdef MYDEBUG
            				NSLog(@"entityObject:%@", entityObject);
            #endif
                            
                            if ([_group isEqualToString:entityObject.group]) {
                                [self.managedObjectContext deleteObject:entityObject];
                            }
            			}
            			[self saveCoreDataContext];
		}
	}
}


@end
