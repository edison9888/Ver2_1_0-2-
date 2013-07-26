//
//  FSTopicSubjectContentObject.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-24.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FSPictureObject;

@interface FSTopicSubjectContentObject : NSManagedObject

@property (nonatomic, retain) NSString * newsid;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * source;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSNumber * timestamp;
@property (nonatomic, retain) NSSet *pictures;
@end

@interface FSTopicSubjectContentObject (CoreDataGeneratedAccessors)

- (void)addPicturesObject:(FSPictureObject *)value;
- (void)removePicturesObject:(FSPictureObject *)value;
- (void)addPictures:(NSSet *)values;
- (void)removePictures:(NSSet *)values;
@end
