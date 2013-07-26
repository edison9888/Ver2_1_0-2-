//
//  FS_GZF_DeepEndDAO.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-12-27.
//
//

#import <Foundation/Foundation.h>
#import "FS_GZF_BaseGETDitailDAO.h"


@class FSDeepEndObject;

@interface FS_GZF_DeepEndDAO : FS_GZF_BaseGETDitailDAO{
@protected
    
    FSDeepEndObject *_obj;
    NSString *_deepid;
}

@property (nonatomic,retain) NSString *deepid;

@end
