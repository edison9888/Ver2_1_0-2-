//
//  FS_GZF_DeepTextDAO.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-12-27.
//
//

#import "FS_GZF_DeepTextDAO.h"

#import "FSDeepContentObject.h"
#import "FSDeepContent_TextObject.h"
#import "FSDeepContent_PicObject.h"
#import "FSDeepContent_ChildObject.h"

#define FSDEEP_TEXT_URL @"http://mobile.app.people.com.cn:81/topic/topic.php?act=news&rt=xml&contentid=%@"





/*
 <item>
 <subjectTile><![CDATA[谁都可以捐精吗？]]></subjectTile>
 <subjectid><![CDATA[86]]></subjectid>
 <subjectPic><![CDATA[http://58.68.130.168/thumbs/640/320/data/newsimages/client/121220/F201212201355990236103578.jpg]]></subjectPic>
 <contented><![CDATA[62]]></contented>
 <title><![CDATA[谁都可以捐精吗？]]></title>
 <timestamp><![CDATA[1355992521]]></timestamp>
 <pubDate><![CDATA[2012-12-20 16:35:21]]></pubDate>
 <source><![CDATA[人民网]]></source>
 <body>
 <picURL><![CDATA[http://58.68.130.168/thumbs/640/320/data/newsimages/client/130107/F2013010713575232023187.jpg]]></picURL>
 <text><![CDATA[Q：谁都可以捐精吗？A：当然不是。首先，你得是男人，且年龄在22—45岁。然后，还有一堆严苛的标准：无严重疾病、近视度数不得大于500度、无酗酒嗜烟等不良嗜好、捐精前3～7天禁欲……当然，远不止如此。[详细]]]></text>
 </body>
 </item>
 */

#define deep_item @"item"
#define deep_subjectTile @"subjectTile"
#define deep_subjectid @"subjectid"
#define deep_contented @"contented"
#define deep_title @"title"
#define deep_timestamp @"timestamp"
#define deep_pubDate @"pubDate"
#define deep_source @"source"
#define deep_body @"body"
#define deep_picURL @"picURL"
#define deep_text @"text"
#define deep_subjectPic @"subjectPic"




@implementation FS_GZF_DeepTextDAO

@synthesize deepid = _deepid;
@synthesize fsDeepContentObject = _fsDeepContentObject;


- (id)init {
	self = [super init];
	if (self) {
		_picCount = 0;
	}
	return self;
}

- (void)dealloc {
    
	[super dealloc];
}


- (NSInteger)pictureFlag {
    return FSDEEP_TEXT_CHILD_PIC_NODE_FLAG;
}

- (NSInteger)textFlag {
    return FSDEEP_TEXT_CHILD_TXT_NODE_FLAG;
}

-(NSString *)entityName{
    return @"FSDeepContentObject";
}

-(NSString *)PicEntityName{
    return @"FSDeepContent_ChildObject";
}

- (NSString *)timestampFlag {
     return [NSString stringWithFormat:@"FSDeepContentObject_%@",self.deepid];
}


-(NSTimeInterval)bufferDataExpireTimeInterval{
    return 60*60*24;
}


-(NSString *)readDataURLStringFromRemoteHostWithGETDataKind:(GET_DataKind)getDataKind{

    NSString *url = [NSString stringWithFormat:FSDEEP_TEXT_URL,self.deepid];
    NSLog(@"NEWSCONTAINER_URL:%@",url);
    return url;
}




-(NSString *)predicateStringWithQueryDataKind:(Query_DataKind)dataKind{
    return [NSString stringWithFormat:@"contentid='%@' AND bufferFlag!='3'", self.deepid];
    
}


- (void)PicinitializeSortDescriptions:(NSMutableArray *)descriptions {
	[self addSortDescription:descriptions withSortFieldName:@"orderIndex" withAscending:YES];
}


- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
#ifdef MYDEBUG
	NSLog(@"XMLParser Error:%@[%d][%@]", [parseError localizedDescription], [parseError code], self);
#endif
	
	//回调错误
	[self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_DataFormatErrorStatus];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	self.currentElementName = elementName;
    if ([self.currentElementName isEqualToString:deep_item]) {
        _fsDeepContentObject = (FSDeepContentObject *)[self insertNewObjectTomanagedObjectContext:0];
        _fsDeepContentObject.contentid = self.deepid;
        _fsDeepContentObject.bufferFlag = @"1";
    }
    if ([self.currentElementName isEqualToString:deep_picURL]) {
//        if (_picCount!=0) {
//            if ([_fsDeepContent_ChildObject.content length] == 0) {
//                _picCount--;
//                [self.managedObjectContext deleteObject:_fsDeepContent_ChildObject];
//            }
//        }
        _fsDeepContent_ChildObject = (FSDeepContent_ChildObject *)[self insertNewObjectTomanagedObjectContext:1];
        _fsDeepContent_ChildObject.flag = [NSNumber numberWithInteger:FSDEEP_TEXT_CHILD_PIC_NODE_FLAG];
        _fsDeepContent_ChildObject.contentid = self.deepid;
        _fsDeepContent_ChildObject.orderIndex = [NSNumber numberWithInteger:_picCount];
        _picCount = _picCount +1;
        _fsDeepContent_ChildObject.bufferFlag = @"1";
    }
    
    if ([self.currentElementName isEqualToString:deep_text]) {
//        if (_picCount!=0) {
//            if ([_fsDeepContent_ChildObject.content length] == 0) {
//                _picCount--;
//                [self.managedObjectContext deleteObject:_fsDeepContent_ChildObject];
//            }
//        }
        _fsDeepContent_ChildObject = (FSDeepContent_ChildObject *)[self insertNewObjectTomanagedObjectContext:1];
        _fsDeepContent_ChildObject.flag = [NSNumber numberWithInteger:FSDEEP_TEXT_CHILD_TXT_NODE_FLAG];
        _fsDeepContent_ChildObject.contentid = self.deepid;
        _fsDeepContent_ChildObject.orderIndex = [NSNumber numberWithInteger:_picCount];
        _picCount = _picCount +1;
        _fsDeepContent_ChildObject.bufferFlag = @"1";
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:deep_body]) {
        
        if ([_fsDeepContent_ChildObject.content length] == 0) {
            _picCount--;
            if ( _fsDeepContent_ChildObject != nil) {
                [self.managedObjectContext deleteObject:_fsDeepContent_ChildObject];
                _fsDeepContent_ChildObject = nil;
            }
        }
    }
	
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	//NSLog(@"foundCharacters");
    /*
     NSString *strUnion = nil;
     if ([self.currentElementName isEqualToString:newscontainer_title]) {
     strUnion = stringCat(_cobj.title, trimString(string));
     _cobj.title = strUnion;
     }else if([self.currentElementName isEqualToString:newscontainer_timestamp]){
     strUnion = stringCat(_cobj.timestamp, trimString(string));
     _cobj.timestamp = strUnion;
     }
     else if([self.currentElementName isEqualToString:newscontainer_date]){
     strUnion = stringCat(_cobj.date, trimString(string));
     _cobj.date = strUnion;
     }
     else if([self.currentElementName isEqualToString:newscontainer_source]){
     strUnion = stringCat(_cobj.source, trimString(string));
     _cobj.source = strUnion;
     }
     else if([self.currentElementName isEqualToString:newscontainer_picture]){
     strUnion = stringCat(_pobj.picture, trimString(string));
     _pobj.picture = strUnion;
     }
     else if([self.currentElementName isEqualToString:newscontainer_picdesc]){
     strUnion = stringCat(_pobj.picdesc, trimString(string));
     _pobj.picdesc = strUnion;
     }
     [strUnion release];
     */
    
    
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock {
    //NSLog(@"11subject");
    
    if ([self.currentElementName isEqualToString:deep_subjectTile]) {
        NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        _fsDeepContentObject.subjectTile = content;
        [content release];
    }else if([self.currentElementName isEqualToString:deep_subjectid]){
        NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        _fsDeepContentObject.subjectid = content;
        [content release];
    }
    else if([self.currentElementName isEqualToString:deep_contented]){
        NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        _fsDeepContentObject.contentid = content;
        [content release];
    }
    else if([self.currentElementName isEqualToString:deep_title]){
        NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        _fsDeepContentObject.title = content;
        [content release];
    }
    else if([self.currentElementName isEqualToString:deep_timestamp]){
        NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        NSString *temp = trimString(content);
        NSNumber *tempNumber = [[NSNumber alloc] initWithInt:[temp intValue]];
        _fsDeepContentObject.timestamp = tempNumber;
        [content release];
        [tempNumber release];
    }
    else if([self.currentElementName isEqualToString:deep_pubDate]){
        NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        _fsDeepContentObject.pubDate = content;
        [content release];
    }
    else if ([_currentElementName isEqualToString:deep_source]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        _fsDeepContentObject.source = content;
		[content release];
	}
    else if ([_currentElementName isEqualToString:deep_picURL]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        _fsDeepContent_ChildObject.content = content;
		[content release];
	}
    else if ([_currentElementName isEqualToString:deep_text]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        _fsDeepContent_ChildObject.content = content;
		[content release];
	}
    else if ([_currentElementName isEqualToString:deep_subjectPic]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        _fsDeepContentObject.subjectPic = content;
		[content release];
	}
    
    
}



- (void)executeFetchRequest:(NSFetchRequest *)request {
	NSError *error = nil;
	NSArray *resultSet = [self.managedObjectContext executeFetchRequest:request error:&error];
	if (!error) {
        
		if ([resultSet count]>0) {
            //NSLog(@"[resultSet count]:%d",[resultSet count]);
            _fsDeepContentObject = [resultSet objectAtIndex:0];
            if ([_fsDeepContentObject.contentid length]>0) {
                [self readNewsPicFromBufferWithQueryDataKind:Query_DataKind_New];
            }
            else{
                [self setBufferFlag];
            }
            
        }
	}
}

- (void)executeFetchPicRequest:(NSFetchRequest *)request {
	NSError *error = nil;
	NSArray *resultSet = [self.managedObjectContext executeFetchRequest:request error:&error];
	if (!error) {
		if ([resultSet count]>0) {
            if ([resultSet count]>0) {
                //NSLog(@"[resultSet count]:%d",[resultSet count]);
                _objectList = (NSMutableArray *)resultSet;
                
                if ([_fsDeepContentObject.childContent count]==0) {
                    NSMutableSet *childSet = [[NSMutableSet alloc] init];
                    [childSet addObjectsFromArray:resultSet];
                    _fsDeepContentObject.childContent = childSet;
                    [childSet release];
                }
                [self setBufferFlag];
            }
        }
	}
}


-(void)setBufferFlag{
    
    NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:[self entityName] key:@"contentid" value:self.deepid];
    
    for (FSDeepContentObject *o in array) {
        if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"2"]) {
            //o.bufferFlag = @"3";
        }else if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"1"]){
            o.bufferFlag = @"2";
        }
    }
    
   NSArray *arrayPic = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:[self PicEntityName] key:@"contentid" value:self.deepid];
    
    for (FSDeepContent_ChildObject *o in arrayPic) {
        if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"2"]) {
            //o.bufferFlag = @"3";
        }else if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"1"]){
            o.bufferFlag = @"2";
        }
    }
    
    [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext].managedObjectContext save:nil];
}


-(void)setBufferFlag3{
    NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:[self entityName] key:@"contentid" value:self.deepid];
    
    for (FSDeepContentObject *o in array) {
        if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"2"]) {
            o.bufferFlag = @"3";
        }
    }
    
    NSArray *arrayPic = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:[self PicEntityName] key:@"contentid" value:self.deepid];
    
    for (FSDeepContent_ChildObject *o in arrayPic) {
        if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"2"]) {
            o.bufferFlag = @"3";
        }
    }
    
    [self saveCoreDataContext];
}


-(void)operateOldBufferData{
    if (self.currentGetDataKind == GET_DataKind_Refresh) {
        if (_isRefreshToDeleteOldData == YES) {
            NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:[self entityName] key:@"contentid" value:_deepid];
            for (FSDeepContentObject *o in array) {
                if ([o.bufferFlag isEqualToString:@"3"]) {
                    NSLog(@"o:%@",o);
                    [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] deleteObjectByObject:o];
                }
            }
            
            NSArray *arrayPic = [[FSBaseDB sharedFSBaseDB] getObjectsByKeyWithName:[self PicEntityName] key:@"contentid" value:_deepid];
            for (FSDeepContent_ChildObject *oo in arrayPic) {
                if ([oo.bufferFlag isEqualToString:@"3"]) {
                    NSLog(@"oo:%@",oo);
                    [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] deleteObjectByObject:oo];
                }
            }
            
        }
	}
}




//- (void)executeFetchRequest:(NSFetchRequest *)request {
//	NSError *error = nil;
//	NSArray *resultSet = [self.managedObjectContext executeFetchRequest:request error:&error];
//	if (!error) {
//		if ([resultSet count]>0) {
//            for (FSDeepContentObject *o in resultSet) {
//                NSLog(@"executeFetchRequesto:%@",o);
//                if ([o.bufferFlag isEqualToString:@"1"] && _isRefreshToDeleteOldData == YES) {
//                    _fsDeepContentObject = o;
//                    o.bufferFlag = @"2";
//                }
//                else if(_isRefreshToDeleteOldData == NO && [o.bufferFlag isEqualToString:@"2"]){
//                    _fsDeepContentObject = o;;
//                }else if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"2"]) {
//                    _fsDeepContentObject = o;
//                    o.bufferFlag = @"3";
//                }
//            }
//            if ([_fsDeepContentObject.contentid length]>0) {
//                    [self readNewsPicFromBufferWithQueryDataKind:Query_DataKind_New];
//            }
//        }
//	}
//}
//
//
//
//
//- (void)executeFetchPicRequest:(NSFetchRequest *)request {
//	NSError *error = nil;
//	NSArray *resultSet = [self.managedObjectContext executeFetchRequest:request error:&error];
//	if (!error) {
//		if ([resultSet count]>0) {
//            NSMutableArray *tempResultSet = [[NSMutableArray alloc] init];
//            for (FSDeepContent_ChildObject *o in resultSet) {
//                
//                if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"1"]) {
//                    o.bufferFlag = @"2";
//                    [tempResultSet addObject:o];
//                }
//                else if(_isRefreshToDeleteOldData == NO && [o.bufferFlag isEqualToString:@"2"]){
//                    [tempResultSet addObject:o];
//                }else if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"2"]) {
//                    o.bufferFlag = @"3";
//                    [tempResultSet addObject:o];
//                }
//            }
//            NSMutableSet *childSet = [[NSMutableSet alloc] init];
//            [childSet addObjectsFromArray:tempResultSet];
//            _fsDeepContentObject.childContent = childSet;
//            self.objectList = tempResultSet;
//            [tempResultSet release];
//            [childSet release];
//        }
//	}
//}
//
//-(void)operateOldBufferData{
//    if (self.currentGetDataKind == GET_DataKind_Refresh) {
//        if (_isRefreshToDeleteOldData == YES) {
//            NSArray *array = [[FSBaseDB sharedFSBaseDB] getObjectsByKeyWithName:[self entityName] key:@"contentid" value:self.deepid];
//            for (FSDeepContentObject *o in array) {
//                if ([o.bufferFlag isEqualToString:@"3"]) {
//                    [[FSBaseDB sharedFSBaseDB].managedObjectContext deleteObject:o];
//                }
//            }
//            NSArray *arrayPic = [[FSBaseDB sharedFSBaseDB] getObjectsByKeyWithName:[self PicEntityName] key:@"contentid" value:self.deepid];
//            for (FSDeepContent_ChildObject *o in arrayPic) {
//                if ([o.bufferFlag isEqualToString:@"3"]) {
//                    [[FSBaseDB sharedFSBaseDB].managedObjectContext deleteObject:o];
//                }
//            }
//            [[FSBaseDB sharedFSBaseDB].managedObjectContext save:nil];
//        }
//	}
//}



@end
