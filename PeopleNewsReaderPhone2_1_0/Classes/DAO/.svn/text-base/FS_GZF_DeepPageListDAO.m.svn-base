//
//  FS_GZF_DeepPageListDAO.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-12-27.
//
//

#import "FS_GZF_DeepPageListDAO.h"
#import "FSDeepPageObject.h"


/*
<item>
 <pageid>20</pageid>
 <flag>2</flag>
 <orderIndex>1</orderIndex>
 </item>
 */

#define deep_pageid @"pageid"
#define deep_flag @"flag"
#define deep_orderIndex @"orderIndex"
#define deep_item @"item"

#define DEEPPAGE_LIST_URL @"http://mobile.app.people.com.cn:81/topic/topic.php?act=page_list&rt=xml&deepid=%@&type=list&iswp=0"


@implementation FS_GZF_DeepPageListDAO

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
    return @"FSDeepPageObject";
}

-(NSString *)timestampFlag{
    NSString *string = [NSString stringWithFormat:@"FSDeepPageObject_%@",self.deepid];
    return string;
}


-(NSString *)readDataURLStringFromRemoteHostWithGETDataKind:(GET_DataKind)getDataKind{

    NSString *url = [NSString stringWithFormat:DEEPPAGE_LIST_URL,self.deepid];
    return url;
}



-(NSString *)predicateStringWithQueryDataKind:(Query_DataKind)dataKind{
    return [NSString stringWithFormat:@"deepid='%@' AND bufferFlag!='3'", self.deepid];
    return nil;
}



- (void)initializeSortDescriptions:(NSMutableArray *)descriptions {
	[self addSortDescription:descriptions withSortFieldName:@"orderIndex" withAscending:YES];
}

-(NSInteger)fetchLimitWithGETDDataKind:(GET_DataKind)getDataKind{
    return 0;
}

#pragma mark -
#pragma mark NSCMLParserDelegate


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    _currentElementName = elementName;
	if ([_currentElementName isEqualToString:deep_item]) {
        _obj = (FSDeepPageObject *)[self insertNewObjectTomanagedObjectContext];
        _obj.deepid = self.deepid;
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
	
    if ([_currentElementName isEqualToString:deep_pageid]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.pageid = trimString(content);
		[content release];
	} else if ([_currentElementName isEqualToString:deep_flag]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        NSString *temp = trimString(content);
        NSNumber *tempNumber = [[NSNumber alloc] initWithInt:[temp intValue]];
		_obj.flag = tempNumber;
		[content release];
        [tempNumber release];
	}
    else if ([_currentElementName isEqualToString:deep_orderIndex]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        NSString *temp = trimString(content);
        NSNumber *tempNumber = [[NSNumber alloc] initWithInt:[temp intValue]];
		_obj.orderIndex = tempNumber;
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
    
   NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:[self entityName] key:@"deepid" value:self.deepid];
    
    if (self.currentGetDataKind == GET_DataKind_Next){
        for (FSDeepPageObject *o in array) {
            if ([o.bufferFlag isEqualToString:@"1"]) {
                o.bufferFlag = @"2";
            }
        }
        [self saveCoreDataContext];
        return;
    }
    
    for (FSDeepPageObject *o in array) {
        if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"2"]) {
            ;//o.bufferFlag = @"3";
        }else if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"1"]){
            o.bufferFlag = @"2";
        }
    }
    [self saveCoreDataContext];
}


-(void)setBufferFlag3{
    NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:[self entityName] key:@"deepid" value:self.deepid];
    
        
    for (FSDeepPageObject *o in array) {
        if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"2"]) {
            o.bufferFlag = @"3";
        }
    }
    [self saveCoreDataContext];
}


-(void)operateOldBufferData{
    if (self.currentGetDataKind == GET_DataKind_Refresh) {
		
        if (_isRefreshToDeleteOldData == YES) {
            NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:[self entityName] key:@"deepid" value:self.deepid];
            for (FSDeepPageObject *o in array) {
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
//            for (FSDeepPageObject *entityObject in resultSets) {
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
