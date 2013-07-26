//
//  FS_GZF_DeepPriorListDAO.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-12-28.
//
//

#import "FS_GZF_DeepPriorListDAO.h"
#import "FSTopicPriorObject.h"

#define FSDEEP_PRIOR_LIST_URL @"http://mobile.app.people.com.cn:81/topic/topic.php?act=history_list&rt=xml&deepid=%@&type=list&iswp=&lastdeepid=%@&count=%d"

/*
<item>
<title><![CDATA[水鬼]]></title>
<news_abstract><![CDATA[又到年底]]></news_abstract>
<timestamp><![CDATA[1356575487]]></timestamp>
<pubDate><![CDATA[]]></pubDate>
<pictureLogo><![CDATA[ ]]></pictureLogo>
<pictureLink><![CDATA[http://58.68.1075365755042.jpg]]></pictureLink>
<deepid><![CDATA[38]]></deepid>
</item>
 */

#define deep_item @"item"
#define deep_title @"title"
#define deep_news_abstract @"news_abstract"
#define deep_timestamp @"timestamp"
#define deep_pubDate @"pubDate"
#define deep_pictureLogo @"pictureLogo"
#define deep_pictureLink @"pictureLink"
#define deep_deepid @"deepid"


@implementation FS_GZF_DeepPriorListDAO


@synthesize deepid = _deepid;
@synthesize lastDeepid = _lastDeepid;


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
    return 60 *30;
}

-(NSString *)entityName{
    return @"FSTopicPriorObject";
}


- (NSString *)timestampFlag {
    return [NSString stringWithFormat:@"FSDeepOuterLinkListObject_%@",self.deepid];
}


-(NSString *)readDataURLStringFromRemoteHostWithGETDataKind:(GET_DataKind)getDataKind{
    
    if (getDataKind == GET_DataKind_Refresh) {
        NSString *url = [NSString stringWithFormat:FSDEEP_PRIOR_LIST_URL,self.deepid,@"",6];
        NSLog(@"url:%@",url);
        return url;
    }
    else if(getDataKind == GET_DataKind_Next){
        NSString *url = [NSString stringWithFormat:FSDEEP_PRIOR_LIST_URL,self.deepid,self.lastDeepid,6];
        NSLog(@"url:%@",url);
        return url;
    }
    return  nil;
}



-(NSString *)predicateStringWithQueryDataKind:(Query_DataKind)dataKind{
    
    return [NSString stringWithFormat:@"ownerdeepid='%@' AND bufferFlag!='3'", self.deepid];
}

#pragma mark -
#pragma mark NSCMLParserDelegate


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    _currentElementName = elementName;
	if ([_currentElementName isEqualToString:deep_item]) {
        _obj = (FSTopicPriorObject *)[self insertNewObjectTomanagedObjectContext];
        _obj.ownerdeepid = self.deepid;
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
	} else if ([_currentElementName isEqualToString:deep_news_abstract]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.news_abstract = trimString(content);
		[content release];
	}
    else if ([_currentElementName isEqualToString:deep_timestamp]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        NSString *temp = trimString(content);
        NSNumber *tempNumber = [[NSNumber alloc] initWithInt:[temp intValue]];
		_obj.timestamp = tempNumber;
		[content release];
        [tempNumber release];
	}
    else if ([_currentElementName isEqualToString:deep_pubDate]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        _obj.pubDate = trimString(content);
		[content release];
	}
    else if ([_currentElementName isEqualToString:deep_pictureLogo]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.pictureLogo = trimString(content);
		[content release];
	}
    else if ([_currentElementName isEqualToString:deep_pictureLink]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.pictureLink = trimString(content);
		[content release];
        //NSLog(@"city_cityName:%@",_obj.cityName);
	}
    else if ([_currentElementName isEqualToString:deep_deepid]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.deepid = trimString(content);
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
            self.isRecordListTail = NO;
            [self setBufferFlag];
        }
	}
}

-(void)setBufferFlag{
    
    NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:[self entityName] key:@"ownerdeepid" value:self.deepid];
    
    for (FSTopicPriorObject *o in array) {
        if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"2"]) {
            //o.bufferFlag = @"3";
        }else if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"1"]){
            o.bufferFlag = @"2";
        }
    }
    [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext].managedObjectContext save:nil];
}


-(void)setBufferFlag3{
    NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:[self entityName] key:@"ownerdeepid" value:self.deepid];
    
    for (FSTopicPriorObject *o in array) {
        if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"2"]) {
            o.bufferFlag = @"3";
        }
    }
    [self saveCoreDataContext];
}


-(void)operateOldBufferData{
    if (self.currentGetDataKind == GET_DataKind_Refresh) {
		
        if (_isRefreshToDeleteOldData == YES) {
            NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:[self entityName] key:@"ownerdeepid" value:self.deepid];
            for (FSTopicPriorObject *o in array) {
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
//            for (FSTopicPriorObject *entityObject in resultSets) {
//#ifdef MYDEBUG
//                //NSLog(@"entityObject:%@", entityObject);
//#endif
//                //NSLog(@"%d",i);
//                //i++;
//                if (entityObject!=nil) {
//                    if (![entityObject isDeleted] && [entityObject.deepid isEqualToString:self.deepid]) {
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
