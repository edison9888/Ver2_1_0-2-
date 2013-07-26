//
//  FSDeepEndDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-2.
//
//

#import "FSDeepEndDAO.h"
#import "FSDeepEndObject.h"

#define FSDEEP_END_URL @"http://mobile.app.people.com.cn:81/topic/topic.php?act=end&rt=xml&deepid=%@&type=list&iswp=0"

#define FSDEEP_END_TIMESTAMP_FLAG @"DEEP_END_%@"

#define FSDEEP_END_ENTITY_NODE @"item"

@implementation FSDeepEndDAO
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
    return NSStringFromClass([FSDeepEndObject class]);
}

- (NSString *)timestampFlag {
    return [NSString stringWithFormat:FSDEEP_END_TIMESTAMP_FLAG, _deepid];
}

- (NSString *)contentPrimaryKeyName {
    return @"deepid";
}

- (NSObject *)contentPrimaryValue {
    return _deepid;
}

- (void)GETData {
    [super GETData];
    dispatch_queue_t queue = dispatch_queue_create(NULL, NULL);
    dispatch_async(queue, ^{
        if (self.contentObject == nil) {
            [self readDataFromCoreData];
            [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_BufferSuccessfulStatus];
        }
        
        self.timestampObject.forceRefreshRemoteData = self.foreceRefreshRemoteData;
        [self.timestampObject dataTimestampWithLocalData:(self.contentObject != nil)
                                           localInterval:0.0f
                                              completion:^(NetworkDataTimestampResult result) {
                                                  if (result == NetworkDataTimestampResult_NoRequest) {
                                                      return;
                                                  }
                                                  
                                                  if (!checkNetworkIsValid()) {
                                                      [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_NetworkErrorStatus];
                                                      return;
                                                  }
                                                  
                                                  [FSHTTPWebExData HTTPGetDataWithURLString:[NSString stringWithFormat:FSDEEP_END_URL, _deepid]
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
                                                                                         if ([elementName isEqualToString:FSDEEP_END_ENTITY_NODE]) {
                                                                                             FSDeepEndObject *endObj = [storeObj insertObjectWithEntityName:[self entityName]];
                                                                                             endObj.deepid = _deepid;
                                                                                             
                                                                                             NSNumber *numberTimestamp = [[NSNumber alloc] initWithDouble:self.timestampObject.networkTimestamp];
                                                                                             endObj.batchtimestamp = numberTimestamp;
                                                                                             [numberTimestamp release];
                                                                                         }
                                                                                     } else if (operationKind == ElementOperationKind_End) {
                                                                                         if ([parentElementName isEqualToString:FSDEEP_END_ENTITY_NODE]) {
                                                                                             FSDeepEndObject *endObj = [storeObj objectWithEntity:[self entityName]];
                                                                                             if ([elementName isEqualToString:@"picture"] ||
                                                                                                 [elementName isEqualToString:@"endContent"]) {
                                                                                                 [endObj setValue:value forKey:elementName];
                                                                                             }
                                                                                         } else if ([elementName isEqualToString:FSDEEP_END_ENTITY_NODE]) {
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
                                                  
                                              }];
        
    });
    dispatch_release(queue);
}

@end
