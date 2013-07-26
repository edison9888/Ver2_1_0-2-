//
//  FS_GZF_BaseNetworkDAO.m
//  PeopleNewsReaderPhone
//
//  Created by Xu dandan on 12-10-19.
//
//

#import "FS_GZF_BaseNetworkDAO.h"
#import <zlib.h>
#import "FSCommonFunction.h"
#import "FSTimestamps.h"
#import "FS_GZF_TimestampDAO.h"


#define FSTIMESTAMPS @"FSTimestamps"


#define COREDATA_MODEL_EXTENSION_STRING @"momd"
#define COREDATA_LOCALSTORE_EXTENSION_STRING @".sqlite"

@interface FS_GZF_BaseNetworkDAO(PrivateMethod)
- (void)exitNonMainThread;
- (void)interruptURLConnection;
- (NSURL *)applicationCachesDirectory;
@end

@implementation FS_GZF_BaseNetworkDAO

@synthesize dataBuffer = _dataBuffer;

@synthesize managedObjectContext = _managedObjectContext;
@synthesize fetchRequest = _fetchRequest;

@synthesize localtimestamp = _localtimestamp;
@synthesize netTimestamp = _netTimestamp;
@synthesize Timestamp = _Timestamp;



- (id)init {
	self = [super init];
	if (self) {
		//self.managedObjectContext = [[GlobalConfig shareConfig] getApplicationManagedObjectContext];
        self.managedObjectContext = [[GlobalConfig shareConfig] newManagedObjectContext];
        if (self.managedObjectContext == nil) {
            self.managedObjectContext = [[GlobalConfig shareConfig] newManagedObjectContext];
        }
	}
	return self;
}

- (void)dealloc {
	[_dataBuffer release];
	
	[_managedObjectContext release];
	[_fetchRequest release];
	[super dealloc];
}

- (void)doSomethingInDataReceiveComplete{
	
}

- (BOOL)saveCoreDataContext {
	BOOL result = NO;
    if (self.managedObjectContext != nil) {
		NSError *error = nil;
        if ([self.managedObjectContext hasChanges] && ![self saveCoreDataContextSynchronized:&error]) { //by zhiliang
#ifdef MYDEBUG
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
#endif
			[self doSomethingInSaveCoreDataContextError:error];
        } else {
			result = YES;
		}
    }
	return result;
}
//added by zhiliang
- (BOOL)saveCoreDataContextSynchronized:(NSError**) error{
   
        //NSLog(@"--------------------MOC Start to Save----------%d",[NSThread isMainThread]);
        BOOL res = [self.managedObjectContext save:error];
        //NSLog(@"--------------------MOC Finish to Save---------%d",[NSThread isMainThread]);
        return res;
    
}


- (void)doSomethingInSaveCoreDataContextError:(NSError *)error {
    //	[self.managedObjectContext undo];
    //	[self.managedObjectContext rollback];
}


- (void)inner_InitializeDataTimestamp:(NSString *)flag {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [[NSEntityDescription alloc] init];
    [entity setName:FSTIMESTAMPS];
    [request setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"flag=%@", flag];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *resultSet = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (!error) {
        //NSLog(@"resultSet :%d :%@",[resultSet count],flag);
        if ([resultSet count] > 0) {
            FSTimestamps *o = [resultSet objectAtIndex:0];
            //NSLog(@"FSTimestamps:%@  :%@",o,flag);
            self.localtimestamp = [o.localtimestamp doubleValue];
            self.netTimestamp = [o.networktimestamp doubleValue];
        }
        else{
            self.localtimestamp = 0;
            self.netTimestamp = 0;
        }
    } else {
        self.localtimestamp = 0;
        self.netTimestamp = 0;
    }
    
    [entity release];
    [request release];
}


-(Timestamp_DataKind)getTimestampWithURL:(NSString *)URL flag:(NSString *)flag networkRequestInterval:(double)Interval{
    
    [self inner_InitializeDataTimestamp:flag];
    
    return Timestamp_DataKind_errer;
    
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:0.0f];
    NSTimeInterval curTimeIntevalNow = [date timeIntervalSince1970];
    [date release];
    
    
    if (curTimeIntevalNow-self.localtimestamp <= Interval) {
        NSLog(@"刷新时间间隔过短，不需请求网络数据:%@",flag);
        return Timestamp_DataKind_notrequest;//刷新时间间隔过短，不需请求网络数据
    }
    
    FS_GZF_TimestampDAO *dao = [[FS_GZF_TimestampDAO alloc] init];
    [dao getTimestampWithURL:URL];
    if (dao.Timestamp) {
        self.Timestamp = dao.Timestamp;
    }
    //NSLog(@"_Timestamp:%f  _netTimestamp:%f",_Timestamp,_netTimestamp);
    if (self.Timestamp>self.netTimestamp || self.netTimestamp == 0) {
        //NSLog(@"刷新数据");
        return Timestamp_DataKind_request;
    }
    else{
         //NSLog(@"已经是最新数据，不请求网络数据:");
        return Timestamp_DataKind_notrequest;
    }
    [dao release];
    return Timestamp_DataKind_errer;
}

-(void)updataTimestamp:(NSString *)flag{
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [[NSEntityDescription alloc] init];
    [entity setName:FSTIMESTAMPS];
    [request setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"flag=%@", flag];
    [request setPredicate:predicate];
    NSError *error = nil;
    //NSLog(@"updataTimestamp:%@",flag);
    NSArray *resultSet = [self.managedObjectContext executeFetchRequest:request error:&error];
    //NSLog(@"updataTimestamp:%@",flag);
    if (!error) {
       
        if ([resultSet count]>0) {
            FSTimestamps *o = [resultSet objectAtIndex:0];
            //NSLog(@"FSTimestamps1:%@",o);
            NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:0.0f];
            NSNumber *curTimestamp = [[NSNumber alloc] initWithDouble:[date timeIntervalSince1970]];
            o.localtimestamp = curTimestamp;
            NSNumber *netTimestamp = [[NSNumber alloc] initWithDouble:_Timestamp];
            o.networktimestamp = netTimestamp;
            [curTimestamp release];
            [netTimestamp release];
            [date release];
            //NSLog(@"FSTimestamps1:%@",o);
        }
        else{
            
            FSTimestamps *o = [NSEntityDescription insertNewObjectForEntityForName:FSTIMESTAMPS inManagedObjectContext:self.managedObjectContext];
            //NSLog(@"FSTimestamps2:%@",o);
            o.flag = flag;
            NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:0.0f];
            NSNumber *curTimestamp = [[NSNumber alloc] initWithDouble:[date timeIntervalSince1970]];
            o.localtimestamp = curTimestamp;
            NSNumber *netTimestamp = [[NSNumber alloc] initWithDouble:_Timestamp];
            o.networktimestamp = netTimestamp;
            [curTimestamp release];
            [netTimestamp release];
            [date release];
            //NSLog(@"FSTimestamps2:%@",o);
        }
        
    }else{
        NSLog(@"FSTimestamps:error");
    }
    //NSLog(@"MOC:updataTimestamp:%@",self);
    [self saveCoreDataContext];
    [request release];
    [entity release];
}


#pragma mark -
#pragma mark FSHTTPWebDataDelegate
- (void)fsHTTPWebDataDidFinished:(FSHTTPWebData *)sender withData:(NSData *)data {
	NSData *tempData = [[NSData alloc] initWithData:data];
	self.dataBuffer = data;
	[tempData release];
//	dispatch_queue_t queue = dispatch_queue_create(NULL, NULL);
//	dispatch_async(queue, ^(void) {
//		
//	});
//	dispatch_release(queue);
    //NSLog(@"call doSomethingInDataReceiveComplete before");
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        
//    });
    [self doSomethingInDataReceiveComplete];
//	[self release];
}

- (void)fsHTTPWebDataStart:(FSHTTPWebData *)sender withTotalBytes:(long long)totalBytes {
	[self executeCallBackDelegateSyncBegin:totalBytes];
//    [self retain];
}

- (void)fsHTTPWebDataProgress:(FSHTTPWebData *)sender withCurrentBytes:(long long)currentBytes {
	[self executeCallBackDelegateSyncProgress:currentBytes];
}

- (void)fsHTTPWebDataDidFail:(FSHTTPWebData *)sender withError:(NSError *)error {
//	dispatch_queue_t queue = dispatch_queue_create(NULL, NULL);
//	dispatch_async(queue, ^(void) {
//		if (checkNetworkIsValid()) {
//			[self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_HostErrorStatus];
//		} else {
//			[self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_NetworkErrorStatus];
//		}
//	});
//	dispatch_release(queue);
    NSLog(@"%@",error);
    if (checkNetworkIsValid()) {
        [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_HostErrorStatus];
    } else {
        [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_NetworkErrorStatus];
        //[self release];
    }
    
}

@end
