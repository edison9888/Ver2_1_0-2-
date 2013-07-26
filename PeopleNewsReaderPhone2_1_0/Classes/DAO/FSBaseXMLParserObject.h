//
//  FSBaseXMLParserObject.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-24.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FSBaseXMLParserObjectDelegate;

@interface FSBaseXMLParserObject : NSObject <NSXMLParserDelegate> {
@private
	NSMutableArray *_xmlElementStack;
	NSMutableDictionary *_xmlKVObjects;
	
	id<FSBaseXMLParserObjectDelegate> _parentDelegate;
	NSString *_objectNodeElementName;
	BOOL _startPushElementName;
}

- (id)initWithData:(NSData *)data withDelegate:(id<FSBaseXMLParserObjectDelegate>)delegate;

@end

@protocol FSBaseXMLParserObjectDelegate
//************************************************************
//	解析完成
//************************************************************
- (void)baseXMLParserComplete:(FSBaseXMLParserObject *)sender;

//************************************************************
//	解析回传一个结果，可能是NSArray、NSDictionary
//************************************************************
- (void)baseXMLParserFinishXMLObjectNode:(FSBaseXMLParserObject *)sender withXMLResultObject:(id)resultObject;
@optional
//************************************************************
//	需要从那个节点开始构建回传对象，默认根节点一起返回，可选node作为一个对象回传
//************************************************************
- (NSString *)baseXMLParserSeparatedObjectNodeElementName:(FSBaseXMLParserObject *)sender;

//************************************************************
//	解析发生错误,数据格式不对
//************************************************************
- (void)baseXMLParserError:(FSBaseXMLParserObject *)sender withError:(NSError *)error;
@end



