//
//  FSDeepPictureObject.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-1-6.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FSBatchAbsObject.h"


@interface FSDeepPictureObject : FSBatchAbsObject

@property (nonatomic, retain) NSString * picture;
@property (nonatomic, retain) NSString * pictureid;
@property (nonatomic, retain) NSString * pictureText;

@end
