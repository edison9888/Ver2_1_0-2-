    //
//  FSNewsViewController.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-13.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSNewsViewController.h"
#import "FSChannelListForNewsController.h"
#import "FSUINavigationController.h"

#import "FSSlideViewController.h"
//#import "FSWeatherViewController.h"
#import "FSLocalWeatherViewController.h"
#import "FSSettingViewController.h"

#import "FS_GZF_ForOnedayNewsFocusTopDAO.h"
#import "FS_GZF_ChannelListDAO.h"
#import "FS_GZF_ForNewsListDAO.h"
#import "FSFocusTopObject.h"
#import "FSOneDayNewsObject.h"
#import "FSUserSelectObject.h"
#import "FSChannelObject.h"
#import "FSTabBarViewCotnroller.h"
#import "FSBaseDAO.h"

#import "FSNewsContainerViewController.h"
#import "FSWebViewForOpenURLViewController.h"



#define KIND_USERCHANNEL_SELECTED @"KIND_USERCHANNEL_SELECTED"

@implementation FSNewsViewController

- (id)init {
	self = [super init];
	if (self) {
		_isfirstShow = YES;
	}
	return self;
}

- (void)dealloc {
    [_routineNewsListContentView release];
    [_fs_GZF_ForOnedayNewsFocusTopDAO release];
    [_fs_GZF_ChannelListDAO release];
    [_fs_GZF_ForNewsListDAO release];
    [_titleView release];
    [_reFreshDate release];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSNOTIF_NEWSCHANNEL_SELECTED object:nil];
    [super dealloc];
}

- (void)loadChildView {
	[super loadChildView];
    _routineNewsListContentView = [[FSRoutineNewsListContentView alloc] init];
    _routineNewsListContentView.parentDelegate = self;
    [self.view addSubview:_routineNewsListContentView];
	//self.view.backgroundColor = [UIColor orangeColor];
    
    _reFreshDate = nil;
    
    _titleView = [[FSTitleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    _titleView.hidRefreshBt = YES;
    _titleView.toBottom = NO;
    _titleView.parentDelegate = self;
    self.navigationItem.titleView = _titleView;
	//标签栏设置
	//[self.fsTabBarItem setTabBarItemWithNormalImage:[UIImage imageNamed:@"allNews.png"] withSelectedImage:[UIImage imageNamed:@"allNews.png"] withText:NSLocalizedString(@"新闻", nil)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newsChannelSelected:) name:NSNOTIF_NEWSCHANNEL_SELECTED object:nil];

    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftAction:)];
    swipeLeft.delegate = self;
    swipeLeft.direction = UISwipeGestureRecognizerDirectionRight;
    [_routineNewsListContentView addGestureRecognizer:swipeLeft];
    [swipeLeft release];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightAction:)];
    swipeRight.delegate = self;
    swipeRight.direction = UISwipeGestureRecognizerDirectionLeft;
    [_routineNewsListContentView addGestureRecognizer:swipeRight];
    [swipeRight release];
    
    
}

-(void)initDataModel{
    NSLog(@"initDataModelinitDataModel");
    _fs_GZF_ForOnedayNewsFocusTopDAO = [[FS_GZF_ForOnedayNewsFocusTopDAO alloc] init];
    _fs_GZF_ForOnedayNewsFocusTopDAO.group = PUTONG_NEWS_LIST_KIND;
    _fs_GZF_ForOnedayNewsFocusTopDAO.type = @"news";
    _fs_GZF_ForOnedayNewsFocusTopDAO.channelid = @"";
    _fs_GZF_ForOnedayNewsFocusTopDAO.count = 3;
    _fs_GZF_ForOnedayNewsFocusTopDAO.parentDelegate = self;
    _fs_GZF_ForOnedayNewsFocusTopDAO.isGettingList = YES;
    
    
    _fs_GZF_ChannelListDAO = [[FS_GZF_ChannelListDAO alloc] init];
    _fs_GZF_ChannelListDAO.parentDelegate = self;
    _fs_GZF_ChannelListDAO.type = @"news";
    _fs_GZF_ChannelListDAO.isGettingList = YES;
    
    _fs_GZF_ForNewsListDAO = [[FS_GZF_ForNewsListDAO alloc] init];
    _fs_GZF_ForNewsListDAO.parentDelegate = self;
    _fs_GZF_ForNewsListDAO.isGettingList = YES;
}

-(void)doSomethingForViewFirstTimeShow{
    NSLog(@"doSomethingForViewFirstTimeShowdoSomethingForViewFirstTimeShow");
    
    _reFreshDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
  
    [_fs_GZF_ChannelListDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
    
}


- (UIImage *)tabBarItemNormalImage {
	return [UIImage imageNamed:@"news.png"];
}

- (NSString *)tabBarItemText {
	return NSLocalizedString(@"新闻", nil);
}

- (UIImage *)tabBarItemSelectedImage {
	return [UIImage imageNamed:@"news_sel.png"];
}

- (void)layoutControllerViewWithRect:(CGRect)rect {
    _routineNewsListContentView.frame = CGRectMake(0.0f, 0.0f, rect.size.width, rect.size.height);
    _titleView.frame = CGRectMake(0, 0, 200, 44);
    [_titleView reSetFrame];
    
}

/*
-(void)viewDidAppear:(BOOL)animated{
    [_routineNewsListContentView loadData];
    [_titleView reSetFrame];
}
*/


-(void)swipeLeftAction:(id)sender{
    
    //    FSWeatherViewController *fsWeatherViewController = [[FSWeatherViewController alloc] init];
    //    [self.fsSlideViewController slideViewController:fsWeatherViewController withKind:PushViewControllerKind_Left withAnimation:YES];
    //    [fsWeatherViewController release];
    
    
    if ([self.fsSlideViewController.leftViewController isKindOfClass:[FSLocalWeatherViewController class]]) {
        //NSLog(@"swipeLeftAction 111111");
        [self.fsSlideViewController slideViewController:self.fsSlideViewController.leftViewController withKind:PushViewControllerKind_Left withAnimation:YES];
    }
    else{
        //NSLog(@"swipeLeftAction 222222");
        FSLocalWeatherViewController *weatherCtrl = [[FSLocalWeatherViewController alloc] init];
        [self.fsSlideViewController slideViewController:weatherCtrl withKind:PushViewControllerKind_Left withAnimation:YES];
        [weatherCtrl release];
    }
	
}

-(void)swipeRightAction:(id)sender{
    
    if ([self.fsSlideViewController.rightViewController isKindOfClass:[FSSettingViewController class]]) {
        [self.fsSlideViewController slideViewController:self.fsSlideViewController.rightViewController withKind:PushViewControllerKind_Right withAnimation:YES];
    }
    else{
        FSSettingViewController *settingCtrl = [[FSSettingViewController alloc] init];
        [self.fsSlideViewController slideViewController:settingCtrl withKind:PushViewControllerKind_Right withAnimation:YES];
        [settingCtrl release];
    }
}


#pragma mark - 
#pragma FSTableContainerViewDelegate mark


-(NSInteger)tableViewSectionNumber:(FSTableContainerView *)sender{
    return 1;
}

-(NSInteger)tableViewNumberInSection:(FSTableContainerView *)sender section:(NSInteger)section{
    if ([_fs_GZF_ForOnedayNewsFocusTopDAO.objectList count]>0) {
        return [_fs_GZF_ForNewsListDAO.objectList count]+1;
    }
    else{
        return [_fs_GZF_ForNewsListDAO.objectList count];
    }
    return 0;
}


-(NSObject *)tableViewCellData:(FSTableContainerView *)sender withIndexPath:(NSIndexPath *)indexPath{
	NSInteger row = [indexPath row];
    
    if ([_fs_GZF_ForOnedayNewsFocusTopDAO.objectList count]>0) {
        if (row==0) {
            return _fs_GZF_ForOnedayNewsFocusTopDAO.objectList;
        }
        else{
            if (row <= [_fs_GZF_ForNewsListDAO.objectList count]) {
               // FSOneDayNewsObject *o = [_fs_GZF_ForNewsListDAO.objectList objectAtIndex:row-1];
                //NSLog(@"FSOneDayNewsObject:%d  :%@",row,o.title);
                return [_fs_GZF_ForNewsListDAO.objectList objectAtIndex:row-1];
            }
            
        }
    }
    else{
        if (row==0) {
            return _fs_GZF_ForOnedayNewsFocusTopDAO.objectList;
        }
        else{
            if (row <= [_fs_GZF_ForNewsListDAO.objectList count]) {
                return [_fs_GZF_ForNewsListDAO.objectList objectAtIndex:row-1];
            }
            
        }
    }
    
    return nil;

}

   

-(void)tableViewDataSourceDidSelected:(FSTableContainerView *)sender withIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    if ([_fs_GZF_ForOnedayNewsFocusTopDAO.objectList count]>0) {
        if (row== 0) {
            return;
        }
        FSOneDayNewsObject *o = [_fs_GZF_ForNewsListDAO.objectList objectAtIndex:row-1];
        FSNewsContainerViewController *fsNewsContainerViewController = [[FSNewsContainerViewController alloc] init];
        fsNewsContainerViewController.obj = o;
        fsNewsContainerViewController.FCObj = nil;
        fsNewsContainerViewController.newsSourceKind = NewsSourceKind_PuTongNews;
        
        //NSLog(@"1_newsListData:%@",o.title);
        [self.navigationController pushViewController:fsNewsContainerViewController animated:YES];
        //[self.fsSlideViewController pres:fsNewsContainerViewController animated:YES];
        //NSLog(@"2_newsListData:%@",o.newsid);
        [fsNewsContainerViewController release];
        [[FSBaseDB sharedFSBaseDB] updata_visit_message:o.channelid];
    }
    else{
        FSOneDayNewsObject *o = [_fs_GZF_ForNewsListDAO.objectList objectAtIndex:row-1];
        
        FSNewsContainerViewController *fsNewsContainerViewController = [[FSNewsContainerViewController alloc] init];
        
        fsNewsContainerViewController.obj = o;
        fsNewsContainerViewController.FCObj = nil;
        fsNewsContainerViewController.newsSourceKind = NewsSourceKind_PuTongNews;
        
        //NSLog(@"1_newsListData:%@",o.title);
        [self.navigationController pushViewController:fsNewsContainerViewController animated:YES];
        //[self.fsSlideViewController pres:fsNewsContainerViewController animated:YES];
        //NSLog(@"2_newsListData:%@",o.newsid);
        [fsNewsContainerViewController release];
        [[FSBaseDB sharedFSBaseDB] updata_visit_message:o.channelid];
    }
    
}


-(void)tableViewTouchPicture:(FSTableContainerView *)sender index:(NSInteger)index{
    //NSLog(@"channel did selected!%d",index);
    if (index<[_fs_GZF_ForOnedayNewsFocusTopDAO.objectList count]) {
        FSFocusTopObject *o = [_fs_GZF_ForOnedayNewsFocusTopDAO.objectList objectAtIndex:index];
        
        if ([o.flag isEqualToString:@"1"]) {
            FSNewsContainerViewController *fsNewsContainerViewController = [[FSNewsContainerViewController alloc] init];
            
            fsNewsContainerViewController.obj = nil;
            fsNewsContainerViewController.FCObj = o;
            fsNewsContainerViewController.newsSourceKind = NewsSourceKind_PuTongNews;
            
            [self.navigationController pushViewController:fsNewsContainerViewController animated:YES];
            //[self.fsSlideViewController pres:fsNewsContainerViewController animated:YES];
            [fsNewsContainerViewController release];
            [[FSBaseDB sharedFSBaseDB] updata_visit_message:o.channelid];
        }
        else if ([o.flag isEqualToString:@"2"]){//内嵌浏览器
            
            NSURL *url = [[NSURL alloc] initWithString:o.link];
            [[UIApplication sharedApplication] openURL:url];
            [url release];
            
        }
        else if ([o.flag isEqualToString:@"3"]){
            
            FSWebViewForOpenURLViewController *fsWebViewForOpenURLViewController = [[FSWebViewForOpenURLViewController alloc] init];
            
            fsWebViewForOpenURLViewController.urlString = o.link;
            fsWebViewForOpenURLViewController.withOutToolbar = YES;
            [self.navigationController pushViewController:fsWebViewForOpenURLViewController animated:YES];
            //[self.fsSlideViewController pres:fsNewsContainerViewController animated:YES];
            [fsWebViewForOpenURLViewController release];
        }
    }
    
}


-(void)tableViewDataSource:(FSTableContainerView *)sender withTableDataSource:(TableDataSource)dataSource{
    if (dataSource == tdsRefreshFirst) {
        FSLog(@"FSNewsViewController  tdsRefreshFirst");
        //[_routineNewsListContentView refreshDataSource];
        if (_reFreshDate!=nil) {
            [_reFreshDate release];
            _reFreshDate = nil;
        }
        
       _reFreshDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
        [_routineNewsListContentView reSetAssistantViewFlag:0];
        
        if ([_fs_GZF_ChannelListDAO.objectList count]==0) {
            [_fs_GZF_ChannelListDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
            return;
        }
        
        if ([_fs_GZF_ForNewsListDAO.channelid isEqualToString:@"1_0"]) {
            _fs_GZF_ForNewsListDAO.getNextOnline = NO;
        }
        else{
            _fs_GZF_ForNewsListDAO.getNextOnline = YES;
        }
        _fs_GZF_ForOnedayNewsFocusTopDAO.objectList = nil;
        [_fs_GZF_ForOnedayNewsFocusTopDAO HTTPGetDataWithKind:GET_DataKind_ForceRefresh];
        
        _fs_GZF_ForNewsListDAO.objectList = nil;
        [_fs_GZF_ForNewsListDAO HTTPGetDataWithKind:GET_DataKind_ForceRefresh];
        
    }
    if (dataSource == tdsNextSection) {
        FSOneDayNewsObject *o = [_fs_GZF_ForNewsListDAO.objectList lastObject];
        _fs_GZF_ForNewsListDAO.lastid = o.newsid;
        
        
        if ([_fs_GZF_ForNewsListDAO.channelid isEqualToString:@"1_0"]) {
            _fs_GZF_ForNewsListDAO.getNextOnline = NO;
        }
        else{
            _fs_GZF_ForNewsListDAO.getNextOnline = YES;
        }
        
        [_fs_GZF_ForNewsListDAO HTTPGetDataWithKind:GET_DataKind_Next];
    }
}


-(NSString *)tableViewDataSourceUpdateMessage:(FSTableContainerView *)sender{
    NSString *REdatetime = timeIntervalStringSinceNow(_reFreshDate);
    
    return REdatetime;
}

-(void)newsChannelSelected:(NSNotification *)aNotification{
    NSDictionary *o = [aNotification userInfo];
    NSString *channelID = [o valueForKey:NSNOTIF_NEWSCHANNEL_SELECTED_KEY];
    NSLog(@"channelID:%@",channelID);
    
    [self getUserChannelSelectedObject];
    [_routineNewsListContentView refreshDataSource];
    
//    [_fs_GZF_ForOnedayNewsFocusTopDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
//    [_routineNewsListContentView reSetAssistantViewFlag:0];
}


-(void)doSomethingWithDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status{
    
    NSLog(@"doSomethingWithDAO：%@ :%d",sender,status);

    if ([sender isEqual:_fs_GZF_ChannelListDAO]) {
        if (status == FSBaseDAOCallBack_SuccessfulStatus || status == FSBaseDAOCallBack_BufferSuccessfulStatus) {
            if (status == FSBaseDAOCallBack_SuccessfulStatus) {
                //FSLog(@"_fs_GZF_ForNewsListDAO Refresh");
                [self getUserChannelSelectedObject];
                if (status == FSBaseDAOCallBack_SuccessfulStatus) {
                    
                    [_fs_GZF_ChannelListDAO operateOldBufferData];
                    [_routineNewsListContentView refreshDataSource];
                    
                    //[_fs_GZF_ForOnedayNewsFocusTopDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
                }
            }
        }else if(status ==FSBaseDAOCallBack_NetworkErrorStatus){
            //[self getUserChannelSelectedObject];
            
            //[_fs_GZF_ForOnedayNewsFocusTopDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
        }
        return;
    }
    
    if ([sender isEqual:_fs_GZF_ForOnedayNewsFocusTopDAO]) {
        if (status == FSBaseDAOCallBack_SuccessfulStatus || status == FSBaseDAOCallBack_BufferSuccessfulStatus) {
            NSLog(@"FSNewsViewController:%d",[_fs_GZF_ForOnedayNewsFocusTopDAO.objectList count]);
            [_routineNewsListContentView loadDataWithOutCompelet];
            if (status == FSBaseDAOCallBack_SuccessfulStatus) {
                //FSLog(@"_fs_GZF_ForNewsListDAO Refresh");
                [_fs_GZF_ForOnedayNewsFocusTopDAO operateOldBufferData];
                
                //[_fs_GZF_ForNewsListDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
                [self updataWeatherMessage];
            }
        }else if(status ==FSBaseDAOCallBack_NetworkErrorStatus){
            
            //[_fs_GZF_ForNewsListDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
        }
        else if(status ==FSBaseDAOCallBack_ListWorkingStatus){
            
        }
        
        return;
    }
    
    
    if ([sender isEqual:_fs_GZF_ForNewsListDAO]) {
        if (status == FSBaseDAOCallBack_SuccessfulStatus || status == FSBaseDAOCallBack_BufferSuccessfulStatus) {
            NSLog(@"_fs_GZF_ForNewsListDAO:%d",[_fs_GZF_ForNewsListDAO.objectList count]);
            
            
            if (status == FSBaseDAOCallBack_SuccessfulStatus) {
                [_routineNewsListContentView reSetAssistantViewFlag:[_fs_GZF_ForNewsListDAO.objectList count]];
                [_routineNewsListContentView loadData];
                [_fs_GZF_ForNewsListDAO operateOldBufferData];
                //[_routineNewsListContentView loaddingComplete];
                //[_fsWeatherView doSomethingAtLayoutSubviews];
                //NSLog(@"self:%@ :%d",self,[self retainCount]);
//                NSInteger k = [self retainCount];
//                for (NSInteger i=0; i<k-1; i++) {
//                    [self release];
//                }
                
            }else{
                [_routineNewsListContentView loadData];
                [_routineNewsListContentView loadDataWithOutCompelet];
            }
        }
        else if(status ==FSBaseDAOCallBack_ListWorkingStatus){
            //[_routineNewsListContentView refreshDataSource];
        }else if(status == FSBaseDAOCallBack_NetworkErrorStatus || status == FSBaseDAOCallBack_HostErrorStatus){
            
            [_routineNewsListContentView loaddingComplete];
        }
        return;
    }
}


#pragma mark -
#pragma FSTitleViewDelegate
-(void)FSTitleViewTouchEvent:(FSTitleView *)titleView{
    
    NSLog(@"FSTitleViewTouchEvent");
    FSChannelListForNewsController *fsChannelController = [[FSChannelListForNewsController alloc] init];
    
    //[self.navigationController pushViewController:fsChannelController animated:YES];
    
    FSUINavigationController *NSfsChannelController = [[FSUINavigationController alloc] initWithRootViewController:fsChannelController];

    //self.navigationController.t
    
    //[self.navigationController pushViewController:fsChannelController animated:YES];
    
    //[self.fsTabBarViewController setHideTabBar:YES withAnimation:NO];
    
    [self.fsTabBarViewController setTabBarHided:YES withAnimation:NO];
    
    [self presentModalViewController:NSfsChannelController animated:YES];
    NSLog(@"FSTitleViewTouchEventFSTitleViewTouchEventFSTitleViewTouchEvent");
    [fsChannelController release];
    [NSfsChannelController release];
    
}



///______-----------------------------------------------
-(FSUserSelectObject *)getUserChannelSelectedObject{
    
    
    if (_isfirstShow) {
        NSArray *array = [[FSBaseDB sharedFSBaseDB] getObjectsByKeyWithName:@"FSUserSelectObject" key:@"kind" value:KIND_USERCHANNEL_SELECTED];
        
        if ([array count]>0) {
            FSUserSelectObject *sobj = [array objectAtIndex:0];
            
            if ([_fs_GZF_ChannelListDAO.objectList count]>0) {
                FSChannelObject *CObject = [_fs_GZF_ChannelListDAO.objectList objectAtIndex:0];
                sobj.kind = KIND_USERCHANNEL_SELECTED;
                sobj.keyValue1 = CObject.channelname;
                sobj.keyValue2 = CObject.channelid;
                sobj.keyValue3 = nil;
                [[FSBaseDB sharedFSBaseDB].managedObjectContext save:nil];
                
                _titleView.data = sobj.keyValue1;
                _fs_GZF_ForOnedayNewsFocusTopDAO.channelid = sobj.keyValue2;
                _fs_GZF_ForNewsListDAO.channelid = sobj.keyValue2;
                _fs_GZF_ForNewsListDAO.lastid = nil;
                _isfirstShow = NO;
                return sobj;
            }
            else{
                _titleView.data = @"";
                _fs_GZF_ForOnedayNewsFocusTopDAO.channelid = @"";
                _fs_GZF_ForNewsListDAO.channelid = @"";
                _fs_GZF_ForNewsListDAO.lastid = nil;
                _isfirstShow = NO;
                return nil;
            }
        }
        
    }
    
    
    NSArray *array = [[FSBaseDB sharedFSBaseDB] getObjectsByKeyWithName:@"FSUserSelectObject" key:@"kind" value:KIND_USERCHANNEL_SELECTED];
    
    if ([array count]>0) {
        FSUserSelectObject *sobj = [array objectAtIndex:0];
        
        if ([self channleISexp:sobj]) {
            _titleView.data = sobj.keyValue1;
            _fs_GZF_ForOnedayNewsFocusTopDAO.channelid = sobj.keyValue2;
            _fs_GZF_ForNewsListDAO.channelid = sobj.keyValue2;
            _fs_GZF_ForNewsListDAO.lastid = nil;
            
            return sobj;
        }
    }
    if ([_fs_GZF_ChannelListDAO.objectList count]==0) {
        _titleView.data = @"";
        _fs_GZF_ForOnedayNewsFocusTopDAO.channelid = @"";
        _fs_GZF_ForNewsListDAO.channelid = @"";
        _fs_GZF_ForNewsListDAO.lastid = nil;
        return nil;
    }
    FSChannelObject *CObject = [_fs_GZF_ChannelListDAO.objectList objectAtIndex:0];
        
    FSUserSelectObject *sobj = (FSUserSelectObject *)[[FSBaseDB sharedFSBaseDB] insertObject:@"FSUserSelectObject"];
        
    sobj.kind = KIND_USERCHANNEL_SELECTED;
    sobj.keyValue1 = CObject.channelname;
    sobj.keyValue2 = CObject.channelid;
    sobj.keyValue3 = nil;
    [[FSBaseDB sharedFSBaseDB].managedObjectContext save:nil];
    
    _titleView.data = sobj.keyValue1;
    _fs_GZF_ForOnedayNewsFocusTopDAO.channelid = sobj.keyValue2;
    _fs_GZF_ForNewsListDAO.channelid = sobj.keyValue2;
    _fs_GZF_ForNewsListDAO.lastid = nil;
    _isfirstShow = NO;
    return sobj;
    
}

-(BOOL)channleISexp:(FSUserSelectObject *)obj{
    
    for (FSChannelObject *o in _fs_GZF_ChannelListDAO.objectList) {
        if ([o.channelid isEqualToString:obj.keyValue2]) {
            return YES;
        }
    }
    [[FSBaseDB sharedFSBaseDB] deleteObjectByKey:@"FSUserSelectObject" key:@"kind" value:KIND_USERCHANNEL_SELECTED];
    [[FSBaseDB sharedFSBaseDB].managedObjectContext save:nil];
    return NO;
}



@end
