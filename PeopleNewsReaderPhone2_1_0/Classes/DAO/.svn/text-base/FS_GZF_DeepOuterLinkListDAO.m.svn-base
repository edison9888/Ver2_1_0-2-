//
//  FS_GZF_DeepOuterLinkListDAO.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-12-28.
//
//

#import "FS_GZF_DeepOuterLinkListDAO.h"
#import "FSDeepOuterLinkListObject.h"

/*
<item>
<title><![CDATA[cesena]]></title>
<link><![CDATA[www.baidu.com]]></link>
<newsid><![CDATA[www.baidu.com]]></newsid>
<flag><![CDATA[2]]></flag>
</item>
 */

#define DEEPOUTERLINKLIST_URL @"http://mobile.app.people.com.cn:81/topic/topic.php?act=link_list&rt=xml&outerid=%@&type=list&iswp=0"

#define deep_item @"item"
#define deep_title @"title"
#define deep_link @"link"
#define deep_newsid @"newsid"
#define deep_flag @"flag"



@implementation FS_GZF_DeepOuterLinkListDAO

@synthesize deepid = _deepid;

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
    return 60*30;
}

-(NSString *)entityName{
    return @"FSDeepOuterLinkListObject";
}

- (NSString *)timestampFlag {
    return [NSString stringWithFormat:@"FSDeepOuterLinkListObject_%@",self.deepid];
}


-(NSString *)readDataURLStringFromRemoteHostWithGETDataKind:(GET_DataKind)getDataKind{
   
    NSString *url = [NSString stringWithFormat:DEEPOUTERLINKLIST_URL,self.deepid];
    
    return url;
}



-(NSString *)predicateStringWithQueryDataKind:(Query_DataKind)dataKind{
    
    return [NSString stringWithFormat:@"outerid='%@' AND bufferFlag!='3'", self.deepid];
}

#pragma mark -
#pragma mark NSCMLParserDelegate


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    _currentElementName = elementName;
	if ([_currentElementName isEqualToString:deep_item]) {
        _obj = (FSDeepOuterLinkListObject *)[self insertNewObjectTomanagedObjectContext];
        _obj.outerid = self.deepid;
        _obj.bufferFlag = @"1";
        
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:deep_item]) {
        
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
	
    if ([_currentElementName isEqualToString:deep_title]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.title = trimString(content);
		[content release];
	} else if ([_currentElementName isEqualToString:deep_link]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.link = trimString(content);
		[content release];
	}
    else if ([_currentElementName isEqualToString:deep_newsid]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.newsid = trimString(content);
		[content release];
        //NSLog(@"city_cityName:%@",_obj.cityName);
	}
    else if ([_currentElementName isEqualToString:deep_flag]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        NSString *temp = trimString(content);
        NSNumber *tempNumber = [[NSNumber alloc] initWithInt:[temp intValue]];
		_obj.flag = tempNumber;
		[content release];
        [tempNumber release];
	}
}



- (void)executeFetchRequest:(NSFetchRequest *)request {
	NSError *error = nil;
	NSArray *resultSet = [self.managedObjectContext executeFetchRequest:request error:&error];
	if (!error) {
        
		if ([resultSet count]>0) {
            //NSLog(@"[resultSet count]:%d",[resultSet count]);
            self.objectList = (NSMutableArray *)resultSet;
            [self setBufferFlag];
        }
	}
}

-(void)setBufferFlag{
    
    NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:[self entityName] key:@"outerid" value:self.deepid];
    
    for (FSDeepOuterLinkListObject *o in array) {
        if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"2"]) {
            ;//o.bufferFlag = @"3";
        }else if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"1"]){
            o.bufferFlag = @"2";
        }
    }
    [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext].managedObjectContext save:nil];
}


-(void)setBufferFlag3{
    NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:[self entityName] key:@"outerid" value:self.deepid];
    
    for (FSDeepOuterLinkListObject *o in array) {
        if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"2"]) {
            o.bufferFlag = @"3";
        }
    }
    [self saveCoreDataContext];
}



-(void)operateOldBufferData{
    if (self.currentGetDataKind == GET_DataKind_Refresh) {
		
        if (_isRefreshToDeleteOldData == YES) {
            NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:[self entityName] key:@"outerid" value:self.deepid];
            for (FSDeepOuterLinkListObject *o in array) {
                if ([o.bufferFlag isEqualToString:@"3"]) {
                    [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] deleteObjectByObject:o];
                    //[self.managedObjectContext deleteObject:o];
                    
                }
            }
            //[self saveCoreDataContext];
            
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
//            for (FSDeepOuterLinkListObject *entityObject in resultSets) {
//#ifdef MYDEBUG
//                //NSLog(@"entityObject:%@", entityObject);
//#endif
//                //NSLog(@"%d",i);
//                //i++;
//                if (entityObject!=nil) {
//                    if (![entityObject isDeleted] && [entityObject.outerid isEqualToString:self.deepid]) {
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
