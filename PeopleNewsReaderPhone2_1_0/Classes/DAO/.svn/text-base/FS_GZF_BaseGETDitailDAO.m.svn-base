//
//  FS_GZF_BaseGETDitailDAO.m
//  PeopleNewsReaderPhone
//
//  Created by Xu dandan on 12-10-26.
//
//

#import "FS_GZF_BaseGETDitailDAO.h"

@implementation FS_GZF_BaseGETDitailDAO


- (id)init {
	self = [super init];
	if (self) {
		//_objectList = [[NSMutableArray alloc] init];
        _isRefreshToDeleteOldData = NO;
	}
	return self;
}

- (void)dealloc {
    //[_objectList release];
	[super dealloc];
}

-(NSString *)getnewsid{
    return nil;
}

-(NSString *)entityName{
    return @"FSNewsDitailObject";
}


-(NSString *)PicEntityName{
    return @"FSNewsDitailPicObject";
}

-(void)PicinitializeSortDescriptions:(NSMutableArray *)sortDescriptions{
    ;
}


- (Buffer_DataKind)isExistsBufferData {
	Buffer_DataKind result = Buffer_DataKind_None;
	
	//STEP 1.
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	
	//STEP 2.
	NSEntityDescription *entity = [[NSEntityDescription alloc] init];
	[entity setName:[self entityName]];
	[request setEntity:entity];
	
	//STEP 3.
	NSError *error = nil;
    
	NSInteger recordCount = [self.managedObjectContext countForFetchRequest:request error:&error];
	//NSLog(@"isExistsBufferData22222");
	if (error) {
#ifdef MYDEBUG
		NSLog(@"表中有多少记录,最后一次缓存的记录。错误");
#endif
	} else {
        
		if (recordCount > 0) {
			//有缓存数据，包括过期或者新的
            
			NSString *newDataPredicateString = [self predicateStringWithQueryDataKind:Query_DataKind_New];
			if (newDataPredicateString == nil) {
                
				result = [self isExpireData] ? Buffer_DataKind_Expire : Buffer_DataKind_New;
                
			} else {
                
				[request setPredicate:[NSPredicate predicateWithFormat:newDataPredicateString]];
				NSInteger newRecordCount = [self.managedObjectContext countForFetchRequest:request error:&error];
				
                if (error) {
#ifdef MYDEBUG
					NSLog(@"表中有多少新记录,最后一次缓存的记录。错误");
#endif
				} else {
                    //NSLog(@"newRecordCount:%d",newRecordCount);
					if (newRecordCount > 0) {
						result = [self isExpireData] ? Buffer_DataKind_Expire : Buffer_DataKind_New;
					} else {
						result = Buffer_DataKind_None;
					}
				}
			}
		}
	}
    
    [entity release];
    [request release];
	return result;
}

- (BOOL)isExpireData {
	BOOL result = YES;
	
	if (self.localtimestamp == 0) {
        ;
		//NSDate *currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
        //_lastGetDataTimestamp = [currentDate timeIntervalSince1970];
	} else {
		NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
		NSTimeInterval currentTimeInterval = [date timeIntervalSince1970];
        //NSLog(@"self.localtimestamp:%d",self.localtimestamp);
		if (currentTimeInterval - self.localtimestamp > [self bufferDataExpireTimeInterval]) {
			result = YES;
		} else {
            NSLog(@"刷新时间间隔过短，不需请求网络数据:");
			result = NO;
		}
		
		[date release];
	}
	
	return result;
}


-(void)HTTPGetDataWithKind:(GET_DataKind)httpGetDataKind{
    
    self.managedObjectContext = [[GlobalConfig shareConfig] newManagedObjectContext];
    _isRefreshToDeleteOldData = NO;
    _isRefreshNewDataSuccess = NO;
    [self getTimestampWithURL:@"" flag:[self timestampFlag] networkRequestInterval:60*30];
    
    Buffer_DataKind bufferDataKind = [self isExistsBufferData];
    //先取缓存数据表示在UI上
    if (bufferDataKind != Buffer_DataKind_None) {
        Query_DataKind dataKind = bufferDataKind == Buffer_DataKind_New ? Query_DataKind_New : Query_DataKind_Expire;
        
        
        //[self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_BufferSuccessfulStatus];
        if (bufferDataKind == Buffer_DataKind_New) {
            NSLog(@"缓存数据");
            [self readDataFromBufferWithQueryDataKind:dataKind];
            [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_SuccessfulStatus];
            //[self performSelectorOnMainThread:@selector(readBuffer_CallBackScreen:) withObject:@"FSBaseDAOCallBack_SuccessfulStatus" waitUntilDone:YES];
            return;
        }
        else{
            if (!checkNetworkIsValid()) {
                [self performSelectorOnMainThread:@selector(readBuffer_CallBackScreen:) withObject:@"FSBaseDAOCallBack_NetworkErrorStatus" waitUntilDone:[NSThread isMainThread]];
                //[self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_NetworkErrorStatus];
            } else {
                _isRefreshToDeleteOldData = YES;
                [self readDataFromBufferWithQueryDataKind:dataKind];
                [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_BufferSuccessfulStatus];
                //[self performSelectorOnMainThread:@selector(readBuffer_CallBackScreen:) withObject:@"FSBaseDAOCallBack_BufferSuccessfulStatus" waitUntilDone:YES];
                dispatch_queue_t queue = dispatch_queue_create(NULL, NULL);
                dispatch_async(queue, ^(void) {
                    //NSLog(@"dispatch_queue_create ditaile");
                    [self GETdata:GET_DataKind_Refresh];
                });
                dispatch_release(queue);
            }
        }
    }else{
        if (!checkNetworkIsValid()) {
            [self performSelectorOnMainThread:@selector(readBuffer_CallBackScreen:) withObject:@"FSBaseDAOCallBack_NetworkErrorStatus" waitUntilDone:[NSThread isMainThread]];
            //[self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_NetworkErrorStatus];
        } else {
            
            dispatch_queue_t queue = dispatch_queue_create(NULL, NULL);
            dispatch_async(queue, ^(void) {
                //NSLog(@"dispatch_queue_create ditaile");
                [self GETdata:GET_DataKind_Refresh];
            });
            dispatch_release(queue);
            
        }
    }

}

-(void)readBuffer_CallBackScreen:(NSString *)statck{
    if ([statck isEqualToString:@"FSBaseDAOCallBack_BufferSuccessfulStatus"]) {
        [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_BufferSuccessfulStatus];
        return;
    }
    
    if ([statck isEqualToString:@"FSBaseDAOCallBack_NetworkErrorStatus"]) {
        [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_NetworkErrorStatus];
        return;
    }
    
    if ([statck isEqualToString:@"FSBaseDAOCallBack_WorkingStatus"]) {
        [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_WorkingStatus];
        return;
    }
    
    if ([statck isEqualToString:@"FSBaseDAOCallBack_SuccessfulStatus"]) {
        [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_SuccessfulStatus];
        return;
    }

}


-(void)GETdata:(GET_DataKind)httpGetDataKind{
    NSLog(@"开始从网络取数据detle");
    [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_WorkingStatus];
    //[self performSelectorOnMainThread:@selector(readBuffer_CallBackScreen:) withObject:@"FSBaseDAOCallBack_WorkingStatus" waitUntilDone:YES];
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    NSString *httpGetURLString = [self readDataURLStringFromRemoteHostWithGETDataKind:httpGetDataKind];
    
    [FSHTTPGetWebData HTTPGETDataWithURLString:httpGetURLString withDelegate:self];
    
    [pool release];
}


-(void)doSomethingInDataReceiveComplete{
    ///////////////////////////////////////////////////////////////////////////////
    
    if (self.dataBuffer==nil) {
        [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_UnknowErrorStatus];
        return;
    }
    
    if (_isRefreshToDeleteOldData==YES) {
        _isRefreshNewDataSuccess = YES;//[self setBufferFlag3];
    }
    
//#ifdef MYDEBUG
//    NSString *tempXML = [[NSString alloc] initWithData:self.dataBuffer encoding:NSUTF8StringEncoding];
//    if (tempXML == NULL) {
//        tempXML = [[NSString alloc] initWithData:self.dataBuffer encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
//    }
//    NSLog(@"Current XML\r\n:%@", trimString(tempXML));
//    [tempXML release];
//#endif
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:self.dataBuffer];
    //NSString* xml=[[NSString alloc] initWithData:self.dataBuffer encoding:NSUTF8StringEncoding]; //by zhiliang
    //NSLog(@"XMLContent:%@",xml);
    xmlParser.delegate = self;
    @try {
        if ([xmlParser parse]) {
            
 //           [self saveCoreDataContext];
            //[self baseXMLParserComplete:self];
            
            NSLog(@"inner_CallbackScreen000000:%@",[self entityName]);
            [self performSelectorOnMainThread:@selector(inner_CallbackScreenDitail) withObject:nil waitUntilDone:[NSThread isMainThread]];
        } else {
            
        }
    }
    @catch (NSException * e) {
        NSLog(@"name:%@",[self entityName]);
#ifdef MYDEBUG
        NSLog(@"NSXMLParser.ExceptionD:%@", [e reason]);
#endif
        [self performSelectorOnMainThread:@selector(errer_CallbackScreenDitail) withObject:nil waitUntilDone:[NSThread isMainThread]];
    }
    @finally {
        
    }
    
    [xmlParser release];
    
	self.dataBuffer = nil;
}

-(void)errer_CallbackScreenDitail{
    [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_DataFormatErrorStatus];
}

-(void)inner_CallbackScreenDitail{
    //NSLog(@"inner_CallbackScreen1111:%@",[self entityName]);
    //
    if (_isRefreshToDeleteOldData==YES && _isRefreshNewDataSuccess == YES) {
        [self setBufferFlag3];
    }
    [self baseXMLParserComplete:self];
    //NSLog(@"inner_CallbackScreen444444");
}


-(void)baseXMLParserComplete:(FSBaseDAO *)sender{
        
    [self updataTimestamp:[self timestampFlag]];
    [self readDataFromBufferWithQueryDataKind:Buffer_DataKind_New];
    [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_SuccessfulStatus];
    //[self operateOldBufferData];
}



-(NSObject *)insertNewObjectTomanagedObjectContext:(NSInteger)mark{
    
    NSString *entityName;
    if (mark == 0) {
        entityName = [self entityName];
    }
    else{
        entityName = [self PicEntityName];
    }
    if (self.managedObjectContext != nil) {
        NSObject *obj= [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:self.managedObjectContext];
        //NSLog(@"insertNewObjectTomanagedObjectContext obj:%@",obj);
        
        [self saveCoreDataContextSynchronized:nil];
        return  obj;
    }
    else{
        //缓存数据失败
        //NSLog(@"insertNewObjectTomanagedObjectContext 缓存数据失败");
        return nil;
    }
}


- (void)readNewsPicFromBufferWithQueryDataKind:(Query_DataKind)dataKind {
	//NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	if (self.fetchRequest == nil) {
		NSFetchRequest *request = [[NSFetchRequest alloc] init];
		self.fetchRequest = request;
		[request release];
	}
	
	//STEP 1.实体
	NSEntityDescription *entity = [[NSEntityDescription alloc] init];
	[entity setName:[self PicEntityName]];
	[self.fetchRequest setEntity:entity];
	
	
	//STEP 2.排序
	NSMutableArray *sortDescriptions = [[NSMutableArray alloc] init];
	[self PicinitializeSortDescriptions:sortDescriptions];
	if ([sortDescriptions count] > 0) {
		[self.fetchRequest setSortDescriptors:sortDescriptions];
	} else {
		[self.fetchRequest setSortDescriptors:nil];
	}
	[sortDescriptions release];
	
	//STEP 3.条件
	NSString *predicateFormat = [self predicateStringWithQueryDataKind:dataKind];
	if (predicateFormat != nil) {
		NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateFormat];
		[self.fetchRequest setPredicate:predicate];
	} else {
		[self.fetchRequest setPredicate:nil];
	}
    
	
	//STEP 4.限制记录数量
    NSInteger Limit = [self fetchLimitWithGETDDataKind:self.currentGetDataKind];
    if (Limit>0) {
        [self.fetchRequest setFetchLimit:Limit];
    }
    
	//STEP 5.取数据以及做些其他类型的工作
	[self executeFetchPicRequest:self.fetchRequest];
	
	
	[entity release];
	//[pool release];
}

-(void)executeFetchPicRequest:(NSFetchRequest *)request{
    
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


@end
