//
//  FSLocalNewsCityListController.h
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-14.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSBaseDataViewController.h"
#import "FSLocalNewsCityListView.h"
#import "FSTitleView.h"
#import "FS_GZF_CityListDAO.h"


@class FSUserSelectObject,FSCityObject;


@interface FSLocalNewsCityListController : FSBaseDataViewController<FSTableContainerViewDelegate,FSTitleViewDelegate>{
@protected
    FSLocalNewsCityListView *_localNewsCityListView;
    UINavigationBar *_navTopBar;
    FSTitleView *_titleView;
    FS_GZF_CityListDAO *_fsCityListData;
    NSMutableArray *_sectionArrary;
    NSMutableArray *_sectionNumberArrary;
    
    NSString *_cityName;
    
    NSString *_localCity;
    
}

@property (nonatomic,retain) NSString *cityName;
@property (nonatomic,retain) NSString *localCity;

-(void)getSectionsTitle;

-(FSUserSelectObject *)insertCityselectedObject:(FSCityObject *)obj;

@end
