    //
//  FSSettingViewController.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-13.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSSettingViewController.h"
#import "FSMyFavoritesViewController.h"
#import "FSUINavigationController.h"
#import "FSSlideViewController.h"
#import "FSLocalWeatherViewController.h"
#import "FSCheckAppStoreVersionObject.h"

#import "FS_GZF_AppUpdateDAO.h"


#import "FSChannelSettingForOneDayViewController.h"
#import "FSALLSettingViewController.h"

#import "FSCommonFunction.h"
#import "GlobalConfig.h"

#define FSSETTING_VIEW_NAVBAR_HEIGHT 44.0f

@implementation FSSettingViewController

- (id)init {
	self = [super init];
	if (self) {
		
	}
	return self;
}

- (void)dealloc {
	[_navTopBar release];
	[_settingView release];
    [_fs_GZF_GetNewsDataForOFFlineDAO release];
    [super dealloc];
}
-(void)addNavView
{
    _navTopBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, FSSETTING_VIEW_NAVBAR_HEIGHT)];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
        [_navTopBar setBackgroundImage:[UIImage imageNamed: @"navigatorBar.png"] forBarMetrics:UIBarMetricsDefault];
    }
	UINavigationItem *topItem = [[UINavigationItem alloc] init];
	NSArray *items = [[NSArray alloc] initWithObjects:topItem, nil];
	_navTopBar.items = items;
	_navTopBar.topItem.title = NSLocalizedString(@"工具栏", nil);
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:18], UITextAttributeFont,[UIColor blackColor],UITextAttributeTextColor,nil];
    _navTopBar.titleTextAttributes = dict;
	[topItem release];
	[items release];
	[self.view addSubview:_navTopBar];
}

- (void)loadChildView {
		

    [self addNavView];
    //the setting view
    _settingView = [[FSNewSettingView alloc]initWithFrame:CGRectMake(0.0f, FSSETTING_VIEW_NAVBAR_HEIGHT, self.view.frame.size.width, self.view.frame.size.height - FSSETTING_VIEW_NAVBAR_HEIGHT)];
    _settingView.delegate = self;
    [self.view addSubview:_settingView];
    
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightAction:)];
    swipeRight.delegate = self;
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [_settingView addGestureRecognizer:swipeRight];
    [swipeRight release];
    
    _fs_GZF_GetNewsDataForOFFlineDAO = [[FS_GZF_GetNewsDataForOFFlineDAO alloc] init];//离线下载
    _fs_GZF_GetNewsDataForOFFlineDAO.parentDelegate = self;
    _fs_GZF_GetNewsDataForOFFlineDAO.parentView = self.view;
    
    
    
        //[weatcherBt release];

    
}
- (void)weatherNewsViewButtonClick
{
    FSLocalWeatherViewController *weatherCtrl = [[FSLocalWeatherViewController alloc] init];
    NSLog(@"%@",self.navigationController);
    //[self.parentViewController.navigationController pushViewController:weatherCtrl animated:YES];
    [[UIApplication sharedApplication].keyWindow addSubview:weatherCtrl.view];
    //[weatherCtrl release];
}
#pragma mark - FSNewSettingViewDelegate
//***************************************
//by QIN,Zhuoran
//implement the FSNewSettingView delegate

//离线下载----字体设置
- (void)tappedInSettingView:(UIView *)settingView downloadButton:(UIButton *)button
{
    NSLog(@"download");
    
    FSChannelSettingForOneDayViewController *fsChannelSettingForOneDayViewController = [[FSChannelSettingForOneDayViewController alloc] init];
    fsChannelSettingForOneDayViewController.isReSetting = YES;
    [self.fsSlideViewController presentModalViewController:fsChannelSettingForOneDayViewController animated:YES];
    //[self.navigationController pushViewController:fsChannelSettingForOneDayViewController animated:YES];
    [fsChannelSettingForOneDayViewController release];
    
    /*
    
    FSNewsTextFontSettingController *fsSettingViewController = [[FSNewsTextFontSettingController alloc] init];
    
    //FSUINavigationController *navMyFavoritesCtrl = [[FSUINavigationController alloc]init];
    //[navMyFavoritesCtrl pushViewController:fsSettingViewController animated:YES];
    
    FSUINavigationController *navFont = [[FSUINavigationController alloc]initWithRootViewController:fsSettingViewController];
    [self.fsSlideViewController  presentModalViewController:navFont animated:YES];
    
    [fsSettingViewController release];
    [navFont release];
     */

}

//夜间模式---订阅中心
- (void)tappedInSettingView:(UIView *)settingView nightModeButton:(UIButton *)button
{
    NSLog(@"nigth mode");
    
    //账号绑定
    
    
    FSALLSettingViewController *fsSettingViewController = [[FSALLSettingViewController alloc] init];
    fsSettingViewController.isnavTopBar = YES;
    [self.fsSlideViewController presentModalViewController:fsSettingViewController animated:YES];
    [fsSettingViewController release];
    
}

//我的收藏
- (void)tappedInSettingView:(UIView *)settingView myCollectionButton:(UIButton *)button
{
    NSLog(@"MY CLOLLECTION");
    FSMyFavoritesViewController *myFavoritesCtrl = [[FSMyFavoritesViewController alloc] init];
    FSUINavigationController *navMyFavoritesCtrl = [[FSUINavigationController alloc] initWithRootViewController:myFavoritesCtrl];
    [self.fsSlideViewController  presentModalViewController:navMyFavoritesCtrl animated:YES];
    [navMyFavoritesCtrl release];
    [myFavoritesCtrl release];
}




//清理缓存
- (void)tappedInSettingView:(UIView *)settingView clearMemoryButton:(UIButton *)button{
    NSLog(@"CLEAR MEMORY");
    [self clearAllBufferWithPath];
}

//检查更新
- (void)tappedInSettingView:(UIView *)settingView updateButton:(UIButton *)button
{
//    NSLog(@"UPDATE");
//    if (! fsAppUpdateDAO ) {
//        fsAppUpdateDAO = [[FS_GZF_AppUpdateDAO alloc]init];
//    }
//    fsAppUpdateDAO.isShow = 0;
//    fsAppUpdateDAO.isManualUpdata = YES;
//    [fsAppUpdateDAO getVersion];
//    NSLog(@"手动更新");
    
    FSCheckAppStoreVersionObject *checkAppStoreVersionObject = [[FSCheckAppStoreVersionObject alloc] init];
    checkAppStoreVersionObject.isManual = YES;
	[checkAppStoreVersionObject checkAppVersion:MYAPPLICATIONID_IN_APPSTORE];
	[checkAppStoreVersionObject release];

}


-(void)clearAllBufferWithPath{
    
    [[FSBaseDB sharedFSBaseDB] clearCache];
    
    GlobalConfig *config = [GlobalConfig shareConfig];
    BOOL mark = NO;
        
    NSString *cachePath = getCachesPath();
    if (![config clearBufferWithPath:cachePath]) {
        mark = YES;
    }
   
    NSString *message;
    if (mark == YES) {
        message = @"不能完全清除缓存文件";
    }else{
       message = @"缓存文件已经成功清除！";
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"通知"
                                                   message:message
                                                  delegate:self
                                         cancelButtonTitle:@"返回" otherButtonTitles: nil];
    [alert show];
    [alert release];
    
}


//***************************************
-(void)swipeRightAction:(id)sender{
    [self.fsSlideViewController resetViewControllerWithAnimated:NO];
}


- (void)layoutControllerViewWithRect:(CGRect)rect {
	_navTopBar.frame = CGRectMake(0.0f, 0.0f, rect.size.width, FSSETTING_VIEW_NAVBAR_HEIGHT);
	_settingView.frame = CGRectMake(0.0f, FSSETTING_VIEW_NAVBAR_HEIGHT, rect.size.width, rect.size.height - FSSETTING_VIEW_NAVBAR_HEIGHT);
}

- (void)doSomethingForViewFirstTimeShow {
	//[_settingView loadData];
}


//
////每个cell的data
//- (NSObject *)tableViewCellData:(FSTableContainerView *)sender withIndexPath:(NSIndexPath *)indexPath {
//	NSInteger section = [indexPath section];
//	NSInteger row = [indexPath row];
//	if (section == 0) {
//		FSSettingObject *obj = [[[FSSettingObject alloc] init] autorelease];
//		if (row == 0) {
//            obj.description = NSLocalizedString(@"离线下载", nil);
//			obj.settingKind = FSSetting_None;
//		} else if (row == 1) {
//			obj.description = NSLocalizedString(@"我的收藏", nil);
//			obj.settingKind = FSSetting_None;
//			obj.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//		} else if (row == 2) {
//			obj.description = NSLocalizedString(@"清理缓存", nil);
//			obj.settingKind = FSSetting_None;
//		} else if (row == 3) {
//			obj.description = NSLocalizedString(@"检查更新", nil);
//			obj.settingKind = FSSetting_None;
//		} 
//		return obj;
//	} else {
//		return nil;
//	}
//}
//
////cell数量
//- (NSInteger)tableViewNumberInSection:(FSTableContainerView *)sender section:(NSInteger)section {
//	if (section == 0) {
//		return 4;
//	} else {
//		return 0;
//	}
//}
//
//- (NSInteger)tableViewSectionNumber:(FSTableContainerView *)sender {
//	return 1;
//}
//
//-(void)tableViewDataSourceDidSelected:(FSTableContainerView *)sender withIndexPath:(NSIndexPath *)indexPath{
//    NSInteger section = [indexPath section];
//	NSInteger row = [indexPath row];
//    if (section == 0) {
//		if (row == 0) {
//            //[_fs_GZF_GetNewsDataForOFFlineDAO getDataForOFFline];
//		}
//        
//        if (row == 1) {
//			FSMyFavoritesViewController *myFavoritesCtrl = [[FSMyFavoritesViewController alloc] init];
//			FSUINavigationController *navMyFavoritesCtrl = [[FSUINavigationController alloc] initWithRootViewController:myFavoritesCtrl];
//			[self.fsSlideViewController  presentModalViewController:navMyFavoritesCtrl animated:YES];
//			[navMyFavoritesCtrl release];
//			[myFavoritesCtrl release];
//		}
//        if (row == 2) {
//			;//清理缓存
//		}
//        if (row == 3) {
//			;//检查更新
//		}
//	} 
//}
//
//
////***********************************************
//-(void)getAllDataComplete:(FS_GZF_BaseGETForOFFlineDAO *)sender{
//    NSLog(@"getAllDataComplete");
//    [[GlobalConfig shareConfig] setOFFlineReading:YES];
//    [_settingView loadData];
//}
//

@end
