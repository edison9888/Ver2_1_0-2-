//
//  FSWeatherInformationCell.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-9.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSWeatherInformationCell.h"
#import "FSWeatherObject.h"
#import "FSCommonFunction.h"


#define H1 14
#define H2 40
#define H3 60
#define H4 100
#define H5 120

#define W 160


@implementation FSWeatherInformationCell


+(CGFloat)getCellHeight{
    return 0;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _lab_day = [[UILabel alloc] init];
        _lab_city = [[UILabel alloc] init];
        _lab_old_day = [[UILabel alloc] init];
        _lab_week_day = [[UILabel alloc] init];
        _lab_live_temperature = [[UILabel alloc] init];
        _lab_temperature = [[UILabel alloc] init];
        _lab_precipitation = [[UILabel alloc] init];
        _image_weather_icon = [[UIImageView alloc] init];
        
        _contain_background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weathercell_tianqibeijing.png"]];
        _contain_background.frame = CGRectZero;
        [self.contentView addSubview:_contain_background];
        [self.contentView addSubview:_lab_day];
        [self.contentView addSubview:_lab_city];
        [self.contentView addSubview:_lab_old_day];
        [self.contentView addSubview:_lab_week_day];
        [self.contentView addSubview:_lab_live_temperature];
        [self.contentView addSubview:_lab_temperature];
        [self.contentView addSubview:_lab_precipitation];
        [self.contentView addSubview:_image_weather_icon];
        
        
        _lab_day.backgroundColor = COLOR_CLEAR;
        _lab_day.textColor = COLOR_NEWSLIST_TITLE_WHITE;
        _lab_day.textAlignment = UITextAlignmentCenter;
        _lab_day.numberOfLines = 1;
        _lab_day.font = [UIFont systemFontOfSize:12];
        
        _lab_city.backgroundColor = COLOR_CLEAR;
        _lab_city.textColor = COLOR_NEWSLIST_TITLE_WHITE;
        _lab_city.textAlignment = UITextAlignmentLeft;
        _lab_city.numberOfLines = 1;
        _lab_city.font = [UIFont systemFontOfSize:18];
        
        _lab_old_day.backgroundColor = COLOR_CLEAR;
        _lab_old_day.textColor = COLOR_NEWSLIST_TITLE_WHITE;
        _lab_old_day.textAlignment = UITextAlignmentCenter;
        _lab_old_day.numberOfLines = 1;
        _lab_old_day.font = [UIFont systemFontOfSize:12];
        
        _lab_week_day.backgroundColor = COLOR_CLEAR;
        _lab_week_day.textColor = COLOR_NEWSLIST_TITLE_WHITE;
        _lab_week_day.textAlignment = UITextAlignmentLeft;
        _lab_week_day.numberOfLines = 1;
        _lab_week_day.font = [UIFont systemFontOfSize:TODAYNEWSLIST_TOP_TITLE_FONT];
        
        _lab_live_temperature.backgroundColor = COLOR_CLEAR;
        _lab_live_temperature.textColor = COLOR_NEWSLIST_TITLE_WHITE;
        _lab_live_temperature.textAlignment = UITextAlignmentCenter;
        _lab_live_temperature.numberOfLines = 1;
        _lab_live_temperature.font = [UIFont systemFontOfSize:38];
        
        _lab_temperature.backgroundColor = COLOR_CLEAR;
        _lab_temperature.textColor = COLOR_NEWSLIST_TITLE_WHITE;
        _lab_temperature.textAlignment = UITextAlignmentLeft;
        _lab_temperature.numberOfLines = 1;
        _lab_temperature.font = [UIFont systemFontOfSize:14];
        
        _lab_precipitation.backgroundColor = COLOR_CLEAR;
        _lab_precipitation.textColor = COLOR_NEWSLIST_TITLE_WHITE;
        _lab_precipitation.textAlignment = UITextAlignmentLeft;
        _lab_precipitation.numberOfLines = 1;
        _lab_precipitation.font = [UIFont systemFontOfSize:14];
        
        UIImageView *backGround = [[UIImageView alloc] init];
        backGround.image = [UIImage imageNamed:@"weathercell_beijing2.png"];
        self.backgroundView = backGround;
        [backGround release];

    }
    return self;
}

-(void)dealloc{
    [_lab_day release];
    [_lab_city release];
    [_lab_old_day release];
    [_lab_week_day release];
    [_lab_live_temperature release];
    [_lab_temperature release];
    [_lab_precipitation release];
    [_image_weather_icon release];
    [_contain_background release];
    [super dealloc];
}

-(void)doSomethingAtLayoutSubviews{
    
    if (self.data == nil) {
        return;
    }
    
    if ([self.data isKindOfClass:[NSString class]]) {
        _lab_city.text = (NSString *)self.data;
        
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0.0f];
        
        NSString *ymd = dateToString_YMD(date);
        _lab_day.text = ymd;
        _lab_old_day.text = [self getCHineseDate:date];
        
        _contain_background.frame = CGRectMake(10, self.frame.size.height-70, 255, 60);
        _image_weather_icon.frame = CGRectMake((self.frame.size.width-130)/2, (self.frame.size.height-150)/2, 130, 121);
        _lab_day.frame = CGRectMake(15, self.frame.size.height-85, 75, 16);
        _lab_old_day.frame = CGRectMake(self.frame.size.width-100, self.frame.size.height-85, 90, 16);
        
        CGFloat pwidth = [self getTextLabWidth:_lab_precipitation.text font:14];
        _lab_precipitation.frame = CGRectMake(15, self.frame.size.height-40, pwidth, 20);
        _lab_temperature.frame = CGRectMake(20+pwidth, self.frame.size.height-40, 80, 20);
        
        _lab_live_temperature.frame = CGRectMake(self.frame.size.width-100, self.frame.size.height-70, 90, 60);
        _lab_city.frame = CGRectMake(15, self.frame.size.height-65, 100, 20);
        
        return;
    }
    
    FSWeatherObject *o = (FSWeatherObject *)self.data;
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0.0f];
    
    NSString *ymd = dateToString_YMD(date);
    
    
    //NSString *week = [self getWeekWithDate:date];
    
    _lab_day.text = ymd;
    
    //NSString *year = [ymd substringToIndex:4];
    NSRange rang;
    rang.length = 2;
    rang.location = 5;
    //NSString *month = [ymd substringWithRange:rang];
    
    _lab_city.text = o.cityname;
    
    _lab_old_day.text = [self getCHineseDate:date];
    
    NSString *hm = dateToString_HM(date);
    hm = [hm substringToIndex:2];
    NSInteger h = [hm integerValue];
    if (h>=6 && h<=18) {
        _lab_live_temperature.text = [NSString stringWithFormat:@"%@",o.day_tp];
        _lab_precipitation.text = o.day_meteorology;
        [self downloadImage:o.day_icon];
    }
    else{
        
        _lab_live_temperature.text = [NSString stringWithFormat:@"%@",o.night_tp];
        _lab_precipitation.text = o.night_meteorology;
        [self downloadImage:o.night_icon];
    }
    _lab_temperature.text = [NSString stringWithFormat:@"%@-%@",o.night_tp,o.day_tp];
    
    
    _contain_background.frame = CGRectMake(10, self.frame.size.height-70, 255, 60);
    _image_weather_icon.frame = CGRectMake((self.frame.size.width-130)/2, (self.frame.size.height-150)/2, 130, 121);
    _lab_day.frame = CGRectMake(15, self.frame.size.height-85, 75, 16);
    _lab_old_day.frame = CGRectMake(self.frame.size.width-100, self.frame.size.height-85, 90, 16);
    
    CGFloat pwidth = [self getTextLabWidth:_lab_precipitation.text font:14];
    _lab_precipitation.frame = CGRectMake(15, self.frame.size.height-40, pwidth, 20);
    _lab_temperature.frame = CGRectMake(20+pwidth, self.frame.size.height-40, 80, 20);
    
    _lab_live_temperature.frame = CGRectMake(self.frame.size.width-100, self.frame.size.height-70, 90, 60);
    _lab_city.frame = CGRectMake(15, self.frame.size.height-65, 100, 20);
    //_lab_city.backgroundColor = COLOR_RED;
    
    
    
}


-(void)downloadImage:(NSString *)url{
    NSString *loaclFile = getFileNameWithURLString(url, getCachesPath());
    if (![[NSFileManager defaultManager] fileExistsAtPath:loaclFile]) {
        [FSNetworkData networkDataWithURLString:url withLocalStoreFileName:loaclFile withDelegate:self];
    }
    else{
        _image_weather_icon.image = [UIImage imageWithContentsOfFile:loaclFile];
    }
}

-(void)networkDataDownloadDataComplete:(FSNetworkData *)sender isError:(BOOL)isError data:(NSData *)data{
    if (data!=nil) {
        _image_weather_icon.image = [UIImage imageWithData:data];
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


-(NSString *)getCHineseDate:(NSDate *)date{
    
    
    NSTimeInterval timeInterval_day = 60*60*24;
    
    NSDate *nextDay_date = [NSDate dateWithTimeInterval:timeInterval_day sinceDate:date];
    
    
    
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    
    
    
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:nextDay_date];
    
    if ( 1 == localeComp.month && 1 == localeComp.day ) {
        
        [localeCalendar release];
        
        return @"农历除夕";
    }
    
    
    
    NSDictionary *chineseHoliDay = [NSDictionary dictionaryWithObjectsAndKeys:
                                    
                                    @"春节", @"1-1",
                                    
                                    @"元宵", @"1-15",
                                    
                                    @"端午", @"5-5",
                                    
                                    @"七夕", @"7-7",
                                    
                                    @"中元", @"7-15",
                                    
                                    @"中秋", @"8-15",
                                    
                                    @"重阳", @"9-9",
                                    
                                    @"腊八", @"12-8",
                                    
                                    @"小年", @"12-24",
                                    
                                    nil];
    
    localeComp = [localeCalendar components:unitFlags fromDate:date];
    
    NSString *key_str = [NSString stringWithFormat:@"%d-%d",localeComp.month,localeComp.day];
    
    
    NSString *jieri = [chineseHoliDay objectForKey:key_str];
    
    
    if (jieri!=nil) {
        [localeCalendar release];
        return [NSString stringWithFormat:@"农历%@",jieri];
    }
    
    
    
    NSDictionary *chineseDay = [NSDictionary dictionaryWithObjectsAndKeys:
                                    
                                    @"一", @"1",
                                    @"二", @"2",
                                    @"三", @"3",
                                    @"四", @"4",
                                    @"五", @"5",
                                    @"六", @"6",
                                    @"七", @"7",
                                    @"八", @"8",
                                    @"九", @"9",
                                    @"十", @"10",
                                    @"十一", @"11",
                                    @"十二", @"12",
                                    @"十三", @"13",
                                    @"十四", @"14",
                                    @"十五", @"15",
                                    @"十六", @"16",
                                    @"十七", @"17",
                                    @"十八", @"17",
                                    @"十九", @"18",
                                    @"廿", @"20",
                                    @"廿一", @"21",
                                    @"廿二", @"22",
                                    @"廿三", @"23",
                                    @"廿四", @"24",
                                    @"廿五", @"25",
                                    @"廿六", @"26",
                                    @"廿七", @"27",
                                    @"廿八", @"28",
                                    @"廿九", @"29",
                                    @"卅", @"30",
                                    @"卅一", @"31",
                                    nil];
    
    localeComp = [localeCalendar components:unitFlags fromDate:date];
    
    NSString *key_strday = [NSString stringWithFormat:@"%d",localeComp.day];
    NSString *key_strmonth = [NSString stringWithFormat:@"%d",localeComp.month];
    
    
    NSString *day = [chineseDay objectForKey:key_strday];
    NSString *month = [chineseDay objectForKey:key_strmonth];
    
    [localeCalendar release];
    if (localeComp.day>10) {
        return [NSString stringWithFormat:@"农历%@月%@",month,day];
    }
    else{
        return [NSString stringWithFormat:@"农历%@月初%@",month,day];
    }
    
    
    
    return @"";
    
}

-(CGFloat)getTextLabWidth:(NSString *)text font:(CGFloat)font{
    
    CGFloat width = 0;
    
    CGSize labs = [text sizeWithFont:[UIFont systemFontOfSize:font]];
    width = labs.width;
    return width;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




@end
