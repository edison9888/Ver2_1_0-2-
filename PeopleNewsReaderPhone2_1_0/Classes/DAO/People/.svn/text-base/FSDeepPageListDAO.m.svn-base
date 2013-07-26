//
//  FSDeepPageListDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-2.
//
//

#import "FSDeepPageListDAO.h"
#import "FSDeepPageObject.h"

#define DEEPPAGELIST_FLAG @"DEEP_PAGE_LIST_%@"

#define DEEPPAGE_ENTITYNAME @"FSDeepPageObject"

#define DEEPPAGE_LIST_URL @"http://mobile.app.people.com.cn:81/topic/topic.php?act=page_list&rt=xml&deepid=%@&type=list&iswp=0"
#define DEEPPAGE_LIST_TIMESTAMP_URL @"http://mobile.app.people.com.cn:81/topic/topic.php?act=page_list&rt=xml&deepid=%@&type=timestamp&iswp=0"
#define DEEPPAGE_LIST_INTERVAL (60 * 60)

#define DEEPPAGE_ENTITY_NODE @"item"

@implementation FSDeepPageListDAO
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

- (NSString *)timestampFlag {
    return [NSString stringWithFormat:DEEPPAGELIST_FLAG, _deepid];
}

- (NSString *)entityName {
    return DEEPPAGE_ENTITYNAME;
}

- (NSString *)contentPrimaryKeyName {
    return @"deepid";
}

- (NSObject *)contentPrimaryValue {
    return _deepid;
}

- (void)sortFieldName:(NSString **)fieldName ascending:(BOOL *)ascending {
    *fieldName = @"orderIndex";
    *ascending = YES;
}


- (void)GETData {
    NSLog(@"GETData:%@",self);
    [super GETData];
    
    dispatch_queue_t queue = dispatch_queue_create(NULL, NULL);
    dispatch_async(queue, ^(void) {
        //先取数据
        
        [self initializeBufferData];
        
        
        if (!checkNetworkIsValid()) {
            [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_NetworkErrorStatus];
        } else {
            //STEP 2.先取本地时间戳
            
            [self.timestampObject dataTimestampWithURLString:[NSString stringWithFormat:DEEPPAGE_LIST_TIMESTAMP_URL, _deepid]
                                      networkRequestInterval:DEEPPAGE_LIST_INTERVAL
                                  networkTimestampCompletion:^(NetworkDataTimestampResult result) {
                                      if (result == NetworkDataTimestampResult_Request) {
                                          //取数据
                                          [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_WorkingStatus];
                                          
                                          [FSHTTPWebExData HTTPGetDataWithURLString:[NSString stringWithFormat:DEEPPAGE_LIST_URL, _deepid]
                                                                    blockCompletion:^(NSData *data, BOOL success) {
                                                                        if (success) {
                                                                            //解析存入
                                                                            FSXMLParserObject *parserObj = [[FSXMLParserObject alloc] init];
                                                                            FSStoreObject *storeObj = [[FSStoreObject alloc] init];
                                                                            __block BOOL parserSuccess = NO;
                                                                            
                                                                            [parserObj parserData:data
                                                                                       completion:^(FSXMLParserResult result) {
                                                                                           if (result == FSXMLParserResult_Success) {
                                                                                               parserSuccess = YES;
                                                                                           }
                                                                                       }
                                                                             elementOperationFunc:^(NSString *elementName, NSString *parentElementName, NSDictionary *attributes, NSString *value, ElementOperationKind operationKind) {
                                                                                 if (operationKind == ElementOperationKind_Begin) {
                                                                                     if ([elementName isEqualToString:DEEPPAGE_ENTITY_NODE]) {
                                                                                         id obj = [storeObj insertObjectWithEntityName:[self entityName]];
                                                                                         NSNumber *batchTimestamp = [[NSNumber alloc] initWithDouble:self.timestampObject.networkTimestamp];
                                                                                         [obj setValue:batchTimestamp forKey:[self batchKeyName]];
                                                                                         [batchTimestamp release];
                                                                                     }
                                                                                 } else if (operationKind == ElementOperationKind_End) {
                                                                                     if ([parentElementName isEqualToString:DEEPPAGE_ENTITY_NODE]) {
                                                                                         id obj = [storeObj objectWithEntity:[self entityName]];
                                                                                         if ([elementName isEqualToString:@"flag"]) {
                                                                                             NSNumber *numFlag = [[NSNumber alloc] initWithInt:[value intValue]];
                                                                                             [obj setValue:numFlag forKey:elementName];
                                                                                             [numFlag release];
                                                                                         } else if ([elementName isEqualToString:@"orderIndex"]) {
                                                                                             NSNumber *numOrderIndex = [[NSNumber alloc] initWithInt:[value intValue]];
                                                                                             [obj setValue:numOrderIndex forKey:elementName];
                                                                                             [numOrderIndex release];
                                                                                         } else {
                                                                                             [obj setValue:value forKey:elementName];
                                                                                         }
                                                                                         [obj setValue:_deepid forKey:@"deepid"];
                                                                                     } else if ([elementName isEqualToString:DEEPPAGE_ENTITY_NODE]) {                                                                                    
                                                                                         //[storeObj finalizeEntityWithEntityName:[self entityName]];
                                                                                         [storeObj finalizeEntityWithEntityName:[self entityName]
                                                                                                                   judageEntity:^BOOL(id obj) {
                                                                                                                       BOOL result = NO;
                                                                                                                       FSDeepPageObject *pageObj = (FSDeepPageObject *)obj;
                                                                                                                       NSInteger flag = [pageObj.flag intValue];
                                                                                                                       if (flag == 1 || //导语
                                                                                                                           flag == 2 || //图片
                                                                                                                           flag == 3 || //文本
                                                                                                                           flag == 4 || //外连
                                                                                                                           flag == 6 || //结束语
                                                                                                                           flag == 8) { //往期
                                                                                                                           result = YES;
                                                                                                                       }
                                                                                                                       return result;
                                                                                                                   }];
                                                                                     }
                                                                                 }
                                                                                 
                                                                             }];
                                                                            
                                                                            
                                                                            if (parserSuccess) {
                                                                                [storeObj finalizeAllObjects: ^(BOOL saveSuccessful) {
                                                                                    if (saveSuccessful) {
                                                                                        //读数据
                                                                                        //[self.timestampObject saveLocalTimestamp];
                                                                                        [self.timestampObject saveTimestampWithCleanOldData:^(FSDataTimestampObject *sender, NSManagedObjectContext *context) {
                                                                                            //删除无效数据
                                                                                            [self deleteOldDataWith:context withOldBatchValue:sender.networkTimestamp];
                                                                                        }];
                                                                                        
                                                                                        [self readDataFromCoreData];
                                                                                        [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_SuccessfulStatus];
                                                                                    } else {
                                                                                        [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_DataFormatErrorStatus];
                                                                                    }
                                                                                }];
                                                                            }
                                                                            
                                                                            [storeObj release];
                                                                            [parserObj release];
                                                                        } else {
                                                                            [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_DataFormatErrorStatus];
                                                                        }
                                                                    }];
                                          
                                      }
                                  }
                                               networkStatus:^(NetworkStatus status) {
                                                   if (status == NetworkStatus_Working) {
                                                       [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_WorkingStatus];
                                                   } else if (status == NetworkStatus_NetworkError) {
                                                       [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_NetworkErrorStatus];
                                                   } else {
                                                       [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_StopWorkingStatus];
                                                   }
                                               }];
            
        }
        
        
    });
    dispatch_release(queue);
}


@end
