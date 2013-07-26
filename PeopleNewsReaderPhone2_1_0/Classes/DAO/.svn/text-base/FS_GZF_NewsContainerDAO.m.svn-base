//
//  FS_GZF_NewsContainerDAO.m
//  PeopleNewsReaderPhone
//
//  Created by Xu dandan on 12-10-25.
//
//

/*
 <item>
 <title></title>
 <timestamp></timestamp>
 <date></date>
 <source></source>
 <content><![CDATA[]]></content>
 <pictures>
 <pictureItem>
 <picture>图片url</picture>
 <picdesc>图片说明</picdesc>
 </pictureItem>
 ….<!-- 多图 -->
 <pictures>
 </item>
 */

#import "FS_GZF_NewsContainerDAO.h"
#import "FSNewsDitailPicObject.h"
#import "FSNewsDitailObject.h"


#define NEWSCONTAINER_URL @"http://mobile.app.people.com.cn:81/news2/news.php?act=onenews&rt=xml&newsid=%@&fromid=full"

#define NEWSCONTAINER_DIFANG_URL @"http://mobile.app.people.com.cn:81/news2/news.php?act=onenews&rt=xml&newsid=%@&fromid=df"

#define NEWSCONTAINER_SHIKE_URL @"http://mobile.app.people.com.cn:81/news2/news.php?act=realtimecontent&newsid=%@"



#define newscontainer_item @"item"
#define newscontainer_title @"title"
#define newscontainer_timestamp @"timestamp"
#define newscontainer_date @"date"
#define newscontainer_source @"source"
#define newscontainer_content @"content"
#define newscontainer_pictures @"pictures"
#define newscontainer_pictureItem @"pictureItem"
#define newscontainer_picture @"picture"
#define newscontainer_picdesc @"picdesc"
#define newscontainer_shortUrl @"shortUrl"



@implementation FS_GZF_NewsContainerDAO

@synthesize cobj = _cobj;
@synthesize pobj = _pobj;
@synthesize newsid = _newsid;
@synthesize newsSourceKind = _newsSourceKind;


- (id)init {
	self = [super init];
	if (self) {
		_picCount = 0;
	}
	return self;
}

- (void)dealloc {
//    [_cobj release];
//    [_pobj release];
//    [_newsid release];
	[super dealloc];
}

-(NSString *)getnewsid{
    if (self.newsid!=nil) {
         return self.newsid;
    }
   
    return @"1307338";
}

-(NSString *)entityName{
    return @"FSNewsDitailObject";
}

-(NSString *)PicEntityName{
    return @"FSNewsDitailPicObject";
}

- (NSString *)timestampFlag {
    return [NSString stringWithFormat:@"FSNewsDitailObject_%@",self.newsid];
}


-(NSTimeInterval)bufferDataExpireTimeInterval{
    return 60*60*2;
}


-(NSString *)readDataURLStringFromRemoteHostWithGETDataKind:(GET_DataKind)getDataKind{
    
    if (self.newsSourceKind == NewsSourceKind_ShiKeNews) {
        NSString *url = [NSString stringWithFormat:NEWSCONTAINER_SHIKE_URL,[self getnewsid]];
        NSLog(@"NEWSCONTAINER_URL:%@",url);
        return url;
    }
    
    if (self.newsSourceKind == NewsSourceKind_PushNews) {
        NSString *url = [NSString stringWithFormat:NEWSCONTAINER_URL,[self getnewsid]];
        NSLog(@"NEWSCONTAINER_URL:%@",url);
        return url;
    }
    
    if (self.newsSourceKind == NewsSourceKind_PuTongNews) {
        NSString *url = [NSString stringWithFormat:NEWSCONTAINER_URL,[self getnewsid]];
        NSLog(@"NEWSCONTAINER_URL:%@",url);
        return url;
    }
    
    if (self.newsSourceKind == NewsSourceKind_DiFangNews) {
        NSString *url = [NSString stringWithFormat:NEWSCONTAINER_DIFANG_URL,[self getnewsid]];
        NSLog(@"NEWSCONTAINER_URL:%@",url);
        return url;
    }
    return nil;
}



-(NSString *)predicateStringWithQueryDataKind:(Query_DataKind)dataKind{
   return [NSString stringWithFormat:@"newsid='%@'  AND bufferFlag!='3'", [self getnewsid]];
   
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
    //NSLog(@"ELementName:%@",elementName);
    if ([self.currentElementName isEqualToString:newscontainer_item]) {
        _cobj = (FSNewsDitailObject *)[self insertNewObjectTomanagedObjectContext:0];
        _cobj.newsid = [self newsid];
        _cobj.bufferFlag = @"1";
    }
    if ([self.currentElementName isEqualToString:newscontainer_pictureItem]) {
        if (_picCount!=0) {
            if ([_pobj.picture length] == 0) {
                _picCount--;
                [self.managedObjectContext deleteObject:_pobj];
            }
        }
        _pobj = (FSNewsDitailPicObject *)[self insertNewObjectTomanagedObjectContext:1];
        _pobj.newsid = [self newsid];
        _picCount = _picCount +1;
        _pobj.bufferFlag = @"1";
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:newscontainer_pictures]) {
        
        if ([_pobj.picture length] == 0) {
            _picCount--;
            if ( _pobj != nil) {
                [self.managedObjectContext deleteObject:_pobj];
                _pobj = nil;
            }
        }
        
        NSLog(@"_picCount:%d",_picCount);
        NSNumber *tempNumber = [[NSNumber alloc] initWithInt:_picCount];
        _cobj.pictures = tempNumber;
        [tempNumber release];
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
    
    if ([self.currentElementName isEqualToString:newscontainer_title]) {
        NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        _cobj.title = content;
        [content release];
    }else if([self.currentElementName isEqualToString:newscontainer_timestamp]){
        NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        _cobj.timestamp = content;
        [content release];
    }
    else if([self.currentElementName isEqualToString:newscontainer_date]){
        NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        _cobj.date = content;
        [content release];
    }
    else if([self.currentElementName isEqualToString:newscontainer_source]){
       NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        _cobj.source = content;
        [content release];
    }
    else if([self.currentElementName isEqualToString:newscontainer_picture]){
        NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        _pobj.picture = content;
        [content release];
    }
    else if([self.currentElementName isEqualToString:newscontainer_picdesc]){
        NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        _pobj.picdesc = content;
        [content release];
    }
    else if ([_currentElementName isEqualToString:newscontainer_content]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        _cobj.content = content;
		[content release];
	}
    else if ([_currentElementName isEqualToString:newscontainer_shortUrl]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        _cobj.shortUrl = content;
		[content release];
	}
}





- (void)executeFetchRequest:(NSFetchRequest *)request {
	NSError *error = nil;
	NSArray *resultSet = [self.managedObjectContext executeFetchRequest:request error:&error];
	if (!error) {
        
		if ([resultSet count]>0) {
            //NSLog(@"[resultSet count]:%d",[resultSet count]);
            _cobj = [resultSet objectAtIndex:0];
            if ([_cobj.pictures intValue]>0) {
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
                [self setBufferFlag];
            }
        }
	}
}


-(void)setBufferFlag{
    
    NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:[self entityName] key:@"newsid" value:self.newsid];
    
    for (FSNewsDitailPicObject *o in array) {
        if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"2"]) {
            ;//o.bufferFlag = @"3";
        }else if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"1"]){
            o.bufferFlag = @"2";
        }
    }
    
    NSArray *arrayPic = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:[self PicEntityName] key:@"newsid" value:self.newsid];
    
    for (FSNewsDitailPicObject *o in arrayPic) {
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
    
    for (FSNewsDitailPicObject *o in array) {
        if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"2"]) {
            o.bufferFlag = @"3";
        }
    }
    
    NSArray *arrayPic = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:[self PicEntityName] key:@"newsid" value:self.newsid];
    
    for (FSNewsDitailPicObject *o in arrayPic) {
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
            for (FSNewsDitailObject *o in array) {
                if ([o.bufferFlag isEqualToString:@"3"]) {
                    [self.managedObjectContext deleteObject:o];
                }
            }
            
            NSArray *arrayPic = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:[self PicEntityName] key:@"newsid" value:self.newsid];
            for (FSNewsDitailPicObject *o in arrayPic) {
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
//        
//		if ([resultSet count]>0) {
//            for (FSNewsDitailObject *o in resultSet) {
//                //NSLog(@"executeFetchRequesto:%@",o);
//                if ([o.bufferFlag isEqualToString:@"1"] && _isRefreshToDeleteOldData == YES) {
//                    _cobj = o;
//                    _cobj.bufferFlag = @"2";
//                }
//                else if(_isRefreshToDeleteOldData == NO && [o.bufferFlag isEqualToString:@"2"]){
//                    _cobj = o;
//                    
//                    //[self.managedObjectContext deleteObject:o];
//                    //[self saveCoreDataContext];
//                }else if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"2"]) {
//                    _cobj = o;
//                    _cobj.bufferFlag = @"3";
//                }
//            }
//            
//            if ([_cobj.pictures intValue]>0) {
//                [self readNewsPicFromBufferWithQueryDataKind:Query_DataKind_New];
//            }
//        }
//	}
//}
//
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
//            for (FSNewsDitailPicObject *o in resultSet) {
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
//            self.objectList = (NSMutableArray *)tempResultSet;
//            [tempResultSet release];
//        }
//	}
//}
//
//
//
//-(void)operateOldBufferData{
//    if (self.currentGetDataKind == GET_DataKind_Refresh) {
//		
//        if (_isRefreshToDeleteOldData == YES) {
//            NSArray *array = [[FSBaseDB sharedFSBaseDB] getObjectsByKeyWithName:[self entityName] key:@"newsid" value:self.newsid];
//            for (FSNewsDitailObject *o in array) {
//                if ([o.bufferFlag isEqualToString:@"3"]) {
//                    [self.managedObjectContext deleteObject:o];
//                }
//            }
//            
//            NSArray *arrayPic = [[FSBaseDB sharedFSBaseDB] getObjectsByKeyWithName:[self PicEntityName] key:@"newsid" value:self.newsid];
//            for (FSNewsDitailPicObject *o in arrayPic) {
//                if ([o.bufferFlag isEqualToString:@"3"]) {
//                    [self.managedObjectContext deleteObject:o];
//                }
//            }
//            
//            [self saveCoreDataContext];
//        }
//	}
//}



@end
