//
//  FS_GZF_DeepPictureDAO.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-12-27.
//
//

#import "FS_GZF_DeepPictureDAO.h"
#import "FSDeepPictureObject.h"

/*
<item>
<pictureid><![CDATA[20]]></pictureid>
<picture><![CDATA[http://58.68.130.1686372.jpg]]></picture>
<pictureText><![CDATA[育子代的梦想。[详细] ]]></pictureText>
</item>
*/

#define deep_item @"item"
#define deep_pictureid @"pictureid"
#define deep_picture @"picture"
#define deep_pictureText @"pictureText"

#define DEEPPICTURE_URL @"http://mobile.app.people.com.cn:81/topic/topic.php?act=picture&rt=xml&pictureid=%@"


@implementation FS_GZF_DeepPictureDAO

@synthesize deepid = _deepid;


- (id)init {
	self = [super init];
	if (self) {
		
	}
	return self;
}

- (void)dealloc {
    
	[super dealloc];
}

-(NSString *)entityName{
    return @"FSDeepPictureObject";
}

-(NSString *)PicEntityName{
    return @"";
}

- (NSString *)timestampFlag {
    NSString *string = [NSString stringWithFormat:@"FSDeepPictureObject_%@",self.deepid];
    NSLog(@"timestampFlag:%@",string);
    return string;
}


-(NSTimeInterval)bufferDataExpireTimeInterval{
    return 60*30;
}


-(NSString *)readDataURLStringFromRemoteHostWithGETDataKind:(GET_DataKind)getDataKind{
    
    
    if (getDataKind == GET_DataKind_Refresh) {
        NSString *url = [NSString stringWithFormat:DEEPPICTURE_URL,self.deepid];
        NSLog(@"NEWSCONTAINER_URL:%@",url);
        return url;
    }
    return nil;
}



-(NSString *)predicateStringWithQueryDataKind:(Query_DataKind)dataKind{
    return [NSString stringWithFormat:@"pictureid='%@' AND bufferFlag!='3'", self.deepid];
    
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
        _obj = (FSDeepPictureObject *)[self insertNewObjectTomanagedObjectContext:0];
        _obj.bufferFlag = @"1";
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
	
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
   // NSLog(@"11subject");
    
    if ([self.currentElementName isEqualToString:deep_pictureid]) {
        NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        _obj.pictureid = content;
        [content release];
    }else if([self.currentElementName isEqualToString:deep_picture]){
        NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        _obj.picture = content;
        [content release];
    }
    else if([self.currentElementName isEqualToString:deep_pictureText]){
        NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        _obj.pictureText = content;
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
    
    NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:[self entityName] key:@"pictureid" value:self.deepid];
    
    for (FSDeepPictureObject *o in array) {
        if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"2"]) {
            o.bufferFlag = @"3";
        }else if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"1"]){
            o.bufferFlag = @"2";
        }
    }
    [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext].managedObjectContext save:nil];
}


-(void)operateOldBufferData{
    if (self.currentGetDataKind == GET_DataKind_Refresh) {
		
        if (_isRefreshToDeleteOldData == YES) {
            NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:[self entityName] key:@"pictureid" value:self.deepid];
            for (FSDeepPictureObject *o in array) {
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
//        
//		if ([resultSet count]>0) {
//            
//            NSMutableArray *tempResultSet = [[NSMutableArray alloc] init];
//            
//            for (FSDeepPictureObject *o in resultSet) {
//                NSLog(@"executeFetchRequesto:%@",o);
//                if ([o.bufferFlag isEqualToString:@"1"] && _isRefreshToDeleteOldData == YES) {
//                    [tempResultSet addObject:o];
//                    o.bufferFlag = @"2";
//                }
//                else if(_isRefreshToDeleteOldData == NO && [o.bufferFlag isEqualToString:@"2"]){
//                    [tempResultSet addObject:o];
//                }else if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"2"]) {
//                    [tempResultSet addObject:o];
//                    o.bufferFlag = @"3";
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
//            NSArray *array = [[FSBaseDB sharedFSBaseDB] getObjectsByKeyWithName:[self entityName] key:@"pictureid" value:self.deepid];
//            for (FSDeepPictureObject *o in array) {
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
