//
//  FS_GZF_BaseGETDitailDAO.h
//  PeopleNewsReaderPhone
//
//  Created by Xu dandan on 12-10-26.
//
//

#import <Foundation/Foundation.h>
#import "FS_GZT_BaceGETDAO.h"

@interface FS_GZF_BaseGETDitailDAO : FS_GZT_BaceGETDAO<NSXMLParserDelegate>{
@protected
    NSMutableArray *_objectList;
	
}

@property (nonatomic, retain) NSMutableArray *objectList;

-(NSString *)getnewsid;

-(NSString *)PicEntityName;

-(void)PicinitializeSortDescriptions:(NSMutableArray *)sortDescriptions;

-(NSObject *)insertNewObjectTomanagedObjectContext:(NSInteger)mark;

//************************************************************
//从本地取新闻内容图片信息数据，不要覆盖此方法
//************************************************************
- (void)readNewsPicFromBufferWithQueryDataKind:(Query_DataKind)dataKind;

//************************************************************
//执行
//************************************************************
- (void)executeFetchPicRequest:(NSFetchRequest *)request;

@end
