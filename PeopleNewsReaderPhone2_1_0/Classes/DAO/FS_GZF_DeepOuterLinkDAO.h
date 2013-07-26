//
//  FS_GZF_DeepOuterLinkDAO.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-12-27.
//
//

#import <Foundation/Foundation.h>
#import "FS_GZF_BaseGETDitailDAO.h"

@class FSDeepOuterObject;

@interface FS_GZF_DeepOuterLinkDAO : FS_GZF_BaseGETDitailDAO{
@protected
    FSDeepOuterObject *_obj;
    NSString *_deepid;
}


@property (nonatomic,retain) NSString *deepid;

@end
