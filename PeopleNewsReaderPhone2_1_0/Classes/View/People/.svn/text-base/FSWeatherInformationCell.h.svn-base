//
//  FSWeatherInformationCell.h
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-9.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSTableViewCell.h"
#import "FSNetworkData.h"

@interface FSWeatherInformationCell : FSTableViewCell <FSNetworkDataDelegate>{
@protected
    
    UILabel *_lab_day;
    UILabel *_lab_city;
    UILabel *_lab_old_day;
    UILabel *_lab_week_day;
    UILabel *_lab_live_temperature;
    UILabel *_lab_temperature;
    UILabel *_lab_precipitation;
    UIImageView *_image_weather_icon;
    UIImageView *_contain_background;
    
}

-(NSString *)getWeekWithDate:(NSDate *)date;

-(NSString *)getCHineseDate:(NSDate *)date;

-(void)downloadImage:(NSString *)url;


-(CGFloat)getTextLabWidth:(NSString *)text font:(CGFloat)font;

@end
