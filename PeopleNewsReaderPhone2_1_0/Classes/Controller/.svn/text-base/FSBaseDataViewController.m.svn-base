    //
//  FSBaseDataViewController.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-6.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSBaseDataViewController.h"


@implementation FSBaseDataViewController
@synthesize currentDAOData = _currentDAOData;
@synthesize currentDAOStatus = _currentDAOStatus;

- (id)init {
	self = [super init];
	if (self) {
		//NSLog(@"FSBaseDataViewController:%@  :%d",self,[self retainCount]);
	}
	return self;
}

- (void)dealloc {
	self.monitorApplicationState = NO;
    NSLog(@"FSBaseDataViewController.dealloc:%@",self);
	[super dealloc];
}

- (void)loadView {
	[self initDataModel];
	[super loadView];
	self.monitorApplicationState = YES;
}

- (void)initDataModel {
	
}

- (void)applicationBecomeActivie:(NSNotification *)notification {
	
}

- (void)layoutControllerViewWithInterfaceOrientation:(UIInterfaceOrientation)willToOrientation {
	[super layoutControllerViewWithInterfaceOrientation:willToOrientation];
	//[FSIndicatorMessageView layoutIndicatorMessageViewInView:self.view];
}

- (BOOL)canShowIndicatorMessageViewWithDAO:(FSBaseDAO *)sender {
	BOOL rst = YES;
	return rst;
}

- (NSString *)indicatorMessageTextWithDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status {
	NSString *rst = @"";
	switch (status) {
		case FSBaseDAOCallBack_WorkingStatus:
			rst = NSLocalizedString(@"DAOCallBack_Working", @"正在努力加载...");
			break;
		case FSBaseDAOCallBack_BufferWorkingStatus:
			//do nothing
			break;
		case FSBaseDAOCallBack_SuccessfulStatus:
			//rst = NSLocalizedString(@"DAOCallBack_Working", @"正在连接远程服务器...");
			break;
		case FSBaseDAOCallBack_BufferSuccessfulStatus:
			[FSIndicatorMessageView dismissIndicatorMessageViewInView:self.view];
			break;
		case FSBaseDAOCallBack_HostErrorStatus:
			rst = NSLocalizedString(@"DAOCallBack_HostError", @"休息一下，稍后再试");
			break;
		case FSBaseDAOCallBack_NetworkErrorStatus:
			rst = NSLocalizedString(@"DAOCallBack_NetworkError", @"网络不给力，再试一下哦");
			break;
		case FSBaseDAOCallBack_NetworkErrorAndNoBufferStatus:
			rst = NSLocalizedString(@"DAOCallBack_NetworkErrorAndNoBuffer", @"网络不给力，再试一下哦");
			break;
		case FSBaseDAOCallBack_NetworkErrorAndDataIsTailStatus:
			rst = NSLocalizedString(@"DAOCallBack_NetworkErrorAndDataIsTailStatus", @"网络不给力，再试一下哦");
			break;
		case FSBaseDAOCallBack_DataFormatErrorStatus:
			rst = NSLocalizedString(@"DAOCallBack_DataFormatError", @"网络不给力，再试一下哦");
			break;
		case FSBaseDAOCallBack_URLErrorStatus:
			rst = NSLocalizedString(@"DAOCallBack_URLError", @"休息一下，稍后再试");
			break;
		case FSBaseDAOCallBack_UnknowErrorStatus:
			rst = NSLocalizedString(@"DAOCallBack_UnknowError", @"休息一下，稍后再试");
			break;
		case FSBaseDAOCallBack_POSTDataZeroErrorStatus:
			rst = NSLocalizedString(@"DAOCallBack_POSTDataZeroError", @"提交数据不存在哦");
			break;
		default:
			break;
	}
	return rst;
}

- (void)dataAccessObjectSync:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status {
	//当前的数据访问对象以及状态，用于出错时候进行处理
    //FSLog(@"当前的数据访问对象以及状态，用于出错时候进行处理");
	self.currentDAOData = sender;
	self.currentDAOStatus = status;
	
	if (status == FSBaseDAOCallBack_WorkingStatus || status == FSBaseDAOCallBack_ListWorkingStatus ) {
		if ([self canShowIndicatorMessageViewWithDAO:sender]&&status == FSBaseDAOCallBack_WorkingStatus) {
			FSIndicatorMessageView *indicatorMessageView = [[FSIndicatorMessageView alloc] initWithFrame:CGRectZero];
			[indicatorMessageView showIndicatorMessageViewInView:self.view withMessage:[self indicatorMessageTextWithDAO:sender withStatus:status]];
			[indicatorMessageView release];
		}
        
        if ([self canShowIndicatorMessageViewWithDAO:sender]&&status == FSBaseDAOCallBack_ListWorkingStatus) {
            [self doSomethingWithLoadingListDAO:sender withStatus:status];
        }
	} else {
		[FSIndicatorMessageView dismissIndicatorMessageViewInView:self.view];
		
		switch (status) {
			case FSBaseDAOCallBack_HostErrorStatus:
				
			case FSBaseDAOCallBack_NetworkErrorStatus:
	
			case FSBaseDAOCallBack_NetworkErrorAndNoBufferStatus:

			case FSBaseDAOCallBack_NetworkErrorAndDataIsTailStatus:

			case FSBaseDAOCallBack_DataFormatErrorStatus:

			case FSBaseDAOCallBack_URLErrorStatus:

			case FSBaseDAOCallBack_UnknowErrorStatus:
                
			case FSBaseDAOCallBack_POSTDataZeroErrorStatus:{
				FSInformationMessageView *informationMessageView = [[FSInformationMessageView alloc] initWithFrame:CGRectZero];
				informationMessageView.parentDelegate = self;
				[informationMessageView showInformationMessageViewInView:self.view 
															 withMessage:[self indicatorMessageTextWithDAO:sender withStatus:status] 
														withDelaySeconds:2.0f
														withPositionKind:PositionKind_Vertical_Horizontal_Center 
															  withOffset:0.0f];
				[informationMessageView release];
				break;
			}
			default:
				break;
		}
		if (status == FSBaseDAOCallBack_HostErrorStatus) {
			
		}
	}

	[self doSomethingWithDAO:sender withStatus:status];
}

- (void)doSomethingWithDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status {
	
}

-(void)doSomethingWithLoadingListDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status{
    
}

- (void)informationMessageViewTouchClosed:(FSInformationMessageView *)sender {
	//子类实现
	/*
	if ([self.currentDAOData isEqual:xxxObj] && self.currentDAOStatus == FSBaseDAOCallBack_HostErrorStatus) {
		//doSomething
	}
	 */
}

@end
