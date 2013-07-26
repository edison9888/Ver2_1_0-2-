//
//  FS_GZT_BaceGETDAO.m
//  PeopleNewsReaderPhone
//
//  Created by Xu dandan on 12-10-19.
//
//

#import "FS_GZT_BaceGETDAO.h"
#import "GlobalConfig.h"


#define TOPICLIST_TIMESTAMP_URL @"http://mobile.app.people.com.cn:81/news2/topic.php?act=list&rt=xml&type=timestamp"

@interface FS_GZT_BaceGETDAO(PrivateMethod)
- (BOOL)isExpireData;
@end


@implementation FS_GZT_BaceGETDAO

@synthesize isRecordListTail = _isRecordListTail;
@synthesize currentGetDataKind = _currentGetDataKind;
@synthesize lastGetDataTimestamp = _lastGetDataTimestamp;
//@synthesize timestampObject = _timestampObject;
@synthesize currentElementName = _currentElementName;
@synthesize getNextOnline =_getNextOnline;
@synthesize isGettingList = _isGettingList;

- (id)init {
	self = [super init];
	if (self) {
		NSString *flag = [self timestampFlag];
        if (flag != nil && ![flag isEqualToString:@""]) {
            //_timestampObject = [[FSDataTimestampObject alloc] initWithFlagValue:flag];
            _isRefreshToDeleteOldData = NO;
            self.getNextOnline = YES;
            _isGettingList = NO;
        }
	}
	return self;
}

- (void)dealloc {
    //[_timestampObject release];
	[super dealloc];
}

-(NSString *)timestampFlag{
    return  @"";
}

- (NSTimeInterval)bufferDataExpireTimeInterval {
	return 60 * 10;
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
                    
					if (newRecordCount > 0) {
						result = [self isExpireData] ? Buffer_DataKind_Expire : Buffer_DataKind_New;
					} else {
						result = Buffer_DataKind_Expire;
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


- (void)HTTPGetDataWithKind:(GET_DataKind)httpGetDataKind {
	 
    if (httpGetDataKind!=GET_DataKind_Next && self.managedObjectContext == nil) { //by zhiliang check self.managedobjectcontext not nil  
        NSLog(@"self.ManagedObjectContext:%@",self.managedObjectContext);
        self.managedObjectContext = [[GlobalConfig shareConfig] newManagedObjectContext];
    }
    
    
    _isRefreshToDeleteOldData = NO;
    _isRefreshNewDataSuccess = NO;
//    NSLog(@"1111");
//	if (httpGetDataKind == GET_DataKind_Refresh || httpGetDataKind == GET_DataKind_Unlimited || httpGetDataKind==GET_DataKind_ForceRefresh) {
//		self.isRecordListTail = NO;
//	}
//	
//	if (httpGetDataKind != GET_DataKind_Refresh && self.isRecordListTail) {
//        
//		return;
//	}
    
	_currentGetDataKind = httpGetDataKind;
    
    [self getTimestampWithURL:TOPICLIST_TIMESTAMP_URL flag:[self timestampFlag] networkRequestInterval:60*30];
    
    
    Buffer_DataKind bufferDataKind = [self isExistsBufferData];
    
    //先取缓存数据表示在UI上
    if (bufferDataKind != Buffer_DataKind_None) {
        
        Query_DataKind dataKind = bufferDataKind == Buffer_DataKind_New ? Query_DataKind_New : Query_DataKind_Expire;
        
        
        if (bufferDataKind == Buffer_DataKind_New && httpGetDataKind != GET_DataKind_Next && httpGetDataKind != GET_DataKind_ForceRefresh) {
            //NSLog(@"读取缓存数据1");
            [self readDataFromBufferWithQueryDataKind:dataKind];
            //NSLog(@"读取缓存数据11");
            [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_SuccessfulStatus];
            //NSLog(@"读取缓存数据1111");
            if (!checkNetworkIsValid()) {
                [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_NetworkErrorStatus];
                return;
            }
            return;
        }
        
        if (self.getNextOnline == NO && httpGetDataKind == GET_DataKind_Next) {
            
            //NSLog(@"读取缓存数据2");
            [self readDataFromBufferWithQueryDataKind:dataKind];
            [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_SuccessfulStatus];
            return;
        }
        //NSLog(@"读取缓存数据3");
        
        if (httpGetDataKind != GET_DataKind_Next) {
            _isRefreshToDeleteOldData = YES;
            [self readDataFromBufferWithQueryDataKind:dataKind];
            [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_BufferSuccessfulStatus];
            
        }
    }
   
    //Timestamp_DataKind tdkind = [self getTimestampWithURL:TOPICLIST_TIMESTAMP_URL flag:[self timestampFlag] networkRequestInterval:60*30];
    
    
    if (httpGetDataKind == GET_DataKind_ForceRefresh) {
        //NSLog(@"GET_DataKind_ForceRefresh");
        //tdkind = Timestamp_DataKind_request;
        httpGetDataKind = GET_DataKind_Refresh;
    }
    else{
        /*
        if (tdkind != Timestamp_DataKind_request && httpGetDataKind != GET_DataKind_Next) {
            NSLog(@"不请求数据，使用缓存");
            [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_SuccessfulStatus];
            return;
        }
         */
    }
    
    if (!checkNetworkIsValid()) {
        //
        _isRefreshToDeleteOldData = NO;
        [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_NetworkErrorStatus];
        [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_SuccessfulStatus];
        return;
    }
   
	dispatch_queue_t queue = dispatch_queue_create(NULL, NULL);

	dispatch_async(queue, ^(void) {
         
        if (httpGetDataKind == GET_DataKind_Unlimited) {
                 
            [self GETdata:GET_DataKind_Refresh];
        }
        else{
            [self GETdata:httpGetDataKind];
        }
    
	});
	dispatch_release(queue);
}



-(void)GETdata:(GET_DataKind)httpGetDataKind{

      if(httpGetDataKind == GET_DataKind_Refresh) {
            //开始从网络取数据
            //NSLog(@"开始从网络取数据");
          if (self.isGettingList) {
              [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_ListWorkingStatus];
          }
          else{
              [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_WorkingStatus];
          }
            
            NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
            
            NSString *httpGetURLString = [self readDataURLStringFromRemoteHostWithGETDataKind:httpGetDataKind];
                    
            [FSHTTPGetWebData HTTPGETDataWithURLString:httpGetURLString withDelegate:self];
             //NSLog(@"GettingURL:%@",httpGetURLString);

            [pool release];
        }
        else{
            if (httpGetDataKind == GET_DataKind_Next) {
                //NSLog(@"开始next从网络取数据");
                if (self.isGettingList) {
                    [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_ListWorkingStatus];
                }
                else{
                    [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_WorkingStatus];
                }
                NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
                
                NSString *httpGetURLString = [self readDataURLStringFromRemoteHostWithGETDataKind:httpGetDataKind];
                             
                [FSHTTPGetWebData HTTPGETDataWithURLString:httpGetURLString withDelegate:self];
                //NSLog(@"GettingURL:%@",httpGetURLString);

                [pool release];
            }
            else{
                ;
            }
        }

   
}


//需要覆盖的两个类

- (void)readDataFromBufferWithQueryDataKind:(Query_DataKind)dataKind {
   
	//NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	if (self.fetchRequest == nil) {
		NSFetchRequest *request = [[NSFetchRequest alloc] init];
		self.fetchRequest = request;
		[request release];
	}
	
	//STEP 1.实体
	NSEntityDescription *entity = [[NSEntityDescription alloc] init];
	[entity setName:[self entityName]];
	[self.fetchRequest setEntity:entity];
	
	
	//STEP 2.排序
	NSMutableArray *sortDescriptions = [[NSMutableArray alloc] init];
	[self initializeSortDescriptions:sortDescriptions];
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
	[self executeFetchRequest:self.fetchRequest];
	
	
	[entity release];
	//[pool release];
}

- (void)executeFetchRequest:(NSFetchRequest *)request {
    
}

- (NSInteger)fetchLimitWithGETDDataKind:(GET_DataKind)getDataKind {
	return 0;
}

- (NSString *)entityName {
	return nil;
}

- (NSString *)predicateStringWithQueryDataKind:(Query_DataKind)dataKind {
	//********************************************************
	//		返回查询条件，根据buffer类型新的，还是过期的
	//
	//********************************************************
	return  nil;
}

- (void)initializeSortDescriptions:(NSMutableArray *)descriptions {
	//********************************************************
	//		Sample
	//		[self addSortFieldName:@"" withAscending:YES];
	//********************************************************
}

- (void)addSortDescription:(NSMutableArray *)descriptions withSortFieldName:(NSString *)fieldName withAscending:(BOOL)ascending {
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:fieldName ascending:ascending];
	[descriptions addObject:sortDescriptor];
	[sortDescriptor release];
}

- (NSString *)readDataURLStringFromRemoteHostWithGETDataKind:(GET_DataKind)getDataKind {
	return nil;
}


-(void)baseXMLParserComplete:(FSBaseDAO *)sender{
    
}

-(void)operateOldBufferDataDelate{
//    NSString *qcname = [NSString stringWithFormat:@"cn.com.people.operateOldBufferData%d",arc4random()];
//	dispatch_queue_t queue = dispatch_queue_create( [qcname cStringUsingEncoding:NSASCIIStringEncoding], NULL);
//    
//	dispatch_async(queue, ^(void) {
//        [self operateOldBufferData];
//	});
//	dispatch_release(queue);
}

- (void)operateOldBufferData {
}

-(void)setBufferFlag{
    
}

-(void)setBufferFlag3{
    
}

/*
- (void)fsStoreInCoreData:(FSStoreInCoreDataObject *)sender successful:(BOOL)successful {
	if (successful) {
		NSString *lastUpdateDesc = [self lastUpdateTimestampPredicateValue];
		if (lastUpdateDesc != nil) {
			NSDate *currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
			_lastGetDataTimestamp = [currentDate timeIntervalSince1970];
			FSLastUpdateTimestampObject *lastUpdateObject = [[FSLastUpdateTimestampObject alloc] initWithContext:self.managedObjectContext];
			[lastUpdateObject writeLastUpdateTimestamp:lastUpdateDesc timestamp:_lastGetDataTimestamp];
			[lastUpdateObject release];
#ifdef MYDEBUG
			NSLog(@"%@.fsStoreInCoreData.writeLastUpdateTimestamp", self);
#endif
			[currentDate release];
		}
	}
}
 */

@end
