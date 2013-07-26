//
//  FSDeepOuterDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-2.
//
//

#import "FSDeepOuterDAO.h"
#import "FSDeepOuterObject.h"

#define FSDEEP_OUTER_HEADER_URL @"http://mobile.app.people.com.cn:81/topic/topic.php?act=outer_list&rt=xml&outerid=%@"

#define FSDEEP_OUTER_HEADER_TIMESTAMP_FLAG @"DEEP_OUTER_HEADER_%@"

#define FSDEEP_OUTER_HEADER_ENTITY_NODE @"item"

@implementation FSDeepOuterDAO
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

- (NSString *)timestampFlag {
    return [NSString stringWithFormat:FSDEEP_OUTER_HEADER_TIMESTAMP_FLAG, _outerid];
}

- (NSString *)entityName {
    return NSStringFromClass([FSDeepOuterObject class]);
}

- (NSString *)contentPrimaryKeyName {
    return @"outerid";
}

- (NSObject *)contentPrimaryValue {
    return _outerid;
}

- (void)GETData {
    [super GETData];
    dispatch_queue_t queue = dispatch_queue_create(NULL, NULL);
    dispatch_async(queue, ^(void){
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
                                                  
                                                  [FSHTTPWebExData HTTPGetDataWithURLString:[NSString stringWithFormat:FSDEEP_OUTER_HEADER_URL, _outerid]
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
                                                                                         if ([elementName isEqualToString:FSDEEP_OUTER_HEADER_ENTITY_NODE]) {
                                                                                             FSDeepOuterObject *outerObj = [storeObj insertObjectWithEntityName:[self entityName]];
                                                                                             NSNumber *numberTimestamp = [[NSNumber alloc] initWithDouble:self.timestampObject.networkTimestamp];
                                                                                             outerObj.batchtimestamp = numberTimestamp;
                                                                                             [numberTimestamp release];
                                                                                         }
                                                                                     } else if (operationKind == ElementOperationKind_End) {
                                                                                         if ([parentElementName isEqualToString:FSDEEP_OUTER_HEADER_ENTITY_NODE]) {
                                                                                             FSDeepOuterObject *outerObj = [storeObj objectWithEntity:[self entityName]];
                                                                                             if ([elementName isEqualToString:@"subjectTile"] ||
                                                                                                 [elementName isEqualToString:@"subjectid"] ||
                                                                                                 [elementName isEqualToString:@"outerid"] ||
                                                                                                 [elementName isEqualToString:@"leadTitle"] ||
                                                                                                 [elementName isEqualToString:@"leadContent"]) {
                                                                                                 [outerObj setValue:value forKey:elementName];
                                                                                             }
                                                                                         } else if ([elementName isEqualToString:FSDEEP_OUTER_HEADER_ENTITY_NODE]) {
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
