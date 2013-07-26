//
//  FSBaseGETXMLSingleDAO.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-9-4.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSBaseGETXMLDAO.h"

@interface FSBaseGETXMLSingleDAO : FSBaseGETXMLDAO {
@private
	NSManagedObject *_contentObject;
}

@property (nonatomic, retain) NSManagedObject *contentObject;

@end
