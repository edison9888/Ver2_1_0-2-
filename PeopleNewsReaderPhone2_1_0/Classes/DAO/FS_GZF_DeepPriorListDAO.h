//
//  FS_GZF_DeepPriorListDAO.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-12-28.
//
//

#import <Foundation/Foundation.h>
#import "FS_GZF_BaseGETXMLDataListDAO.h"


@class FSTopicPriorObject;

@interface FS_GZF_DeepPriorListDAO : FS_GZF_BaseGETXMLDataListDAO{
@protected
    FSTopicPriorObject *_obj;
    NSString *_deepid;
    NSString *_lastDeepid;
}

@property (nonatomic,retain) NSString *deepid;
@property (nonatomic,retain) NSString *lastDeepid;

@end
