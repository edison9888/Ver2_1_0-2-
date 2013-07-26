//
//  FS_GZT_BaceGETDAO.h
//  PeopleNewsReaderPhone
//
//  Created by Xu dandan on 12-10-19.
//
//

#import <Foundation/Foundation.h>
#import "FS_GZF_BaseNetworkDAO.h"
#import "FSHTTPGetWebData.h"

//#import "FSStoreInCoreDataObject.h"
//#import "FSLastUpdateTimestampObject.h"

//#import "FSDataTimestampObject.h"

typedef enum _GET_DataKind {
	GET_DataKind_Refresh,	//第一次从头取数据
	GET_DataKind_Next,		//取一下阶段数据
    GET_DataKind_Unlimited,		//取一下阶段数据
    GET_DataKind_ForceRefresh	//强制刷新
} GET_DataKind;

typedef enum _Buffer_DataKind {
	Buffer_DataKind_None,	//没有缓存
	Buffer_DataKind_Expire,	//缓存过期
	Buffer_DataKind_New		//新数据
} Buffer_DataKind;

typedef enum _Query_DataKind {
	Query_DataKind_New,		//最新的数据的查询条件
	Query_DataKind_Expire,	//过期的数据的查询条件
} Query_DataKind;

@interface FS_GZT_BaceGETDAO : FS_GZF_BaseNetworkDAO{
@protected
	BOOL _isRecordListTail;
	GET_DataKind _currentGetDataKind;
	NSTimeInterval _lastGetDataTimestamp;
    NSString *_currentElementName;
    //FSDataTimestampObject *_timestampObject;
    BOOL _getNextOnline;
    
    BOOL _isRefreshToDeleteOldData;
    
    BOOL _isRefreshNewDataSuccess;
    
    BOOL _isGettingList;
    
}

@property (nonatomic, readonly) NSTimeInterval lastGetDataTimestamp;
@property (nonatomic, readonly) GET_DataKind currentGetDataKind;
@property (nonatomic) BOOL isRecordListTail;
@property (nonatomic) BOOL getNextOnline;
@property (nonatomic,assign) BOOL isGettingList;
//@property (nonatomic, retain, readonly) FSDataTimestampObject *timestampObject;
@property (nonatomic, retain)  NSString *currentElementName;


-(void)GETdata:(GET_DataKind)httpGetDataKind;

//------------------------------------------------------------
//						本地缓存CoreData读取方法
//------------------------------------------------------------
//************************************************************
//是否有缓存数据
//************************************************************
- (Buffer_DataKind)isExistsBufferData;

//************************************************************
//返回查询条件， CoreData
//************************************************************
- (NSString *)predicateStringWithQueryDataKind:(Query_DataKind)dataKind;

//************************************************************
//缓存数据时间间隔
//************************************************************
- (NSTimeInterval)bufferDataExpireTimeInterval;

//************************************************************
//从本地取数据，不要覆盖此方法
//************************************************************
- (void)readDataFromBufferWithQueryDataKind:(Query_DataKind)dataKind;

//************************************************************
//返回实体名称
//************************************************************
- (NSString *)entityName;

//************************************************************
//返回记录限制
//************************************************************
- (NSInteger)fetchLimitWithGETDDataKind:(GET_DataKind)getDataKind;

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
- (NSString *)readDataURLStringFromRemoteHostWithGETDataKind:(GET_DataKind)getDataKind;

//************************************************************
//外部调用的，不要覆盖此方法
//************************************************************
- (void)HTTPGetDataWithKind:(GET_DataKind)httpGetDataKind;


//************************************************************
//	解析完成
//************************************************************
- (void)baseXMLParserComplete:(FSBaseDAO *)sender;

//************************************************************
//	处理旧数据
//************************************************************
-(void)operateOldBufferDataDelate;
- (void)operateOldBufferData;

-(NSString *)timestampFlag;

-(void)setBufferFlag;

-(void)setBufferFlag3;

@end
