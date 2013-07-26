//
//  FS_GZF_BasePOSTXMLDAO.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-11-8.
//
//

#import <Foundation/Foundation.h>
#import "FS_GZF_BaseNetworkDAO.h"
#import "FSHTTPPostWebData.h"

@interface FS_GZF_BasePOSTXMLDAO : FS_GZF_BaseNetworkDAO<NSXMLParserDelegate>{
@protected
    
	NSMutableArray *_entitiesForUpdate;
	    NSString *_currentElementName;
	NSInteger _errorCode;
	NSString *_errorMessage;
	NSStringEncoding _stringEncoding;
}

@property (nonatomic, retain, readonly) NSMutableArray *entitiesForUpdate;
@property (nonatomic) NSStringEncoding stringEncoding;
@property (nonatomic) NSInteger errorCode;
@property (nonatomic, retain) NSString *errorMessage;
@property (nonatomic, retain) NSString *currentElementName;

//************************************************************
//	提交数据的url
//************************************************************
- (NSString *)HTTPPostURLString;

//************************************************************
//	外部调用的，不要覆盖此方法
//************************************************************
- (void)HTTPPostDataWithKind:(HTTPPOSTDataKind)httpPostKind;

//************************************************************
//	必须覆盖此方法，向postItems内填充post数据的内容，FSHTTPPOSTItem类型
//************************************************************
- (void)HTTPBuildPostItems:(NSMutableArray *)postItems withPostKind:(HTTPPOSTDataKind)postKind;

//************************************************************
//	解析完成
//************************************************************
- (void)baseXMLParserComplete:(FSBaseDAO *)sender;

@end
