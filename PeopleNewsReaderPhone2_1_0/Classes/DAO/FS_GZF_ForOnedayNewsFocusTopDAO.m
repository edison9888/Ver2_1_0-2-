//
//  FS_GZF_ForOnedayNewsFocusTopDAO.m
//  PeopleNewsReaderPhone
//
//  Created by Xu dandan on 12-10-23.
//
//

#import "FS_GZF_ForOnedayNewsFocusTopDAO.h"
#import "FSFocusTopObject.h"


#define FSFOUCS_URL @"http://mobile.app.people.com.cn:81/news2/news.php?act=focuspicture&rt=xml"

#define FSFOUCS_WITH_TYPE_URL @"http://mobile.app.people.com.cn:81/news2/news.php?act=focuspicture&type=%@&channelid=%@&count=%d&rt=xml"



/*
<item>
<newsid><![CDATA[1698722]]></newsid>
<title><![CDATA[利比亚战争结束一周年：梦想现实]]></title>
<browserCount><![CDATA[0]]></browserCount>
<type><![CDATA[]]></type>
<channelid><![CDATA[1_7]]></channelid>
<timestamp><![CDATA[1350949570]]></timestamp>
<picture><![CDATA[http://58.68......]]></picture>
<link><![CDATA[]]></link>
<flag><![CDATA[0]]></flag>
 <order><![CDATA[0]]></order>
</item>
*/

#define Focus_item @"item"
#define Focus_newsid @"newsid"
#define Focus_title @"title"
#define Focus_browserCount @"browserCount"
#define Focus_type @"type"
#define Focus_channelid @"channelid"
#define Focus_timestamp @"timestamp"
#define Focus_picture @"picture"
#define Focus_link @"link"
#define Focus_flag @"flag"
#define Focus_order @"order"

@implementation FS_GZF_ForOnedayNewsFocusTopDAO

@synthesize type = _type;
@synthesize channelid = _channelid;
@synthesize count = _count;
@synthesize group = _group;

- (id)init {
	self = [super init];
	if (self) {
        _group = @"";
	}
    
	return self;
}

-(void)dealloc{
    [_type release];
    [_channelid release];
    [_group release];
    [super dealloc];
}


- (NSString *)timestampFlag {
    NSString *flag = [NSString stringWithFormat:@"Focus_%@%@",self.group,self.channelid];
    return flag;
}

-(NSString *)entityName{
    return @"FSFocusTopObject";
}


-(NSTimeInterval)bufferDataExpireTimeInterval{
    return 60*8;
}


-(NSString *)readDataURLStringFromRemoteHostWithGETDataKind:(GET_DataKind)getDataKind{
    //return FSFOUCS_URL;
    
    NSString *urlString = [NSString stringWithFormat:FSFOUCS_WITH_TYPE_URL,self.type,self.channelid,self.count];
    return urlString;
}



-(NSString *)predicateStringWithQueryDataKind:(Query_DataKind)dataKind{
    
    return [NSString stringWithFormat:@"group='%@' AND bufferFlag!='3'",[self timestampFlag]];

}


- (void)initializeSortDescriptions:(NSMutableArray *)descriptions {
	[self addSortDescription:descriptions withSortFieldName:@"order" withAscending:YES];
}

#pragma mark -
#pragma mark NSCMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    _currentElementName = elementName;
	if ([_currentElementName isEqualToString:Focus_item]) {
        _obj = (FSFocusTopObject *)[self insertNewObjectTomanagedObjectContext];
        _obj.group = [self timestampFlag];
        _obj.bufferFlag = @"1";
        
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:Focus_item]) {
        
        //[self.objectList addObject:_obj];
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
    
    if ([_currentElementName isEqualToString:Focus_newsid]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        _obj.newsid = trimString(content);;
		[content release];
	} else if ([_currentElementName isEqualToString:Focus_title]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.title = trimString(content);
		[content release];
        
	}
    else if ([_currentElementName isEqualToString:Focus_browserCount]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		NSString *temp = trimString(content);
        NSNumber *tempNumber = [[NSNumber alloc] initWithInt:[temp intValue]];
        _obj.browserCount = tempNumber;
		[content release];
        [tempNumber release];
	}
    else if ([_currentElementName isEqualToString:Focus_type]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.type = trimString(content);
		[content release];
	}
    else if ([_currentElementName isEqualToString:Focus_channelid]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.channelid = trimString(content);
		[content release];
	}
    else if ([_currentElementName isEqualToString:Focus_timestamp]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        NSString *temp = trimString(content);
        NSNumber *tempNumber = [[NSNumber alloc] initWithInt:[temp intValue]];
		_obj.timestamp = tempNumber;
		[content release];
        [tempNumber release];
	}
    else if ([_currentElementName isEqualToString:Focus_picture]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.picture = trimString(content);
		[content release];
	}
    else if ([_currentElementName isEqualToString:Focus_link]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.link = trimString(content);
		[content release];
	}
    else if ([_currentElementName isEqualToString:Focus_flag]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.flag = trimString(content);
		[content release];
	}
    else if ([_currentElementName isEqualToString:Focus_order]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        NSString *temp = trimString(content);
        NSNumber *tempNumber = [[NSNumber alloc] initWithInt:[temp intValue]];
		_obj.order = tempNumber;
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
            self.isRecordListTail = [self.objectList count] < [self.fetchRequest fetchLimit];
            [self setBufferFlag];
        }
	}
}

-(void)setBufferFlag{
    
   NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:[self entityName] key:@"group" value:[self timestampFlag]];
    
    if (self.currentGetDataKind == GET_DataKind_Next){
        for (FSFocusTopObject *o in array) {
            if ([o.bufferFlag isEqualToString:@"1"]) {
                o.bufferFlag = @"2";
            }
        }
        [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext].managedObjectContext save:nil];
        return;
    }
    
    for (FSFocusTopObject *o in array) {
        if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"2"]) {
            ;//o.bufferFlag = @"3";
        }else if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"1"]){
            o.bufferFlag = @"2";
        }
    }
    [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext].managedObjectContext save:nil];
}

-(void)setBufferFlag3{
    
    NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:[self entityName] key:@"group" value:[self timestampFlag]];
    
    
    for (FSFocusTopObject *o in array) {
        if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"2"]) {
            o.bufferFlag = @"3";
        }
    }
    [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext].managedObjectContext save:nil];
}

-(void)operateOldBufferData{
    if (self.currentGetDataKind == GET_DataKind_Refresh) {
		
        if (_isRefreshToDeleteOldData == YES) {
            NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:[self entityName] key:@"group" value:[self timestampFlag]];
            for (FSFocusTopObject *o in array) {
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
//        NSMutableArray *array = [[NSMutableArray alloc] init];
//        NSLog(@"resultSet:%d",[resultSet count]);
//        for (FSFocusTopObject *o in resultSet) {
//            if ([o.group isEqualToString:self.group]) {
//                [array addObject:o];
//            }
//        }
//        
//		self.objectList = (NSMutableArray *)array;
//        NSLog(@"executeFetchRequest:%d",[self.objectList count]);
//		self.isRecordListTail = NO;
//        [array release];
//	}
//}
//
//
//-(void)operateOldBufferData{
//    if (self.currentGetDataKind == GET_DataKind_Refresh) {
//		NSArray *resultSets = self.objectList;
//		if ([resultSets count] > 0) {
//#ifdef MYDEBUG
//            NSLog(@"FresultSets:%d", [resultSets count]);
//#endif
//            for (FSFocusTopObject *entityObject in resultSets) {
//#ifdef MYDEBUG
//                NSLog(@"FentityObject");
//#endif
//                
//                if (entityObject!=nil) {
//                    if (![entityObject isDeleted]) {
//                        if ([self.group isEqualToString:entityObject.group]) {
//                            [self.managedObjectContext deleteObject:entityObject];
//                        }
//                        
//                    }
//                }
//                
//            }
//            //[self.objectList removeAllObjects];
//            [self saveCoreDataContext];
//            
//		}
//	}
//}


@end
