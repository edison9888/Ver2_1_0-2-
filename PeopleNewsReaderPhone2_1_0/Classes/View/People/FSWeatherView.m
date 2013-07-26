//
//  FSWeatherView.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-6.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSWeatherView.h"
#import "FSConst.h"
#import "FSAsyncImageView.h"
#import "FSCommonFunction.h"


#import "FSWeatherObject.h"

#define CITYNAME_FRONT_SIZE 18.0f
#define TEMPERATURE_FRONT_SIZE 35.0f


@implementation FSWeatherView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)doSomethingAtDealloc{
    [_image_WeatherIcon release];
    [_lab_CityName release];
    [_lab_Temperature release];
}


-(void)doSomethingAtInit{
    _image_WeatherIcon = [[UIImageView alloc] init];
    _lab_CityName = [[UILabel alloc] init];
    _lab_Temperature = [[UILabel alloc] init];
    
    [self addSubview:_image_WeatherIcon];
    [self addSubview:_lab_CityName];
    [self addSubview:_lab_Temperature];
    [self initializationVariable];
}


-(void)doSomethingAtLayoutSubviews{
    if (self.data==nil) {
        return;
    }
    [self setContent];
    _image_WeatherIcon.frame = CGRectMake(0, 4, self.frame.size.height-8, self.frame.size.height-8);
    
    _lab_CityName.frame = CGRectMake(self.frame.size.height, 10, self.frame.size.width-self.frame.size.height + 16, self.frame.size.height/2-10);
    _lab_Temperature.frame = CGRectMake(self.frame.size.height, self.frame.size.height/2 - 8, self.frame.size.width-self.frame.size.height+8, self.frame.size.height/2-10);
}


-(void)initializationVariable{
    _lab_CityName.backgroundColor = COLOR_CLEAR;
    //_lab_CityName.textColor = COLOR_NEWSLIST_CHANNEL_TITLE;
    _lab_CityName.textColor   = [UIColor darkGrayColor];
    _lab_CityName.textAlignment = UITextAlignmentLeft;
    _lab_CityName.numberOfLines = 1;
    _lab_CityName.font = [UIFont systemFontOfSize:CITYNAME_FRONT_SIZE];
    
    _lab_Temperature.backgroundColor = COLOR_CLEAR;
    //_lab_Temperature.textColor = COLOR_NEWSLIST_CHANNEL_TITLE;
    _lab_Temperature.textColor = [UIColor blackColor];
    _lab_Temperature.textAlignment = UITextAlignmentLeft;
    _lab_Temperature.numberOfLines = 1;
    _lab_Temperature.font = [UIFont systemFontOfSize:TEMPERATURE_FRONT_SIZE];
}

-(void)setContent{
    
    FSWeatherObject *o = (FSWeatherObject *)self.data;
    //NSLog(@"FSWeatherObject:%@",o);
    
    NSString *time = dateToString_HM([NSDate dateWithTimeIntervalSinceNow:0.0f]);
    
    time = [time substringToIndex:2];
    //NSLog(@"time:%@",time);
    NSInteger h = [time integerValue];
    
    NSString *defaultDBPath;
    
    if (h>6 && h<18) {
        defaultDBPath = o.day_icon;
    }
    else{
        defaultDBPath = o.night_icon;
    }
    //NSLog(@"defaultDBPath%@",defaultDBPath);
    if (o.day_tp == nil || o.night_tp == nil) {
       _lab_Temperature.text = [NSString stringWithFormat:@""];
    }
    else{
        _lab_Temperature.text = [NSString stringWithFormat:@"%@",o.day_tp];
    }
    
    _lab_CityName.text = o.cityname;
    [self downloadImage:defaultDBPath];
    
}



-(void)downloadImage:(NSString *)url{
    NSString *loaclFile = getFileNameWithURLString(url, getCachesPath());
    if (![[NSFileManager defaultManager] fileExistsAtPath:loaclFile]) {
        [FSNetworkData networkDataWithURLString:url withLocalStoreFileName:loaclFile withDelegate:self];
    }
    else{
        _image_WeatherIcon.image = [UIImage imageWithContentsOfFile:loaclFile];
    }
}

-(void)networkDataDownloadDataComplete:(FSNetworkData *)sender isError:(BOOL)isError data:(NSData *)data{
    if (data!=nil) {
        _image_WeatherIcon.image = [UIImage imageWithData:data];
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

/*
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if ([_parentDelegate conformsToProtocol:@protocol(FSWeatherViewDelegate)] && [_parentDelegate respondsToSelector:@selector(FSWeatherViewTouchEvent:)]) {
        [_parentDelegate FSWeatherViewTouchEvent:self];
    }
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
}
 
 */

@end
