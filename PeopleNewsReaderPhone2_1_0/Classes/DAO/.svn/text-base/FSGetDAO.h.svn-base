//
//  FSGetDAO.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-18.
//
//

#import <Foundation/Foundation.h>
#import "FSNetworkDAO.h"
#import "FSHTTPGetWebData.h"
#import "FSHTTPWebExData.h"
#import "FSXMLParserObject.h"
#import "FSStoreObject.h"
#import "FSDataTimestampObject.h"

typedef enum _ReadDataKind {
	ReadDataKind_Refresh,	//第一次从头取数据
	ReadDataKind_Next		//取一下阶段数据
} ReadDataKind;

@interface FSGetDAO : FSNetworkDAO {
@private
    ReadDataKind _currentReadDataKind;
    FSDataTimestampObject *_timestampObject;
    
    NSFetchRequest *_request;
    NSEntityDescription *_entity;
    BOOL *_forceRefreshRemoteData;
}

@property (nonatomic) ReadDataKind currentReadDataKind;
@property (nonatomic, retain, readonly) FSDataTimestampObject *timestampObject;
@property (nonatomic, retain, readonly) NSFetchRequest *request;
@property (nonatomic, retain, readonly) NSEntityDescription *entity;
@property (nonatomic) BOOL *foreceRefreshRemoteData;

- (void)GETData;

- (void)readDataFromCoreData;

- (NSString *)timestampFlag;

- (NSString *)entityName;

- (NSString *)batchKeyName;

- (NSString *)contentPrimaryKeyName;

- (NSObject *)contentPrimaryValue;

- (void)deleteOldDataWith:(NSManagedObjectContext *)context withOldBatchValue:(double)batchValue;

@end

