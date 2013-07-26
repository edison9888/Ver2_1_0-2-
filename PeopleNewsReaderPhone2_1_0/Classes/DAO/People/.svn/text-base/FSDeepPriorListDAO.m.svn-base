//
//  FSDeepPriorListDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-6.
//
//

#import "FSDeepPriorListDAO.h"
#import "FSTopicPriorObject.h"


#define FSDEEP_PRIOR_LIST_TIMESTAMP_FLAG @"DEEP_PRIROR_LIST_%@"

#define FSDEEP_PRIOR_LIST_TIMESTAMP_URL @"http://mobile.app.people.com.cn:81/topic/topic.php?act=history_list&rt=xml&deepid=%@&type=timestamp&iswp=0"

#define FSDEEP_PRIOR_LIST_URL @"http://mobile.app.people.com.cn:81/topic/topic.php?act=history_list&rt=xml&deepid=%@&type=list&iswp=0"

//新的url
#define FSDEEP_PRIOR_LIST_NEW_URL @"http://mobile.app.people.com.cn:81/topic/topic.php?act=history_list&rt=xml&deepid=%@&count=%d&type=list&iswp=0&lastdeepid=%@"

#define FSDEEP_PRIOR_LIST_TIMESTAMP_NEW_URL @"http://mobile.app.people.com.cn:81/topic/topic.php?act=history_list&rt=xml&deepid=%@&type=timestamp&iswp=0"
//新的url

#define FSDEEP_PRIOR_LIST_INTERVAL (60 * 15)

#define FSDEEP_PRIOR_LIST_ENTITY_NODE @"item"

@interface FSDeepPriorListDAO()
- (void)inner_GETData;
@end

@implementation FSDeepPriorListDAO
@synthesize deepid = _deepid;
@synthesize lastPriorDeepid = _lastPriorDeeepid;
@synthesize pageCount = _pageCount;

- (id)init {
    self = [super init];
    if (self) {
        _pageCount = 4;
    }
    return self;
}

- (void)dealloc {
    [_lastPriorDeeepid release];
    [super dealloc];
}

- (NSString *)entityName {
    return @"FSTopicPriorObject";
}

- (NSString *)timestampFlag {
    return [NSString stringWithFormat:FSDEEP_PRIOR_LIST_TIMESTAMP_FLAG, _deepid];
}

- (NSString *)contentPrimaryKeyName {
    return @"ownerdeepid";
}

- (NSObject *)contentPrimaryValue {
    return _deepid;
}

- (void)GETData {
    [super GETData];
    NSLog(@"FSDeepPriorListDAO 11");
    dispatch_queue_t queue = dispatch_queue_create(NULL, NULL);
    dispatch_async(queue, ^{
        [self initializeBufferData];
        
        BOOL isRefresh = (_lastPriorDeeepid == nil || [_lastPriorDeeepid isEqualToString:@""]);
        
        if (!checkNetworkIsValid()) {
            [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_NetworkErrorStatus];
            return;
        }
        
        if (isRefresh) {
            self.lastPriorDeepid = @"";
            self.timestampObject.forceRefreshRemoteData = self.foreceRefreshRemoteData;
            [self.timestampObject dataTimestampWithURLString:[NSString stringWithFormat:FSDEEP_PRIOR_LIST_TIMESTAMP_NEW_URL, _deepid]
                                      networkRequestInterval:FSDEEP_PRIOR_LIST_INTERVAL
                                  networkTimestampCompletion:^(NetworkDataTimestampResult result) {
                                      if (result == NetworkDataTimestampResult_NoRequest) {
                                          return;
                                      }
                                      
                                      [self inner_GETData];
                                      
                                  }
                                               networkStatus:^(NetworkStatus status) {
                                                   if (status == NetworkStatus_NetworkError) {
                                                       [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_NetworkErrorStatus];
                                                   } else if (status == NetworkStatus_Success) {
                                                       [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_StopWorkingStatus];
                                                   } else if (status == NetworkStatus_Working) {
                                                       [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_WorkingStatus];
                                                   }
                                               }];
            
        } else {
            [self inner_GETData];
        }
        

    });
    dispatch_release(queue);
}

- (void)inner_GETData {
    if (!checkNetworkIsValid()) {
        [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_NetworkErrorStatus];
        return;
    }
    
    NSString *deepPriorListURL = [NSString stringWithFormat:FSDEEP_PRIOR_LIST_NEW_URL, _deepid, _pageCount, _lastPriorDeeepid];
    FSLog(@"deepPriorListURL:%@", deepPriorListURL);
    [FSHTTPWebExData HTTPGetDataWithURLString:deepPriorListURL
                              blockCompletion:^(NSData *data, BOOL success) {
                                  if (!success) {
                                      if (checkNetworkIsValid()) {
                                          [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_HostErrorStatus];
                                      } else {
                                          [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_NetworkErrorStatus];
                                      }
                                      return;
                                  }
                                  
                                  __block BOOL parserSuccess = NO;
                                  FSXMLParserObject *parserObj = [[FSXMLParserObject alloc] init];
                                  FSStoreObject *storeObj = [[FSStoreObject alloc] init];
                                  
                                  [parserObj parserData:data
                                             completion:^(FSXMLParserResult result) {
                                                 if (result == FSXMLParserResult_Success) {
                                                     parserSuccess = YES;
                                                 }
                                             }
                                   elementOperationFunc:^(NSString *elementName, NSString *parentElementName, NSDictionary *attributes, NSString *value, ElementOperationKind operationKind) {
                                       if (operationKind == ElementOperationKind_Begin) {
                                           if ([elementName isEqualToString:FSDEEP_PRIOR_LIST_ENTITY_NODE]) {
                                               FSTopicPriorObject *priorObj = [storeObj insertObjectWithEntityName:[self entityName]];
                                               
                                               NSNumber *numberTimestamp = [[NSNumber alloc] initWithDouble:self.timestampObject.networkTimestamp];
                                               priorObj.batchtimestamp = numberTimestamp;
                                               [numberTimestamp release];
                                               
                                               priorObj.ownerdeepid = _deepid;
                                           }
                                       } else if (operationKind == ElementOperationKind_End) {
                                           if ([parentElementName isEqualToString:FSDEEP_PRIOR_LIST_ENTITY_NODE]) {
                                               id obj = [storeObj objectWithEntity:[self entityName]];
                                               if ([elementName isEqualToString:@"timestamp"]) {
                                                   NSNumber *number = [[NSNumber alloc] initWithDouble:[value doubleValue]];
                                                   
                                                   [obj setValue:number forKey:elementName];
                                                   [number release];
                                               } else if ([elementName isEqualToString:@"title"] ||
                                                          [elementName isEqualToString:@"news_abstract"] ||
                                                          [elementName isEqualToString:@"pubDate"] ||
                                                          [elementName isEqualToString:@"pictureLink"] ||
                                                          [elementName isEqualToString:@"deepid"]) {
                                                   
                                                   [obj setValue:value forKey:elementName];
                                               }
                                           } else if ([elementName isEqualToString:FSDEEP_PRIOR_LIST_ENTITY_NODE]) {
                                               [storeObj finalizeEntityWithEntityName:[self entityName]];
                                           }
                                       }
                                   }];
                                  
                                  if (parserSuccess) {
                                      [storeObj finalizeAllObjects:^(BOOL saveSuccessful) {
                                          if (!saveSuccessful) {
                                              [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_DataFormatErrorStatus];
                                              return;
                                          }
                                          
                                          [self.timestampObject saveTimestampWithCleanOldData:^(FSDataTimestampObject *sender, NSManagedObjectContext *context) {
                                              [self deleteOldDataWith:context withOldBatchValue:sender.networkTimestamp];
                                          }];
                                          
                                          [self readDataFromCoreData];
                                          [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_SuccessfulStatus];
                                      }];
                                  } else {
                                      [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_DataFormatErrorStatus];
                                  }
                                  
                                  [storeObj release];
                                  [parserObj release];
                                  
                              }];
}

@end
