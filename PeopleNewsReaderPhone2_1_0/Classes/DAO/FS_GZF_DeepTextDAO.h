//
//  FS_GZF_DeepTextDAO.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-12-27.
//
//

#import <Foundation/Foundation.h>
#import "FS_GZF_BaseGETDitailDAO.h"

#define FSDEEP_TEXT_CHILD_PIC_NODE_FLAG 1
#define FSDEEP_TEXT_CHILD_TXT_NODE_FLAG 2

@class FSDeepContentObject,FSDeepContent_TextObject,FSDeepContent_PicObject,FSDeepContent_ChildObject;

@interface FS_GZF_DeepTextDAO : FS_GZF_BaseGETDitailDAO{
@protected
    
    FSDeepContentObject *_fsDeepContentObject;
    FSDeepContent_TextObject *_fsDeepContent_TextObject;
    FSDeepContent_PicObject *_fsDeepContent_PicObject;
    FSDeepContent_ChildObject *_fsDeepContent_ChildObject;
    
    NSString *_deepid;
    
    NSInteger _picCount;
}

- (NSInteger)pictureFlag;
- (NSInteger)textFlag;


@property (nonatomic,retain) NSString *deepid;
@property (nonatomic,retain) FSDeepContentObject *fsDeepContentObject;

@end
