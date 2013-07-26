//
//  FS_GZF_ForOneDayNewsListDAO.h
//  PeopleNewsReaderPhone
//
//  Created by Xu dandan on 12-10-23.
//
//

#import <Foundation/Foundation.h>
#import "FS_GZF_BaseGETXMLDataListDAO.h"

@class FSOneDayNewsObject;

@interface FS_GZF_ForOneDayNewsListDAO : FS_GZF_BaseGETXMLDataListDAO{
@protected
    
    FSOneDayNewsObject *_obj;
    NSInteger _count;
    
    NSString *_channelList;
    NSString *_visitNOList;
    NSString *_lastid;

    BOOL _SetChannalIcon;
}

@property (nonatomic,retain) NSString *lastid;
@property (nonatomic,retain) NSString *visitNOList;
@property (nonatomic,retain) NSString *channelList;
@property (nonatomic,assign) BOOL SetChannalIcon;

-(NSString *)getGroupName;


-(NSString *)selectChannelListString;

@end
