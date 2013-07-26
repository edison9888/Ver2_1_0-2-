//
//  FSDeepPictureDAO.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-2.
//
//

#import <Foundation/Foundation.h>
#import "FSGetSingleDAO.h"


@interface FSDeepPictureDAO : FSGetSingleDAO {
@private
    NSString *_pictureid;
}

@property (nonatomic, retain) NSString *pictureid;

@end
