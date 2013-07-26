//
//  FS_GZF_BaseNetworkDAO.h
//  PeopleNewsReaderPhone
//
//  Created by Xu dandan on 12-10-19.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FSBaseDAO.h"
#import "FSHTTPWebData.h"
#import "FSBaseDB.h"

typedef enum _Timestamp_DataKind {
	Timestamp_DataKind_request,		//取网络数据
	Timestamp_DataKind_notrequest,	//取本地数据
    Timestamp_DataKind_errer        //网络错误
} Timestamp_DataKind;

@interface FS_GZF_BaseNetworkDAO : FSBaseDAO<NSXMLParserDelegate>{
@protected
    double _Timestamp;//网络
    double _localtimestamp;
    double _netTimestamp;
@private
	NSData *_dataBuffer;
	NSManagedObjectContext *_managedObjectContext;
	NSFetchRequest *_fetchRequest;
    //NSString *_result;
}

//************************************************************
//	网络专用
//************************************************************
@property (nonatomic, retain) NSData *dataBuffer;
@property (nonatomic,assign) double localtimestamp;
@property (nonatomic,assign) double netTimestamp;
@property (nonatomic,assign) double Timestamp;


//************************************************************
//时间戳管理
//************************************************************

- (void)inner_InitializeDataTimestamp:(NSString *)flag;

-(Timestamp_DataKind)getTimestampWithURL:(NSString *)URL flag:(NSString *)flag networkRequestInterval:(double)Interval;
-(void)updataTimestamp:(NSString *)flag;


//************************************************************
//	接收数据完成
//************************************************************
- (void)doSomethingInDataReceiveComplete;

//************************************************************
//	用于本地存储
//************************************************************
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchRequest *fetchRequest;


- (BOOL)saveCoreDataContext;
- (void)doSomethingInSaveCoreDataContextError:(NSError *)error;

@end
