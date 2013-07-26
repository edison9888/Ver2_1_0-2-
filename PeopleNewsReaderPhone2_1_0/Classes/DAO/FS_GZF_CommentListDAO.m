//
//  FS_GZF_CommentListDAO.m
//  PeopleNewsReaderPhone
//
//  Created by Xu dandan on 12-11-1.
//
//

/*
<commentsCount>3</commentsCount>
<comments>
<item>
<commentid>601780</commentid>
<deviceType></deviceType>
<content><![CDATA[我顶!说得好！]]></content>
<nickname><![CDATA[中国人]]></nickname>
<timestamp><![CDATA[1349933486]]></timestamp>
</item>
</comments>
*/

#import "FS_GZF_CommentListDAO.h"

#import "FSCommentObject.h"

#define COMMENT_LIST_URL @"http://mobile.app.people.com.cn:81/news2/news.php?act=getcomment&rt=xml&newsid=%@&count=%@&commentid=%@"



#define comment_commentsCount @"commentsCount"
#define comment_item @"item"
#define comment_commentid @"commentid"
#define comment_deviceType @"deviceType"
#define comment_content @"content"
#define comment_nickname @"nickname"
#define comment_timestamp @"timestamp"

#define comment_adminContent @"adminContent"
#define comment_adminNickname @"adminNickname"
#define comment_adminTimestamp @"adminTimestamp"


@implementation FS_GZF_CommentListDAO

@synthesize count = _count;
@synthesize newsid = _newsid;
@synthesize lastCommentid = _lastCommentid;


- (id)init {
	self = [super init];
	if (self) {
		
	}
	return self;
}

- (void)dealloc {
	
	[super dealloc];
}

- (NSString *)readDataURLStringFromRemoteHostWithGETDataKind:(GET_DataKind)getDataKind {
    //self.newsid = @"1673597";
    
    if (getDataKind == GET_DataKind_Refresh) {
        return [NSString stringWithFormat:COMMENT_LIST_URL,self.newsid,self.count,@""];
    }
    else{
        return [NSString stringWithFormat:COMMENT_LIST_URL,self.newsid,self.count,self.lastCommentid];
    }
}

- (NSTimeInterval)bufferDataExpireTimeInterval {
	return 40;
}

//查询数据
- (NSString *)predicateStringWithQueryDataKind:(Query_DataKind)dataKind {
    
    return [NSString stringWithFormat:@"newsid='%@' AND bufferFlag!='3'", self.newsid];
	
}



- (NSString *)entityName {
	return @"FSCommentObject";
}

- (NSString *)timestampFlag {
    return [NSString stringWithFormat:@"comment_list_%@", self.newsid];
}

- (void)initializeSortDescriptions:(NSMutableArray *)descriptions {
	[self addSortDescription:descriptions withSortFieldName:@"commentid" withAscending:NO];
}



#pragma mark -
#pragma mark NSCMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    _currentElementName = elementName;
	if ([_currentElementName isEqualToString:comment_item]) {
        _obj = (FSCommentObject *)[self insertNewObjectTomanagedObjectContext];
        _obj.newsid = self.newsid;
        _obj.bufferFlag = @"1";
        
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
	if ([elementName isEqualToString:comment_item]) {
        
        //[_objectList addObject:_obj];
        //[_obj release];
        //_obj = nil;
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	//NSLog(@"foundCharacters:%@",string);
    
    
     NSString *strUnion = nil;
     if ([self.currentElementName isEqualToString:comment_commentsCount]) {
         strUnion = stringCat(self.count, trimString(string));
         self.count = strUnion;
     }else if([self.currentElementName isEqualToString:comment_commentid]){
         strUnion = stringCat(_obj.commentid, trimString(string));
         _obj.commentid = strUnion;
     }
     //[strUnion release];
     
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock {
    
    if ([_currentElementName isEqualToString:comment_content]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        _obj.content = content;
		[content release];
	} else if ([_currentElementName isEqualToString:comment_nickname]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.nickname = trimString(content);
		[content release];
	}
    else if ([_currentElementName isEqualToString:comment_timestamp]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.timestamp = trimString(content);
		[content release];
	}else if ([_currentElementName isEqualToString:comment_adminContent]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        _obj.adminContent = content;
		[content release];
	} else if ([_currentElementName isEqualToString:comment_adminNickname]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.adminNickname = trimString(content);
		[content release];
	}
    else if ([_currentElementName isEqualToString:comment_adminTimestamp]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.adminTimestamp = trimString(content);
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
    
    NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:[self entityName] key:@"newsid" value:self.newsid];
    
    if (self.currentGetDataKind == GET_DataKind_Next){
        for (FSCommentObject *o in array) {
            if ([o.bufferFlag isEqualToString:@"1"]) {
                o.bufferFlag = @"2";
            }
        }
        [self saveCoreDataContext];
        return;
    }
    
    for (FSCommentObject *o in array) {
        if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"2"]) {
            ;//o.bufferFlag = @"3";
        }else if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"1"]){
            o.bufferFlag = @"2";
        }
    }
    [self saveCoreDataContext];
}

-(void)setBufferFlag3{
    NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:[self entityName] key:@"newsid" value:self.newsid];
    
       
    for (FSCommentObject *o in array) {
        if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"2"]) {
            o.bufferFlag = @"3";
        }
    }
    [self saveCoreDataContext];
}


-(void)operateOldBufferData{
    if (self.currentGetDataKind == GET_DataKind_Refresh) {
		
        if (_isRefreshToDeleteOldData == YES) {
            NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:[self entityName] key:@"newsid" value:self.newsid];
            for (FSCommentObject *o in array) {
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
//		self.isRecordListTail = [self.objectList count] < [self.fetchRequest fetchLimit];
//        [tempResultSet release];
//    }
//}
//
//
//-(void)operateOldBufferData{
//    if (self.currentGetDataKind == GET_DataKind_Refresh) {
//		NSMutableArray *resultSets = self.objectList;
//        
//		if ([resultSets count] > 0) {
//#ifdef MYDEBUG
//            NSLog(@"resultSets:%d", [resultSets count]);
//#endif
//            for (FSCommentObject *entityObject in resultSets) {
//#ifdef MYDEBUG
//                //NSLog(@"entityObject");
//#endif
//                if (entityObject!=nil) {
//                    if (![entityObject isDeleted]) {
//                        [self.managedObjectContext deleteObject:entityObject];
//                        
//                    }
//                }
//            }
//            //[_objectList removeAllObjects];
//            [self saveCoreDataContext];
//		}
//	}
//}



@end
