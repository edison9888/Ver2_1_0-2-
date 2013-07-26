//
//  FSBaseGETXMLDAO.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-7.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSBaseGETDAO.h"
#import "FSBaseXMLParserObject.h"


@interface FSBaseGETXMLDAO : FSBaseGETDAO <NSXMLParserDelegate> {
@private
	 NSMutableArray *_elementStack;
}

@end
