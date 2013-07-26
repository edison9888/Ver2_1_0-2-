//
//  FS_GZF_ForOneDayNewsListDAO.m
//  PeopleNewsReaderPhone
//
//  Created by Xu dandan on 12-10-23.
//
//

#import "FS_GZF_ForOneDayNewsListDAO.h"
#import "FSOneDayNewsObject.h"
#import "FSBaseDB.h"
#import "FSChannelSelectedObject.h"
#import "FSVisitChannelObject.h"
#import "FSChannelObject.h"
#import "GlobalConfig.h"
// http://mobile.app.people.com.cn:81/news2/news.php?act=dailylist&channelid=1_6,1_11,1_8,1_20&rt=xml&count=1&iswp=1&channelpv=1,100,100,100

#define FSONEDAY_NEWS_URL @"http://mobile.app.people.com.cn:81/news2/news.php?act=dailylist&channelid=%@&rt=xml&channelpv=%@&count=%@&lastid=%@"


#define FSONEDAY_NEWS_PAGECOUNT 20



/*
<item>
<newsid><![CDATA[1700254]]></newsid>
 <realtimeid>201</realtimeid>
<title><![CDATA[1500中国游客赴日游涉嫌炒作]]></title>
 <source><![CDATA[新闻来源]]></source>
<abstract><![CDATA[1500中国游客赴日游涉嫌炒作]]></abstract>
<browserCount><![CDATA[0]]></browserCount>
<channelid><![CDATA[1_8]]></channelid>
<commentCount><![CDATA[0]]></commentCount>
<timestamp><![CDATA[1350974210]]></timestamp>
<news_date><![CDATA[2012-10-23 14:36:50]]></news_date>
<kind><![CDATA[1]]></kind>
 <order><![CDATA[0]]> </order>
<pictureItem>
<picture><![CDATA[]]></picture>
<picdesc><![CDATA[]]></picdesc>
</pictureItem>
<link><![CDATA[]]></link>
</item>

*/
#define Onedaynews_item @"item"
#define Onedaynews_newsid @"newsid"
#define Onedaynews_realtimeid @"realtimeid"
#define Onedaynews_title @"title"
#define Onedaynews_abstract @"abstract"
#define Onedaynews_browserCount @"browserCount"
#define Onedaynews_channelid @"channelid"
#define Onedaynews_commentCount @"commentCount"
#define Onedaynews_timestamp @"timestamp"
#define Onedaynews_news_date @"news_date"
#define Onedaynews_kind @"kind"
#define Onedaynews_pictureItem @"pictureItem"
#define Onedaynews_picture @"picture"
#define Onedaynews_picdesc @"picdesc"
#define Onedaynews_link @"link"
#define Onedaynews_order @"order"
#define Onedaynews_source @"source"



@implementation FS_GZF_ForOneDayNewsListDAO

@synthesize lastid = _lastid;
@synthesize channelList = _channelList;
@synthesize visitNOList = _visitNOList;
@synthesize SetChannalIcon = _SetChannalIcon;


- (id)init {
	self = [super init];
	if (self) {
		 _count = 1;
        self.getNextOnline = NO;
        self.SetChannalIcon = NO;
        self.channelList = @"";
        self.visitNOList = @"";
	}
   
	return self;
}

- (void)dealloc {
	
	[super dealloc];
}

- (NSString *)readDataURLStringFromRemoteHostWithGETDataKind:(GET_DataKind)getDataKind {

    
    //[self selectChannelListString];
    
	if (getDataKind == GET_DataKind_Refresh) {
        _count = 1;
		return [NSString stringWithFormat:FSONEDAY_NEWS_URL, self.channelList,self.visitNOList,@"20",@""];
	} else {
        _count =_count +1;
        NSLog(@"self.lastid:%@",self.lastid);
        NSString *strURL = [NSString stringWithFormat:FSONEDAY_NEWS_URL,  self.channelList,self.visitNOList,@"20",self.lastid];
        return strURL;
	}
}

-(NSString *)selectChannelListString{
    
    self.channelList = @"";
    self.visitNOList = @"";
    
//    NSArray *arraySHIKE = [[FSBaseDB sharedFSBaseDB] getObjectsByKeyWithName:@"FSChannelObject" key:@"type" value:@"realtime"];
//    
//    for (FSChannelObject *o in arraySHIKE) {
//        
//        NSArray *arrayV = [[FSBaseDB sharedFSBaseDB] getObjectsByKeyWithName:@"FSVisitChannelObject" key:@"channelid" value:o.channelid];
//        if ([arrayV count] > 0) {
//            FSVisitChannelObject *vo = [arrayV objectAtIndex:0];
//            
//            NSInteger count1 = 0;
//            NSInteger count2 = 0;
//            NSInteger count = 0;
//            
//            count1 = [vo.date9 integerValue] + [vo.date8 integerValue] + [vo.date7 integerValue];
//            count2 = [vo.date6 integerValue] + [vo.date5 integerValue] + [vo.date4 integerValue];
//            
//            count = count1 + count2*0.5;
//            
//            if ([self.channelList length] == 0) {
//                self.channelList = o.channelid;
//            }
//            else{
//                self.channelList = [NSString stringWithFormat:@"%@,%@",self.channelList,o.channelid];
//            }
//            
//            
//            if ([self.visitNOList length] == 0) {
//                self.visitNOList = [NSString stringWithFormat:@"%d",count];;
//            }
//            else{
//                self.visitNOList = [NSString stringWithFormat:@"%@,%d",self.visitNOList,count];
//            }
//        }
//    }
    
    
    NSArray *array = [[FSBaseDB sharedFSBaseDB] getAllObjectsSortByKey:@"FSChannelSelectedObject" key:@"channelid" ascending:YES];
    
    for (FSChannelSelectedObject *o in array) {
        
        NSArray *arrayV = [[FSBaseDB sharedFSBaseDB] getObjectsByKeyWithName:@"FSVisitChannelObject" key:@"channelid" value:o.channelid];
        if ([arrayV count] == 0) {
            if ([self.channelList length] == 0) {
                self.channelList = o.channelid;
            }
            else{
                self.channelList = [NSString stringWithFormat:@"%@,%@",self.channelList,o.channelid];
            }
            
            
            if ([self.visitNOList length] == 0) {
                self.visitNOList = @"0";
            }
            else{
                self.visitNOList = [NSString stringWithFormat:@"%@,%d",self.visitNOList,0];
            }
        }
        else{
            FSVisitChannelObject *vo = [arrayV objectAtIndex:0];
            
            NSInteger count1 = 0;
            NSInteger count2 = 0;
            NSInteger count = 0;
            
            count1 = [vo.date9 integerValue] + [vo.date8 integerValue] + [vo.date7 integerValue];
            count2 = [vo.date6 integerValue] + [vo.date5 integerValue] + [vo.date4 integerValue];
            
            count = count1 + count2*0.5;
            
            if ([self.channelList length] == 0) {
                self.channelList = o.channelid;
            }
            else{
                self.channelList = [NSString stringWithFormat:@"%@,%@",self.channelList,o.channelid];
            }
            
            
            if ([self.visitNOList length] == 0) {
                self.visitNOList = [NSString stringWithFormat:@"%d",count];;
            }
            else{
                self.visitNOList = [NSString stringWithFormat:@"%@,%d",self.visitNOList,count];
            }
        }
    }
    
    return @"";
}


- (NSTimeInterval)bufferDataExpireTimeInterval {
	return 60*8;
}

//查询数据
- (NSString *)predicateStringWithQueryDataKind:(Query_DataKind)dataKind {
    
    return [NSString stringWithFormat:@"group='%@' AND bufferFlag!='3'", SHIKE_NEWS_LIST_KIND];
}

- (NSInteger)fetchLimitWithGETDDataKind:(GET_DataKind)getDataKind {
	if (getDataKind == GET_DataKind_Refresh) {
		return FSONEDAY_NEWS_PAGECOUNT;
	} else {
		return [self.objectList count] + FSONEDAY_NEWS_PAGECOUNT;
	}
}


- (NSString *)entityName {
	return @"FSOneDayNewsObject";
}

- (NSString *)timestampFlag {
    return SHIKE_NEWS_LIST_KIND;
}


-(NSString *)getGroupName{
    return SHIKE_NEWS_LIST_KIND;
}

- (void)initializeSortDescriptions:(NSMutableArray *)descriptions {
	[self addSortDescription:descriptions withSortFieldName:@"timestamp" withAscending:NO];
}



#pragma mark -
#pragma mark NSCMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    //NSLog(@"didStartElement:%@",elementName);
    _currentElementName = elementName;
	if ([_currentElementName isEqualToString:Onedaynews_item]) {
        _obj = (FSOneDayNewsObject *)[self insertNewObjectTomanagedObjectContext];
        _obj.group = [self getGroupName];
        _obj.bufferFlag = @"1";
        
    }
     
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
	if ([elementName isEqualToString:Onedaynews_item]) {
        //[self.managedObjectContext save:nil];
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
    
    if ([_currentElementName isEqualToString:Onedaynews_newsid]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        //NSLog(@"content:%@",content);
        _obj.newsid = trimString(content);
		[content release];
	} else if ([_currentElementName isEqualToString:Onedaynews_title]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.title = trimString(content);
		[content release];
	}
    else if ([_currentElementName isEqualToString:Onedaynews_abstract]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.news_abstract = trimString(content);
		[content release];
	}
    else if ([_currentElementName isEqualToString:Onedaynews_browserCount]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        NSString *temp = trimString(content);
        NSNumber *tempNumber = [[NSNumber alloc] initWithInt:[temp intValue]];
		_obj.browserCount = tempNumber;
		[content release];
        [tempNumber release];
	}
    else if ([_currentElementName isEqualToString:Onedaynews_channelid]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.channelid = trimString(content);
		[content release];
        _obj.channalIcon = @"";
//        NSArray *array = [[FSBaseDB sharedFSBaseDB] getObjectsByKeyWithName:@"FSChannelObject" key:@"channelid" value:_obj.channelid];
//        if ([array count]>0) {
//            FSChannelObject *channel = [array objectAtIndex:0];
//            //NSLog(@"channel.channel_highlight:%@",channel.channel_highlight);
//            _obj.channalIcon = channel.channel_highlight;
//        }
        
	}
    else if ([_currentElementName isEqualToString:Onedaynews_commentCount]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        NSString *temp = trimString(content);
        NSNumber *tempNumber = [[NSNumber alloc] initWithInt:[temp intValue]];
		_obj.commentCount = tempNumber;
		[content release];
        [tempNumber release];
	}
    else if ([_currentElementName isEqualToString:Onedaynews_timestamp]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        NSString *temp = trimString(content);
        NSNumber *tempNumber = [[NSNumber alloc] initWithInt:[temp intValue]];
		_obj.timestamp = tempNumber;
		[content release];
        [tempNumber release];
	}
    else if ([_currentElementName isEqualToString:Onedaynews_news_date]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.UPDATE_DATE = trimString(content);
		[content release];
	}
    else if ([_currentElementName isEqualToString:Onedaynews_kind]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.kind = trimString(content);
		[content release];
	}
    else if ([_currentElementName isEqualToString:Onedaynews_picture]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.picture = trimString(content);
		[content release];
	}
    else if ([_currentElementName isEqualToString:Onedaynews_picdesc]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.picdesc = trimString(content);
		[content release];
	}
    else if ([_currentElementName isEqualToString:Onedaynews_link]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.link = trimString(content);
		[content release];
	}
    else if ([_currentElementName isEqualToString:Onedaynews_order]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        NSString *temp = trimString(content);
        NSInteger orderindex = [temp intValue];
        orderindex = orderindex + (_count-1)*FSONEDAY_NEWS_PAGECOUNT;
        NSNumber *tempNumber = [[NSNumber alloc] initWithInt:orderindex];
		_obj.order = tempNumber;
		[content release];
        [tempNumber release];
	}
    else if ([_currentElementName isEqualToString:Onedaynews_source]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.source = trimString(content);
		[content release];
	}
    else if ([_currentElementName isEqualToString:Onedaynews_realtimeid]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.realtimeid = trimString(content);
		[content release];
	}
    
     
}


- (void)executeFetchRequest:(NSFetchRequest *)request {
	NSError *error = nil;
	NSArray *resultSet = [self.managedObjectContext executeFetchRequest:request error:&error];
	if (!error) {
        
		if ([resultSet count]>0) {
            
            for (FSOneDayNewsObject *o in resultSet) {
                if ([o.channalIcon length]==0 && self.SetChannalIcon) {
                    NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:@"FSChannelObject" key:@"channelid" value:o.channelid];
                    if ([array count]>0) {
                        FSChannelObject *channel = [array objectAtIndex:0];
                        o.channalIcon = channel.channel_highlight;
                    }
                }
                //确定最小的lastid
                if ([o.realtimeid integerValue] <  [self.lastid integerValue] || [self.lastid integerValue] == 0) {
                    self.lastid = o.realtimeid;//by zhiliang
                }
            }
            
            self.objectList = (NSMutableArray *)resultSet;
            self.isRecordListTail = [self.objectList count] < [self.fetchRequest fetchLimit];
            [self setBufferFlag];
        }
        
	}
}

-(void)setBufferFlag{
    
     NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:[self entityName] key:@"group" value:[self getGroupName]];
    
    
    if (self.currentGetDataKind == GET_DataKind_Next){
        
        for (FSOneDayNewsObject *o in array) {
            if ([o.bufferFlag isEqualToString:@"1"]) {
                o.bufferFlag = @"2";
            }
        }
        //NSLog(@"MOCSave:SetBufferFlag:%d",[NSThread isMainThread]);
        [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext].managedObjectContext save:nil];
        return;
    }
   
    BOOL mark = NO;
    for (FSOneDayNewsObject *o in array) {
         mark = NO;
        for (FSOneDayNewsObject *oo in self.objectList) {
            if ([oo.newsid isEqualToString:o.newsid]) {
                mark = YES;
                break;
            }
        }
        
        if (!mark && self.getNextOnline == YES) {
            o.bufferFlag = @"3";
        }
        
        if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"2"]) {
            ;//o.bufferFlag = @"3";
        }else if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"1"]){
            o.bufferFlag = @"2";
        }
    }
    NSLog(@"MOCSave:SetBufferFlag2:%d",[NSThread isMainThread]);
    [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext].managedObjectContext save:nil];
}
// by zhiliang  on pass self.moc to a different thread -main thread
-(void)setBufferFlag3{
    NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:[self entityName] key:@"group" value:[self getGroupName]];
    //NSManagedObjectContext* appContext = [[GlobalConfig shareConfig] getApplicationManagedObjectContext];
    //NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:appContext] getObjectsByKeyWithName:[self entityName] key:@"group" value:[self getGroupName]];
    for (FSOneDayNewsObject *o in array) {

        if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"2"]) {
            o.bufferFlag = @"3";
        }
    }
    //NSLog(@"MOCSave:SetBufferFlag3:%d",[NSThread isMainThread]);
    [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext].managedObjectContext save:nil];
}

-(void)operateOldBufferDataDelate{
    [self performSelector:@selector(operateOldBufferData) withObject:nil afterDelay:1.0];
}


-(void)operateOldBufferData{
    if (self.currentGetDataKind == GET_DataKind_Refresh) {
		
        NSMutableArray *bufferFlag3 = [[NSMutableArray alloc] init];
        
        if (_isRefreshToDeleteOldData == YES) {
            NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:[self entityName] key:@"group" value:[self getGroupName]];
            
            for (FSOneDayNewsObject *o in array) {
                if ([o.bufferFlag isEqualToString:@"3"]) {
                    
                    [bufferFlag3 addObject:o];
                    //[[FSBaseDB sharedFSBaseDB] deleteObjectByObject:o];
                    //[[FSBaseDB sharedFSBaseDB].managedObjectContext deleteObject:o];
                    
                }
            }
            [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] deleteObjectByObjectS:bufferFlag3];
            
        }
        [bufferFlag3 release];
	}
}


//- (void)executeFetchRequest:(NSFetchRequest *)request {
//	NSError *error = nil;
//	NSArray *resultSet = [self.managedObjectContext executeFetchRequest:request error:&error];
//	if (!error) {
//		NSMutableArray *tempResultSet = [[NSMutableArray alloc] initWithArray:resultSet];
//		self.objectList = (NSMutableArray *)tempResultSet;
//        NSLog(@"executeFetchRequest objectList:%d",[self.objectList count]);
//		self.isRecordListTail = [self.objectList count] < [self.fetchRequest fetchLimit];
//		[tempResultSet release];
//	}
//}
//
//
//-(void)operateOldBufferData{
//    if (self.currentGetDataKind == GET_DataKind_Refresh) {
//		NSMutableArray *resultSets = self.objectList;
//       
//		if ([resultSets count] > 0) {
//#ifdef MYDEBUG
//           NSLog(@"resultSets:%d", [resultSets count]);
//#endif
//            for (FSOneDayNewsObject *entityObject in resultSets) {
//#ifdef MYDEBUG
//                //NSLog(@"one entityObject");
//#endif
//                
//                if (entityObject!=nil) {
//                    if (![entityObject isDeleted]) {
//                        if ([entityObject.group isEqualToString:SHIKE_NEWS_LIST_KIND]) {
//                            [self.managedObjectContext deleteObject:entityObject];
//                        }
//                        
//                    }
//                }
//                
//            }
//            //[_objectList removeAllObjects];
//            [self saveCoreDataContext];
//		}
//	}
//}


@end
