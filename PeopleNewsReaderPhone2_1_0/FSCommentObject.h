//
//  FSCommentObject.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-1-5.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FSBatchNewsObject.h"


@interface FSCommentObject : FSBatchNewsObject

@property (nonatomic, retain) NSString * newsid;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * adminContent;
@property (nonatomic, retain) NSString * adminNickname;
@property (nonatomic, retain) NSString * deviceType;
@property (nonatomic, retain) NSString * nickname;
@property (nonatomic, retain) NSString * commentid;
@property (nonatomic, retain) NSString * timestamp;
@property (nonatomic, retain) NSString * adminTimestamp;

@end
