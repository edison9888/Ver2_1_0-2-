//
//  FSOneDayChannelSelectedDAO.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-9-7.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSBasePOSTXMLDAO.h"

@interface FSOneDayChannelSelectedDAO : FSBasePOSTXMLDAO {
@private
	NSArray *_channelIDs;
}

@property (nonatomic, retain) NSArray *channelIDs;

@end
