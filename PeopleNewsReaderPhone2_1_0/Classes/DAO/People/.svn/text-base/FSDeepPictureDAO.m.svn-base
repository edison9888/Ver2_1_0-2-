//
//  FSDeepPictureDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-2.
//
//

#import "FSDeepPictureDAO.h"
#import "FSDeepPictureObject.h"

#define FSDEEP_PICTURE_URL @"http://mobile.app.people.com.cn:81/topic/topic.php?act=picture&rt=xml&pictureid=%@"

#define FSDEEP_PCITURE_ENTITY_NODE @"item"

#define FSDEEP_PICTURE_TIMESTAMP_FLAG @"DEEP_PICTURE_%@"

@implementation FSDeepPictureDAO
@synthesize pictureid = _pictureid;

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc {
    [_pictureid release];
    [super dealloc];
}

- (NSString *)entityName {
    return NSStringFromClass([FSDeepPictureObject class]);
}

- (NSString *)timestampFlag {
    return [NSString stringWithFormat:FSDEEP_PICTURE_TIMESTAMP_FLAG, _pictureid];
}

- (NSString *)contentPrimaryKeyName {
    return @"pictureid";
}

- (NSObject *)contentPrimaryValue {
    return _pictureid;
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
                                                  
                                                  [FSHTTPWebExData HTTPGetDataWithURLString:[NSString stringWithFormat:FSDEEP_PICTURE_URL, _pictureid]
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
                                                                                         if ([elementName isEqualToString:FSDEEP_PCITURE_ENTITY_NODE]) {
                                                                                             FSDeepPictureObject *picObj = [storeObj insertObjectWithEntityName:[self entityName]];
                                                                                             NSNumber *numberTimestamp = [[NSNumber alloc] initWithDouble:self.timestampObject.networkTimestamp];
                                                                                             picObj.batchtimestamp = numberTimestamp;
                                                                                             [numberTimestamp release];
                                                                                         }
                                                                                     } else if (operationKind == ElementOperationKind_End) {
                                                                                         if ([parentElementName isEqualToString:FSDEEP_PCITURE_ENTITY_NODE]) {
                                                                                             FSDeepPictureObject *picObj = [storeObj objectWithEntity:[self entityName]];
                                                                                             if ([elementName isEqualToString:@"pictureid"] ||
                                                                                                 [elementName isEqualToString:@"picture"] ||
                                                                                                 [elementName isEqualToString:@"pictureText"]) {
                                                                                                 [picObj setValue:value forKey:elementName];
                                                                                             }
                                                                                         
                                                                                         } else if ([elementName isEqualToString:FSDEEP_PCITURE_ENTITY_NODE]) {
                                                                                             [storeObj finalizeEntityWithEntityName:[self entityName]];
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
