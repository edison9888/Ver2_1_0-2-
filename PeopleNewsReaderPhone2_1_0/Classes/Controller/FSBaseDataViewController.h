//
//  FSBaseDataViewController.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-6.
//  Copyright 2012 people.com.cn. All rights reserved.
//////////////////////////////////////////////////////////////////
//	版本			时间				说明
//////////////////////////////////////////////////////////////////
//	1.0			2012-08-06		初版做成
//****************************************************************

#import <UIKit/UIKit.h>
#import "FSBaseViewController.h"
#import "FSBaseDAO.h"
#import "FSIndicatorMessageView.h"
#import "FSInformationMessageView.h"
#import "FSBaseDB.h"

@interface FSBaseDataViewController : FSBaseViewController <FSBaseDAODelegate, FSInformationMessageViewDelegate> {
@private
	FSBaseDAO *_currentDAOData;
	FSBaseDAOCallBackStatus _currentDAOStatus;
	
}

@property (nonatomic, assign) FSBaseDAO *currentDAOData;
@property (nonatomic, assign) FSBaseDAOCallBackStatus currentDAOStatus;


- (void)initDataModel;
- (void)doSomethingWithDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status;

- (void)doSomethingWithLoadingListDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status;

- (BOOL)canShowIndicatorMessageViewWithDAO:(FSBaseDAO *)sender;
- (NSString *)indicatorMessageTextWithDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status;

@end
