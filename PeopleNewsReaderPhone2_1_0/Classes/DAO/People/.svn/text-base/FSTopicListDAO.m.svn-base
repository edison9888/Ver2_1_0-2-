//
//  FSTopicListDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-18.
//
//

#import "FSTopicListDAO.h"
#import "FSTopicObject.h"
/*
 20、深度（专题）列表
 地址
 http://mobile.app.people.com.cn:81/news2/topic.php?act=list&rt=xml&type=list&iswp=1
 参数说明：
 act:跳转url对应PHP地址，不可修改
 rt:返回文件格式,xml，不可修改
 type:获取类别，list或默认返回 主题列表，timestamp返回时间戳。根据具体应用调用。
 iswp:返回时间戳类别，可不传此参数。当type=timestamp时有效。 不填写返回为时间戳，1为返回日期
 */

#define TOPICLIST_DATA_URL @"http://mobile.app.people.com.cn:81/topic/topic.php?act=info_list&rt=xml&type=list&iswp=0"

#define TOPICLIST_TIMESTAMP_URL @"http://mobile.app.people.com.cn:81/topic/topic.php?act=info_list&rt=xml&type=timestamp&iswp=0"

#define TOPICLIST_FLAG @"TOPICLIST"

#define TOPICLIST_TIMEINTEVAL (60)//(60 * 30)

#define FSTOPIC_ENTITYNAME @"FSTopicObject"

#define FSTOPIC_OBJECT_NODE @"item"

#define FSTOPIC_BATCH_KEY @"batchtimestamp"

@interface FSTopicListDAO()
//- (void)readDataFromCoreData;
@end

@implementation FSTopicListDAO


- (id)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (NSString *)timestampFlag {
    return TOPICLIST_FLAG;
}

- (NSString *)entityName {
    return FSTOPIC_ENTITYNAME;
}


//- (NSString *)batchKeyName {
//    return DEFAULT_BATCH_KEY;
//}

- (void)GETData {
    [super GETData];
    
    dispatch_queue_t queue = dispatch_queue_create(NULL, NULL);
    dispatch_async(queue, ^(void) {
        //先取数据

        [self initializeBufferData];

        if (!checkNetworkIsValid()) {
            [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_NetworkErrorStatus];
        } else {
            //STEP 2.先取本地时间戳
            
            [self.timestampObject dataTimestampWithURLString:TOPICLIST_TIMESTAMP_URL
                              networkRequestInterval:TOPICLIST_TIMEINTEVAL
                          networkTimestampCompletion:^(NetworkDataTimestampResult result) {
                              if (result == NetworkDataTimestampResult_Request) {
                                  //取数据
                                  NSLog(@"取数据......");
                                  [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_WorkingStatus];
                                  
                                  [FSHTTPWebExData HTTPGetDataWithURLString:TOPICLIST_DATA_URL
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
                                                                             if ([elementName isEqualToString:FSTOPIC_OBJECT_NODE]) {
                                                                                 id obj = [storeObj insertObjectWithEntityName:FSTOPIC_ENTITYNAME];
                                                                                 NSNumber *batchTimestamp = [[NSNumber alloc] initWithDouble:self.timestampObject.networkTimestamp];
                                                                                 [obj setValue:batchTimestamp forKey:FSTOPIC_BATCH_KEY];
                                                                                 [batchTimestamp release];
                                                                             }
                                                                         } else if (operationKind == ElementOperationKind_End) {
                                                                             if ([parentElementName isEqualToString:FSTOPIC_OBJECT_NODE]) {
                                                                                 id obj = [storeObj objectWithEntity:FSTOPIC_ENTITYNAME];
                                                                                 if ([elementName isEqualToString:@"timestamp"]) {
                                                                                     NSNumber *number = [[NSNumber alloc] initWithDouble:[value doubleValue]];
                                                                                     
                                                                                     [obj setValue:number forKey:elementName];
                                                                                     [number release];
                                                                                 } else if ([elementName isEqualToString:@"title"] ||
                                                                                            [elementName isEqualToString:@"news_abstract"] ||
                                                                                            [elementName isEqualToString:@"pubDate"] ||
                                                                                            [elementName isEqualToString:@"pictureLink"] ||
                                                                                            [elementName isEqualToString:@"deepid"] ||
                                                                                            [elementName isEqualToString:@"pictureLogo"]) {
                                                                                     
                                                                                     [obj setValue:value forKey:elementName];
                                                                                 }
                                                                             } else if ([elementName isEqualToString:FSTOPIC_OBJECT_NODE]) {
                                                                                 [storeObj finalizeEntityWithEntityName:FSTOPIC_ENTITYNAME];
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
