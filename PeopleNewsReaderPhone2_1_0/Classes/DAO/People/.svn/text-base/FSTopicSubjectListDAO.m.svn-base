//
//  FSTopicSubjectListDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-23.
//
//

#import "FSTopicSubjectListDAO.h"
#import "FSTopicSubjectObject.h"

#define FSTOPICSUBJECT_URL @"http://mobile.app.people.com.cn:81/news2/topic.php?act=channel_list&rt=xml&type=list&topic_id=%@"

#define FSTOPICSUBJECT_TIMESTAMP_URL @"http://mobile.app.people.com.cn:81/news2/topic.php?act=channel_list&rt=xml&type=timestamp&topic_id=%@"

#define FSTOPICSUBJECT_TIMESTAMP_FLAG @"FSTOPICSUBJECTLIST_%@"

#define FSTOPICSUBJECT_ENTITYNAME @"FSTopicSubjectObject"

#define FSTOPICSUBJECT_INTERVAL (60 * 30)

#define FSTOPICSUBJECT_ENTITY_NODENAME @"item"

@implementation FSTopicSubjectListDAO
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
    return [NSString stringWithFormat:FSTOPICSUBJECT_TIMESTAMP_FLAG, _deepid];
}

- (NSString *)entityName {
    return FSTOPICSUBJECT_ENTITYNAME;
}

- (void)GETData {
    [super GETData];
    dispatch_queue_t queue = dispatch_queue_create(NULL, NULL);
    dispatch_async(queue, ^(void) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [self readDataFromCoreData];
            [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_BufferSuccessfulStatus];
        });
        
        if (!checkNetworkIsValid()) {
            [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_NetworkErrorStatus];
            return;
        }
        //URL 动态
        [self.timestampObject dataTimestampWithURLString:[NSString stringWithFormat:FSTOPICSUBJECT_TIMESTAMP_URL, _deepid]
                                  networkRequestInterval:FSTOPICSUBJECT_INTERVAL
                              networkTimestampCompletion:^(NetworkDataTimestampResult result) {
                                  if (result == NetworkDataTimestampResult_Request) {
                                      [FSHTTPWebExData HTTPGetDataWithURLString:[NSString stringWithFormat:FSTOPICSUBJECT_URL, _deepid]
                                                                blockCompletion:^(NSData *data, BOOL success) {
                                                                    if (!success) {
                                                                        [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_HostErrorStatus];
                                                                        return;
                                                                    }
                                                                    //返回正确信息
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
                                                                             if ([elementName isEqualToString:FSTOPICSUBJECT_ENTITY_NODENAME]) {
                                                                                 id topicSubjectObj = [storeObj insertObjectWithEntityName:[self entityName]];
                                                                                 NSNumber *batchTimestamp = [[NSNumber alloc] initWithDouble:self.timestampObject.networkTimestamp];
                                                                                 [topicSubjectObj setValue:batchTimestamp forKey:[self batchKeyName]];
                                                                                 [batchTimestamp release];
                                                                             }
                                                                         } else if (operationKind == ElementOperationKind_End) {
                                                                             if ([parentElementName isEqualToString:FSTOPICSUBJECT_ENTITY_NODENAME]) {
                                                                                 id topicSubjectObj = [storeObj objectWithEntity:[self entityName]];
                                                                                 [topicSubjectObj setValue:value forKey:elementName];
                                                                             } else if ([elementName isEqualToString:FSTOPICSUBJECT_ENTITY_NODENAME])
                                                                                 [storeObj finalizeEntityWithEntityName:[self entityName]];
                                                                         }
                                                                     }];
                                                                    
                                                                    if (parserSuccess) {
                                                                        [storeObj finalizeAllObjects:^(BOOL saveSuccessful) {
                                                                            if (saveSuccessful) {
                                                                                [self.timestampObject saveTimestampWithCleanOldData:^(FSDataTimestampObject *sender, NSManagedObjectContext *context) {
                                                                                    //删除旧数据
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
        
        
    });
    dispatch_release(queue);
}

@end
