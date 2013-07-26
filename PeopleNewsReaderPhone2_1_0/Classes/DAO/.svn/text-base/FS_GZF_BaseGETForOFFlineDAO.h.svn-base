//
//  FS_GZF_BaseGETForOFFlineDAO.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-11-20.
//
//

#import <Foundation/Foundation.h>
#import "FSBaseDAO.h"

typedef enum _FSGETForOFFlineCallBackStatus{
    FSGETForOFFline_UnknowStatus = 0,
    FSGETForOFFline_WorkingStatus,							//开始工作
	FSGETForOFFline_SuccessfulStatus,							//成功完成网络连接
	FSGETForOFFline_HostErrorStatus,							//不能连接主机
	FSGETForOFFline_NetworkErrorStatus,						//网络连接错误
	FSGETForOFFline_NetworkErrorAndNoBufferStatus,			//网络不可用，并且没有缓存数据
	FSGETForOFFline_DataFormatErrorStatus,					//数据格式解析错误，要容错
	FSGETForOFFline_URLErrorStatus,							//URL错误
	FSGETForOFFline_UnknowErrorStatus,						//未知错误
	FSGETForOFFline_POSTDataZeroErrorStatus,
	FSGETForOFFline_ConnectionCacnelStatus,
    FSGETForOFFline_StopWorkingStatus

    
}FSGETForOFFlineCallBackStatus;

@protocol FSGETForOFFlineDAODelegate;

@interface FS_GZF_BaseGETForOFFlineDAO : NSObject<FSBaseDAODelegate>{
@protected
    id _parentDelegate;
    UIView *_parentView;
}


@property (nonatomic,assign) id parentDelegate;
@property (nonatomic,retain) UIView *parentView;


-(void)getDataForOFFline;
-(void)doSomethingWithDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status;


@end


@protocol FSGETForOFFlineDAODelegate 
@optional

-(void)getDataUnitBegin:(FS_GZF_BaseGETForOFFlineDAO *)sender;
-(void)getDataUnitEnd:(FS_GZF_BaseGETForOFFlineDAO *)sender;

-(void)getAllDataComplete:(FS_GZF_BaseGETForOFFlineDAO *)sender;

@end