//
//  FS_GZF_GetNewsDataForOFFlineDAO.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-11-21.
//
//

#import <Foundation/Foundation.h>
#import "FS_GZF_BaseGETForOFFlineDAO.h"

@class FS_GZF_ForOnedayNewsFocusTopDAO,FS_GZF_ForOneDayNewsListDAO,FS_GZF_ForNewsListDAO,FS_GZF_ForLocalNewsListDAO,FS_GZF_CityListDAO,FS_GZF_NewsContainerDAO,FS_GZF_CommentListDAO;

@interface FS_GZF_GetNewsDataForOFFlineDAO : FS_GZF_BaseGETForOFFlineDAO{
@protected
    FS_GZF_ForOnedayNewsFocusTopDAO *_fs_GZF_ForOnedayNewsFocusTopDAO;
    FS_GZF_ForOneDayNewsListDAO *_fs_GZF_ForOneDayNewsListDAO;
    FS_GZF_ForNewsListDAO *_fs_GZF_ForNewsListDAO;
    FS_GZF_CityListDAO *_fs_GZF_CityListDAO;
    FS_GZF_ForLocalNewsListDAO *_fs_GZF_ForLocalNewsListDAO;
    FS_GZF_NewsContainerDAO *_fs_GZF_NewsContainerDAO;
    FS_GZF_CommentListDAO *_fs_GZF_CommentListDAO;
    
    NSArray *_array;
    NSInteger _index;
}


-(void)getFocusNewsList;

-(void)getChannelList;

-(void)getCityList;


-(void)getOneDayNewsList;

-(void)getNomolNewsList;

-(void)getLocalNewsList;


-(void)getNewsContain;

@end
