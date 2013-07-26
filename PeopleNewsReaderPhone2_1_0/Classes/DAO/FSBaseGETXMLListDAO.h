//
//  FSBaseGETXMLListDAO.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-8.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSBaseGETXMLDAO.h"

@interface FSBaseGETXMLListDAO : FSBaseGETXMLDAO {
@private
	NSArray *_objectList;
	
}

@property (nonatomic, retain) NSArray *objectList;


@end
