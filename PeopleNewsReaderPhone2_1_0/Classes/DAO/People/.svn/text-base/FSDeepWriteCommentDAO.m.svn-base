//
//  FSDeepWriteCommentDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-6.
//
//

#import "FSDeepWriteCommentDAO.h"

#define FSDEEP_WRITE_COMMENT_URL @"http://mobile.app.people.com.cn:81/topic/topic.php?act=comment&rt=xml"

@implementation FSDeepWriteCommentDAO
@synthesize deepid = _deepid;
@synthesize commentMsg = _commentMsg;
@synthesize commentid =_commentid;
@synthesize pubDateTime = _pubDateTime;
@synthesize lastTimestamp = _lastTimestamp;
@synthesize totalCount = _totalCount;

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc {
    [_pubDateTime release];
    [_commentid release];
    [_deepid release];
    [_commentMsg release];
    [super dealloc];
}

- (void)POSTData:(HTTPPOSTDataKind)postKind {
    dispatch_queue_t queue = dispatch_queue_create(NULL, NULL);
    dispatch_async(queue, ^{
        if (!checkNetworkIsValid()) {
            [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_NetworkErrorStatus];
            return;
        }
        
        NSMutableArray *postParameters = [[NSMutableArray alloc] init];
        //deepid=335&commentMsg=我顶！
        FSHTTPPOSTItem *deepidItem = [[FSHTTPPOSTItem alloc] initWithName:@"deepid" withValue:_deepid];
        [postParameters addObject:deepidItem];
        [deepidItem release];
        
        FSHTTPPOSTItem *commentMsgItem = [[FSHTTPPOSTItem alloc] initWithName:@"commentMsg" withValue:_commentMsg];
        [postParameters addObject:commentMsgItem];
        [commentMsgItem release];
        
        [FSHTTPWebExData HTTPPostDataWithURLString:FSDEEP_WRITE_COMMENT_URL
                                    withParameters:postParameters
                                withStringEncoding:self.stringEncoding
                              withHTTPPOSTDataKind:postKind
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
                                       
                                       [parserObj parserData:data
                                                  completion:^(FSXMLParserResult result) {
                                                      if (result == FSXMLParserResult_Success) {
                                                          parserSuccess = YES;
                                                      }
                                                  }
                                        elementOperationFunc:^(NSString *elementName, NSString *parentElementName, NSDictionary *attributes, NSString *value, ElementOperationKind operationKind) {
                                            if (operationKind == ElementOperationKind_Begin) {
                                                
                                            } else if (operationKind == ElementOperationKind_End) {
                                                if ([elementName isEqualToString:@"errorCode"]) {
                                                    self.errorCode = [value intValue];
                                                } else if ([elementName isEqualToString:@"timestamp"]) {
                                                    self.lastTimestamp = [value doubleValue];
                                                } else if ([elementName isEqualToString:@"commentid"]) {
                                                    self.commentid = value;
                                                } else if ([elementName isEqualToString:@"pubDatetime"]) {
                                                    self.pubDateTime = value;
                                                } else if ([elementName isEqualToString:@"totalCount"]) {
                                                    self.totalCount = [value intValue];
                                                }
                                            }
                                        }];
                                       
                                       if (parserSuccess) {
                                           [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_SuccessfulStatus];
                                       } else  {
                                           [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_DataFormatErrorStatus];
                                       }
                                       
                                       [parserObj release];
                                       
                                       
                                   }];
        
        [postParameters release];
    });
    dispatch_release(queue);
}


@end
