//
//  FSBaseDAO.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-6.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>
#import "FSConst.h"
#import "FSCommonFunction.h"
#import "GlobalConfig.h"


typedef enum _FSBaseDAOCallBackStatus {
	FSBaseDAOCallBack_UnknowStatus = 0,
	FSBaseDAOCallBack_WorkingStatus,							//开始工作
    FSBaseDAOCallBack_ListWorkingStatus,						//开始工作
	FSBaseDAOCallBack_BufferWorkingStatus,						//开始读缓存数据
	FSBaseDAOCallBack_SuccessfulStatus,							//成功完成网络连接
	FSBaseDAOCallBack_BufferSuccessfulStatus,                   //
	FSBaseDAOCallBack_HostErrorStatus,							 //不能连接主机----休息一下，稍后再试
	FSBaseDAOCallBack_NetworkErrorStatus,						 //网络连接错误----网络不给力，再试一下哦
	FSBaseDAOCallBack_NetworkErrorAndNoBufferStatus,			 //网络不可用，并且没有缓存数据----网络不给力，再试一下哦
	FSBaseDAOCallBack_NetworkErrorAndDataIsTailStatus,			//网络不可用并且已经取过缓存数据----网络不给力，再试一下哦
	FSBaseDAOCallBack_DataFormatErrorStatus,					//数据格式解析错误，要容错----网络不给力，再试一下哦
	FSBaseDAOCallBack_URLErrorStatus,							//URL错误----休息一下，稍后再试
	FSBaseDAOCallBack_UnknowErrorStatus,						//未知错误----休息一下，稍后再试
    FSBaseDAOCallBack_OFFlineReadStatus,						//离线阅读
	FSBaseDAOCallBack_POSTDataZeroErrorStatus,
	FSBaseDAOCallBack_ConnectionCacnelStatus,
    FSBaseDAOCallBack_StopWorkingStatus
} FSBaseDAOCallBackStatus;

@protocol FSBaseDAODelegate;

@interface FSBaseDAO : NSObject {
@private
	//NSObject<FSBaseDAODelegate> *_parentDelegate;
    id _parentDelegate;
}

//@property (nonatomic, retain) NSObject<FSBaseDAODelegate> *parentDelegate;

@property (nonatomic, assign) id parentDelegate;

//线程中调用
- (void)executeCallBackDelegateWithStatus:(FSBaseDAOCallBackStatus)status;
- (void)executeCallBackDelegateSyncBegin:(long long)totalBytes;
- (void)executeCallBackDelegateSyncProgress:(long long)receiveBytes;
- (void)executeCallBackDelegateSyncEnd;
@end

@protocol FSBaseDAODelegate
@optional
- (void)dataAccessObjectSync:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status;
- (void)dataAccessObjectSyncBegin:(FSBaseDAO *)sender withTotalBytes:(long long)totalBytes;
- (void)dataAccessObjectSyncProgress:(FSBaseDAO *)sender withReceiveBytes:(long long)receiveBytes;
- (void)dataAccessObjectSyncEnd:(FSBaseDAO *)sender;
@end


