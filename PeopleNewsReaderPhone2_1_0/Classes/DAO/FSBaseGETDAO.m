//
//  FSBaseGETDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-7.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSBaseGETDAO.h"


@interface FSBaseGETDAO(PrivateMethod)
- (BOOL)isExpireData;
@end


@implementation FSBaseGETDAO
@synthesize isRecordListTail = _isRecordListTail;
@synthesize currentGetDataKind = _currentGetDataKind;
@synthesize lastGetDataTimestamp = _lastGetDataTimestamp;
@synthesize netowkDataTimestamp = _netowkDataTimestamp;

- (id)init {
	self = [super init];
	if (self) {
        _networkDataTimestamp = 0;
		_lastGetDataTimestamp = 0;//从未取过
		NSString *lastUpdateDesc = [self lastUpdateTimestampPredicateValue];
		if (lastUpdateDesc != nil) {
			FSLastUpdateTimestampObject *lastUpdateObj = [[FSLastUpdateTimestampObject alloc] initWithContext:self.managedObjectContext];
			_lastGetDataTimestamp = [lastUpdateObj readLastUpdateTimestamp:lastUpdateDesc];
			[lastUpdateObj release];
		}
	}
	return self;
}

- (void)dealloc {
	[super dealloc];
}

- (NSTimeInterval)bufferDataExpireTimeInterval {
	return 60 * 60;
}

- (BufferDataKind)isExistsBufferData {
	BufferDataKind result = BufferDataKind_None;
	
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
			NSString *newDataPredicateString = [self predicateStringWithQueryDataKind:QueryDataKind_New];
			if (newDataPredicateString == nil) {
				result = [self isExpireData] ? BufferDataKind_Expire : BufferDataKind_New;
			} else {
				[request setPredicate:[NSPredicate predicateWithFormat:newDataPredicateString]];
				NSInteger newRecordCount = [self.managedObjectContext countForFetchRequest:request error:&error];
				if (error) {
#ifdef MYDEBUG
					NSLog(@"表中有多少新记录,最后一次缓存的记录。错误");
#endif					
				} else {
					if (newRecordCount > 0) {
						result = [self isExpireData] ? BufferDataKind_Expire : BufferDataKind_New;
					} else {
						result = BufferDataKind_Expire;
					}
				}
			}
		}
	}
	return result;
}

- (BOOL)isExpireData {
	BOOL result = YES;
	
	if (_lastGetDataTimestamp == 0) {
		
	} else {
		NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
		NSTimeInterval currentTimeInterval = [date timeIntervalSince1970];
		if (currentTimeInterval - _lastGetDataTimestamp > [self bufferDataExpireTimeInterval]) {
			result = YES;
		} else {
			result = NO;
		}
		
		[date release];
	}
	
	return result;
}

- (void)HTTPGetDataWithKind:(GETDataKind)httpGetDataKind {
	
	if (httpGetDataKind == GETDataKind_Refresh) {
		self.isRecordListTail = NO;
	}
	
	if (httpGetDataKind != GETDataKind_Refresh && self.isRecordListTail) {
		return;
	}
	
	_currentGetDataKind = httpGetDataKind;
	
	dispatch_queue_t queue = dispatch_queue_create(NULL, NULL);
	dispatch_async(queue, ^(void) {
		if (httpGetDataKind == GETDataKind_Refresh) {
			//刷新的场合
			BufferDataKind bufferDataKind = [self isExistsBufferData];
			//先取缓存数据表示在UI上
			if (bufferDataKind != BufferDataKind_None) {
				QueryDataKind dataKind = bufferDataKind == BufferDataKind_New ? QueryDataKind_New : QueryDataKind_Expire;
				[self readDataFromBufferWithQueryDataKind:dataKind];
				[self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_BufferSuccessfulStatus];
			}
			
			if (!checkNetworkIsValid()) {
				[self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_NetworkErrorStatus];
			} else {
				if (bufferDataKind == BufferDataKind_None || bufferDataKind == BufferDataKind_Expire) {
					//从网络取数据
					[self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_WorkingStatus];
					NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
					
					NSString *httpGetURLString = [self readDataURLStringFromRemoteHostWithGETDataKind:httpGetDataKind];
					
					[FSHTTPGetWebData HTTPGETDataWithURLString:httpGetURLString withDelegate:self];
					
					[pool release];
				}
			}
		} else {
			//取下一批数据的场合
			if (!checkNetworkIsValid()) {
				[self readDataFromBufferWithQueryDataKind:QueryDataKind_Expire];
			} else {
				[self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_WorkingStatus];
				NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
				
				NSString *httpGetURLString = [self readDataURLStringFromRemoteHostWithGETDataKind:httpGetDataKind];
				
				[FSHTTPGetWebData HTTPGETDataWithURLString:httpGetURLString withDelegate:self];
				
				[pool release];
			}
		}
	});
	dispatch_release(queue);
}


//需要覆盖的两个类

- (void)readDataFromBufferWithQueryDataKind:(QueryDataKind)dataKind {
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
	[self.fetchRequest setFetchLimit:[self fetchLimitWithGETDDataKind:self.currentGetDataKind]];
	
	//STEP 5.取数据以及做些其他类型的工作
	[self executeFetchRequest:self.fetchRequest];
	
	
	[entity release];
	//[pool release];
}

- (void)executeFetchRequest:(NSFetchRequest *)request {

}

- (NSInteger)fetchLimitWithGETDDataKind:(GETDataKind)getDataKind {
	return 1;
}

- (NSString *)entityName {
	return nil;
}

- (NSString *)predicateStringWithQueryDataKind:(QueryDataKind)dataKind {
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

- (NSString *)readDataURLStringFromRemoteHostWithGETDataKind:(GETDataKind)getDataKind {
	return nil;
}

- (NSString *)lastUpdateTimestampPredicateValue {
	return nil;
}

- (void)operateOldBufferData {
}

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

@end
