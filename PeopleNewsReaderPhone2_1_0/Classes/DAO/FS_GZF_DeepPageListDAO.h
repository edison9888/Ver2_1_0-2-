//
//  FS_GZF_DeepPageListDAO.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-12-27.
//
//

#import <Foundation/Foundation.h>
#import "FS_GZF_BaseGETXMLDataListDAO.h"


@class FSDeepPageObject;

@interface FS_GZF_DeepPageListDAO : FS_GZF_BaseGETXMLDataListDAO{
@protected
    FSDeepPageObject *_obj;
    
    NSString *_deepid;
}

@property (nonatomic,retain) NSString *deepid;

@end
