//
//  FSXMLParserObject.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-19.
//
//

#import "FSXMLParserObject.h"

@implementation FSXMLParserObject

- (id)init {
    self = [super init];
    if (self) {
        _elementStack = [[NSMutableArray alloc] init];
        _elementValueDic = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)dealloc {
#ifdef MYDEBUG
    NSLog(@"%@.dealloc.XMLParser.", self);
#endif
    [_elementStack release];
    [_elementValueDic release];
    [super dealloc];
}

- (void)parserData:(NSData *)data completion:(parserCompletion)completion elementOperationFunc:(elementOperation)elementOperationFunc {
    _elementOperation = [elementOperationFunc copy];
    
    NSXMLParser *parserObj = [[NSXMLParser alloc] initWithData:data];
    parserObj.delegate = self;
    BOOL parserSuccess = [parserObj parse];
    [parserObj release];
    
    FSXMLParserResult rst = FSXMLParserResult_Success;
    if (!parserSuccess) {
        rst = FSXMLParserResult_Error;
    }
    
    completion(rst);
    
    [_elementOperation release];
}

#pragma -
#pragma NSXMLParserDelegate
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
#ifdef MYDEBUG
    NSLog(@"%@.parserXML.Error:%@", self, parseError);
#endif
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    NSString *parentElementName = [_elementStack lastObject];
    [_elementStack addObject:elementName];
    _elementOperation(elementName, parentElementName, attributeDict, nil, ElementOperationKind_Begin);
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    NSString *lastElementName = [_elementStack lastObject];
    if ([elementName isEqualToString:lastElementName]) {
        [_elementStack removeLastObject];
        NSString *value = [_elementValueDic objectForKey:elementName];
        NSString *parentElementName = [_elementStack lastObject];
        _elementOperation(elementName, parentElementName, nil, value, ElementOperationKind_End);
        if (value != nil) {
            [_elementValueDic removeObjectForKey:elementName];
        }
#ifdef MYDEBUG
        NSLog(@"_elementStack:%@;_elementValueDic:%@", _elementStack, _elementValueDic);
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
