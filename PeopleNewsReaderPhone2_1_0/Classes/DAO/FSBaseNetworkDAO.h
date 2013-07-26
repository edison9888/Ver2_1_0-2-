//
//  FSBaseNetworkDAO.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-6.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FSBaseDAO.h"
#import "FSHTTPWebData.h"

@interface FSBaseNetworkDAO : FSBaseDAO  {
@private
	NSData *_dataBuffer;
	NSManagedObjectContext *_managedObjectContext;
	NSFetchRequest *_fetchRequest;
    
   
}

//@property (nonatomic, readonly) NSMutableArray

//************************************************************
//	网络专用
//************************************************************
@property (nonatomic, retain) NSData *dataBuffer;

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
