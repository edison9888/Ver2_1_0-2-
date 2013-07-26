//
//  FSBaseGETXMLDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-7.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSBaseGETXMLDAO.h"


@implementation FSBaseGETXMLDAO

- (id)init {
	self = [super init];
	if (self) {
	}
	return self;
}

- (void)dealloc {
    [_elementStack release];
	[super dealloc];
}

- (void)doSomethingInDataReceiveComplete {
	[self operateOldBufferData];
    
    if (_elementStack == nil) {
        _elementStack = [[NSMutableArray alloc] init];
    } else {
        [_elementStack removeAllObjects];
    }
    if ([self.dataBuffer length] > 0) {
        NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:self.dataBuffer];
        BOOL parserError = [xmlParser parse];
        if (parserError) {
            //
            [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_SuccessfulStatus];
        } else {
            //
            [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_DataFormatErrorStatus];
        }
        [xmlParser release];
    } else {
        //
        [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_DataFormatErrorStatus];
    }
	
//	FSBaseXMLParserObject *parserObject = [[FSBaseXMLParserObject alloc] initWithData:self.dataBuffer withDelegate:self];
//	[parserObject release];	
//	self.dataBuffer = nil;
}

//#pragma mark -
//#pragma mark FSBaseXMLParserObjectDelegate
//
//- (void)baseXMLParserComplete:(FSBaseXMLParserObject *)sender {
//	[self readDataFromBufferWithQueryDataKind:QueryDataKind_New];
//	[self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_SuccessfulStatus];
//}
//
//- (void)baseXMLParserError:(FSBaseXMLParserObject *)sender withError:(NSError *)error {
//	[self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_DataFormatErrorStatus];
//	[self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_SuccessfulStatus];
//}

- (void)baseXMLParserFinishXMLObjectNode:(FSBaseXMLParserObject *)sender withXMLResultObject:(id)resultObject {

}

#pragma -
#pragma NSXMLParserDelegate
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    [_elementStack addObject:elementName];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock {
    
}

@end
