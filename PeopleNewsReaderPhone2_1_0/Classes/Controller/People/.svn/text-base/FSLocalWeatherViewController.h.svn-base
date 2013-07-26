//
//  FSLocalWeatherViewController.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-3-18.
//
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "FSBaseDataViewController.h"
#import <MapKit/MapKit.h>

#import "FSTitleView.h"

#import "FSLocalWeatherMessageView.h"


@class FS_GZF_CityListDAO,FS_GZF_GetWeatherMessageDAO;

@interface FSLocalWeatherViewController : FSBaseDataViewController<UIGestureRecognizerDelegate,CLLocationManagerDelegate,MKReverseGeocoderDelegate,FSTitleViewDelegate>{
@protected
    UINavigationBar *_navTopBar;
    FSTitleView *_titleView;
    
    FSLocalWeatherMessageView *_fsLocalWeatherMessageView;
    
    FS_GZF_CityListDAO *_fs_GZF_CityListDAO;
    
    FS_GZF_GetWeatherMessageDAO *_fs_GZF_localGetWeatherMessageDAO;
    NSDate *_reFreshDate;
    
    NSString *_cityName;
    NSString *_provinceName;
    
    BOOL _isFirstShow;
    
    NSString *_localCity;
}

@end
