//
//  FS_GZF_CityListDAO.m
//  PeopleNewsReaderPhone
//
//  Created by Xu dandan on 12-10-19.
//
//

#import "FS_GZF_CityListDAO.h"
#import "FSCityObject.h"


#define FSCITYLIST_URL @"http://mobile.app.people.com.cn:81/news2/news.php?act=citylist&rt=xml"




/*
 <item>
 <kind><![CDATA[AKESU]]></kind>
 <cityId><![CDATA[843000]]></cityId>
 <cityName><![CDATA[阿克苏]]></cityName>
 <provinceId><![CDATA[186339]]></provinceId>
 <provinceName><![CDATA[辽宁]]></provinceName>
 </item>
 */

#define city_item @"item"
#define city_kind @"kind"
#define city_cityId @"cityId"
#define city_cityName @"cityName"
#define city_provinceId @"provinceId"
#define city_provinceName @"provinceName"

@implementation FS_GZF_CityListDAO


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
    return 60*60*24*2;
}

-(NSString *)entityName{
    return @"FSCityObject";
}


-(NSString *)readDataURLStringFromRemoteHostWithGETDataKind:(GET_DataKind)getDataKind{
    NSLog(@"FSCITYLIST_URL:%@",FSCITYLIST_URL);
    return FSCITYLIST_URL;
}



-(NSString *)predicateStringWithQueryDataKind:(Query_DataKind)dataKind{
    
    return @"bufferFlag!='3'";

}



- (void)initializeSortDescriptions:(NSMutableArray *)descriptions {
	[self addSortDescription:descriptions withSortFieldName:city_kind withAscending:YES];
}

#pragma mark -
#pragma mark NSCMLParserDelegate


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    _currentElementName = elementName;
	if ([_currentElementName isEqualToString:city_item]) {
        _obj = (FSCityObject *)[self insertNewObjectTomanagedObjectContext];
        _obj.bufferFlag = @"1";
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:city_item]) {
        
        //[_objectList addObject:_obj];
        //[_obj release];
        //_obj = nil;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	//NSLog(@"foundCharacters:%@",string);
   
    /*
    NSString *strUnion = nil;
	if ([self.currentElementName isEqualToString:NEWS_COMMENT_CREATE_TIME]) {
		strUnion = [CommonFuncs strCat:_obj.create_time TwoStr:[CommonFuncs trimString:string]];
		_obj.create_time = strUnion;
	}else if([self.currentElementName isEqualToString:NEWS_COMMENT_CREATE_TIMEINSECONDS]){
        strUnion = [CommonFuncs strCat:_obj.time_inSeconds TwoStr:[CommonFuncs trimString:string]];
		_obj.time_inSeconds = strUnion;
    }
	[strUnion release];
     */
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock {
	
    if ([_currentElementName isEqualToString:city_kind]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		NSString *temp = trimString(content);
        _obj.kind = temp;
		[content release];
	} else if ([_currentElementName isEqualToString:city_cityId]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.cityId = trimString(content);
		[content release];
	}
    else if ([_currentElementName isEqualToString:city_cityName]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.cityName = trimString(content);
		[content release];
        //NSLog(@"city_cityName:%@",_obj.cityName);
	}
    else if ([_currentElementName isEqualToString:city_provinceId]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.provinceId = trimString(content);
		[content release];
	}
    else if ([_currentElementName isEqualToString:city_provinceName]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.provinceName = trimString(content);
		[content release];
	}
}



- (void)executeFetchRequest:(NSFetchRequest *)request {
	NSError *error = nil;
	NSArray *resultSet = [self.managedObjectContext executeFetchRequest:request error:&error];
	if (!error) {
        
		if ([resultSet count]>0) {
            //NSLog(@"[resultSet count]:%d",[resultSet count]);
            self.objectList = (NSMutableArray *)resultSet;
            self.isRecordListTail = [self.objectList count] < [self.fetchRequest fetchLimit];
            [self setBufferFlag];
        }
	}
}

-(void)setBufferFlag{
    
    NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getAllObjectsSortByKey:[self entityName] key:city_kind ascending:YES];
    
    
    if (self.currentGetDataKind == GET_DataKind_Next){
        for (FSCityObject *o in array) {
            if ([o.bufferFlag isEqualToString:@"1"]) {
                o.bufferFlag = @"2";
            }
        }
        [self saveCoreDataContext];
        return;
    }
    
    for (FSCityObject *o in array) {
        if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"2"]) {
            ;//o.bufferFlag = @"3";
        }else if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"1"]){
            o.bufferFlag = @"2";
        }
    }
    
}


-(void)setBufferFlag3{
    NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getAllObjectsSortByKey:[self entityName] key:city_kind ascending:YES];
    
    for (FSCityObject *o in array) {
        if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"2"]) {
            o.bufferFlag = @"3";
        }
    }
}


-(void)operateOldBufferData{
    if (self.currentGetDataKind == GET_DataKind_Refresh) {
		
        if (_isRefreshToDeleteOldData == YES) {
           NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getAllObjectsSortByKey:[self entityName] key:city_kind ascending:YES];
            for (FSCityObject *o in array) {
                if ([o.bufferFlag isEqualToString:@"3"]) {
                    [self.managedObjectContext deleteObject:o];
                    
                }
            }
            [self saveCoreDataContext];
            
        }
	}
}



//- (void)executeFetchRequest:(NSFetchRequest *)request {
//	NSError *error = nil;
//	NSArray *resultSet = [self.managedObjectContext executeFetchRequest:request error:&error];
//	if (!error) {
//		NSMutableArray *tempResultSet = [[NSMutableArray alloc] initWithArray:resultSet];
//		self.objectList = (NSMutableArray *)tempResultSet;
//        NSLog(@"self.objectList:%d",[self.objectList count]);
//		self.isRecordListTail = NO;
//		[tempResultSet release];
//	}
//}
//
//
//-(void)operateOldBufferData{
//    if (self.currentGetDataKind == GET_DataKind_Refresh || self.currentGetDataKind == GET_DataKind_Unlimited) {
//		NSArray *resultSets = self.objectList;
//		if ([resultSets count] > 0) {
//#ifdef MYDEBUG
//            NSLog(@"resultSets:11111 %d",[resultSets count]);
//#endif
//            //NSInteger i = 0;
//            for (FSCityObject *entityObject in resultSets) {
//#ifdef MYDEBUG
//                //NSLog(@"entityObject:%@", entityObject);
//#endif
//                //NSLog(@"%d",i);
//                //i++;
//                if (entityObject!=nil) {
//                    if (![entityObject isDeleted]) {
//                        [self.managedObjectContext deleteObject:entityObject];
//                        
//                    }
//                }
//            
//            }
//            //[_objectList removeAllObjects];
//            //NSLog(@"111111");
//            [self saveCoreDataContext];
//		}
//	}
//}


@end
