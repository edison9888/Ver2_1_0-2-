//
//  FSStoreInCoreDataObject.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-9-5.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef enum _MasterDetailRelationShip {
	MasterDetailRelationShip_OneToOne,
	MasterDetailRelationShip_OneToMany
} MasterDetailRelationShip;

//返回父实体的对应元素关系
typedef MasterDetailRelationShip (^defineRelationShip)(NSString *memberName, id entityObject);
//返回一个父实体对应子实体的对象，必须是NSMutableArray, NSMutableSet类型
typedef id (^relationShipObject)(NSString *memberName, id parentEntityObject);
//对实体的键、值进行赋值
typedef void (^assignEntityValue)(id currentObject, NSString *key, id value);
//根据key的名称返回实体名称，nil必须返回一个根实体
typedef NSString * (^entityNameWithMemberName)(NSString *memberName);
//额外的实体属性
typedef void (^assignEntitySpecificValue)(id currentObject);

@protocol FSStoreInCoreDataObjectDelegate;

@interface FSStoreInCoreDataObject : NSObject {
@private
	NSManagedObjectContext *_managedObjectContext;
	id<FSStoreInCoreDataObjectDelegate> _delegate;
	
	id _resultObject;
	
	entityNameWithMemberName _blockEntityName;
	defineRelationShip _blockDefineRelationShip;
	relationShipObject _blockRelationShipObject;
	assignEntityValue _blockAssignEntityValue;
	assignEntitySpecificValue _blockAssignEntitySpecificValue;
}

- (id)initWithResultObject:(id)resultObject 
			   withContext:(NSManagedObjectContext *)context 
			  withDelegate:(id<FSStoreInCoreDataObjectDelegate>)delegate;


- (void)startStoreBlockEntityName:(entityNameWithMemberName)blockEntityName 
		  blockRelationShipObject:(relationShipObject)blockRelationShipObject 
		  blockDefineRelationShip:(defineRelationShip)blockDefineRelationShip 
		   blockAssignEntityValue:(assignEntityValue)blockAssignEntityValue 
   blockAssignEntitySpecificValue:(assignEntitySpecificValue)blockAssignEntitySpecificValue;

@end

@protocol FSStoreInCoreDataObjectDelegate
//成功
//错误
- (void)fsStoreInCoreData:(FSStoreInCoreDataObject *)sender successful:(BOOL)successful;
@end


