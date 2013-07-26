//
//  FSXMLParserStoreObject.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-19.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "GlobalConfig.h"
#import "FSCommonFunction.h"

typedef enum _FSXMLParserStore_Result {
    FSXMLParserStore_Result_Successful,
    FSXMLParserStore_Result_ParserError,
    FSXMLParserStore_Result_StoreError
} FSXMLParserStore_Result;


typedef void (^parserStoreCompletion)(FSXMLParserStore_Result result);
typedef NSObject* (^elementInitialize)(NSString *elementName, NSDictionary *attributes, NSManagedObjectContext *context);
typedef void (^elementFinallize)(NSString *elementName, NSString *parentElementName, NSObject *object, NSString *value);

@interface FSXMLParserStoreObject : NSObject <NSXMLParserDelegate> {
@private
    NSManagedObjectContext *_context;
    NSMutableArray *_elementStack;
    NSMutableDictionary *_elementValueDic;
    NSMutableDictionary *_entitiesDic;
    
    elementFinallize _elementFinallize;
    elementInitialize _elementInitialize;
}

@property (nonatomic, readonly) NSManagedObjectContext *context;

- (void)parserStoreData:(NSData *)data completion:(void(^)(FSXMLParserStore_Result result))completion elementInitializeFunc:(elementInitialize)initializeFunc elementFinallizeFunc:(elementFinallize)finallizeFunc;


@end
