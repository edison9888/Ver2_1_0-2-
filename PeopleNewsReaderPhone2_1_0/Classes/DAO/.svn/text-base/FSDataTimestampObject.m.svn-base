//
//  FSDataTimestampObject.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-18.
//
//

#import "FSDataTimestampObject.h"
#import "FSCommonFunction.h"

#import "FSBaseDB.h"

#define FS_TIMESTAMP_NODE_NAME @"result"

#define FSTIMESTAMPS @"FSTimestamps"

@interface FSDataTimestampObject()
- (void)inner_InitializeDataTimestamp;
@end

@implementation FSDataTimestampObject
@synthesize localTimestamp = _localTimestamp;
@synthesize networkTimestamp = _networkTimestamp;
@synthesize forceRefreshRemoteData = _forceRefreshRemoteData;


- (id)initWithFlagValue:(NSString *)value {
    self = [super init];
    if (self) {
        NSLog(@"%@.init", self);
        
        /*
        _context = [[GlobalConfig shareConfig] getApplicationManagedObjectContext];
        if (_context == nil) {
            NSLog(@"1111??。。。。。");
            _context = [[GlobalConfig shareConfig] newManagedObjectContext];
        }
         */
        
        _context = [[[GlobalConfig shareConfig] newManagedObjectContext] retain];
        
        _flagValue = [value retain];
        
        [self inner_InitializeDataTimestamp];
    }
    return self;
}

- (void)dealloc {
#ifdef  MYDEBUG
    NSLog(@"%@.dealloc", self);
#endif
    [_timestampObject release];
    if (_context != nil) {
        //[_context release];
    }
    [_flagValue release];
    [super dealloc];
}

- (void)inner_InitializeDataTimestamp {
    NSLog(@"inner_InitializeDataTimestamp1");
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [[NSEntityDescription alloc] init];
    [entity setName:FSTIMESTAMPS];
    [request setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"flag='%@'", _flagValue];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSLog(@"111111:%@,:%@",_flagValue,_context);
    NSArray *array = [[FSBaseDB sharedFSBaseDB] getObjectsByKeyWithName:FSTIMESTAMPS key:@"flag" value:_flagValue];
    NSLog(@"array:%@",array);
    NSArray *resultSet = [_context executeFetchRequest:request error:&error];
    NSLog(@"222222");
    if (!error) {
        if ([resultSet count] > 0) {
            NSLog(@"33333");
            _timestampObject = [[resultSet objectAtIndex:0] retain];
            _localTimestamp = [_timestampObject.localtimestamp doubleValue];
            _networkTimestamp = [_timestampObject.networktimestamp doubleValue];
        }
    } else {
        _localTimestamp = 0;
        _networkTimestamp = 0;
    }
    
    [entity release];
    [request release];
    NSLog(@"inner_InitializeDataTimestamp2");
}

- (void)saveTimestampWithCleanOldData:(cleanOldDataFunction)cleanOldData {
    if (_timestampObject == nil) {
        _timestampObject = [[NSEntityDescription insertNewObjectForEntityForName:FSTIMESTAMPS inManagedObjectContext:_context] retain];
        _timestampObject.flag = _flagValue;
    }
    
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:0.0f];
    NSNumber *curTimestamp = [[NSNumber alloc] initWithDouble:[date timeIntervalSince1970]];
    _timestampObject.localtimestamp = curTimestamp;
    
    if ([_context hasChanges]) {
        NSError *error = nil;
        if ([_context save:&error]) {
            _localTimestamp = [curTimestamp doubleValue];
            _networkTimestamp = [_timestampObject.networktimestamp doubleValue];
            //清除无效数据
            cleanOldData(self, _context);
        }
    }
    
    [curTimestamp release];
    [date release];
}

- (void)dataTimestampWithURLString:(NSString *)urlString networkRequestInterval:(double)interval networkTimestampCompletion:(timestampCompletion)networkTimestampCompletion networkStatus:(networkStatusFunction)networkStatus {
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:0.0f];
    NSTimeInterval curTimeIntevalNow = [date timeIntervalSince1970];
    [date release];
    
    BOOL forceRefresh = NO;
    if (_forceRefreshRemoteData) {
        forceRefresh = *_forceRefreshRemoteData;
    }
    
    if (!forceRefresh && curTimeIntevalNow - _localTimestamp <= interval) {
        //时间过短，不需要请求网络
        networkTimestampCompletion(NetworkDataTimestampResult_NoRequest);
    } else {
        //时间过长可以请求网络数据
        if (_forceRefreshRemoteData) {
            *_forceRefreshRemoteData = NO;
        }
        
        
        NSURL *url = [[NSURL alloc] initWithString:urlString];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        NSError *error = nil;
        networkStatus(NetworkStatus_Working);
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        
        if (!error) {
            FSLog(@"dataTimestamp.URL:%@", urlString);
            FSLog(@"dataTimestamp.result:%@", [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease]);
            networkStatus(NetworkStatus_Success);
            __block BOOL parserSuccess = NO;
            __block BOOL needRequest = NO;
            FSStoreObject *stroeObj = [[FSStoreObject alloc] init];
            FSXMLParserObject *parserObj = [[FSXMLParserObject alloc] init];
            
            [parserObj parserData:data
                       completion:^(FSXMLParserResult result) {
                           if (result == FSXMLParserResult_Success) {
                               parserSuccess = YES;
                           } else {
                               parserSuccess = NO;
                           }
                       }
             elementOperationFunc:^(NSString *elementName, NSString *parentElementName, NSDictionary *attributes, NSString *value, ElementOperationKind operationKind) {
                 if (operationKind == ElementOperationKind_Begin) {
                     if ([elementName isEqualToString:FS_TIMESTAMP_NODE_NAME]) {
                         if (_timestampObject == nil) {
                             _timestampObject = [[NSEntityDescription insertNewObjectForEntityForName:FSTIMESTAMPS inManagedObjectContext:_context] retain];
                             _timestampObject.flag = _flagValue;
                         }
                     }
                 } else if (operationKind == ElementOperationKind_End) {
                     if ([elementName isEqualToString:FS_TIMESTAMP_NODE_NAME]) {
                         NSNumber *tempTimestamp = [[NSNumber alloc] initWithDouble:[value doubleValue]];
                         _timestampObject.networktimestamp = tempTimestamp;
                         needRequest = [tempTimestamp doubleValue] > _networkTimestamp;
                         if (!needRequest && [tempTimestamp doubleValue] == 0.0f) {
                             needRequest = YES;
                         }
                         [tempTimestamp release];
                     }
                 }
             }];
            
            //得比较
            
            if (needRequest) {
                _networkTimestamp = [_timestampObject.networktimestamp doubleValue];
                networkTimestampCompletion(NetworkDataTimestampResult_Request);
            } else {
                networkTimestampCompletion(NetworkDataTimestampResult_NoRequest);
            }
            
            [parserObj release];
            [stroeObj release];
        } else {
            networkStatus(NetworkStatus_NetworkError);
            networkTimestampCompletion(NetworkDataTimestampResult_NoRequest);
        }
        
        [request release];
        [url release];
    }
}

- (void)dataTimestampWithLocalData:(BOOL)hasOwnerData localInterval:(double)interval completion:(timestampCompletion)completion {
    BOOL forceRefresh = NO;
    if (_forceRefreshRemoteData) {
        forceRefresh = *_forceRefreshRemoteData;
    }
    
    if (hasOwnerData && !forceRefresh && interval == 0.0f) {
        completion(NetworkDataTimestampResult_NoRequest);
        return;
    }
    
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:0.0f];
    NSTimeInterval curTimeIntevalNow = [date timeIntervalSince1970];
    [date release];
    
    if (!hasOwnerData || forceRefresh || (interval > 0 && curTimeIntevalNow - _networkTimestamp > interval)) {
        if (_forceRefreshRemoteData) {
            *_forceRefreshRemoteData = NO;
        }
        
        NSNumber *numberNetworkTimestamp = [[NSNumber alloc] initWithDouble:curTimeIntevalNow];
        _timestampObject.networktimestamp = numberNetworkTimestamp;
        [numberNetworkTimestamp release];
        
        completion(NetworkDataTimestampResult_Request);
    } else {
        completion(NetworkDataTimestampResult_NoRequest);
    }
}

@end
