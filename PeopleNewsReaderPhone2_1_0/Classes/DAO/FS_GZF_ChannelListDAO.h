//
//  FS_GZF_ChannelListDAO.h
//  PeopleNewsReaderPhone
//
//  Created by Xu dandan on 12-10-28.
//
//

#import <Foundation/Foundation.h>
#import "FS_GZF_BaseGETXMLDataListDAO.h"

@class FSChannelObject;

@interface FS_GZF_ChannelListDAO : FS_GZF_BaseGETXMLDataListDAO{
@protected
    FSChannelObject *_obj;
    NSString *_type;
}

@property (nonatomic,retain) NSString *type;

@end
