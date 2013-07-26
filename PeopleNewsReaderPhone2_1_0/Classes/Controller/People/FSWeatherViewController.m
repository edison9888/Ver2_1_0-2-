//
//  FSWeatherViewController.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-13.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "PeopleNewsReaderPhoneAppDelegate.h"
#import "FSWeatherViewController.h"
#import "FSSlideViewController.h"

#import "FSLocalNewsCityListController.h"
#import "FSNewsContainerViewController.h"

#import "FS_GZF_ForLocalNewsListDAO.h"
#import "FS_GZF_CityListDAO.h"
#import "FS_GZF_GetWeatherMessageDAO.h"

#import "FSOneDayNewsObject.h"
#import "FSCityObject.h"
#import "FSUserSelectObject.h"
#import "FSBaseDB.h"




#define KIND_CITY_SELECTED @"KIND_CITY_SELECTED"

#define FSSETTING_VIEW_NAVBAR_HEIGHT 44.0f

@implementation FSWeatherViewController


- (id)init {
	self = [super init];
	if (self) {
		
	}
	return self;
}

- (void)dealloc {
    [_localNewsListContentView release];
    [_fs_GZF_CityListDAO release];
    [_fs_GZF_ForLocalNewsListDAO release];
    [_fs_GZF_localGetWeatherMessageDAO release];
    [_navTopBar release];
    [_titleView release];
    [_reFreshDate release];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSNOTIF_POPOCITYLISTCONTROLLER object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSNOTIF_LOCALNEWSLISTREFRESH object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSNOTIF_LOCALNEWSLIST_CITYSELECTED object:nil];
    [super dealloc];
}

- (void)loadChildView {
    _localNewsListContentView = [[FSLocalNewsListContentView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height)];
    _localNewsListContentView.parentDelegate = self;
    [self.view addSubview:_localNewsListContentView];
    
    _titleView = [[FSTitleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-44, 44)];
    _titleView.hidRefreshBt = YES;
    _titleView.toBottom = NO;
    _titleView.parentDelegate = self;
    
    _navTopBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, FSSETTING_VIEW_NAVBAR_HEIGHT)];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
        [_navTopBar setBackgroundImage:[UIImage imageNamed: @"navigatorBar.png"] forBarMetrics:UIBarMetricsDefault];
    }
    [_navTopBar addSubview:_titleView];
    //[_titleView reSetFrame];
    
	[self.view addSubview:_navTopBar];
    
    _reFreshDate = nil;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popoCityListController) name:NSNOTIF_POPOCITYLISTCONTROLLER object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localNewsListRefresh) name:NSNOTIF_LOCALNEWSLISTREFRESH object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localNewsListCitySelected:) name:NSNOTIF_LOCALNEWSLIST_CITYSELECTED object:nil];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftAction:)];
    swipeRight.delegate = self;
    swipeRight.direction = UISwipeGestureRecognizerDirectionLeft;
    [_localNewsListContentView addGestureRecognizer:swipeRight];
    [swipeRight release];
    
    //[self getlocationManager];
    
    
}


-(void)getlocationManager{
    NSLog(@"get getlocationManager");
    CLLocationManager *_locManager = [[CLLocationManager alloc] init];
    [_locManager setDelegate:self];
    [_locManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [_locManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
    NSLog(@"newLocation:%@",newLocation);
    CLLocationCoordinate2D loc = [newLocation coordinate];
    NSString *lat =[NSString stringWithFormat:@"%f",loc.latitude];//get latitude
    NSString *lon =[NSString stringWithFormat:@"%f",loc.longitude];//get longitude
    NSLog(@"locationManager:%@ %@",lat,lon);
    
    
    
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    NSInteger v = [systemVersion integerValue];
    
    if (v>5) {
        //获取所在地城市名
        CLGeocoder *geocoder=[[CLGeocoder alloc]init];
        [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks,NSError *error)
         {
             for(CLPlacemark *placemark in placemarks)
             {
                 //NSString *currentCity=[[placemark.addressDictionary objectForKey:@"City"] substringToIndex:2];
                 NSDictionary *addressDictionary = placemark.addressDictionary;
                 NSLog(@"addressDictionary%@",placemark.addressDictionary);
                
                 NSArray *array = [[FSBaseDB sharedFSBaseDB] getObjectsByKeyWithName:@"FSUserSelectObject" key:@"kind" value:KIND_CITY_SELECTED];
                 
                 if ([array count]>0) {
                     FSUserSelectObject *sobj = [array objectAtIndex:0];
                     NSDate *date = [NSDate dateWithTimeIntervalSince1970:0];
                     NSString *nsstringdate = dateToString_YMD(date);
                     if (![sobj.keyValue4 isEqualToString:nsstringdate]) {
                         sobj.kind = KIND_CITY_SELECTED;
                         sobj.keyValue1 = [addressDictionary objectForKey:@"State"];
                         sobj.keyValue2 = [addressDictionary objectForKey:@"SubLocality"];
                         sobj.keyValue3 = @"";
                         sobj.keyValue4 = nsstringdate;
                     }
                 }
                 else{
                     
                     NSDate *date = [NSDate dateWithTimeIntervalSince1970:0];
                     NSString *nsstringdate = dateToString_YMD(date);
                     FSUserSelectObject *sobj = (FSUserSelectObject *)[[FSBaseDB sharedFSBaseDB] insertObject:@"FSUserSelectObject"];
                     sobj.kind = KIND_CITY_SELECTED;
                     sobj.keyValue1 = [addressDictionary objectForKey:@"State"];
                     sobj.keyValue2 = [addressDictionary objectForKey:@"SubLocality"];
                     sobj.keyValue3 = @"";
                     sobj.keyValue4 = nsstringdate;
                     [[FSBaseDB sharedFSBaseDB].managedObjectContext save:nil];
                 }
                 
             }
         }];
        
    }
    else{
        MKReverseGeocoder *reverseGeocoder =[[[MKReverseGeocoder alloc] initWithCoordinate:loc] autorelease];
        reverseGeocoder.delegate = self;
        [reverseGeocoder start];
    }
    
    [manager stopUpdatingLocation];
    
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@" locationManager errorerror");
    //请先允许 人民新闻是用定位服务。
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"授权"
                                                        message:@"请先手动开启隐私授权，允许人民新闻使用定位服务！"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}


- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error
{
    NSString *errorMessage = [error localizedDescription];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cannot obtain address."
                                                        message:errorMessage
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark
{
    
    
    NSDictionary *addressDictionary = placemark.addressDictionary;
    //NSLog(@"addressDictionary%@",placemark.addressDictionary);
    
    //NSLog(@"SubLocality%@",[addressDictionary objectForKey:@"State"]);
    
    NSArray *array = [[FSBaseDB sharedFSBaseDB] getObjectsByKeyWithName:@"FSUserSelectObject" key:@"kind" value:KIND_CITY_SELECTED];
    
    if ([array count]>0) {
        FSUserSelectObject *sobj = [array objectAtIndex:0];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:0];
        NSString *nsstringdate = dateToString_YMD(date);
        if (![sobj.keyValue4 isEqualToString:nsstringdate]) {
            sobj.kind = KIND_CITY_SELECTED;
            sobj.keyValue1 = [addressDictionary objectForKey:@"State"];
            sobj.keyValue2 = [addressDictionary objectForKey:@"SubLocality"];
            sobj.keyValue3 = @"";
            sobj.keyValue4 = nsstringdate;
        }
    }
    else{
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:0];
        NSString *nsstringdate = dateToString_YMD(date);
        FSUserSelectObject *sobj = (FSUserSelectObject *)[[FSBaseDB sharedFSBaseDB] insertObject:@"FSUserSelectObject"];
        sobj.kind = KIND_CITY_SELECTED;
        sobj.keyValue1 = [addressDictionary objectForKey:@"State"];
        sobj.keyValue2 = [addressDictionary objectForKey:@"SubLocality"];
        sobj.keyValue3 = @"";
        sobj.keyValue4 = nsstringdate;
        [[FSBaseDB sharedFSBaseDB].managedObjectContext save:nil];
    }
    
}



-(void)initDataModel{
    _fs_GZF_ForLocalNewsListDAO = [[FS_GZF_ForLocalNewsListDAO alloc] init];
    _fs_GZF_ForLocalNewsListDAO.parentDelegate = self;
    _fs_GZF_ForLocalNewsListDAO.isGettingList = YES;
    
    _fs_GZF_CityListDAO = [[FS_GZF_CityListDAO alloc] init];
    _fs_GZF_CityListDAO.parentDelegate = self;
    _fs_GZF_CityListDAO.isGettingList = YES;
    
    _fs_GZF_localGetWeatherMessageDAO = [[FS_GZF_GetWeatherMessageDAO alloc] init];
    _fs_GZF_localGetWeatherMessageDAO.parentDelegate = self;
    _fs_GZF_localGetWeatherMessageDAO.isGettingList = YES;
    
}

-(void)doSomethingForViewFirstTimeShow{
    
    _reFreshDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    [_localNewsListContentView refreshDataSource];
    //[_fs_GZF_CityListDAO HTTPGetDataWithKind:GET_DataKind_Unlimited];
    //[_fsWeatherNewsListData HTTPGetDataWithKind:GETDataKind_Refresh];
    //[_localNewsListContentView loadData];
}


- (void)layoutControllerViewWithRect:(CGRect)rect {
    _localNewsListContentView.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    
}


-(void)swipeLeftAction:(id)sender{
    [self.fsSlideViewController resetViewControllerWithAnimated:YES];
}

#pragma mark - 
#pragma FSTableContainerViewDelegate mark


-(NSInteger)tableViewSectionNumber:(FSTableContainerView *)sender{
    return 1;
}

-(NSInteger)tableViewNumberInSection:(FSTableContainerView *)sender section:(NSInteger)section{
    //NSLog(@"[_fs_GZF_ForLocalNewsListDAO.objectList count]+1:%d",[_fs_GZF_ForLocalNewsListDAO.objectList count]+1);
    return [_fs_GZF_ForLocalNewsListDAO.objectList count]+1;
}

-(UITableViewCellSelectionStyle)tableViewCellSelectionStyl:(FSTableContainerView *)sender withIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellSelectionStyleNone;
}


- (NSObject *)tableViewCellData:(FSTableContainerView *)sender withIndexPath:(NSIndexPath *)indexPath {
	//NSInteger section = [indexPath section];
	NSInteger row = [indexPath row];
    
    if (row==0) {
        if ([_fs_GZF_localGetWeatherMessageDAO.objectList count]>0) {
            return [_fs_GZF_localGetWeatherMessageDAO.objectList objectAtIndex:0];
        }
        return (NSString *)_titleView.data;
    }
    else{
        return [_fs_GZF_ForLocalNewsListDAO.objectList objectAtIndex:row-1];
    }
    return nil;

}

-(void)tableViewDataSourceDidSelected:(FSTableContainerView *)sender withIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = [indexPath row];
    if (row==0) {
        //[self getlocationManager];
        return;
    }
    FSOneDayNewsObject *o = [_fs_GZF_ForLocalNewsListDAO.objectList objectAtIndex:row-1];
    
    FSNewsContainerViewController *fsNewsContainerViewController = [[FSNewsContainerViewController alloc] init];
    fsNewsContainerViewController.obj = o;
    fsNewsContainerViewController.FCObj = nil;
    fsNewsContainerViewController.isNewNavigation = YES;
    fsNewsContainerViewController.newsSourceKind = NewsSourceKind_DiFangNews;
    
    
    [self.fsSlideViewController presentModalViewController:fsNewsContainerViewController animated:YES];
    //[self.navigationController presentModalViewController:fsNewsContainerViewController animated:YES];
    
    
    [fsNewsContainerViewController release];
   
    [[FSBaseDB sharedFSBaseDB] updata_visit_message:o.channelid];
}


-(void)tableViewTouchPicture:(FSTableContainerView *)sender withImageURLString:(NSString *)imageURLString withImageLocalPath:(NSString *)imageLocalPath imageID:(NSString *)imageID{
    NSLog(@"channel did selected!!");
    
}

-(void)tableViewDataSource:(FSTableContainerView *)sender withTableDataSource:(TableDataSource)dataSource{
    if (dataSource == tdsRefreshFirst) {
        //[_fs_GZF_CityListDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
        //[_localNewsListContentView refreshDataSource];
        if (_reFreshDate != nil) {
            [_reFreshDate release];
            _reFreshDate = nil;
        }
        _reFreshDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
        [_fs_GZF_CityListDAO HTTPGetDataWithKind:GET_DataKind_Unlimited];
        [_localNewsListContentView reSetAssistantViewFlag:0];
    }
    if (dataSource == tdsNextSection) {
        //[_fs_GZF_CityListDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
        FSOneDayNewsObject *o = [_fs_GZF_ForLocalNewsListDAO.objectList lastObject];
        _fs_GZF_ForLocalNewsListDAO.lastnewsid = o.newsid;
        NSLog(@"GET_DataKind_Next");
        [_fs_GZF_ForLocalNewsListDAO HTTPGetDataWithKind:GET_DataKind_Next];
    }
}

-(NSString *)tableViewDataSourceUpdateMessage:(FSTableContainerView *)sender{
    NSString *REdatetime = timeIntervalStringSinceNow(_reFreshDate);
    
    return REdatetime;
}

#pragma mark -
#pragma nsnotify mark

-(void)FSTitleViewTouchEvent:(FSTitleView *)titleView{
    FSLocalNewsCityListController *localCityListController = [[FSLocalNewsCityListController alloc] init];
    localCityListController.view.backgroundColor = [UIColor blueColor];
    [self.fsSlideViewController presentModalViewController:localCityListController animated:YES];
    
    [localCityListController release];
    return;
}

-(void)popoCityListController{
#ifdef MYDEBUG
    NSLog(@"popoCityListController");
#endif
    
    //---------------
    
    FSLocalNewsCityListController *localCityListController = [[FSLocalNewsCityListController alloc] init];
    localCityListController.view.backgroundColor = [UIColor blueColor];
    [self.fsSlideViewController presentModalViewController:localCityListController animated:YES];
    
    [localCityListController release];
    return;
}

-(void)localNewsListRefresh{
#ifdef MYDEBUG
    NSLog(@"localNewsListRefresh11");
#endif

    [_fs_GZF_CityListDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
    
}

-(void)localNewsListCitySelected:(NSNotification *)aNotification{
        
    FSUserSelectObject *sobj = [self insertCityselectedObject:nil];
    if (sobj!=nil) {
        NSLog(@"sobj:%@",sobj.keyValue1);
        if (sobj.keyValue2!=nil) {
            _fs_GZF_localGetWeatherMessageDAO.group = sobj.keyValue1;
            _fs_GZF_localGetWeatherMessageDAO.cityID = sobj.keyValue2;
            _titleView.data = sobj.keyValue1;
        }
        else{
            _fs_GZF_localGetWeatherMessageDAO.group = @"本地";
            _titleView.data = @"本地";
        }
    }
    else{
        NSLog(@"sobj:%@",sobj.keyValue2);
        _fs_GZF_localGetWeatherMessageDAO.group = @"本地";
        _titleView.data = @"本地";
    }
    [_localNewsListContentView refreshDataSource];
//    [_fs_GZF_localGetWeatherMessageDAO HTTPGetDataWithKind:GET_DataKind_ForceRefresh];
//    [_localNewsListContentView reSetAssistantViewFlag:0];

}

#pragma mark -
-(void)doSomethingWithDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status{
    NSLog(@"doSomethingWithDAO");
    if ([sender isEqual:_fs_GZF_CityListDAO]) {
        if (status == FSBaseDAOCallBack_SuccessfulStatus || status == FSBaseDAOCallBack_BufferSuccessfulStatus) {
            if ([_fs_GZF_CityListDAO.objectList count]>0) {
                NSLog(@"获取城市列表成功！！！");
                
                FSCityObject *o = [_fs_GZF_CityListDAO.objectList objectAtIndex:0];
                FSUserSelectObject *sobj = [self insertCityselectedObject:o];
                NSLog(@"sobj:%@",sobj);
                if (sobj!=nil) {
                    NSLog(@"sobj:%@",sobj.keyValue1);
                    if (sobj.keyValue2!=nil) {
                        _fs_GZF_localGetWeatherMessageDAO.group = sobj.keyValue1;
                        _fs_GZF_localGetWeatherMessageDAO.cityID = sobj.keyValue2;
                        _titleView.data = sobj.keyValue1;
                    }
                    else{
                        _fs_GZF_localGetWeatherMessageDAO.group = @"本地";
                        _titleView.data = @"本地";
                    }
                }
                else{
                    NSLog(@"sobj:%@",sobj.keyValue2);
                    _fs_GZF_localGetWeatherMessageDAO.group = @"本地";
                    _titleView.data = @"本地";
                }
                
                if (status == FSBaseDAOCallBack_SuccessfulStatus) {
                   NSLog(@"11sobj:%@",sobj.keyValue1);
                    
                    [_fs_GZF_localGetWeatherMessageDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
                    [_fs_GZF_CityListDAO operateOldBufferData];
                }
            
                
            }
        }else if(status ==FSBaseDAOCallBack_NetworkErrorStatus){
            //[_fs_GZF_localGetWeatherMessageDAO HTTPGetDataWithKind:GET_DataKind_ForceRefresh];
        }
        return;
    }
    
    
    if ([sender isEqual:_fs_GZF_localGetWeatherMessageDAO]) {
        NSLog(@"获取天气成功！！！");
        if (status == FSBaseDAOCallBack_SuccessfulStatus || status == FSBaseDAOCallBack_BufferSuccessfulStatus) {
            if ([_fs_GZF_localGetWeatherMessageDAO.objectList count]>0) {
                
                if (status == FSBaseDAOCallBack_SuccessfulStatus ) {//if(_fsUserSelectObject.keyValue3!=nil)
                    
                    
                    FSUserSelectObject *sobj = [self insertCityselectedObject:nil];
                    if(sobj!=nil){
                        _fs_GZF_ForLocalNewsListDAO.provinceid = sobj.keyValue3;//???
                        //_titleView.data = sobj.keyValue1;
                    }
                    
                    [_fs_GZF_ForLocalNewsListDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
                    [_fs_GZF_localGetWeatherMessageDAO operateOldBufferData];
                }
            }
        }
        else if(status ==FSBaseDAOCallBack_NetworkErrorStatus){
            [_fs_GZF_ForLocalNewsListDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
        }
        return;
    }
    
    
    if ([sender isEqual:_fs_GZF_ForLocalNewsListDAO]) {
        if (status == FSBaseDAOCallBack_SuccessfulStatus || status == FSBaseDAOCallBack_BufferSuccessfulStatus) {
            NSLog(@"_fs_GZF_ForLocalNewsListDAO:%d",[_fs_GZF_ForLocalNewsListDAO.objectList count]);
            
            if (status == FSBaseDAOCallBack_SuccessfulStatus) {
                [_localNewsListContentView reSetAssistantViewFlag:[_fs_GZF_ForLocalNewsListDAO.objectList count]];
                [_fs_GZF_ForLocalNewsListDAO operateOldBufferData];
                //[_localNewsListContentView loaddingComplete];
            }
            if ([_fs_GZF_ForLocalNewsListDAO.objectList count]>0) {
                [_localNewsListContentView loadData];
            }
        }
        else if(status == FSBaseDAOCallBack_NetworkErrorStatus || status == FSBaseDAOCallBack_HostErrorStatus){
            
            [_localNewsListContentView loaddingComplete];
        }
        return;
    }
}


-(FSUserSelectObject *)insertCityselectedObject:(FSCityObject *)obj{
    NSArray *array = [[FSBaseDB sharedFSBaseDB] getObjectsByKeyWithName:@"FSUserSelectObject" key:@"kind" value:KIND_CITY_SELECTED];
    
    if ([array count]>0) {
        FSUserSelectObject *sobj = [array objectAtIndex:0];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:0];
        NSString *nsstringdate = dateToString_YMD(date);
        if ([sobj.keyValue4 isEqualToString:nsstringdate]) {
            return sobj;
        }
        else{
            //[self getlocationManager];
        }
        return sobj;
    }
    else{
        if (obj==nil) {
            return nil;
        }
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:0];
        NSString *nsstringdate = dateToString_YMD(date);
        FSUserSelectObject *sobj = (FSUserSelectObject *)[[FSBaseDB sharedFSBaseDB] insertObject:@"FSUserSelectObject"];
        sobj.kind = KIND_CITY_SELECTED;
        sobj.keyValue1 = obj.cityName;
        sobj.keyValue2 = obj.cityId;
        sobj.keyValue3 = obj.provinceId;
        sobj.keyValue4 = nsstringdate;
        [[FSBaseDB sharedFSBaseDB].managedObjectContext save:nil];
        return sobj;
    }

}


@end

























