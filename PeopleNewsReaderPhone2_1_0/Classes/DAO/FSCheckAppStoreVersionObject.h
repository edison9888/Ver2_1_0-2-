//
//  FSCheckAppStoreVersionObject.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-9-12.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSCheckAppStoreVersionDAO.h"

@interface FSCheckAppStoreVersionObject : NSObject <FSBaseDAODelegate> {
@private
	FSCheckAppStoreVersionDAO *_checkData;
    BOOL _isManual;
}

@property (nonatomic,assign)  BOOL isManual;

- (void)checkAppVersion:(NSString *)appID;

@end
