//
//  FSChannelObject.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-9-27.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface FSChannelObject :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * channel_normal;
@property (nonatomic, retain) NSString * channel_selected;
@property (nonatomic, retain) NSString * channel_highlight;
@property (nonatomic, retain) NSString * channelname;
@property (nonatomic, retain) NSString * channel_request;
@property (nonatomic, retain) NSString * channelid;
@property (nonatomic, retain) NSNumber * channelindex;

@end



