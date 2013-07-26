//
//  FSBasePOSTXMLDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-8.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSBasePOSTXMLDAO.h"


@implementation FSBasePOSTXMLDAO

- (id)init {
	self = [super init];
	if (self) {

	}
	return self;
}

- (void)dealloc {
	
	[super dealloc];
}

- (void)doSomethingInDataReceiveComplete {
#ifdef RESULT_STRING_DEBUG
	NSString *tempXML = [[NSString alloc] initWithData:self.dataBuffer encoding:NSUTF8StringEncoding];
	if (tempXML == NULL) {
		tempXML = [[NSString alloc] initWithData:data encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
	}
	NSLog(@"Current XML\r\n:%@", trimString(tempXML));
	[tempXML release];
#endif
	
	FSBaseXMLParserObject *parserObject = [[FSBaseXMLParserObject alloc] initWithData:self.dataBuffer withDelegate:self];
	[parserObject release];	
	
	self.dataBuffer = nil;
}

#pragma mark -
#pragma mark FSBaseXMLParserObjectDelegate

- (void)baseXMLParserComplete:(FSBaseXMLParserObject *)sender {

	[self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_SuccessfulStatus];
}

- (void)baseXMLParserError:(FSBaseXMLParserObject *)sender withError:(NSError *)error {
	[self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_DataFormatErrorStatus];
	[self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_SuccessfulStatus];
}

- (void)baseXMLParserFinishXMLObjectNode:(FSBaseXMLParserObject *)sender withXMLResultObject:(id)resultObject {
	//完成一个对象
	
}


@end
