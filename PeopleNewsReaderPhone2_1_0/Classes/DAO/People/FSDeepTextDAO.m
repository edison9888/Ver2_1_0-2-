//
//  FSDeepTextDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-2.
//
//

#import "FSDeepTextDAO.h"
#import "FSDeepContentObject.h"
#import "FSDeepContent_TextObject.h"
#import "FSDeepContent_PicObject.h"
#import "FSDeepContent_ChildObject.h"

#define FSDEEP_TEXT_URL @"http://mobile.app.people.com.cn:81/topic/topic.php?act=news&rt=xml&contentid=%@"

#define FSDEEP_TEXT_ENTITY_NODE @"item"

#define FSDEEP_TEXT_CHILD_PIC_NODE @"picURL"
#define FSDEEP_TEXT_CHILD_TXT_NODE @"text"
#define FSDEEP_TEXT_BODY_NODE @"body"

#define FSDEEP_TEXT_CHILD_PIC_NODE_FLAG 1
#define FSDEEP_TEXT_CHILD_TXT_NODE_FLAG 2

#define FSDEEP_TEXT_CHILD_CONTENT @"content"

#define FSDEEP_TEXT_TIMESTAMP_FLAG @"DEEP_TEXT_FLAG_%@"

@implementation FSDeepTextDAO
@synthesize contentid = _contentid;

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc {
    [_contentid release];
    [super dealloc];
}

- (NSInteger)pictureFlag {
    return FSDEEP_TEXT_CHILD_PIC_NODE_FLAG;
}

- (NSInteger)textFlag {
    return FSDEEP_TEXT_CHILD_TXT_NODE_FLAG;
}

- (NSString *)entityName {
    return  NSStringFromClass([FSDeepContentObject class]);
}

- (NSString *)timestampFlag {
    return [NSString stringWithFormat:FSDEEP_TEXT_TIMESTAMP_FLAG, _contentid];
}

- (NSString *)contentPrimaryKeyName {
    return @"contentid";
}

- (NSObject *)contentPrimaryValue {
    return _contentid;
}

- (void)GETData {
    [super GETData];
    NSLog(@"cn.com.people.deeptextdao");
    dispatch_queue_t queue = dispatch_queue_create(NULL, NULL);
    dispatch_async(queue, ^{
        if (self.contentObject == nil) {
            [self readDataFromCoreData];
            [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_BufferSuccessfulStatus];
        }
        NSLog(@"GETData  text");
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
                                                  NSLog(@"请求数据 text");
                                                  //请求数据
                                                  [FSHTTPWebExData HTTPGetDataWithURLString:[NSString stringWithFormat:FSDEEP_TEXT_URL, _contentid]
                                                                            blockCompletion:^(NSData *data, BOOL success) {
                                                                                if (!success) {
                                                                                    if (checkNetworkIsValid()) {
                                                                                        [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_NetworkErrorStatus];
                                                                                    } else {
                                                                                        [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_HostErrorStatus];
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
                                                                                         if ([elementName isEqualToString:FSDEEP_TEXT_ENTITY_NODE]) {
                                                                                             FSDeepContentObject *contentObj = [storeObj insertObjectWithEntityName:[self entityName]];
                                                                                             NSNumber *numberTimestamp = [[NSNumber alloc] initWithDouble:self.timestampObject.networkTimestamp];
                                                                                             contentObj.batchtimestamp = numberTimestamp;
                                                                                             [numberTimestamp release];
                                                                                         } else if ([elementName isEqualToString:FSDEEP_TEXT_BODY_NODE] && [parentElementName isEqualToString:FSDEEP_TEXT_ENTITY_NODE]) {
                                                                                             NSMutableSet *childSet = [[NSMutableSet alloc] init];
                                                                                             FSDeepContentObject *contentObj = [storeObj objectWithEntity:parentElementName];
                                                                                             contentObj.childContent = childSet;
                                                                                             [childSet release];
                                                                                         } else if ([elementName isEqualToString:FSDEEP_TEXT_CHILD_PIC_NODE] && [parentElementName isEqualToString:FSDEEP_TEXT_BODY_NODE]) {
                                                                                             FSDeepContent_ChildObject *childObj = [storeObj insertObjectWithEntityName:NSStringFromClass([FSDeepContent_ChildObject class])];
                                                                                             NSNumber *numberIndex = [[NSNumber alloc] initWithInt:orderIndex];
                                                                                             childObj.orderIndex = numberIndex;
                                                                                             [numberIndex release];
                                                                                             
                                                                                             NSNumber *numberFlag = [[NSNumber alloc] initWithInt:FSDEEP_TEXT_CHILD_PIC_NODE_FLAG];
                                                                                             childObj.flag = numberFlag;
                                                                                             [numberFlag release];
                                                                                             
                                                                                             FSDeepContentObject *contentObj = [storeObj objectWithEntity:[self entityName]];
                                                                                             NSMutableSet *childSet = (NSMutableSet *)contentObj.childContent;
                                                                                             [childSet addObject:childObj];
                                                                                             
                                                                                         } else if ([elementName isEqualToString:FSDEEP_TEXT_CHILD_TXT_NODE] && [parentElementName isEqualToString:FSDEEP_TEXT_BODY_NODE]) {
                                                                                             FSDeepContent_ChildObject *childObj = [storeObj insertObjectWithEntityName:NSStringFromClass([FSDeepContent_ChildObject class])];
                                                                                             NSNumber *numberIndex = [[NSNumber alloc] initWithInt:orderIndex];
                                                                                             childObj.orderIndex = numberIndex;
                                                                                             [numberIndex release];
                                                                                             
                                                                                             NSNumber *numberFlag = [[NSNumber alloc] initWithInt:FSDEEP_TEXT_CHILD_TXT_NODE_FLAG];
                                                                                             childObj.flag = numberFlag;
                                                                                             [numberFlag release];
                                                                                             
                                                                                             FSDeepContentObject *contentObj = [storeObj objectWithEntity:[self entityName]];
                                                                                             NSMutableSet *childSet = (NSMutableSet *)contentObj.childContent;
                                                                                             [childSet addObject:childObj];
                                                                                         }
                                                                                     } else if (operationKind == ElementOperationKind_End) {
                                                                                         if ([parentElementName isEqualToString:FSDEEP_TEXT_ENTITY_NODE]) {
                                                                                             FSDeepContentObject *contentObj = [storeObj objectWithEntity:[self entityName]];
                                                                                             if ([elementName isEqualToString:@"timestamp"]) {
                                                                                                 NSNumber *numberTimestamp = [[NSNumber alloc] initWithDouble:[value doubleValue]];
                                                                                                 [contentObj setValue:numberTimestamp forKey:elementName];
                                                                                                 [numberTimestamp release];
                                                                                             } else if ([elementName isEqualToString:@"contented"]) {
                                                                                                 contentObj.contentid = value;
                                                                                             } else if (![elementName isEqualToString:FSDEEP_TEXT_BODY_NODE]) {
                                                                                                 [contentObj setValue:value forKey:elementName];
                                                                                             }
                                                                                         } else if ([elementName isEqualToString:FSDEEP_TEXT_ENTITY_NODE]) {
                                                                                             [storeObj finalizeEntityWithEntityName:[self entityName]];
                                                                                         } else if ([parentElementName isEqualToString:FSDEEP_TEXT_BODY_NODE]) {
                                                                                             FSDeepContent_ChildObject *childObj = [storeObj objectWithEntity:NSStringFromClass([FSDeepContent_ChildObject class])];
                                                                                             [childObj setValue:value forKey:FSDEEP_TEXT_CHILD_CONTENT];
                                                                                             orderIndex++;
                                                                                         }
                                                                                     }
                                                                                 }];
                                                                                
                                                                                if (parserSuccess) {
                                                                                    [storeObj finalizeAllObjects:^(BOOL saveSuccessful) {
                                                                                        if (saveSuccessful) {
                                                                                            [self.timestampObject saveTimestampWithCleanOldData:^(FSDataTimestampObject *sender, NSManagedObjectContext *context) {
                                                                                                [self deleteOldDataWith:context withOldBatchValue:sender.networkTimestamp];
                                                                                            }];
                                                                                            
                                                                                            [self readDataFromCoreData];
                                                                                            [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_SuccessfulStatus];
                                                                                        } else  {
                                                                                            [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_DataFormatErrorStatus];
                                                                                        }
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
