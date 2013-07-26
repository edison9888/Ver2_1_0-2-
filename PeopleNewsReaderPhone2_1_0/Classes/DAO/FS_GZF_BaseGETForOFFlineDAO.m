//
//  FS_GZF_BaseGETForOFFlineDAO.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-11-20.
//
//

#import "FS_GZF_BaseGETForOFFlineDAO.h"

#import "FSIndicatorMessageView.h"
#import "FSInformationMessageView.h"

@implementation FS_GZF_BaseGETForOFFlineDAO

@synthesize parentView = _parentView;
@synthesize parentDelegate = _parentDelegate;



- (id)init {
	self = [super init];
	if (self) {
		
	}
	return self;
}

- (void)dealloc {
#ifdef MYDEBUG
	NSLog(@"DAO.dealloc:%@", self);
#endif
	[super dealloc];
}



-(void)getDataForOFFline{
    

}



-(void)doSomethingWithDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status{
    
}




//************************************************************************************************
//FSBaseDAO.h 关于读取数据的回调代理

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
			[FSIndicatorMessageView dismissIndicatorMessageViewInView:self.parentView];
			break;
		case FSBaseDAOCallBack_HostErrorStatus:
			rst = NSLocalizedString(@"DAOCallBack_HostError", @"连接远程服务器超时");
			break;
		case FSBaseDAOCallBack_NetworkErrorStatus:
			rst = NSLocalizedString(@"DAOCallBack_NetworkError", @"您的网络似乎有些问题哦");
			break;
		case FSBaseDAOCallBack_NetworkErrorAndNoBufferStatus:
			rst = NSLocalizedString(@"DAOCallBack_NetworkErrorAndNoBuffer", @"您的网络似乎有些问题哦");
			break;
		case FSBaseDAOCallBack_NetworkErrorAndDataIsTailStatus:
			rst = NSLocalizedString(@"DAOCallBack_NetworkErrorAndDataIsTailStatus", @"您的网络似乎有些问题哦");
			break;
		case FSBaseDAOCallBack_DataFormatErrorStatus:
			rst = NSLocalizedString(@"DAOCallBack_DataFormatError", @"返回的数据格式好像有问题哦");
			break;
		case FSBaseDAOCallBack_URLErrorStatus:
			rst = NSLocalizedString(@"DAOCallBack_URLError", @"请求连接地址好像有问题哦");
			break;
		case FSBaseDAOCallBack_UnknowErrorStatus:
			rst = NSLocalizedString(@"DAOCallBack_UnknowError", @"未知错误");
			break;
		case FSBaseDAOCallBack_POSTDataZeroErrorStatus:
			rst = NSLocalizedString(@"DAOCallBack_POSTDataZeroError", @"提交数据不存在哦");
			break;
		default:
			break;
	}
	return rst;
}


- (void)dataAccessObjectSync:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status{
    
    //self.currentDAOData = sender;
	//self.currentDAOStatus = status;
	
	if (status == FSBaseDAOCallBack_WorkingStatus) {
		if (1) {
			FSIndicatorMessageView *indicatorMessageView = [[FSIndicatorMessageView alloc] initWithFrame:CGRectZero];
			[indicatorMessageView showIndicatorMessageViewInView:self.parentView withMessage:[self indicatorMessageTextWithDAO:sender withStatus:status]];
			[indicatorMessageView release];
		}
	} else {
		[FSIndicatorMessageView dismissIndicatorMessageViewInView:self.parentView];
		
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
				informationMessageView.parentDelegate = self.parentDelegate;
				[informationMessageView showInformationMessageViewInView:self.parentView
															 withMessage:[self indicatorMessageTextWithDAO:sender withStatus:status]
														withDelaySeconds:0
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
- (void)dataAccessObjectSyncBegin:(FSBaseDAO *)sender withTotalBytes:(long long)totalBytes{
    
}
- (void)dataAccessObjectSyncProgress:(FSBaseDAO *)sender withReceiveBytes:(long long)receiveBytes{
    
}
- (void)dataAccessObjectSyncEnd:(FSBaseDAO *)sender{
    
}


@end
