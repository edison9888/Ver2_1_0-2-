//
//  FSXMLParserObject.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-19.
//
//

#import <Foundation/Foundation.h>
#import "FSCommonFunction.h"

typedef enum _FSXMLParserResult {
    FSXMLParserResult_Error,
    FSXMLParserResult_Success
} FSXMLParserResult;

typedef enum _ElementOperationKind {
    ElementOperationKind_Begin,
    ElementOperationKind_End
} ElementOperationKind;

typedef void (^parserCompletion)(FSXMLParserResult result);
typedef void (^elementOperation)(NSString *elementName, NSString *parentElementName, NSDictionary *attributes, NSString *value, ElementOperationKind operationKind);

@interface FSXMLParserObject : NSObject <NSXMLParserDelegate> {
@private
    NSMutableArray *_elementStack;
    NSMutableDictionary *_elementValueDic;
    
    elementOperation _elementOperation;
}


- (void)parserData:(NSData *)data completion:(parserCompletion)completion elementOperationFunc:(elementOperation)elementOperationFunc;

@end
