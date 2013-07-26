//
//  FSStoreInCoreDataObject.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-9-5.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSStoreInCoreDataObject.h"

@interface  FSStoreInCoreDataObject(PrivateMethod)
- (void)inner_startParserToStore;
//************************************************************
//	不要覆盖，这个是转换工作
//************************************************************
- (void)convertDictionaryObject:(NSDictionary *)dictionaryObject withEntityObject:(id)entityObject;
@end


@implementation FSStoreInCoreDataObject

- (id)initWithResultObject:(id)resultObject 
			   withContext:(NSManagedObjectContext *)context 
			  withDelegate:(id<FSStoreInCoreDataObjectDelegate>)delegate
{
	self = [super init];
	if (self) {

		_resultObject = [resultObject retain];
		_delegate = [(id)delegate retain];
		_managedObjectContext = [context retain];
		
	}
	return self;
}

- (void)dealloc {
#ifdef MYDEBUG
	NSLog(@"%@.dealloc", self);
#endif
	[_managedObjectContext release];
	[(id)_delegate release];
	[_resultObject release];
	[super dealloc];
}

- (void)startStoreBlockEntityName:(entityNameWithMemberName)blockEntityName 
		  blockRelationShipObject:(relationShipObject)blockRelationShipObject 
		  blockDefineRelationShip:(defineRelationShip)blockDefineRelationShip 
		   blockAssignEntityValue:(assignEntityValue)blockAssignEntityValue 
   blockAssignEntitySpecificValue:(assignEntitySpecificValue)blockAssignEntitySpecificValue
{
	[self retain];
	_blockEntityName = [blockEntityName copy];
	_blockRelationShipObject = [blockRelationShipObject copy];
	_blockDefineRelationShip = [blockDefineRelationShip copy];
	_blockAssignEntityValue = [blockAssignEntityValue copy];
	_blockAssignEntitySpecificValue = [blockAssignEntitySpecificValue copy];
	
	[self inner_startParserToStore];
}

- (void)inner_startParserToStore {
	if ([_resultObject isKindOfClass:[NSDictionary class]]) {
		id rootEntity = [NSEntityDescription insertNewObjectForEntityForName:_blockEntityName(nil) inManagedObjectContext:_managedObjectContext];
		if (_blockAssignEntitySpecificValue) {
			_blockAssignEntitySpecificValue(rootEntity);
		}
		[self convertDictionaryObject:(NSDictionary *)_resultObject withEntityObject:rootEntity];
		
	} else if ([_resultObject isKindOfClass:[NSArray class]]) {
		for (id childResult in (NSArray *)_resultObject) {
			if ([childResult isKindOfClass:[NSDictionary class]]) {
#ifdef MYDEBUG
				NSLog(@"childResult:%@", childResult);
#endif
				id rootEntity = [NSEntityDescription insertNewObjectForEntityForName:_blockEntityName(nil) inManagedObjectContext:_managedObjectContext];
				if (_blockAssignEntitySpecificValue) {
					_blockAssignEntitySpecificValue(rootEntity);
				}
				[self convertDictionaryObject:(NSDictionary *)childResult withEntityObject:rootEntity];
			}
		}
	} 
	
	[_blockEntityName release];
	[_blockRelationShipObject release];
	[_blockDefineRelationShip release];
	[_blockAssignEntityValue release];
	[_blockAssignEntitySpecificValue release];
	
	NSError *error = nil;
	if ([_managedObjectContext hasChanges] && ![_managedObjectContext save:&error]) {
		[_delegate fsStoreInCoreData:self successful:NO];
#ifdef MYDEBUG
		NSLog(@"%@:error:%@", self, error);
#endif
	} else {
		[_delegate fsStoreInCoreData:self successful:YES];
	}

	[self release];
}

- (void)convertDictionaryObject:(NSDictionary *)dictionaryObject withEntityObject:(id)entityObject {
	
	NSArray *memebrKeys = [dictionaryObject allKeys];
	
	for (NSString *memberKey in memebrKeys) {
		id objectValue = [dictionaryObject objectForKey:memberKey];
		
		if ([objectValue isKindOfClass:[NSString class]]) {
			//字符集合
			_blockAssignEntityValue(entityObject, memberKey, objectValue);
		} else if ([objectValue isKindOfClass:[NSData class]]) {
			//cdata
			_blockAssignEntityValue(entityObject, memberKey, objectValue);
		} else if ([objectValue isKindOfClass:[NSDictionary class]]) {
			//是个子对象, 创建实体
			NSString *childEntityName = _blockEntityName(memberKey);//[self entityNameWithMemberName:memberKey];
			if (childEntityName == nil) {
				//和父对象评级的，xml结构问题
				[self convertDictionaryObject:(NSDictionary *)objectValue withEntityObject:entityObject];
			} else {
				if (_blockDefineRelationShip && _blockRelationShipObject) {
					//返回一个子实体
					id childEntityObject = [NSEntityDescription insertNewObjectForEntityForName:_blockEntityName(memberKey)
																		 inManagedObjectContext:_managedObjectContext];
					if (_blockAssignEntitySpecificValue) {
						_blockAssignEntitySpecificValue(childEntityObject);
					}
					//确认是否是一对多关系
					if (_blockDefineRelationShip(memberKey, entityObject) == MasterDetailRelationShip_OneToMany) {
						id childListObject = _blockRelationShipObject(memberKey, entityObject);
						//一对多的情况下，是否是能够赋值的类型
						if ([childListObject isKindOfClass:[NSMutableSet class]] ||
							[childListObject isKindOfClass:[NSMutableArray class]]) {
							_blockAssignEntityValue(entityObject, memberKey, childListObject);
							[childListObject addObject:childEntityObject];
						}
					} else {
						//向当前实体中加入子实体，（一对一的关系），被父实体引用
						_blockAssignEntityValue(entityObject, memberKey, childEntityObject);
					}
					//回调，转换子实体对象对应的实体类
					[self convertDictionaryObject:dictionaryObject withEntityObject:childEntityObject];
				}				
			}
			
		} else if ([objectValue isKindOfClass:[NSArray class]]) {
			//列表，先生成列表
			if (_blockRelationShipObject) {
				id childListObject = _blockRelationShipObject(memberKey, entityObject);
				if ([childListObject isKindOfClass:[NSMutableSet class]] ||
					[childListObject isKindOfClass:[NSMutableArray class]]) {
					//是能够解析的对象，进行赋值
					_blockAssignEntityValue(entityObject, memberKey, childListObject);
					//将列表中的子对象（关系对象）一一进行转换
					NSArray *listObjects = (NSArray *)objectValue;
					for (int i = 0; i < [listObjects count]; i++) {
						id listObject = [listObjects objectAtIndex:i];
						//是字典类型，则进行实体转换
						if ([listObject isKindOfClass:[NSDictionary class]]) {
							//回调
							id childListEntityObject = [NSEntityDescription insertNewObjectForEntityForName:_blockEntityName(memberKey) inManagedObjectContext:_managedObjectContext];
							[childListObject addObject:childListEntityObject];
							//转换对象
							[self convertDictionaryObject:listObject withEntityObject:childListEntityObject];
						}
					}
				} else {
#ifdef MYDEBUG
					NSLog(@"生成子对象不是NSSet, NSArray");
#endif
				}
			}
		}
	}
}

@end
