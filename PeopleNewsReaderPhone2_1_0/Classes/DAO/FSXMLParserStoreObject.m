//
//  FSXMLParserStoreObject.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-19.
//
//

#import "FSXMLParserStoreObject.h"

@implementation FSXMLParserStoreObject
@synthesize context = _context;

- (id)init {
    self = [super init];
    if (self) {
        _context = [[[GlobalConfig shareConfig] newManagedObjectContext] retain];
        _elementStack = [[NSMutableArray alloc] init];
        _elementValueDic = [[NSMutableDictionary alloc] init];
        _entitiesDic = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)dealloc {
    [_elementStack release];
    [_elementValueDic release];
    [_entitiesDic release];
    [_context release];
    [super dealloc];
}

- (void)parserStoreData:(NSData *)data completion:(void(^)(FSXMLParserStore_Result result))completion elementInitializeFunc:(elementInitialize)initializeFunc elementFinallizeFunc:(elementFinallize)finallizeFunc {
    
//    _elementInitialize = Block_copy(initializeFunc);
//    _elementFinallize = Block_copy(finallizeFunc);
    _elementInitialize = [initializeFunc copy];
    _elementFinallize = [finallizeFunc copy];
    
    NSXMLParser *parserObj = [[NSXMLParser alloc] initWithData:data];
    parserObj.delegate = self;
    BOOL parserSuccess = [parserObj parse];
    [parserObj release];
    
    BOOL storeSuccess = NO;
    if (parserSuccess) {
        if ([_context hasChanges]) {
            NSError *error = nil;
            if ([_context save:&error]) {
                storeSuccess = YES;
            } else {
#ifdef  MYDEBUG
                NSLog(@"%@.store local core data.error:%@", self, error);
#endif
            }
        }
    } else {
        if ([_context hasChanges]) {
            [_context undo];
            [_context rollback];
        }
    }
    
    FSXMLParserStore_Result rst = FSXMLParserStore_Result_Successful;
    if (!parserSuccess) {
        rst = FSXMLParserStore_Result_ParserError;
    }
    
    if (!storeSuccess) {
        rst = FSXMLParserStore_Result_StoreError;
    }
    
    completion(rst);
//    Block_release(_elementFinallize);
//    Block_release(_elementInitialize);
    [_elementInitialize release];
    [_elementFinallize release];
}

#pragma -
#pragma NSXMLParserDelegate
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
#ifdef MYDEBUG
    NSLog(@"%@.parserXML.Error:%@", self, parseError);
#endif
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    [_elementStack addObject:elementName];
    NSObject *elementObj = _elementInitialize(elementName, attributeDict, _context); //[self elementNameBegin:elementName attributes:attributeDict];
    if (elementObj != nil) {
        [_entitiesDic setObject:elementObj forKey:elementName];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    NSString *lastElementName = [_elementStack lastObject];
    if ([elementName isEqualToString:lastElementName]) {
        [_elementStack removeLastObject];
        NSObject *entityWithElementName = [_entitiesDic objectForKey:elementName];  //为空，说明元素为对象的属性
        NSString *value = [_elementValueDic objectForKey:elementName];
        NSString *parentElementName = [_elementStack lastObject];
        NSObject *entityWithParentElementName = [_entitiesDic objectForKey:parentElementName];  //不为空也说明对象的属性
        NSObject *entity = entityWithElementName == nil ? entityWithParentElementName : entityWithElementName;
        
        //[self elementNameEnd:elementName parentElementName:parentElementName withObject:entity withValue:value];
        _elementFinallize(elementName, parentElementName, entity, value);
        
        if (entityWithElementName != nil) {
            [_entitiesDic removeObjectForKey:elementName];
        }
        if (value != nil) {
            [_elementValueDic removeObjectForKey:elementName];
        }
#ifdef MYDEBUG
        NSLog(@"_elementStack:%@;_entitiesDic:%@;_elementValueDic:%@", _elementStack, _entitiesDic, _elementValueDic);
#endif
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    NSString *lastElementName = [_elementStack lastObject];
    if (lastElementName != nil && ![lastElementName isEqualToString:@""]) {
        NSString *value = [_elementValueDic objectForKey:lastElementName];
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        [_elementValueDic setObject:stringCat(value, trimString(string)) forKey:lastElementName];
        [pool release];
    }
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock {
    NSString *lastElementName = [_elementStack lastObject];
    if (lastElementName != nil && ![lastElementName isEqualToString:@""]) {
        NSString *value = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        [_elementValueDic setObject:value forKey:lastElementName];
        [value release];
    }
}

@end
