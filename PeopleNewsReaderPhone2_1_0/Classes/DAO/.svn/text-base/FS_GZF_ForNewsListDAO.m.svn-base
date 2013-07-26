//
//  FS_GZF_ForNewsListDAO.m
//  PeopleNewsReaderPhone
//
//  Created by Xu dandan on 12-11-5.
//
//

#import "FS_GZF_ForNewsListDAO.h"
#import "FSOneDayNewsObject.h"

//#define FS_NEWS_URL @"http://mobile.app.people.com.cn:81/news2/news.php?act=dailylist&channelid=4_7,1_6,1_11,1_8,1_20&rt=xml&count=%d&timestamp=%@"


#define FS_NEWS_URL @"http://mobile.app.people.com.cn:81/news2/news.php?act=channelnewslist&rt=xml&channelid=%@&count=%d&maxid=%@"

#define FS_NEWS_PAGECOUNT 20


@implementation FS_GZF_ForNewsListDAO

@synthesize channelid = _channelid;


- (id)init {
	self = [super init];
	if (self) {
		_count = 1;
        self.getNextOnline = YES;
	}
    
	return self;
}

- (void)dealloc {
	
	[super dealloc];
}
  
- (NSString *)readDataURLStringFromRemoteHostWithGETDataKind:(GET_DataKind)getDataKind {
    
	if (getDataKind == GET_DataKind_Refresh) {
        _count = 1;
        NSLog(@"%@",[NSString stringWithFormat:FS_NEWS_URL, self.channelid, FS_NEWS_PAGECOUNT,@""]);
		return [NSString stringWithFormat:FS_NEWS_URL, self.channelid, FS_NEWS_PAGECOUNT,@""];
	} else {
        _count =_count +1;
        
        return [NSString stringWithFormat:FS_NEWS_URL,  self.channelid, FS_NEWS_PAGECOUNT,self.lastid];
	}
}

- (NSTimeInterval)bufferDataExpireTimeInterval {
	return 60*8;
}

//查询数据
- (NSString *)predicateStringWithQueryDataKind:(Query_DataKind)dataKind {
    return [NSString stringWithFormat:@"group='%@' AND bufferFlag!='3'", [self getGroupName]];
	
}

- (NSInteger)fetchLimitWithGETDDataKind:(GET_DataKind)getDataKind {
	if (getDataKind == GET_DataKind_Refresh) {
		return FS_NEWS_PAGECOUNT;
	} else {
		return [self.objectList count] + FS_NEWS_PAGECOUNT;
	}
}

- (NSString *)entityName {
	return @"FSOneDayNewsObject";
}

- (NSString *)timestampFlag {
    return [NSString stringWithFormat:@"FSOneDayNewsObject_%@",self.channelid];
}

-(NSString *)getGroupName{
    NSString *string = [NSString stringWithFormat:@"FSOneDayNewsObject_%@",self.channelid];
    //NSLog(@"string :%@",string);
    return string;
}


- (void)initializeSortDescriptions:(NSMutableArray *)descriptions {
    
    [self addSortDescription:descriptions withSortFieldName:@"order" withAscending:YES];
    
    return;
    if ([self.channelid isEqualToString:@"1_0"]) {
        //NSLog(@"111111111");
        [self addSortDescription:descriptions withSortFieldName:@"order" withAscending:YES];
    }
    else{
        [self addSortDescription:descriptions withSortFieldName:@"timestamp" withAscending:NO];
    }
	;//[self addSortDescription:descriptions withSortFieldName:@"timestamp" withAscending:NO];
}



//******************************************************************************************



//- (void)executeFetchRequest:(NSFetchRequest *)request {
//	NSError *error = nil;
//	NSArray *resultSet = [self.managedObjectContext executeFetchRequest:request error:&error];
//	if (!error) {
//        
//		if ([resultSet count]>0) {
//            
//            NSMutableArray *tempResultSet = [[NSMutableArray alloc] init];
//            
//            for (FSOneDayNewsObject *o in resultSet) {
//                //NSLog(@"executeFetchRequesto:%@",o);
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
//                
//            }
//            self.objectList = (NSMutableArray *)tempResultSet;
//            self.isRecordListTail = [self.objectList count] < [self.fetchRequest fetchLimit];
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
//            NSArray *array = [[FSBaseDB sharedFSBaseDB] getObjectsByKeyWithName:[self entityName] key:@"group" value:[self getGroupName]];
//            for (FSOneDayNewsObject *o in array) {
//                if ([o.bufferFlag isEqualToString:@"3"]) {
//                    [self.managedObjectContext deleteObject:o];
//                    
//                }
//            }
//            [self saveCoreDataContext];
//            
//        }
//	}
//}



//- (void)executeFetchRequest:(NSFetchRequest *)request {
//	NSError *error = nil;
//	NSArray *resultSet = [self.managedObjectContext executeFetchRequest:request error:&error];
//	if (!error) {
//		NSMutableArray *tempResultSet = [[NSMutableArray alloc] initWithArray:resultSet];
//		self.objectList = (NSMutableArray *)tempResultSet;
//        NSLog(@"executeFetchRequest objectList:%d",[self.objectList count]);
//		self.isRecordListTail = [self.objectList count] < [self.fetchRequest fetchLimit];
//		[tempResultSet release];
//	}
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
//            for (FSOneDayNewsObject *entityObject in resultSets) {
//#ifdef MYDEBUG
//                //NSLog(@"entityObject");
//#endif
//                
//                if (entityObject == nil) {
//                    continue;
//                }
//                if ([entityObject.group isEqualToString:PUTONG_NEWS_LIST_KIND]) {
//                    if (![entityObject isDeleted]) {
//                        [self.managedObjectContext deleteObject:entityObject];
//                    }
//                }
//            }
//            //[_objectList removeAllObjects];
//            [self saveCoreDataContext];
//		}
//	}
//}


@end
