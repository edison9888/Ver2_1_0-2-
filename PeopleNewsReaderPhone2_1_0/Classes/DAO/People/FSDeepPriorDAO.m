//
//  FSDeepPriorDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-2.
//
//

#import "FSDeepPriorDAO.h"
#import "FSDeepPriorFocusObject.h"

#define FSDEEP_PRIOR_TIMESTAMP_FLAG @"DEEP_PRIOR_FOCUS_%@"

#define FSDEEP_PRIOR_URL @"http://mobile.app.people.com.cn:81/topic/topic.php?act=history&rt=xml&deepid=%@&type=list&iswp=0"

#define FSDEEP_PRIOR_TIMESTAMP_URL @"http://mobile.app.people.com.cn:81/topic/topic.php?act=history&rt=xml&deepid=%@&type=timestamp&iswp=0"

#define FSDEEP_PRIOR_INTERVAL (60 * 15)

#define FSDEEP_PRIOR_ENTITY_NODE @"item"

@implementation FSDeepPriorDAO
@synthesize deepid = _deepid;

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc {
    [_deepid release];
    [super dealloc];
}

- (NSString *)entityName {
    return NSStringFromClass([FSDeepPriorFocusObject class]);
}

- (NSString *)timestampFlag {
    return [NSString stringWithFormat:FSDEEP_PRIOR_TIMESTAMP_FLAG, _deepid];
}

- (NSString *)contentPrimaryKeyName {
    return @"ownerdeepid";
}

- (NSObject *)contentPrimaryValue {
    return _deepid;
}

- (void)sortFieldName:(NSString **)fieldName ascending:(BOOL *)ascending {
    *fieldName = @"orderIndex";
    *ascending = YES;
}

- (void)GETData {
    [super GETData];
    
    dispatch_queue_t queue = dispatch_queue_create(NULL, NULL);
    dispatch_async(queue, ^{
        
        [self initializeBufferData];
        
        self.timestampObject.forceRefreshRemoteData = self.foreceRefreshRemoteData;
        [self.timestampObject dataTimestampWithURLString:[NSString stringWithFormat:FSDEEP_PRIOR_TIMESTAMP_URL, _deepid]
                                  networkRequestInterval:FSDEEP_PRIOR_INTERVAL
                              networkTimestampCompletion:^(NetworkDataTimestampResult result) {
                                  if (result == NetworkDataTimestampResult_NoRequest) {
                                      return;
                                  }
                                  
                                  
                                  if (!checkNetworkIsValid()) {
                                      [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_HostErrorStatus];
                                      return;
                                  }
                                  
                                  [FSHTTPWebExData HTTPGetDataWithURLString:[NSString stringWithFormat:FSDEEP_PRIOR_URL, _deepid]
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
                                                                __block NSInteger orderIndex = 0;
                                                                
                                                                FSXMLParserObject * parserObj = [[FSXMLParserObject alloc] init];
                                                                FSStoreObject *storeObj = [[FSStoreObject alloc] init];
                                                                
                                                                [parserObj parserData:data
                                                                           completion:^(FSXMLParserResult result) {
                                                                               if (result == FSXMLParserResult_Success) {
                                                                                   parserSuccess = YES;
                                                                               }
                                                                           }
                                                                 elementOperationFunc:^(NSString *elementName, NSString *parentElementName, NSDictionary *attributes, NSString *value, ElementOperationKind operationKind) {
                                                                     if (operationKind == ElementOperationKind_Begin) {
                                                                         if ([elementName isEqualToString:FSDEEP_PRIOR_ENTITY_NODE]) {
                                                                             FSDeepPriorFocusObject *priorFocusObj = [storeObj insertObjectWithEntityName:[self entityName]];
                                                                             
                                                                             NSNumber *numberTimestamp = [[NSNumber alloc] initWithDouble:self.timestampObject.networkTimestamp];
                                                                             priorFocusObj.batchtimestamp = numberTimestamp;
                                                                             [numberTimestamp release];
                                                                             
                                                                             priorFocusObj.ownerdeepid = _deepid;
                                                                             
                                                                             NSNumber *numberOrderIndex = [[NSNumber alloc] initWithInt:orderIndex];
                                                                             priorFocusObj.orderIndex = numberOrderIndex;
                                                                             [numberOrderIndex release];
                                                                         }
                                                                     } else if (operationKind == ElementOperationKind_End) {
                                                                         if ([parentElementName isEqualToString:FSDEEP_PRIOR_ENTITY_NODE]) {
                                                                             FSDeepPriorFocusObject *priorFocusObj = [storeObj objectWithEntity:[self entityName]];
                                                                             if ([elementName isEqualToString:@"picture"] ||
                                                                                 [elementName isEqualToString:@"deepid"] ||
                                                                                 [elementName isEqualToString:@"link"]) {
                                                                                 [priorFocusObj setValue:value forKey:elementName];
                                                                             } else if ([elementName isEqualToString:@"flag"]) {
                                                                                 NSNumber *numberFlag = [[NSNumber alloc] initWithInt:[value intValue]];
                                                                                 priorFocusObj.flag = numberFlag;
                                                                                 [numberFlag release];
                                                                             }
                                                                         } else if ([elementName isEqualToString:FSDEEP_PRIOR_ENTITY_NODE]) {
                                                                             [storeObj finalizeEntityWithEntityName:[self entityName]];
                                                                             orderIndex++;
                                                                         }
                                                                     }
                                                                 }];
                                                                
                                                                if (parserSuccess) {
                                                                    [storeObj finalizeAllObjects:^(BOOL saveSuccessful) {
                                                                        if (!success) {
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
                                           networkStatus:^(NetworkStatus status) {
                                               if (status == NetworkStatus_NetworkError) {
                                                   [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_NetworkErrorStatus];
                                               } else if (status == NetworkStatus_Success) {
                                                   [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_StopWorkingStatus];
                                               } else if (status == NetworkStatus_Working) {
                                                   [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_WorkingStatus];
                                               }
                                           }];
    });
    dispatch_release(queue);
}


@end
