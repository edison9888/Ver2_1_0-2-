//
//  FS_GZF_BaseGETXMLDataListDAO.m
//  PeopleNewsReaderPhone
//
//  Created by Xu dandan on 12-10-19.
//
//

#import "FS_GZF_BaseGETXMLDataListDAO.h"

@implementation FS_GZF_BaseGETXMLDataListDAO

@synthesize objectList = _objectList;

- (id)init {
	self = [super init];
	if (self) {
        _objectList = nil;
		//_objectList = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void)dealloc {
    //[_objectList removeAllObjects];
	//[_objectList release];
	[super dealloc];
}



-(NSObject *)insertNewObjectTomanagedObjectContext{
    if (self.managedObjectContext != nil) {
        //NSLog(@"ManagedobjectContext:%@",[self.managedObjectContext description]);
        NSObject *obj= [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:self.managedObjectContext];
        //NSLog(@"insertNewObjectTomanagedObjectContext obj:%@",obj);
        return  obj;
    }
    else{
        //缓存数据失败
        NSLog(@"insertNewObjectTomanagedObjectContext 缓存数据失败");
        return nil;
    }
}
-(NSObject *)insertNewObjectTomanagedObjectContextN:(NSString *)name{
    if (self.managedObjectContext != nil) {
        NSObject *obj= [NSEntityDescription insertNewObjectForEntityForName:name inManagedObjectContext:self.managedObjectContext];
        //NSLog(@"insertNewObjectTomanagedObjectContext obj:%@",obj);
        return  obj;
    }
    else{
        //缓存数据失败
        NSLog(@"insertNewObjectTomanagedObjectContext 缓存数据失败");
        return nil;
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
#ifdef MYDEBUG
	NSLog(@"XMLParser Error:%@[%d][%@]", [parseError localizedDescription], [parseError code], self);
#endif
	
	//回调错误
	[self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_DataFormatErrorStatus];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	NSLog(@"foundCharacters:%@",string);
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock {
	NSString *subject = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
    //NSLog(@"11subject:%@",subject);
    [subject release];
}



- (NSInteger)fetchLimitWithGETDDataKind:(GET_DataKind)getDataKind {
	if (getDataKind == GET_DataKind_Refresh) {
		return 20;
	} else if (getDataKind == GET_DataKind_Next){
		return [self.objectList count] + 20;
	}
    else if(getDataKind == GET_DataKind_Unlimited){
        return 0;
    }
    return  0;
}

-(void)baseXMLParserComplete:(FSBaseDAO *)sender{
    [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_SuccessfulStatus];
    
}

- (void)executeFetchRequest:(NSFetchRequest *)request {
	NSError *error = nil;
	NSArray *resultSet = [self.managedObjectContext executeFetchRequest:request error:&error];
	if (!error) {
		NSMutableArray *tempResultSet = [[NSMutableArray alloc] initWithArray:resultSet];
		self.objectList = tempResultSet;
		self.isRecordListTail = [self.objectList count] < [self.fetchRequest fetchLimit];
		[tempResultSet release];
	}
}

- (void)operateOldBufferData {
	if (self.currentGetDataKind == GET_DataKind_Refresh) {
		NSArray *resultSets = self.objectList;
		if ([resultSets count] > 0) {
#ifdef MYDEBUG
			NSLog(@"resultSets:%@", resultSets);
#endif
			for (id entityObject in resultSets) {
#ifdef MYDEBUG
				NSLog(@"entityObject:%@", entityObject);
#endif
                if (![entityObject isDeleted]) {
                    [self.managedObjectContext deleteObject:entityObject];
                    
                }
			}
            NSLog(@"%@",@"operateOldBufferData");
			[self saveCoreDataContext];
		}
	}
}


@end
