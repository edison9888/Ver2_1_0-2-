//
//  FSBasePOSTDAO.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-7.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSBaseNetworkDAO.h"
#import "FSHTTPPostWebData.h"


///////////////////////////////////////////
//
///////////////////////////////////////////

@interface FSBasePOSTDAO : FSBaseNetworkDAO {
@private
	NSMutableArray *_entitiesForUpdate;
	
	NSInteger _errorCode;
	NSString *_errorMessage;
	NSStringEncoding _stringEncoding;
}

@property (nonatomic, retain, readonly) NSMutableArray *entitiesForUpdate;
@property (nonatomic) NSStringEncoding stringEncoding;
@property (nonatomic) NSInteger errorCode;
@property (nonatomic, retain) NSString *errorMessage;

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
@end
