//
//  FSDeepInvestigatePOSTDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-6.
//
//

#import "FSDeepInvestigatePOSTDAO.h"
#import "FSDeepInvestigate_OptionObject.h"
#import "FSDeepInvestigateObject.h"

#define FSDEEP_POST_INVESTIGATE_URL @"http://mobile.app.people.com.cn:81/topic/topic.php?act=vote_result&rt=xml"

#define FSDEEP_INVESTIGATE_OPTION_NODE @"investigate"

@implementation FSDeepInvestigatePOSTDAO
@synthesize investigateid = _investigateid;
@synthesize investigateOptions = _investigateOptions;

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc {
    [_investigateOptions release];
    [_investigateid release];
    [super dealloc];
}

- (void)POSTData:(HTTPPOSTDataKind)postKind {
    dispatch_queue_t queue = dispatch_queue_create(NULL, NULL);
	dispatch_async(queue, ^(void) {
		if (!checkNetworkIsValid()) {
			[self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_NetworkErrorStatus];
		} else {
			NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
			
			NSString *URLString = FSDEEP_POST_INVESTIGATE_URL;
			
			if (URLString == nil || [URLString isEqual:@""]) {
				[self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_URLErrorStatus];
			} else {
                
                
				[self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_WorkingStatus];
				//investigateid=1&orderKeys=1#2
				NSMutableArray *postParameters = [[NSMutableArray alloc] init];
				//加入参数
                FSHTTPPOSTItem *investigateidItem = [[FSHTTPPOSTItem alloc] initWithName:@"investigateid" withValue:_investigateid];
                [postParameters addObject:investigateidItem];
                [investigateidItem release];
                
                NSMutableString *keys = [[NSMutableString alloc] init];
                for (FSDeepInvestigate_OptionObject *optionObj in _investigateOptions) {
                    [keys appendFormat:@"%@#", optionObj.orderKey];
                }
                
                FSHTTPPOSTItem *optionsItem = [[FSHTTPPOSTItem alloc] initWithName:@"orderKeys" withValue:keys];
                [postParameters addObject:optionsItem];
                [optionsItem release];
                [keys release];
                
				
                [FSHTTPWebExData HTTPPostDataWithURLString:URLString
                                            withParameters:postParameters
                                        withStringEncoding:self.stringEncoding
                                      withHTTPPOSTDataKind:postKind
                                           blockCompletion:^(NSData *data, BOOL success) {
                                               //返回数据解析处理
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
                                               __block NSMutableDictionary *invetigateOption = [[NSMutableDictionary alloc] init];
                                               
                                               [parserObj parserData:data
                                                          completion:^(FSXMLParserResult result) {
                                                              if (result == FSXMLParserResult_Success) {
                                                                  parserSuccess = YES;
                                                              }
                                                          }
                                                elementOperationFunc:^(NSString *elementName, NSString *parentElementName, NSDictionary *attributes, NSString *value, ElementOperationKind operationKind) {
                                                    if (operationKind == ElementOperationKind_Begin) {
                                                        if ([elementName isEqualToString:FSDEEP_INVESTIGATE_OPTION_NODE]) {
                                                            [invetigateOption removeAllObjects];
                                                        }
                                                    } else if (operationKind == ElementOperationKind_End) {
                                                        if ([elementName isEqualToString:@"errorCode"]) {
                                                            self.errorCode = [value intValue];
                                                        } else if ([parentElementName isEqualToString:FSDEEP_INVESTIGATE_OPTION_NODE]) {
                                                            [invetigateOption setValue:value forKey:elementName];
                                                        } else if ([elementName isEqualToString:FSDEEP_INVESTIGATE_OPTION_NODE]) {
                                                            FSDeepInvestigateObject *investigateObj = [storeObj objectWithPrimaryKeyName:@"investigateid"
                                                                                                                        withPrimaryValue:_investigateid
                                                                                                                          withEntityName:NSStringFromClass([FSDeepInvestigateObject class])
                                                                                                                           withNewEntity:NO];
                                                            FSLog(@"find investagetObj:%@", investigateObj);
                                                            if (investigateObj) {
                                                                NSSet *childSet = investigateObj.investages;
                                                                [childSet enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
                                                                    FSDeepInvestigate_OptionObject *optionObj = obj;
                                                                    if ([optionObj.orderKey isEqualToString:[invetigateOption objectForKey:@"orderKey"]]) {
                                                                        FSLog(@"orderKey:%@", optionObj.orderKey);
                                                                        NSNumber *numberTotalCount = [[NSNumber alloc] initWithInt:[[invetigateOption objectForKey:@"totalCount"] intValue]];
                                                                        optionObj.totalCount = numberTotalCount;
                                                                        [numberTotalCount release];
                                                                        *stop = YES;
                                                                    }
                                                                }];
                                                            }
                                                            
                                                        }
                                                    }
                                                }];
                                               
                                               if (parserSuccess) {
                                                   if (self.errorCode == 0) {
                                                       [storeObj finalizeAllObjects:^(BOOL saveSuccessful) {
                                                           //do not anything
                                                       }];
                                                   } else {
                                                       FSLog(@"提交调查失败了。");
                                                   }
                                                   
                                                   [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_SuccessfulStatus];
                                               } else {
                                                   [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_DataFormatErrorStatus];
                                               }
                                               
                                               [invetigateOption release];
                                               [storeObj release];
                                               [parserObj release];
                                           }];
				
				[postParameters release];
                [pool release];
			}
		}
        
	});
	dispatch_release(queue);
}


@end
