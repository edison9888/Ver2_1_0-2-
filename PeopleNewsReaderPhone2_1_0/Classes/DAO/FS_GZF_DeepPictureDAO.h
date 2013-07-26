//
//  FS_GZF_DeepPictureDAO.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-12-27.
//
//

#import <Foundation/Foundation.h>
#import "FS_GZF_BaseGETDitailDAO.h"

@class FSDeepPictureObject;


@interface FS_GZF_DeepPictureDAO : FS_GZF_BaseGETDitailDAO{
@protected
    FSDeepPictureObject *_obj;
    NSString *_deepid;
}

@property (nonatomic,retain) NSString *deepid;

@end
