//
//  FSTopicAbstractDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-23.
//
//

#import "FSTopicAbstractDAO.h"
#import "FSTopicAbstractObject.h"

#define FSTOPICABSTRACT_ENTITYNAME @"FSTopicAbstractObject"
#define FSTOPICABSTRACT_TIMESTAMP_FLAG @"TOPICABSTRACT_%@"

#define FSTOPICABSTRACT_URL @"http://mobile.app.people.com.cn:81/news2/topic.php?act=list&rt=xml&type=list"
#define FSTOPICABSTRACT_TIMESTAMP_URL @"http://mobile.app.people.com.cn:81/news2/topic.php?act=list&rt=xml&type=timestamp"

#define FSTOPICABSTRACT_INTERVAL (60 * 60.0f)

@implementation FSTopicAbstractDAO
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
    return [NSString stringWithFormat:FSTOPICABSTRACT_TIMESTAMP_FLAG, _deepid];
}

- (NSString *)entityName {
    return FSTOPICABSTRACT_ENTITYNAME;
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
        [self.timestampObject dataTimestampWithURLString:FSTOPICABSTRACT_TIMESTAMP_URL
                                  networkRequestInterval:FSTOPICABSTRACT_INTERVAL
                              networkTimestampCompletion:^(NetworkDataTimestampResult result) {
                                  if (result == NetworkDataTimestampResult_Request) {
                                      [FSHTTPWebExData HTTPGetDataWithURLString:FSTOPICABSTRACT_URL
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
                                                                             
                                                                         } else if (operationKind == ElementOperationKind_End) {
                                                                             
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
