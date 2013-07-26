//
//  FSDeepInvestigateDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-2.
//
//

#import "FSDeepInvestigateDAO.h"
#import "FSDeepInvestigateObject.h"
#import "FSDeepInvestigate_OptionObject.h"

#define FSDEEP_INVESTIGATE_URL @"http://mobile.app.people.com.cn:81/topic/topic.php?act=vote_list&rt=xml&subjectid=%@&type=list&iswp=0"

#define FSDEEP_INVESTIGATE_TIMESTAMP_FLAG @"DEEP_INVESTIGATE_%@"

#define FSDEEP_INVESTIGATE_ENTITY_NODE @"item"

#define FSDEEP_INVESTIGATE_OPTION_ENTITY_NODE @"investigate"

@implementation FSDeepInvestigateDAO
@synthesize investigateid = _investigateid;

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc {
    [_investigateid release];
    [super dealloc];
}

- (NSString *)entityName {
    return NSStringFromClass([FSDeepInvestigateObject class]);
}

- (NSString *)timestampFlag {
    return [NSString stringWithFormat:FSDEEP_INVESTIGATE_TIMESTAMP_FLAG, _investigateid];
}

- (NSString *)contentPrimaryKeyName {
    return @"investigateid";
}

- (NSObject *)contentPrimaryValue {
    return _investigateid;
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
                                                  
                                                  [FSHTTPWebExData HTTPGetDataWithURLString:[NSString stringWithFormat:FSDEEP_INVESTIGATE_URL, _investigateid]
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
                                                                                         if ([elementName isEqualToString:FSDEEP_INVESTIGATE_ENTITY_NODE]) {
                                                                                             FSDeepInvestigateObject *investigateObj = [storeObj insertObjectWithEntityName:[self entityName]];
                                                                                             NSNumber *numberTimestamp = [[NSNumber alloc] initWithDouble:self.timestampObject.networkTimestamp];
                                                                                             investigateObj.batchtimestamp = numberTimestamp;
                                                                                             [numberTimestamp release];
                                                                                             
                                                                                             NSNumber *numberBool = [[NSNumber alloc] initWithBool:NO];
                                                                                             investigateObj.haspost = numberBool;
                                                                                             [numberBool release];

                                                                                         } else if ([elementName isEqualToString:FSDEEP_INVESTIGATE_OPTION_ENTITY_NODE]) {
                                                                                             FSDeepInvestigate_OptionObject *optionObj = [storeObj insertObjectWithEntityName:NSStringFromClass([FSDeepInvestigate_OptionObject class])];
                                                                                             FSDeepInvestigateObject *investigateObj = [storeObj objectWithEntity:[self entityName]];
                                                                                             
                                                                                             NSNumber *numberOrderIndex = [[NSNumber alloc] initWithInt:orderIndex];
                                                                                             optionObj.orderIndex = numberOrderIndex;
                                                                                             [numberOrderIndex release];
                                                                                             
                                                                                             if (investigateObj.investages == nil) {
                                                                                                 NSMutableSet *childSet = [[NSMutableSet alloc] init];
                                                                                                 investigateObj.investages = childSet;
                                                                                                 [childSet release];
                                                                                             }
                                                                                             
                                                                                             NSMutableSet *childSet = (NSMutableSet *)investigateObj.investages;
                                                                                             [childSet addObject:optionObj];

                                                                                         }
                                                                                     } else if (operationKind == ElementOperationKind_End) {
                                                                                         if ([parentElementName isEqualToString:FSDEEP_INVESTIGATE_ENTITY_NODE]) {
                                                                                             FSDeepInvestigateObject *investigateObj = [storeObj objectWithEntity:[self entityName]];
                                                                                             
                                                                                             if ([elementName isEqualToString:@"subjectTile"] ||
                                                                                                 [elementName isEqualToString:@"subjectid"] ||
                                                                                                 [elementName isEqualToString:@"investigateid"] ||
                                                                                                 [elementName isEqualToString:@"investigateTitle"]) {
                                                                                                 [investigateObj setValue:value forKey:elementName];
                                                                                             } else if ([elementName isEqualToString:@"investigateOption"] ||
                                                                                                        [elementName isEqualToString:@"investigateMultiCount"]) {
                                                                                                 NSNumber *numberValue = [[NSNumber alloc] initWithInt:[value intValue]];
                                                                                                 [investigateObj setValue:numberValue forKey:elementName];
                                                                                                 [numberValue release];                                                                                            
                                                                                             }
                                                                                         } else if ([parentElementName isEqualToString:FSDEEP_INVESTIGATE_OPTION_ENTITY_NODE]) {
                                                                                             FSDeepInvestigate_OptionObject *optionObj = [storeObj objectWithEntity:NSStringFromClass([FSDeepInvestigate_OptionObject class])];
                                                                                             if ([elementName isEqualToString:@"orderKey"] ||
                                                                                                 [elementName isEqualToString:@"orderText"]) {
                                                                                                 [optionObj setValue:value forKey:elementName];
                                                                                             }
                                                                                         } else if ([elementName isEqualToString:FSDEEP_INVESTIGATE_OPTION_ENTITY_NODE]) {
                                                                                             [storeObj finalizeEntityWithEntityName:NSStringFromClass([FSDeepInvestigate_OptionObject class])];
                                                                                             orderIndex++;
                                                                                         } else if ([elementName isEqualToString:FSDEEP_INVESTIGATE_ENTITY_NODE]) {
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
