//
//  FSWeatherViewController.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-13.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "FSBaseDataViewController.h"
#import "FSLocalNewsListContentView.h"
#import "FSTitleView.h"
#import <MapKit/MapKit.h>



@class FSUserSelectObject,FSCityObject;

@class FS_GZF_ForLocalNewsListDAO,FS_GZF_CityListDAO,FS_GZF_GetWeatherMessageDAO;

@interface FSWeatherViewController : FSBaseDataViewController<UIPopoverControllerDelegate,FSTableContainerViewDelegate,UIGestureRecognizerDelegate,FSTitleViewDelegate,CLLocationManagerDelegate,MKReverseGeocoderDelegate>{
@protected
    FSLocalNewsListContentView *_localNewsListContentView;
    UINavigationBar *_navTopBar;
    FSTitleView *_titleView;
    
    FS_GZF_ForLocalNewsListDAO *_fs_GZF_ForLocalNewsListDAO;
    
    FS_GZF_CityListDAO *_fs_GZF_CityListDAO;
    
    FS_GZF_GetWeatherMessageDAO *_fs_GZF_localGetWeatherMessageDAO;
    NSDate *_reFreshDate;
}

-(FSUserSelectObject *)insertCityselectedObject:(FSCityObject *)obj;

-(void)getlocationManager;


@end
