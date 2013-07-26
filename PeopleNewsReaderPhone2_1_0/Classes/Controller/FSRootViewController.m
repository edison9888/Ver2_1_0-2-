    //
//  FSRootViewController.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-8.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSRootViewController.h"


@implementation FSRootViewController

- (void)loadChildView {
//	FSIndicatorMessageView *messageView = [[FSIndicatorMessageView alloc] initWithFrame:CGRectZero];
//	[messageView showIndicatorMessageViewInView:self.view withMessage:NSLocalizedString(@"DAOCallBack_Working", nil)];
//	[messageView release];
	FSInformationMessageView *informationMesssageView = [[FSInformationMessageView alloc] initWithFrame:CGRectZero];
	[informationMesssageView showInformationMessageViewInView:self.view withMessage:@"网络连接好像有问题哦" withDelaySeconds:1 withPositionKind:PositionKind_Horizontal_Center withOffset:360];
	[informationMesssageView release];
}

- (void)layoutControllerViewWithRect:(CGRect)rect {
	[FSIndicatorMessageView layoutIndicatorMessageViewInView:self.view];
}


@end
