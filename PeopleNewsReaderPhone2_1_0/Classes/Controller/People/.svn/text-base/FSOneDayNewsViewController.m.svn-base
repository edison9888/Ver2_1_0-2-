    //
//  FSOneDayNewsViewController.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-13.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSOneDayNewsViewController.h"
#import "FSSlideViewController.h"
//#import "FSWeatherViewController.h"
#import "FSLocalWeatherViewController.h"
#import "FSSettingViewController.h"

#import "FS_GZF_ForOnedayNewsFocusTopDAO.h"
#import "FS_GZF_ForOneDayNewsListDAO.h"

#import "FS_GZF_GetWeatherMessageDAO.h"

#import "FSFocusTopObject.h"

#import "FSSectionObject.h"
#import "FSOneDayNewsObject.h"
#import "FSCommonFunction.h"
#import "NSDate+Ex.h"

#import "FSBaseDB.h"

#import "FSNewsContainerViewController.h"
#import "FSWebViewForOpenURLViewController.h"


@implementation FSOneDayNewsViewController

- (id)init {
	self = [super init];
	if (self) {
		
	}
	return self;
}

- (void)dealloc {
    
	_newsListData.parentDelegate = nil;
    [_newsListData release];
    [_fs_GZF_GetWeatherMessageDAO release];
    [_fsOneDayNewsListContainerView release];
    [_fsForOneDayNewsListFocusTopData release];
    [_sectionMessage removeAllObjects];
    [_sectionMessage release];
    [_reFreshDate release];
    [super dealloc];
}

- (void)initDataModel {
	_newsListData = [[FS_GZF_ForOneDayNewsListDAO alloc] init];
	_newsListData.parentDelegate = self;
    _newsListData.getNextOnline = NO;
    _newsListData.isGettingList = YES;
    _newsListData.SetChannalIcon = YES;
    
    _fsForOneDayNewsListFocusTopData = [[FS_GZF_ForOnedayNewsFocusTopDAO alloc] init];
    _fsForOneDayNewsListFocusTopData.parentDelegate = self;
    _fsForOneDayNewsListFocusTopData.group = SHIKE_NEWS_LIST_KIND;
    _fsForOneDayNewsListFocusTopData.type = @"realtime";
    _fsForOneDayNewsListFocusTopData.channelid = @"";
    _fsForOneDayNewsListFocusTopData.count = 3;
    _fsForOneDayNewsListFocusTopData.isGettingList = YES;
    _sectionMessage = [[NSMutableArray alloc] init];
    
    _reFreshDate = nil;
    _TimeInterval = 0;
    _fs_GZF_GetWeatherMessageDAO = [[FS_GZF_GetWeatherMessageDAO alloc] init];
    _fs_GZF_GetWeatherMessageDAO.group = @"";
    _fs_GZF_GetWeatherMessageDAO.parentDelegate = self;
    _fs_GZF_GetWeatherMessageDAO.isGettingList = YES;
    
}

- (void)loadChildView {
	[super loadChildView];
	self.view.backgroundColor = COLOR_NEWSLIST_TITLE_WHITE;
    _fsOneDayNewsListContainerView = [[FSOneDayNewsListContainerView alloc] init];
    _fsOneDayNewsListContainerView.parentDelegate = self;
    [self.view addSubview:_fsOneDayNewsListContainerView];
	//标签栏设置
	//[self.fsTabBarItem setTabBarItemWithNormalImage:[UIImage imageNamed:@"oneDayNews.png"] withSelectedImage:[UIImage imageNamed:@"oneDayNews.png"] withText:NSLocalizedString(@"时刻", nil)];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftAction:)];
    swipeLeft.delegate = self;
    swipeLeft.direction = UISwipeGestureRecognizerDirectionRight;
    [_fsOneDayNewsListContainerView addGestureRecognizer:swipeLeft];
    [swipeLeft release];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightAction:)];
    swipeRight.delegate = self;
    swipeRight.direction = UISwipeGestureRecognizerDirectionLeft;
    [_fsOneDayNewsListContainerView addGestureRecognizer:swipeRight];
    [swipeRight release];
}



- (UIImage *)tabBarItemNormalImage {
	return [UIImage imageNamed:@"oneday.png"];
}

- (NSString *)tabBarItemText {
	return NSLocalizedString(@"时刻", nil);
}

- (UIImage *)tabBarItemSelectedImage {
	return [UIImage imageNamed:@"oneday_sel.png"];
}


- (void)layoutControllerViewWithRect:(CGRect)rect {
    _fsOneDayNewsListContainerView.frame = CGRectMake(0.0f, 0.0f, rect.size.width, rect.size.height);
    
}

- (void)doSomethingForViewFirstTimeShow {
	//[_fsOneDayNewsListContainerView loadData];
	
	//net work data
	//[_newsListData HTTPGetDataWithKind:GET_DataKind_Refresh];
    NSLog(@"FSOneDayNewsViewController doSomethingForViewFirstTimeShow");
    _reFreshDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    
    _fsForOneDayNewsListFocusTopData.isGettingList = YES;
    [_fsOneDayNewsListContainerView refreshDataSource];
//    _fsForOneDayNewsListFocusTopData.isGettingList = YES;
//    [_fsForOneDayNewsListFocusTopData HTTPGetDataWithKind:GET_DataKind_Refresh];
    
    
}

- (void)layoutControllerViewWithInterfaceOrientation:(UIInterfaceOrientation)willToOrientation {
	[super layoutControllerViewWithInterfaceOrientation:willToOrientation];
	//NSLog(@"layoutControllerViewWithInterfaceOrientation 111");
    
    BOOL mark = [[GlobalConfig shareConfig] getOnedayChannalMark];
    
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    NSTimeInterval currentTimeInterval = [date timeIntervalSince1970];
    [date release];
    
    if (_TimeInterval != 0 && mark && currentTimeInterval - _TimeInterval>5) {
        NSLog(@"刷新1111");
        _TimeInterval = currentTimeInterval;
        BOOL mark = [[GlobalConfig shareConfig] getOnedayChannalMark];
        if (mark) {
            [_fsOneDayNewsListContainerView refreshDataSource];
            [[GlobalConfig shareConfig] setOnedayChannalMark:NO];
        }
        
    }
    else{
        NSLog(@"时间过短");
        
    }
}



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
    //NSLog(@"[_sectionMessage count]:%d",[_sectionMessage count]);
    if ([_sectionMessage count]==0) {
        return 2;
    }
    return [_sectionMessage count]+1;
}

-(NSInteger)tableViewNumberInSection:(FSTableContainerView *)sender section:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    
    if (section <= [_sectionMessage count]) {
         
        FSSectionObject *Obj = [_sectionMessage objectAtIndex:section-1];
        //NSLog(@"[Obj.numberInSection]:%d",Obj.numberInSection);
        return Obj.numberInSection;
    }
    return 0;
}




- (NSObject *)tableViewCellData:(FSTableContainerView *)sender withIndexPath:(NSIndexPath *)indexPath {

	NSInteger section = [indexPath section];
	NSInteger row = [indexPath row];
    if (row==0 && section==0) {
        if ([_fsForOneDayNewsListFocusTopData.objectList count]==0) {
            return nil;
        }
        return _fsForOneDayNewsListFocusTopData.objectList;
    }
    if (section <= [_sectionMessage count]) {
        FSSectionObject *Obj = [_sectionMessage objectAtIndex:section-1];
        //NSLog(@"indexPath:%@:%@",indexPath,Obj.day);
        return [_newsListData.objectList objectAtIndex:Obj.sectionBeginIndex+row];
    }
    return nil;
}

-(NSString *)tableViewSectionTitle:(FSTableContainerView *)sender section:(NSInteger)section{
     
    return @"20120914";
}

-(void)tableViewDataSourceDidSelected:(FSTableContainerView *)sender withIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = [indexPath section];
	NSInteger row = [indexPath row];

    if (section==0) {
        return;
    }
    if (section <= [_sectionMessage count]) {
        FSSectionObject *Obj = [_sectionMessage objectAtIndex:section-1];
        FSOneDayNewsObject *o = [_newsListData.objectList objectAtIndex:Obj.sectionBeginIndex+row];
        FSNewsContainerViewController *fsNewsContainerViewController = [[FSNewsContainerViewController alloc] init];
        NSLog(@"fsNewsContainerViewController1:%d",[fsNewsContainerViewController retainCount]);
        fsNewsContainerViewController.obj = o;
        fsNewsContainerViewController.FCObj = nil;
        fsNewsContainerViewController.newsSourceKind = NewsSourceKind_ShiKeNews;
        NSLog(@"fsNewsContainerViewController2:%d",[fsNewsContainerViewController retainCount]);
        
        [self.navigationController pushViewController:fsNewsContainerViewController animated:YES];
        //[self.fsSlideViewController pres:fsNewsContainerViewController animated:YES];
        NSLog(@"fsNewsContainerViewController3:%d",[fsNewsContainerViewController retainCount]);
        [fsNewsContainerViewController release];
        [[FSBaseDB sharedFSBaseDB] updata_visit_message:o.channelid];
    }
    
}



-(void)tableViewTouchPicture:(FSTableContainerView *)sender index:(NSInteger)index{
    NSLog(@"channel did selected!%d",index);
    if (index<[_fsForOneDayNewsListFocusTopData.objectList count]) {
        FSFocusTopObject *o = [_fsForOneDayNewsListFocusTopData.objectList objectAtIndex:index];
        
        if ([o.flag isEqualToString:@"1"]) {
            FSNewsContainerViewController *fsNewsContainerViewController = [[FSNewsContainerViewController alloc] init];
            
            fsNewsContainerViewController.obj = nil;
            fsNewsContainerViewController.FCObj = o;
            fsNewsContainerViewController.newsSourceKind = NewsSourceKind_ShiKeNews;
            
            [self.navigationController pushViewController:fsNewsContainerViewController animated:YES];
            //[self.fsSlideViewController pres:fsNewsContainerViewController animated:YES];
            
            [fsNewsContainerViewController release];
            [[FSBaseDB sharedFSBaseDB] updata_visit_message:o.channelid];
        }
        else if ([o.flag isEqualToString:@"2"]){
            
            NSURL *url = [[NSURL alloc] initWithString:o.link];
            [[UIApplication sharedApplication] openURL:url];
            [url release];
        }
        else if ([o.flag isEqualToString:@"3"]){//内嵌浏览器
            FSWebViewForOpenURLViewController *fsWebViewForOpenURLViewController = [[FSWebViewForOpenURLViewController alloc] init];
            
            fsWebViewForOpenURLViewController.urlString = o.link;
            fsWebViewForOpenURLViewController.withOutToolbar = YES;
            [self.navigationController pushViewController:fsWebViewForOpenURLViewController animated:YES];
            //[self.fsSlideViewController pres:fsNewsContainerViewController animated:YES];
            [fsWebViewForOpenURLViewController release];
        }
        
    }
    
}

-(NSString *)tableViewDataSourceUpdateMessage:(FSTableContainerView *)sender{
    NSString *REdatetime = timeIntervalStringSinceNow(_reFreshDate);
    
    return REdatetime;
}

-(void)tableViewDataSource:(FSTableContainerView *)sender withTableDataSource:(TableDataSource)dataSource{
    NSLog(@"tableViewDataSource tableViewDataSource");
    if (dataSource == tdsRefreshFirst) {
        //[_fsOneDayNewsListContainerView refreshDataSource];
        if (_reFreshDate != nil) {
            [_reFreshDate release];
            _reFreshDate = nil;
        }
        
        _reFreshDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
        _TimeInterval = [_reFreshDate timeIntervalSince1970];
        [_fsOneDayNewsListContainerView reSetAssistantViewFlag:0];
        [_newsListData selectChannelListString];
        [_newsListData HTTPGetDataWithKind:GET_DataKind_ForceRefresh];
        [[GlobalConfig shareConfig] setOnedayChannalMark:NO];
        [_fsForOneDayNewsListFocusTopData HTTPGetDataWithKind:GET_DataKind_ForceRefresh];
        
    }
    if (dataSource == tdsNextSection) {
        NSLog(@"更多");
        
        FSOneDayNewsObject *o = [_newsListData.objectList lastObject];
        _newsListData.getNextOnline = YES;
         NSLog(@"更多:%@",o.realtimeid);
        //_newsListData.lastid = o.realtimeid;//by zhiliang
        [_newsListData selectChannelListString];
        [_newsListData HTTPGetDataWithKind:GET_DataKind_Next];
    }
}

#pragma mark -
- (void)doSomethingWithDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status {
    
    NSLog(@"doSomethingWithDAO ONE：%@ :%d",sender,status);
    if ([sender isEqual:_fsForOneDayNewsListFocusTopData]) {
        if (status == FSBaseDAOCallBack_SuccessfulStatus || status == FSBaseDAOCallBack_BufferSuccessfulStatus) {
            
            [self reSetSectionMessage];
            [_fsOneDayNewsListContainerView loadDataWithOutCompelet];//
            
            NSLog(@"_fsForOneDayNewsListFocusTopData:%d",[_fsForOneDayNewsListFocusTopData.objectList count]);
            if (status == FSBaseDAOCallBack_SuccessfulStatus) {
                [_fsForOneDayNewsListFocusTopData operateOldBufferData];
                //[_newsListData HTTPGetDataWithKind:GET_DataKind_Refresh];
                [_fsWeatherView doSomethingAtLayoutSubviews];
            }
            //
            return;
        }else if(status == FSBaseDAOCallBack_NetworkErrorStatus){
            
            [_fsOneDayNewsListContainerView loaddingComplete];
        }
        else if(status ==FSBaseDAOCallBack_HostErrorStatus){
            //[_newsListData HTTPGetDataWithKind:GET_DataKind_Refresh];
        }
    }
    
    
	if ([sender isEqual:_newsListData]) {
		if (status == FSBaseDAOCallBack_SuccessfulStatus ||
			status == FSBaseDAOCallBack_BufferSuccessfulStatus) {
            //NSLog(@"_newsListData");
//#ifdef MYDEBUG
//            NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
//            NSLog(@"doSomethingWithDAO 1:%f :%@",[date timeIntervalSince1970],sender);
//#endif
            
            if (status == FSBaseDAOCallBack_SuccessfulStatus) {
                [self reSetSectionMessage];
                [_fsOneDayNewsListContainerView reSetAssistantViewFlag:[_newsListData.objectList count]];
                [_fsOneDayNewsListContainerView loadData];
                [_newsListData operateOldBufferData];
                
                [_fs_GZF_GetWeatherMessageDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
                
            }
            else{
                [self reSetSectionMessage];
                [_fsOneDayNewsListContainerView loadDataWithOutCompelet];
            }
            return;
		}
        else if(status == FSBaseDAOCallBack_NetworkErrorStatus || status == FSBaseDAOCallBack_HostErrorStatus){
            NSLog(@"FSBaseDAOCallBack_NetworkErrorStatus1122");
            [_fsOneDayNewsListContainerView loaddingComplete];
            return;
        }
	}
    
    
    if ([sender isEqual:_fs_GZF_GetWeatherMessageDAO]) {
		if (status == FSBaseDAOCallBack_SuccessfulStatus ||
			status == FSBaseDAOCallBack_BufferSuccessfulStatus) {
            //NSLog(@"_fs_GZF_GetWeatherMessageDAO");
            if ([_fs_GZF_GetWeatherMessageDAO.objectList count]>0) {
                
                _fsWeatherView.data = [_fs_GZF_GetWeatherMessageDAO.objectList objectAtIndex:0];
                //NSLog(@"%@",_fsWeatherView.data);
                
                if (status == FSBaseDAOCallBack_SuccessfulStatus) {
                    [_fs_GZF_GetWeatherMessageDAO operateOldBufferData];
                    //[_fsOneDayNewsListContainerView loaddingComplete];
                    [_fsWeatherView doSomethingAtLayoutSubviews];
                    //NSLog(@"self:%@ :%d",self,[self retainCount]);
//                    NSInteger k = [self retainCount];
//                    for (NSInteger i=0; i<k-1; i++) {
//                        [self release];
//                    }
                    
                }
            }
            
        }
	}
}

-(void)doSomethingWithLoadingListDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status{
    if ([sender isEqual:_fs_GZF_GetWeatherMessageDAO]){
        
    }
}



-(NSString *)getWeekWithDate:(NSDate *)date{
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSWeekdayCalendarUnit fromDate:date];
    int weekday = [weekdayComponents weekday];
	[gregorian release];
    //NSLog(@"weekday:%d",weekday);
    switch (weekday) {
        case 1:
            return @"星期日";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
        default:
            break;
    }
    return @"";
}

-(void)reSetSectionMessage{
    
    NSMutableArray *timeArray = [[NSMutableArray alloc] init];
    if ([_newsListData.objectList count]>0) {
        [_sectionMessage removeAllObjects];
        NSInteger j=0;
        for (FSOneDayNewsObject *o in _newsListData.objectList) {
            //NSLog(@"%@",o);
            FSSectionObject *lastObj;
            if ([_sectionMessage count]>0) {
                lastObj = [_sectionMessage lastObject];
            }
            
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[o.timestamp doubleValue]];
            NSString *week = [self getWeekWithDate:date];
            //NSLog(@"week:%@  %d",week,j);
            NSString *time = dateToString_YMD(date);
            if ([_sectionMessage count]==0) {
                FSSectionObject *obj = [[FSSectionObject alloc] init];
                obj.sectionBeginIndex = j;
                obj.numberInSection = 1;
                //NSLog(@"time:%@",time);
                obj.day = time;
                obj.week = week;
                [_sectionMessage addObject:obj];
                [obj release];
            }else if([lastObj.day isEqualToString:time]){
                lastObj.numberInSection = lastObj.numberInSection +1;
            }else if(![lastObj.day isEqualToString:time]){
                FSSectionObject *obj = [[FSSectionObject alloc] init];
                obj.sectionBeginIndex = j;
                obj.numberInSection = 1;
                //NSLog(@"time:%@",time);
                obj.day = time;
                obj.week = week;
                [_sectionMessage addObject:obj];
                [obj release];
            }
            [timeArray addObject:dateToString_YMDHM(date)];
            j++;
        }
    }
    _fsOneDayNewsListContainerView.timeArray = timeArray;
    [timeArray release];
    _fsOneDayNewsListContainerView.sectionArray = _sectionMessage;
    
}

@end
