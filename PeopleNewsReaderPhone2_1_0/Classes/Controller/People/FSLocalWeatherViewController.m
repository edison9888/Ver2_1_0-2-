//
//  FSLocalWeatherViewController.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-3-18.
//
//

#import "FSLocalWeatherViewController.h"
#import "FSSlideViewController.h"
#import "FSLocalNewsCityListController.h"


#import "FS_GZF_CityListDAO.h"
#import "FS_GZF_GetWeatherMessageDAO.h"

#import "FSCityObject.h"
#import "FSUserSelectObject.h"
#import "FSWeatherObject.h"
#import "FSBaseDB.h"

#define KIND_CITY_SELECTED @"KIND_CITY_SELECTED"

#define FSSETTING_VIEW_NAVBAR_HEIGHT 44.0f

@interface FSLocalWeatherViewController ()

@end

@implementation FSLocalWeatherViewController

- (id)init {
	self = [super init];
	if (self) {
		_isFirstShow = YES;
        _localCity = @"";
	}
	return self;
}

- (void)dealloc {
    [_fsLocalWeatherMessageView release];
    [_fs_GZF_CityListDAO release];
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
    _fsLocalWeatherMessageView = [[FSLocalWeatherMessageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height)];
    _fsLocalWeatherMessageView.parentDelegate = self;
    [self.view addSubview:_fsLocalWeatherMessageView];
    
    _titleView = [[FSTitleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
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
    [_fsLocalWeatherMessageView addGestureRecognizer:swipeRight];
    [swipeRight release];
    
    //[self getlocationManager];
    
    
}


-(void)getlocationManager{
    //NSLog(@"get getlocationManager");
    CLLocationManager *_locManager = [[CLLocationManager alloc] init];
    [_locManager setDelegate:self];
    [_locManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [_locManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
    //NSLog(@"newLocation:%@",newLocation);
    CLLocationCoordinate2D loc = [newLocation coordinate];
//    NSString *lat =[NSString stringWithFormat:@"%f",loc.latitude];//get latitude
//    NSString *lon =[NSString stringWithFormat:@"%f",loc.longitude];//get longitude
    //NSLog(@"locationManager:%@ %@",lat,lon);
    
    
    
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
                 //NSLog(@"addressDictionary%@",placemark.addressDictionary);
                 
                 //北京、上海、重庆、天津
                 NSString *State = [addressDictionary objectForKey:@"State"];
                 
                 NSString *SubLocality = [addressDictionary objectForKey:@"SubLocality"];
                
                 NSString *shi = [State substringFromIndex:[State length]-1];
                
                 if ([shi isEqualToString:@"市"]) {
                     //NSLog(@"111111");
                     
                     if ([_cityName isEqualToString:[State substringToIndex:[State length]-1]]) {
                         _localCity = _cityName;
                         return;
                     }
                     _localCity = [State substringToIndex:[State length]-1];
                     _fs_GZF_localGetWeatherMessageDAO.group = [State substringToIndex:[State length]-1];
                     [_fs_GZF_localGetWeatherMessageDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
                 }
                 else{
                     //NSLog(@"222222");
                     NSString *shi = [SubLocality substringFromIndex:[SubLocality length]-1];
                     if ([shi isEqualToString:@"市"]) {
                         if ([_cityName isEqualToString:[SubLocality substringToIndex:[SubLocality length]-1]]) {
                             _localCity = _cityName;
                             return;
                         }
                         _localCity = [State substringToIndex:[State length]-1];
                         _fs_GZF_localGetWeatherMessageDAO.group = [SubLocality substringToIndex:[SubLocality length]-1];
                         [_fs_GZF_localGetWeatherMessageDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
                     }
                     else{
                         return;//[_fs_GZF_localGetWeatherMessageDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
                     }
                 }
                 
             }
         }];
        [geocoder release];
        
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
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"授权"
//                                                        message:@"请先手动开启隐私授权，允许人民新闻使用定位服务！"
//                                                       delegate:nil
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil];
//    [alertView show];
//    [alertView release];
    
    
    //[_fs_GZF_localGetWeatherMessageDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
}


- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error
{
    NSString *errorMessage = [error localizedDescription];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"定位失败."
                                                        message:errorMessage
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
    
    
    //[_fs_GZF_localGetWeatherMessageDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark
{
    
    
    NSDictionary *addressDictionary = placemark.addressDictionary;
    //NSLog(@"addressDictionary%@",placemark.addressDictionary);
    
    //NSLog(@"SubLocality%@",[addressDictionary objectForKey:@"State"]);
    
    //北京、上海、重庆、天津
    NSString *State = [addressDictionary objectForKey:@"State"];
    
    NSString *SubLocality = [addressDictionary objectForKey:@"SubLocality"];
    
    NSString *shi = [State substringFromIndex:[State length]-1];
    
    if ([shi isEqualToString:@"市"]) {
        //NSLog(@"111111");
        
        if ([_cityName isEqualToString:[State substringToIndex:[State length]-1]]) {
            _localCity = _cityName;
            return;
        }
        _localCity = [State substringToIndex:[State length]-1];
        _fs_GZF_localGetWeatherMessageDAO.group = [State substringToIndex:[State length]-1];
        [_fs_GZF_localGetWeatherMessageDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
    }
    else{
        //NSLog(@"222222");
        NSString *shi = [SubLocality substringFromIndex:[SubLocality length]-1];
        if ([shi isEqualToString:@"市"]) {
            if ([_cityName isEqualToString:[SubLocality substringToIndex:[SubLocality length]-1]]) {
                _localCity = _cityName;
                return;
            }
            _localCity = [State substringToIndex:[State length]-1];
            _fs_GZF_localGetWeatherMessageDAO.group = [SubLocality substringToIndex:[SubLocality length]-1];
            [_fs_GZF_localGetWeatherMessageDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
        }
        else{
            return;//[_fs_GZF_localGetWeatherMessageDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
        }
    }
    
}



-(void)initDataModel{
    
    _fs_GZF_CityListDAO = [[FS_GZF_CityListDAO alloc] init];
    //_fs_GZF_CityListDAO.parentDelegate = self;
    //_fs_GZF_CityListDAO.isGettingList = YES;
    
    _fs_GZF_localGetWeatherMessageDAO = [[FS_GZF_GetWeatherMessageDAO alloc] init];
    _fs_GZF_localGetWeatherMessageDAO.parentDelegate = self;
    _fs_GZF_localGetWeatherMessageDAO.isGettingList = NO;
    _fs_GZF_localGetWeatherMessageDAO.group = @"";
    
}

-(void)doSomethingForViewFirstTimeShow{
    
    _reFreshDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    //NSLog(@"doSomethingForViewFirstTimeShow 111111");
    [_fs_GZF_localGetWeatherMessageDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
}


- (void)layoutControllerViewWithRect:(CGRect)rect {
    _fsLocalWeatherMessageView.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    //NSLog(@"layoutControllerViewWithRect 2222");
}


-(void)swipeLeftAction:(id)sender{
    [self.fsSlideViewController resetViewControllerWithAnimated:NO];
}



#pragma mark -
#pragma nsnotify mark

-(void)FSTitleViewTouchEvent:(FSTitleView *)titleView{
    FSLocalNewsCityListController *localCityListController = [[FSLocalNewsCityListController alloc] init];
    localCityListController.cityName = _cityName;
    localCityListController.localCity = _localCity;
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
    
    //[_fs_GZF_CityListDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
    
}

-(void)localNewsListCitySelected:(NSNotification *)aNotification{
    
    NSDictionary *info = [aNotification userInfo];
	_cityName = [info objectForKey:NSNOTIF_LOCALNEWSLIST_CITYSELECTED_KEY];
    //NSLog(@"localNewsListCitySelected 111111");
    _fs_GZF_localGetWeatherMessageDAO.group = _cityName;
    [_fs_GZF_localGetWeatherMessageDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
}

#pragma mark -
-(void)doSomethingWithDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status{
    NSLog(@"doSomethingWithDAO:%d",status);
    if ([sender isEqual:_fs_GZF_CityListDAO]) {
        if (status == FSBaseDAOCallBack_SuccessfulStatus || status == FSBaseDAOCallBack_BufferSuccessfulStatus) {
            if ([_fs_GZF_CityListDAO.objectList count]>0) {
                NSLog(@"获取城市列表成功！！！");

                if (status == FSBaseDAOCallBack_SuccessfulStatus) {
                    [_fs_GZF_CityListDAO operateOldBufferData];
                }
            }
        }else if(status ==FSBaseDAOCallBack_NetworkErrorStatus){
            ;
        }
        return;
    }
    
    
    if ([sender isEqual:_fs_GZF_localGetWeatherMessageDAO]) {
        
        if (status == FSBaseDAOCallBack_SuccessfulStatus || status == FSBaseDAOCallBack_BufferSuccessfulStatus) {
            NSLog(@"获取天气成功！！！:%d",[_fs_GZF_localGetWeatherMessageDAO.objectList count]);
            if ([_fs_GZF_localGetWeatherMessageDAO.objectList count]>0) {
                
                _fsLocalWeatherMessageView.group = _fs_GZF_localGetWeatherMessageDAO.group;
                _fsLocalWeatherMessageView.data = _fs_GZF_localGetWeatherMessageDAO.objectList;
                
                FSWeatherObject *obj =  [_fs_GZF_localGetWeatherMessageDAO.objectList objectAtIndex:0];
                
                _titleView.data = obj.cityname;
                _cityName = obj.cityname;
                
                if ([_localCity length]==0) {
                    _localCity = _cityName;
                }
                
                if (status == FSBaseDAOCallBack_SuccessfulStatus ) {//if(_fsUserSelectObject.keyValue3!=nil)
                    
                    if (![_fs_GZF_localGetWeatherMessageDAO.group isEqualToString:_cityName] && [_fs_GZF_localGetWeatherMessageDAO.group length]>0) {
                        //NSLog(@"%@ 暂无数据！",_fs_GZF_localGetWeatherMessageDAO.group);
                        FSInformationMessageView *informationMessageView = [[FSInformationMessageView alloc] initWithFrame:CGRectZero];
                        informationMessageView.parentDelegate = self;
                        [informationMessageView showInformationMessageViewInView:self.view
                                                                     withMessage:[NSString stringWithFormat:@"%@ 暂无数据！",_fs_GZF_localGetWeatherMessageDAO.group]
                                                                withDelaySeconds:2.0f
                                                                withPositionKind:PositionKind_Vertical_Horizontal_Center
                                                                      withOffset:0.0f];
                        [informationMessageView release];
                    }
                    
                    [_fs_GZF_localGetWeatherMessageDAO operateOldBufferData];
                    //[_fs_GZF_CityListDAO HTTPGetDataWithKind:GET_DataKind_Unlimited];
                    if (_isFirstShow) {
                        _isFirstShow = NO;
                        [self getlocationManager];
                        
                    }
                }
            }
        }
        else if(status ==FSBaseDAOCallBack_NetworkErrorStatus){
            ;
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
