//
//  FSBaseXMLParserObject.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-24.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSBaseXMLParserObject.h"
#import "FSCommonFunction.h"

@interface FSBaseXMLParserObject(PrivateMethod)
- (void)saveNodeObjectWithElementName:(NSString *)elementName;
@end


@implementation FSBaseXMLParserObject

- (void)dealloc {
	[(id)_parentDelegate release];
	
	[_xmlKVObjects release];
	[_xmlElementStack release];
	[_objectNodeElementName release];
	
	[super dealloc];
}
- (id)initWithData:(NSData *)data withDelegate:(id<FSBaseXMLParserObjectDelegate>)delegate {
	self = [super init];
	if (self) {
#ifdef MYDEBUG
		NSString *tempXML = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
		if (tempXML == NULL) {
			tempXML = [[NSString alloc] initWithData:data encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
		}
		NSLog(@"Current XML\r\n:%@", trimString(tempXML));
		[tempXML release];
#endif
		_xmlKVObjects = [[NSMutableDictionary alloc] init];
		_xmlElementStack = [[NSMutableArray alloc] init];
		_startPushElementName = NO;
		
		
		NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
		_parentDelegate = [(id)delegate retain];
		if ([(id)_parentDelegate respondsToSelector:@selector(baseXMLParserSeparatedObjectNodeElementName:)]) {
			_objectNodeElementName = [[_parentDelegate baseXMLParserSeparatedObjectNodeElementName:self] retain];
		} else {
			_objectNodeElementName = nil;
		}
		
		xmlParser.delegate = self;
		@try {
			if ([xmlParser parse]) {
				[_parentDelegate baseXMLParserComplete:self];
			} else {
				
			}
		}
		@catch (NSException * e) {
#ifdef MYDEBUG
			NSLog(@"NSXMLParser.Exception:%@", [e reason]);
#endif
		}
		@finally {
			
		}

		[xmlParser release];
	}
	return self;
}

- (void)saveNodeObjectWithElementName:(NSString *)elementName {
	NSMutableDictionary *dicRoot = [[NSMutableDictionary alloc] init];
	[_xmlKVObjects setObject:dicRoot forKey:elementName];
	[dicRoot release];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
#ifdef MYDEBUG
	NSLog(@"XMLParser Error:%@[%d][%@]", [parseError localizedDescription], [parseError code], self);
#endif
	
	[_xmlKVObjects removeAllObjects];
	[_xmlElementStack removeAllObjects];
	//回调错误
	
	if ([(id)_parentDelegate respondsToSelector:@selector(baseXMLParserError:)]) {
		[_parentDelegate baseXMLParserError:self withError:parseError];
	}
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	if (_objectNodeElementName == nil) {
		if ([_xmlKVObjects count] == 0) {
			//根
			[self saveNodeObjectWithElementName:elementName];
		} else {
			
		}
		
		[_xmlElementStack addObject:elementName];
	} else {
		if ([elementName isEqualToString:_objectNodeElementName]) {
			[self saveNodeObjectWithElementName:elementName];
			_startPushElementName = YES;
		}
		if (_startPushElementName) {
			[_xmlElementStack addObject:elementName];
		}
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	NSString *lastElementName = [_xmlElementStack lastObject];
#ifdef MYDEBUG
//	NSLog(@"_xmlElementStack.begin:%@", _xmlElementStack);
//	NSLog(@"_xmlKVObjects.begin:%@", _xmlKVObjects);
#endif
	if ([lastElementName isEqualToString:elementName]) {
		//移除最后的元素
		if ([_xmlElementStack count] > 0) {
			[_xmlElementStack removeLastObject];
			if ([_xmlElementStack count] > 0) {
				//取出最后元素的对应的值
				id value = [_xmlKVObjects objectForKey:elementName];
				
				//取当前值的对应的父对象
				lastElementName = [_xmlElementStack lastObject];
				id lastObject = [_xmlKVObjects objectForKey:lastElementName];
				if (lastObject == nil) {
					NSMutableDictionary *dicObject = [[NSMutableDictionary alloc] init];
					[dicObject setObject:value forKey:elementName];
					[_xmlKVObjects setObject:dicObject forKey:lastElementName];
					[dicObject release];
				} else {
					if ([lastObject isKindOfClass:[NSMutableDictionary class]]) {
						id otherValue = [(NSMutableDictionary *)lastObject objectForKey:elementName];
						if (otherValue == nil) {
							[(NSMutableDictionary *)lastObject setObject:value forKey:elementName];
						} else {
							//改变对象类型
							NSMutableArray *listObject = [[NSMutableArray alloc] init];
							[listObject addObject:otherValue];
							[listObject addObject:value];
							[_xmlKVObjects setObject:listObject forKey:lastElementName];
							[listObject release];
						}
					} else if ([lastObject isKindOfClass:[NSMutableArray class]]) {
						[(NSMutableArray *)lastObject addObject:value];
					}
				}
			} else {
				if (_objectNodeElementName != nil) {
					_startPushElementName = NO;
				}
				
				if ([(id)_parentDelegate respondsToSelector:@selector(baseXMLParserFinishXMLObjectNode:withXMLResultObject:)]) {
					[_parentDelegate baseXMLParserFinishXMLObjectNode:self withXMLResultObject:[_xmlKVObjects objectForKey:elementName]];
				}
			}
			
			[_xmlKVObjects removeObjectForKey:elementName];
		}
	} else {
#ifdef MYDEBUG
		NSLog(@"元素出现空.");
#endif
	}

#ifdef MYDEBUG
//	NSLog(@"_xmlElementStack.end:%@", _xmlElementStack);
//	NSLog(@"_xmlKVObjects.end:%@", _xmlKVObjects);
#endif	
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	NSString *lastElementName = [_xmlElementStack lastObject];
#ifdef MYDEBUG
//	NSLog(@"string.lastElementName:%@[%@]", lastElementName, string);
#endif
	NSString *stringValue = trimString(string);
	if (![stringValue isEqualToString:@""] && lastElementName != nil) {
		id value = [_xmlKVObjects objectForKey:lastElementName];
		if (value == nil || [value isKindOfClass:[NSString class]]) {
			[_xmlKVObjects setObject:stringCat((NSString *)value, stringValue) forKey:lastElementName];
		} else {
			//忽略根的字符串
		}
	}
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock {
	NSString *lastElementName = [_xmlElementStack lastObject];
#ifdef MYDEBUG
//	NSLog(@"CDATABlock.lastElementName:%@[%@]", lastElementName, CDATABlock);
#endif
	if (lastElementName != nil) {
		[_xmlKVObjects setObject:CDATABlock forKey:lastElementName];
	}
}


@end
