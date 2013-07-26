//
//  FSBaseGETDAO.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-7.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSBaseNetworkDAO.h"
#import "FSHTTPGetWebData.h"
#import "FSStoreInCoreDataObject.h"
#import "FSLastUpdateTimestampObject.h"

typedef enum _GETDataKind {
	GETDataKind_Refresh,	//第一次从头取数据
	GETDataKind_Next		//取一下阶段数据
} GETDataKind;

typedef enum _BufferDataKind {
	BufferDataKind_None,	//没有缓存
	BufferDataKind_Expire,	//缓存过期
	BufferDataKind_New		//新数据
} BufferDataKind;

typedef enum _QueryDataKind {
	QueryDataKind_New,		//最新的数据的查询条件
	QueryDataKind_Expire,	//过期的数据的查询条件
} QueryDataKind;

@interface FSBaseGETDAO : FSBaseNetworkDAO <FSStoreInCoreDataObjectDelegate> {
@private
	BOOL _isRecordListTail;
	GETDataKind _currentGetDataKind;
	NSTimeInterval _lastGetDataTimestamp;
	NSTimeInterval _networkDataTimestamp;
}

@property (nonatomic, readonly) NSTimeInterval lastGetDataTimestamp;
@property (nonatomic) NSTimeInterval netowkDataTimestamp;
@property (nonatomic, readonly) GETDataKind currentGetDataKind;
@property (nonatomic) BOOL isRecordListTail;

//------------------------------------------------------------
//						本地缓存CoreData读取方法
//------------------------------------------------------------
//************************************************************
//是否有缓存数据
//************************************************************
- (BufferDataKind)isExistsBufferData;

//************************************************************
//返回查询条件， CoreData
//************************************************************
- (NSString *)predicateStringWithQueryDataKind:(QueryDataKind)dataKind;

//************************************************************
//缓存数据时间间隔
//************************************************************
- (NSTimeInterval)bufferDataExpireTimeInterval;

//************************************************************
//从本地取数据，不要覆盖此方法
//************************************************************
- (void)readDataFromBufferWithQueryDataKind:(QueryDataKind)dataKind;

//************************************************************
//返回实体名称
//************************************************************
- (NSString *)entityName;

//************************************************************
//返回记录限制
//************************************************************
- (NSInteger)fetchLimitWithGETDDataKind:(GETDataKind)getDataKind;

//************************************************************
//初始化排序,覆盖此方法，如果有有排序的话调用 'addSortFieldName'
//************************************************************
- (void)initializeSortDescriptions:(NSMutableArray *)descriptions;

//************************************************************
//不要覆盖此方法，增加排序说明
//************************************************************
- (void)addSortDescription:(NSMutableArray *)descriptions withSortFieldName:(NSString *)fieldName withAscending:(BOOL)ascending;

//************************************************************
//执行
//************************************************************
- (void)executeFetchRequest:(NSFetchRequest *)request;

//************************************************************
//返回url字符串
//************************************************************
- (NSString *)readDataURLStringFromRemoteHostWithGETDataKind:(GETDataKind)getDataKind;

//************************************************************
//外部调用的，不要覆盖此方法
//************************************************************
- (void)HTTPGetDataWithKind:(GETDataKind)httpGetDataKind;

//************************************************************
//	最后更新时间的flagvalue
//************************************************************
- (NSString *)lastUpdateTimestampPredicateValue;

//************************************************************
//	处理旧数据
//************************************************************
- (void)operateOldBufferData;

@end
