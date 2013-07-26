//
//  FSDeepCommentDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-2.
//
//

#import "FSDeepCommentDAO.h"
#import "FSDeepCommentObject.h"

#define FSDEEP_COMMENT_URL @"http://mobile.app.people.com.cn:81/topic/topic.php?act=comment_list&rt=xml&type=list&deepid=%@&lastCommentid=%@&count=%d"

#define FSDEEP_COMMENT_TIMESTAMP_URL @"http://mobile.app.people.com.cn:81/topic/topic.php?act=comment_list&rt=xml&type=timestamp&deepid=%@"

#define FSDEEP_COMMENT_TIMESTAMP_FLAG @"DEEP_COMMENT_%@"

#define FSDEEP_COMMENT_INTERVAL (60 * 15)

#define FSDEEP_COMMENT_ENTITY_NODE @"item"

@interface FSDeepCommentDAO()
- (void)inner_GETData;
@end

@implementation FSDeepCommentDAO
@synthesize deepid = _deepid;
@synthesize lastCommentid = _lastCommentid;
@synthesize pageCount = _pageCount;

- (id)init {
    self = [super init];
    if (self) {
        _pageCount = 20;
    }
    return self;
}

- (void)dealloc {
    [_lastCommentid release];
    [_deepid release];
    [super dealloc];
}

- (NSUInteger)listLimited {
    return 0;
}

- (NSString *)entityName {
    return NSStringFromClass([FSDeepCommentObject class]);
}

- (NSString *)timestampFlag {
    return [NSString stringWithFormat:FSDEEP_COMMENT_TIMESTAMP_FLAG, _deepid];
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
        [self initializeBufferData];
        
        BOOL isRefresh = (_lastCommentid == nil || [_lastCommentid isEqualToString:@""]);
        if (isRefresh) {
            self.lastCommentid = @"";
            self.timestampObject.forceRefreshRemoteData = self.foreceRefreshRemoteData;
            [self.timestampObject dataTimestampWithURLString:[NSString stringWithFormat:FSDEEP_COMMENT_TIMESTAMP_URL, _deepid]
                                      networkRequestInterval:FSDEEP_COMMENT_INTERVAL
                                  networkTimestampCompletion:^(NetworkDataTimestampResult result) {
                                      if (result == NetworkDataTimestampResult_NoRequest) {
                                          return;
                                      }
                                      
                                      //
                                      [self inner_GETData];
                                      
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
        } else {
            [self inner_GETData];
        }
        
    });
    dispatch_release(queue);
}

- (void)inner_GETData {
    if (checkNetworkIsValid()) {
        [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_NetworkErrorStatus];
        return;
    }
    
    [FSHTTPWebExData HTTPGetDataWithURLString:[NSString stringWithFormat:FSDEEP_COMMENT_URL, _deepid, _lastCommentid, _pageCount]
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
                                           if ([elementName isEqualToString:FSDEEP_COMMENT_ENTITY_NODE]) {
                                               FSDeepCommentObject *commentObj = [storeObj insertObjectWithEntityName:[self entityName]];
                                               commentObj.deepid = _deepid;
                                               NSNumber *numberTimestamp = [[NSNumber alloc] initWithDouble:self.timestampObject.networkTimestamp];
                                               commentObj.batchtimestamp = numberTimestamp;
                                               [numberTimestamp release];
                                           }
                                       } else if (operationKind == ElementOperationKind_End) {
                                           if ([parentElementName isEqualToString:FSDEEP_COMMENT_ENTITY_NODE]) {
                                               FSDeepCommentObject *commentObj = [storeObj objectWithEntity:[self entityName]];
                                               if ([elementName isEqualToString:@"commentid"] ||
                                                   [elementName isEqualToString:@"pubDatetime"] ||
                                                   [elementName isEqualToString:@"commentMsg"] ||
                                                   [elementName isEqualToString:@"author"]) {
                                                   [commentObj setValue:value forKey:elementName];
                                               } else if ([elementName isEqualToString:@"timestamp"]) {
                                                   NSNumber *numberTimestamp = [[NSNumber alloc] initWithDouble:[value doubleValue]];
                                                   commentObj.timestamp = numberTimestamp;
                                                   [numberTimestamp release];
                                               }
                                           } else if ([elementName isEqualToString:FSDEEP_COMMENT_ENTITY_NODE]) {
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
                                  } else  {
                                      [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_DataFormatErrorStatus];
                                  }
                                  
                                  [storeObj release];
                                  [parserObj release];
                              }];
}

@end
