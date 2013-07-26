//
//  FS_GZF_DeepListDAO.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-12-27.
//
//

#import "FS_GZF_DeepListDAO.h"
#import "FSTopicObject.h"

/*
<item>
<title><![CDATA[水鬼]]></title>
<news_abstract><![CDATA[又到年底了]]></news_abstract>
<timestamp><![CDATA[1356575487]]></timestamp>
<pubDate><![CDATA[2012-12-21 15:33:44]]></pubDate>
<pictureLogo><![CDATA[ ]]></pictureLogo>
<pictureLink><![CDATA[http://58.68.130.168/365755042.jpg]]></pictureLink>
<deepid><![CDATA[38]]></deepid>
 <sort><![CDATA[]]></sort>
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
#define deep_sort @"sort"




#define FSDEEPLIST_URL @"http://mobile.app.people.com.cn:81/topic/topic.php?act=info_list&rt=xml&type=list&iswp=0"


@implementation FS_GZF_DeepListDAO


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
    return @"FSTopicObject";
}


-(NSString *)readDataURLStringFromRemoteHostWithGETDataKind:(GET_DataKind)getDataKind{
    NSLog(@"FSDEEPLIST_URL:%@",FSDEEPLIST_URL);
    return FSDEEPLIST_URL;
}

-(NSString *)timestampFlag{
    return @"FSTopicObject_flag";
}

-(NSString *)predicateStringWithQueryDataKind:(Query_DataKind)dataKind{
    
    return @"bufferFlag!='3'";
    
    if (dataKind == Query_DataKind_New) {
        return [NSString stringWithFormat:@"updata_date='%@'", dateToString_YMD([NSDate dateWithTimeIntervalSinceNow:0.0f])];
    }
    return nil;
}



- (void)initializeSortDescriptions:(NSMutableArray *)descriptions {
	[self addSortDescription:descriptions withSortFieldName:@"sort" withAscending:YES];
}

-(NSInteger)fetchLimitWithGETDDataKind:(GET_DataKind)getDataKind{
    return 0;
}

#pragma mark -
#pragma mark NSCMLParserDelegate


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    _currentElementName = elementName;
	if ([_currentElementName isEqualToString:deep_item]) {
        _obj = (FSTopicObject *)[self insertNewObjectTomanagedObjectContext];
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
	}
    else if ([_currentElementName isEqualToString:deep_deepid]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.deepid = trimString(content);
		[content release];
	}
    else if ([_currentElementName isEqualToString:deep_sort]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        NSString *temp = trimString(content);
        NSNumber *tempNumber = [[NSNumber alloc] initWithInt:[temp intValue]];
		_obj.sort = tempNumber;
		[content release];
        [tempNumber release];
	}
}


- (void)executeFetchRequest:(NSFetchRequest *)request {
	NSError *error = nil;
    
	NSArray *resultSet = [self.managedObjectContext executeFetchRequest:request error:&error];
	if (!error) {
        
		if ([resultSet count]>0) {
            NSMutableArray *idArray = [[NSMutableArray alloc] init];
            NSMutableArray *TopicObjectArray = [[NSMutableArray alloc] init];
            NSInteger mark = 0;
            for (FSTopicObject *o in resultSet) {
                mark = 0;
                for (NSString *deepid in idArray) {
                    if ([deepid isEqualToString:o.deepid]) {
                        mark = 1;
                        break;
                    }
                }
                if (mark == 0) {
                    [TopicObjectArray addObject:o];
                    [idArray addObject:o.deepid];
                }
            }
            //NSLog(@"[resultSet count]:%d",[resultSet count]);
            self.objectList = TopicObjectArray;//(NSMutableArray *)resultSet;
            self.isRecordListTail = [self.objectList count] < [self.fetchRequest fetchLimit];
            [self setBufferFlag];
            [idArray release];
            [TopicObjectArray release];
        }
	}
}

-(void)setBufferFlag{
    
    NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getAllObjectsSortByKey:[self entityName] key:@"timestamp" ascending:YES];
    
    if (self.currentGetDataKind == GET_DataKind_Next){
        for (FSTopicObject *o in array) {
            if ([o.bufferFlag isEqualToString:@"1"]) {
                o.bufferFlag = @"2";
            }
        }
        [self saveCoreDataContext];
        return;
    }
    for (FSTopicObject *o in array) {
        if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"2"]) {
            ;//o.bufferFlag = @"3";
        }else if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"1"]){
            o.bufferFlag = @"2";
        }
    }
    [self saveCoreDataContext];
}

-(void)setBufferFlag3{
    NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getAllObjectsSortByKey:[self entityName] key:@"timestamp" ascending:YES];

    for (FSTopicObject *o in array) {
        if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"2"]) {
            o.bufferFlag = @"3";
        }
    }
    [self saveCoreDataContext];
}


-(void)operateOldBufferData{
    if (self.currentGetDataKind == GET_DataKind_Refresh) {
		
        if (_isRefreshToDeleteOldData == YES) {
             NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getAllObjectsSortByKey:[self entityName] key:@"timestamp" ascending:YES];
            for (FSTopicObject *o in array) {
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
//            for (FSTopicObject *entityObject in resultSets) {
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
