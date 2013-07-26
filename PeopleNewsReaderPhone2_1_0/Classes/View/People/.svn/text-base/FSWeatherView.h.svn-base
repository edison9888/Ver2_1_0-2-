//
//  FSWeatherView.h
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-6.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSBaseContainerView.h"
#import "FSNetworkData.h"

@class FSAsyncImageView;

@interface FSWeatherView : FSBaseContainerView<FSNetworkDataDelegate>{
@protected
    UIImageView *_image_WeatherIcon;
    UILabel *_lab_CityName;
    UILabel *_lab_Temperature;
}

@property (nonatomic,assign) id parentDelegate;


-(void)initializationVariable;
-(void)setContent;


-(void)downloadImage:(NSString *)url;

@end
