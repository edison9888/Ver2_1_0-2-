//
//  FSDeepContent_TextObject.h
//  PeopleNewsReaderPhone
//
//  Created by chen guoshuang on 12-11-4.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FSDeepContent_TextObject : NSManagedObject

@property (nonatomic, retain) NSNumber * orderIndex;
@property (nonatomic, retain) NSString * text;

@end
