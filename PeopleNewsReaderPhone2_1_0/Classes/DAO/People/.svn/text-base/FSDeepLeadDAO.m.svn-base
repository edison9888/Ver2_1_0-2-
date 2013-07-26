//
//  FSDeepLeadDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-2.
//
//

#import "FSDeepLeadDAO.h"
#import "FSDeepLeadObject.h"


#define FSDEEP_LEAD_FLAG @"DEEP_PAGE_LEAD_%@"

#define FSDEEP_LEAD_URL @"http://mobile.app.people.com.cn:81/topic/topic.php?act=lead&rt=xml&deepid=%@&type=list&iswp=0"

#define FSDEEP_PAGE_ENTITY_NODE @"item"

@implementation FSDeepLeadDAO
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
    return NSStringFromClass([FSDeepLeadObject class]);
}

- (NSString *)timestampFlag {
    return [NSString stringWithFormat:FSDEEP_LEAD_FLAG, _deepid];
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
                                                  [FSHTTPWebExData HTTPGetDataWithURLString:[NSString stringWithFormat:FSDEEP_LEAD_URL, _deepid]
                                                                            blockCompletion:^(NSData *data, BOOL success) {
                                                                                if (!success) {
                                                                                    if (checkNetworkIsValid()) {
                                                                                        [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_NetworkErrorStatus];
                                                                                    } else {
                                                                                        [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_HostErrorStatus];
                                                                                    }
                                                                                    return;
                                                                                }
                                                                                
                                                                                //存储解析
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
                                                                                         if ([elementName isEqualToString:FSDEEP_PAGE_ENTITY_NODE]) {
                                                                                             FSDeepLeadObject *leadObj = [storeObj insertObjectWithEntityName:[self entityName]];
                                                                                             leadObj.deepid = _deepid;
                                                                                             
                                                                                         }
                                                                                     } else if (operationKind == ElementOperationKind_End) {
                                                                                         if ([parentElementName isEqualToString:FSDEEP_PAGE_ENTITY_NODE]) {
                                                                                             FSDeepLeadObject *leadObj = [storeObj objectWithEntity:[self entityName]];
                                                                                             if ([elementName isEqualToString:@"picture"] ||
                                                                                                 [elementName isEqualToString:@"deepTitle"] ||
                                                                                                 [elementName isEqualToString:@"title"] ||
                                                                                                 [elementName isEqualToString:@"leadContent"]) {
                                                                                                 [leadObj setValue:value forKey:elementName];
                                                                                             }
                                                                                         
                                                                                         } else if ([elementName isEqualToString:FSDEEP_PAGE_ENTITY_NODE]) {
                                                                                             [storeObj finalizeEntityWithEntityName:[self entityName]];
                                                                                         }
                                                                                     }
                                                                                 }];
                                                                                
                                                                                if (parserSuccess) {
                                                                                    [storeObj finalizeAllObjects:^(BOOL saveSuccessful) {
                                                                                        
                                                                                        [self.timestampObject saveTimestampWithCleanOldData:^(FSDataTimestampObject *sender, NSManagedObjectContext *context) {
                                                                                            [self deleteOldDataWith:context withOldBatchValue:sender.networkTimestamp];
                                                                                        }];
                                                                                        
                                                                                        if (saveSuccessful) {
                                                                                            [self readDataFromCoreData];
                                                                                            [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_SuccessfulStatus];
                                                                                        } else {
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
