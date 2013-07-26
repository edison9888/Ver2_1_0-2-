//
//  FSDeepOuterLinkListDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-5.
//
//

#import "FSDeepOuterLinkListDAO.h"
#import "FSDeepOuterLinkListObject.h"

#define FSDEEP_OUTER_LINK_URL @"http://mobile.app.people.com.cn:81/topic/topic.php?act=link_list&rt=xml&outerid=%@&type=list&iswp=0"

#define FSDEEP_OUTER_LINK_TIMESTAMP_URL @"http://mobile.app.people.com.cn:81/topic/topic.php?act=link_list&rt=xml&outerid=%@&type=timestamp&iswp=0"

#define FSDEEP_OUTER_TIMESTAMP_FLAG @"DEEP_OUTER_LINK_%@"

#define FSDEEP_OUTER_LINK_INTERVAL (60 * 10)

#define FSDEEP_OUTER_LINK_ENTITY_NODE @"item"

@implementation FSDeepOuterLinkListDAO
@synthesize outerid = _outerid;

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc {
    [_outerid release];
    [super dealloc];
}

- (NSString *)entityName {
    return NSStringFromClass([FSDeepOuterLinkListObject class]);
}

- (NSString *)timestampFlag {
    return [NSString stringWithFormat:FSDEEP_OUTER_TIMESTAMP_FLAG, _outerid];
}

- (NSString *)contentPrimaryKeyName {
    return @"outerid";
}

- (NSObject *)contentPrimaryValue {
    return _outerid;
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
        
        if (!checkNetworkIsValid()) {
            [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_NetworkErrorStatus];
            return;
        }
        
        [self.timestampObject dataTimestampWithURLString:[NSString stringWithFormat:FSDEEP_OUTER_LINK_TIMESTAMP_URL, _outerid]
                                  networkRequestInterval:FSDEEP_OUTER_LINK_INTERVAL
                              networkTimestampCompletion:^(NetworkDataTimestampResult result) {
                                  if (result == NetworkDataTimestampResult_NoRequest) {
                                      return;
                                  }
                                  [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_WorkingStatus];
                                  
                                  [FSHTTPWebExData HTTPGetDataWithURLString:[NSString stringWithFormat:FSDEEP_OUTER_LINK_URL, _outerid]
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
                                                                         if ([elementName isEqualToString:FSDEEP_OUTER_LINK_ENTITY_NODE]) {
                                                                             FSDeepOuterLinkListObject *linkObj = [storeObj insertObjectWithEntityName:[self entityName]];
                                                                             NSNumber *numberTimestamp = [[NSNumber alloc] initWithDouble:self.timestampObject.networkTimestamp];
                                                                             linkObj.batchtimestamp = numberTimestamp;
                                                                             [numberTimestamp release];
                                                                             
                                                                             NSNumber *numberOrderIndex = [[NSNumber alloc] initWithInt:orderIndex];
                                                                             linkObj.orderIndex = numberOrderIndex;
                                                                             [numberOrderIndex release];
                                                                             
                                                                             linkObj.outerid = _outerid;
                                                                         }
                                                                     } else if (operationKind == ElementOperationKind_End) {
                                                                         if ([parentElementName isEqualToString:FSDEEP_OUTER_LINK_ENTITY_NODE]) {
                                                                             FSDeepOuterLinkListObject *linkObj = [storeObj objectWithEntity:[self entityName]];
                                                                             if ([elementName isEqualToString:@"title"] ||
                                                                                 [elementName isEqualToString:@"link"] ||
                                                                                 [elementName isEqualToString:@"newsid"]) {
                                                                                 [linkObj setValue:value forKey:elementName];
                                                                             } else if ([elementName isEqualToString:@"flag"]) {
                                                                                 NSNumber *numberFlag = [[NSNumber alloc] initWithInt:[value intValue]];
                                                                                 linkObj.flag = numberFlag;
                                                                                 [numberFlag release];
                                                                             }
                                                                         } else if ([elementName isEqualToString:FSDEEP_OUTER_LINK_ENTITY_NODE]) {
                                                                             [storeObj finalizeEntityWithEntityName:[self entityName]];
                                                                             orderIndex++;
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
