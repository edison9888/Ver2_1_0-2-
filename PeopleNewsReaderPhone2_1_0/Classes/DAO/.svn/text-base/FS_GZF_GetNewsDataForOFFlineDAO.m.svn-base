//
//  FS_GZF_GetNewsDataForOFFlineDAO.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-11-21.
//
//

#import "FS_GZF_GetNewsDataForOFFlineDAO.h"

#import "FS_GZF_ForOnedayNewsFocusTopDAO.h"
#import "FS_GZF_ForOneDayNewsListDAO.h"
#import "FS_GZF_ForNewsListDAO.h"
#import "FS_GZF_CityListDAO.h"
#import "FS_GZF_ForLocalNewsListDAO.h"
#import "FS_GZF_NewsContainerDAO.h"
#import "FS_GZF_CommentListDAO.h"

#import "FSBaseDB.h"
#import "FSChannelObject.h"
#import "FSCityObject.h"
#import "FSFocusTopObject.h"



@implementation FS_GZF_GetNewsDataForOFFlineDAO

- (id)init {
	self = [super init];
	if (self) {
		
	}
	return self;
}

- (void)dealloc {
#ifdef MYDEBUG
	NSLog(@"DAO.dealloc:%@", self);
#endif
    
    [_fs_GZF_ForOnedayNewsFocusTopDAO release];
    
    
	[super dealloc];
}

-(void)getDataForOFFline{
    _fs_GZF_ForOnedayNewsFocusTopDAO = [[FS_GZF_ForOnedayNewsFocusTopDAO alloc] init];
    _fs_GZF_ForOnedayNewsFocusTopDAO.group = @"oneday";
    _fs_GZF_ForOnedayNewsFocusTopDAO.parentDelegate = self;
    
    
    _fs_GZF_ForOneDayNewsListDAO = [[FS_GZF_ForOneDayNewsListDAO alloc] init];
    _fs_GZF_ForOneDayNewsListDAO.parentDelegate = self;
    
    
    _fs_GZF_ForNewsListDAO = [[FS_GZF_ForNewsListDAO alloc] init];
    _fs_GZF_ForNewsListDAO.parentDelegate = self;
    
    
    _fs_GZF_CityListDAO = [[FS_GZF_CityListDAO alloc] init];
    _fs_GZF_CityListDAO.parentDelegate = self;
    
    _fs_GZF_ForLocalNewsListDAO = [[FS_GZF_ForLocalNewsListDAO alloc] init];
    _fs_GZF_ForLocalNewsListDAO.parentDelegate = self;
    
    [_fs_GZF_ForOnedayNewsFocusTopDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
    
}

-(void)doSomethingWithDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status{
    
    //一天新闻大图完成
    if ([sender isEqual:_fs_GZF_ForOnedayNewsFocusTopDAO] && [_fs_GZF_ForOnedayNewsFocusTopDAO.group isEqualToString:@"oneday"]) {
        if (status == FSBaseDAOCallBack_SuccessfulStatus) {
            [_fs_GZF_ForOneDayNewsListDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
            
        }
        return;
    }
    
    //一天新闻列表完成
    if ([sender isEqual:_fs_GZF_ForOneDayNewsListDAO]) {
        if (status == FSBaseDAOCallBack_SuccessfulStatus) {
            _fs_GZF_ForOnedayNewsFocusTopDAO.group = @"nomol_focus";
            [_fs_GZF_ForOnedayNewsFocusTopDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
            
        }
        return;
    }
    
    //普通新闻大图完成
    if ([sender isEqual:_fs_GZF_ForOnedayNewsFocusTopDAO] && [_fs_GZF_ForOnedayNewsFocusTopDAO.group isEqualToString:@"nomol_focus"]) {
        if (status == FSBaseDAOCallBack_SuccessfulStatus) {
            [_fs_GZF_CityListDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
            
        }
        return;
    }
    
    //城市列表完成
    if ([sender isEqual:_fs_GZF_CityListDAO]) {
        if (status == FSBaseDAOCallBack_SuccessfulStatus) {
            [self getChannelList];
        }
        return;
    }
    
    
    //普通新闻列表完成
    if ([sender isEqual:_fs_GZF_ForNewsListDAO]) {
        if (status == FSBaseDAOCallBack_SuccessfulStatus) {
            [_fs_GZF_CityListDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
            [self getNomolNewsList];
        }
        return;
    }
    
   
    
    //本地新闻列表完成
    if ([sender isEqual:_fs_GZF_ForLocalNewsListDAO]) {
        if (status == FSBaseDAOCallBack_SuccessfulStatus) {
            [self getLocalNewsList];
            return;
        }
    }
    
    /*
     if ([_parentDelegate respondsToSelector:@selector(getAllDataComplete:)]) {
     [_parentDelegate getAllDataComplete:self];
     }
    */

}

//*********************************************************

-(void)getChannelList{
    _array = [[FSBaseDB sharedFSBaseDB] getAllObjectsSortByKey:@"FSChannelObject" key:@"channelid" ascending:YES];
    _index = 0;
    [self getNomolNewsList];
}


-(void)getFocusNewsList{
    
    _array = [[FSBaseDB sharedFSBaseDB] getAllObjectsSortByKey:@"FSFocusTopObject" key:@"newsid" ascending:NO];
    _index = 0;
    [self getNewsContain];
}

-(void)getCityList{
    _array = [[FSBaseDB sharedFSBaseDB] getAllObjectsSortByKey:@"FSCityObject" key:@"provinceId" ascending:YES];
    _index = 0;
    [self getLocalNewsList];
}


-(void)getOneDayNewsList{
    
}

-(void)getNomolNewsList{
    if (_index<[_array count]) {
        FSChannelObject *o = [_array objectAtIndex:_index];
        _fs_GZF_ForNewsListDAO.channelid = o.channelid;
        [_fs_GZF_ForNewsListDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
        _index ++;
    }
    else{
        [self getCityList];
    }
}

-(void)getLocalNewsList{
    if (_index<[_array count]) {
        FSCityObject *o = [_array objectAtIndex:_index];
        _fs_GZF_ForLocalNewsListDAO.provinceid = o.provinceId;
        [_fs_GZF_ForLocalNewsListDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
        _index ++;
    }
    else{
        [self getFocusNewsList];
    }

    
}

-(void)getNewsContain{
    
}


@end
