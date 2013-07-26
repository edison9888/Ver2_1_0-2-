//
//  FSDeepTextDAO.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-2.
//
//

#import <Foundation/Foundation.h>
#import "FSGetSingleDAO.h"


@interface FSDeepTextDAO : FSGetSingleDAO {
@private
    NSString *_contentid;
}

@property (nonatomic, retain) NSString *contentid;

- (NSInteger)pictureFlag;
- (NSInteger)textFlag;

@end
