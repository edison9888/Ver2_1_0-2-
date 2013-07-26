//
//  FS_GZF_BaseDAO.h
//  PeopleNewsReaderPhone
//
//  Created by Xu dandan on 12-10-19.
//
//

#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>
#import "FSConst.h"
#import "FSCommonFunction.h"
#import "GlobalConfig.h"
#import "FSBaseDB.h"
#import "FS_GZF_DAODelegate.h"

#import "FSDataTimestampObject.h"

@protocol FS_GZF_DAODelegate;

@interface FS_GZF_BaseDAO : NSObject{
@protected
    NSObject<FS_GZF_DAODelegate> *_parentDelegate;
    NSString *_currentElementName;
}

@property (nonatomic, assign) NSObject<FS_GZF_DAODelegate> *parentDelegate;

//线程中调用
- (void)executeCallBackDelegateWithStatus:(FS_GZF_BaseDAOCallBackStatus)status;
- (void)executeCallBackDelegateSyncBegin:(long long)totalBytes;
- (void)executeCallBackDelegateSyncProgress:(long long)receiveBytes;
- (void)executeCallBackDelegateSyncEnd;


//************************************************************
//	解析完成
//************************************************************
- (void)baseXMLParserComplete:(FS_GZF_BaseDAO *)sender;

@end


@protocol FS_GZF_DAODelegate
@optional

- (void)dataAccessObjectSync:(FS_GZF_BaseDAO *)sender withStatus:(FS_GZF_BaseDAOCallBackStatus)status;
- (void)dataAccessObjectSyncBegin:(FS_GZF_BaseDAO *)sender withTotalBytes:(long long)totalBytes;
- (void)dataAccessObjectSyncProgress:(FS_GZF_BaseDAO *)sender withReceiveBytes:(long long)receiveBytes;
- (void)dataAccessObjectSyncEnd:(FS_GZF_BaseDAO *)sender;



//************************************************************
//	解析回传一个结果，可能是NSArray、NSDictionary
//************************************************************
- (void)baseXMLParserFinishXMLObjectNode:(FS_GZF_BaseDAO *)sender withXMLResultObject:(id)resultObject;
@optional
//************************************************************
//	需要从那个节点开始构建回传对象，默认根节点一起返回，可选node作为一个对象回传
//************************************************************
- (NSString *)baseXMLParserSeparatedObjectNodeElementName:(FS_GZF_BaseDAO *)sender;

//************************************************************
//	解析发生错误,数据格式不对
//************************************************************
- (void)baseXMLParserError:(FS_GZF_BaseDAO *)sender withError:(NSError *)error;

@end
