//
//  FSLocalWeatherMessageView.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-3-18.
//
//

#import "FSLocalWeatherMessageView.h"
#import "FSLocalNextDayWeatherMessageView.h"
#import "FSWeatherObject.h"
#import "FSCommonFunction.h"

#import "FSBaseDB.h"
#import "FSUserSelectObject.h"

#define namol_font 14.0f
#define tp_font 50.0f
#define zhishu_font 14.0f

#define FUTV_height 130.0f

@implementation FSLocalWeatherMessageView

@synthesize group = _group;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)doSomethingAtDealloc{
    [_lab_date release];
    [_lab_updataDate release];
    [_lab_tp release];
    [_lab_meteorology release];
    [_lab_wind release];
    [_weatherIcon release];
    [_line release];
    [_lineBACK release];
    [_rightView2 release];
    [_rightView1 release];
    [_rightView2BACK release];
    [_rightView1BACK release];
    
    [_lab_zhishu1 release];
    [_lab_zhishu11 release];
    [_lab_zhishu2 release];
    [_lab_zhishu22 release];
    [_lab_zhishu3 release];
    [_lab_zhishu33 release];
    
    [_scrollView release];
}

-(void)doSomethingAtInit{
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.delegate = self;
    
    
    _lab_date = [[UILabel alloc] init];
    _lab_updataDate = [[UILabel alloc] init];
    _lab_tp = [[UILabel alloc] init];
    _lab_meteorology = [[UILabel alloc] init];
    _lab_wind = [[UILabel alloc] init];
    
    _lab_zhishu1 = [[UILabel alloc] init];
    _lab_zhishu11 = [[UILabel alloc] init];
    
    _lab_zhishu2 = [[UILabel alloc] init];
    _lab_zhishu22 = [[UILabel alloc] init];
    
    _lab_zhishu3 = [[UILabel alloc] init];
    _lab_zhishu33 = [[UILabel alloc] init];
    
    _lab_date.textColor = COLOR_NEWSLIST_TITLE;
    _lab_updataDate.textColor = COLOR_NEWSLIST_DESCRIPTION;
    _lab_tp.textColor = COLOR_NEWSLIST_TITLE;
    _lab_meteorology.textColor = COLOR_NEWSLIST_TITLE;
    _lab_wind.textColor = COLOR_NEWSLIST_TITLE;
    
    _lab_zhishu1.textColor = COLOR_NEWSLIST_TITLE;
    _lab_zhishu11.textColor = COLOR_NEWSLIST_DESCRIPTION;
    
    _lab_zhishu2.textColor = COLOR_NEWSLIST_TITLE;
    _lab_zhishu22.textColor = COLOR_NEWSLIST_DESCRIPTION;
    
    _lab_zhishu3.textColor = COLOR_NEWSLIST_TITLE;
    _lab_zhishu33.textColor = COLOR_NEWSLIST_DESCRIPTION;
    
    
    _lab_date.textAlignment = UITextAlignmentLeft;
    _lab_updataDate.textAlignment = UITextAlignmentLeft;
    _lab_tp.textAlignment = UITextAlignmentLeft;
    _lab_meteorology.textAlignment = UITextAlignmentLeft;
    _lab_wind.textAlignment = UITextAlignmentLeft;
    
    _lab_zhishu1.textAlignment = UITextAlignmentLeft;
    _lab_zhishu11.textAlignment = UITextAlignmentLeft;
    
    _lab_zhishu2.textAlignment = UITextAlignmentLeft;
    _lab_zhishu22.textAlignment = UITextAlignmentLeft;
    
    _lab_zhishu3.textAlignment = UITextAlignmentLeft;
    _lab_zhishu33.textAlignment = UITextAlignmentLeft;
    
    _lab_zhishu11.numberOfLines = 3;
    _lab_zhishu22.numberOfLines = 3;
    _lab_zhishu33.numberOfLines = 3;
    
    
    _lab_date.font = [UIFont systemFontOfSize:TODAYNEWSLIST_TITLE_FONT];
    _lab_updataDate.font = [UIFont systemFontOfSize:namol_font];
    _lab_tp.font = [UIFont systemFontOfSize:tp_font];
    _lab_meteorology.font = [UIFont systemFontOfSize:namol_font];
    _lab_wind.font = [UIFont systemFontOfSize:namol_font];
    
    _lab_zhishu1.font = [UIFont systemFontOfSize:zhishu_font];
    _lab_zhishu11.font = [UIFont systemFontOfSize:zhishu_font];
    
    _lab_zhishu2.font = [UIFont systemFontOfSize:zhishu_font];
    _lab_zhishu22.font = [UIFont systemFontOfSize:zhishu_font];
    
    _lab_zhishu3.font = [UIFont systemFontOfSize:zhishu_font];
    _lab_zhishu33.font = [UIFont systemFontOfSize:zhishu_font];
    
    
    _lab_date.backgroundColor = [UIColor clearColor];
    _lab_updataDate.backgroundColor = [UIColor clearColor];
    _lab_tp.backgroundColor = [UIColor clearColor];
    _lab_meteorology.backgroundColor = [UIColor clearColor];
    _lab_wind.backgroundColor = [UIColor clearColor];
    
    _lab_zhishu1.backgroundColor = [UIColor clearColor];
    _lab_zhishu11.backgroundColor = [UIColor clearColor];
    
    _lab_zhishu2.backgroundColor = [UIColor clearColor];
    _lab_zhishu22.backgroundColor = [UIColor clearColor];
    
    _lab_zhishu3.backgroundColor = [UIColor clearColor];
    _lab_zhishu33.backgroundColor = [UIColor clearColor];
    
    
    
    
    
    _weatherIcon = [[FSAsyncImageView alloc] init];
    _weatherIcon.imageCuttingKind = ImageCuttingKind_fixrect;
    _weatherIcon.borderColor = COLOR_CLEAR;
    
    
    
    UIImageView *image = [[UIImageView alloc] init];
    image.image = [UIImage imageNamed:@"weather_BG.png"];
    image.frame = CGRectMake(0, 0, self.frame.size.width, image.image.size.height);
    
    [self addSubview:image];
    [image release];
    
    
    _lineBACK = [[UIView alloc] init];
    _lineBACK.backgroundColor = COLOR_NEWSLIST_TITLE_WHITE;
    [self addSubview:_lineBACK];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = [UIColor colorWithRed:208.0f/255.0f green:208.0f/255.0f blue:208.0f/255.0f alpha:1.0];
    [self addSubview:_line];
    
    
    
    
    _rightView1BACK = [[UIView alloc] init];
    _rightView1BACK.backgroundColor = COLOR_NEWSLIST_TITLE_WHITE;
    [self addSubview:_rightView1BACK];
    
    _rightView2BACK = [[UIView alloc] init];
    _rightView2BACK.backgroundColor = COLOR_NEWSLIST_TITLE_WHITE;
    [self addSubview:_rightView2BACK];
    
    
    _rightView1 = [[UIView alloc] init];
    _rightView1.backgroundColor = [UIColor colorWithRed:218.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:0.8];
    [self addSubview:_rightView1];
    
    _rightView2 = [[UIView alloc] init];
    _rightView2.backgroundColor = [UIColor colorWithRed:218.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:0.8];
    [self addSubview:_rightView2];
   
    
    
    _NextDayWeatherMessageView1 = [[FSLocalNextDayWeatherMessageView alloc] init];
    _NextDayWeatherMessageView2 = [[FSLocalNextDayWeatherMessageView alloc] init];
    _NextDayWeatherMessageView3 = [[FSLocalNextDayWeatherMessageView alloc] init];
    
    _NextDayWeatherMessageView1.backgroundColor = COLOR_CLEAR;
    _NextDayWeatherMessageView2.backgroundColor = COLOR_CLEAR;
    _NextDayWeatherMessageView3.backgroundColor = COLOR_CLEAR;

    
    
    [_scrollView addSubview:_lab_date];
    [_scrollView addSubview:_lab_updataDate];
    [_scrollView addSubview:_lab_tp];
    [_scrollView addSubview:_lab_meteorology];
    [_scrollView addSubview:_lab_wind];
    
    
    [_scrollView addSubview:_lab_zhishu1];
    [_scrollView addSubview:_lab_zhishu11];
    
    [_scrollView addSubview:_lab_zhishu2];
    [_scrollView addSubview:_lab_zhishu22];
    
    [_scrollView addSubview:_lab_zhishu3];
    [_scrollView addSubview:_lab_zhishu33];
    
    [_scrollView addSubview:_weatherIcon];
    
    [self addSubview:_scrollView];
    
    [self addSubview:_NextDayWeatherMessageView1];
    [self addSubview:_NextDayWeatherMessageView2];
    [self addSubview:_NextDayWeatherMessageView3];
    
    
    
}




-(void)doSomethingAtLayoutSubviews{
    
    
    _scrollView.frame = CGRectMake(0, 44, self.frame.size.width, self.frame.size.height - FUTV_height-44);
    //_scrollView.backgroundColor = COLOR_RED;
    
    CGFloat orY = 6.0f;
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0.0f];
    
    NSString *md = [self FromeDateFormat:date];
    NSString *OldDate = [self getCHineseDate:date];
    
    _lab_date.frame = CGRectMake(10.0f, orY, self.frame.size.width-20, [self getTextLabHeight:@"中国" font:TODAYNEWSLIST_TITLE_FONT]);
    _lab_date.text = [NSString stringWithFormat:@"%@  %@",md,OldDate];
    
    
    if (self.data==nil) {
        return;
    }
    
    NSArray *array = (NSArray *)self.data;
    
    if ([array count]<=0) {
        return;
    }
    
    
    NSString *time = dateToString_HM([NSDate dateWithTimeIntervalSinceNow:0.0f]);
    
    time = [time substringToIndex:2];
   
    NSInteger h = [time integerValue];
    
    
    FSWeatherObject *obj0 = [array objectAtIndex:0];
 //NSLog(@"obj0:%@",obj0);
    
    orY = orY + [self getTextLabHeight:@"中国" font:TODAYNEWSLIST_TITLE_FONT] + 2;
    _lab_updataDate.frame = CGRectMake(10.0f, orY, self.frame.size.width-20, [self getTextLabHeight:@"中国" font:namol_font]);
    _lab_updataDate.text = obj0.updataMessage;
    
    orY = orY + [self getTextLabHeight:@"中国" font:namol_font] + 10;
    _lab_tp.frame = CGRectMake(10.0f, orY, self.frame.size.width-20, [self getTextLabHeight:@"中国" font:tp_font]);
    
    if (h>6 && h<18) {
        if (obj0.day_tp==nil) {
            _lab_tp.text = @"";
        }
        else{
            _lab_tp.text = obj0.day_tp;
        }
        
    }
    else{
        if (obj0.night_tp==nil) {
            _lab_tp.text = @"";
        }
        else{
            _lab_tp.text = obj0.night_tp;
        }
    }
    
    
    _weatherIcon.frame = CGRectMake(self.frame.size.width - 144, orY-8, 130, 130);
    
    orY = orY + [self getTextLabHeight:@"中国" font:tp_font] + 4;
    _lab_meteorology.frame = CGRectMake(10.0f, orY, self.frame.size.width-20, [self getTextLabHeight:@"中国" font:namol_font]);
    
    
    if (h>6 && h<18) {
        _lab_meteorology.text = obj0.day_meteorology;
    }
    else{
       _lab_meteorology.text = obj0.night_meteorology;
    }
    
    
    orY = orY + [self getTextLabHeight:@"中国" font:namol_font] + 2;
    _lab_wind.frame = CGRectMake(10.0f, orY, self.frame.size.width-20, [self getTextLabHeight:@"中国" font:namol_font]);
    
    if (obj0.day_wind_direction==nil || obj0.day_wind_power==nil) {
        _lab_wind.text = @"";
    }
    else{
        if (h>6 && h<18) {
            _lab_wind.text = [NSString stringWithFormat:@"%@ %@",obj0.day_wind_direction,obj0.day_wind_power];
        }
        else{
            _lab_wind.text = [NSString stringWithFormat:@"%@ %@",obj0.night_wind_direction,obj0.night_wind_power];
        }
    }
    
    
    NSArray *zhishuArray = [[FSBaseDB sharedFSBaseDB] getObjectsByKeyWithName:@"FSUserSelectObject" key:@"kind" value:[NSString stringWithFormat:@"weather_%@",self.group]];
    
    NSLog(@"zhishuArray:%d",[zhishuArray count]);
    
    if ([zhishuArray count]>0) {
        FSUserSelectObject *uobj = [zhishuArray objectAtIndex:0];
        
        orY = orY + [self getTextLabHeight:@"中国" font:namol_font] + 14;
        _lab_zhishu1.frame = CGRectMake(10.0f, orY, self.frame.size.width-20, [self getTextLabHeight:@"中国" font:zhishu_font]);
        _lab_zhishu1.text = [NSString stringWithFormat:@"%@:%@",uobj.keyValue1,uobj.keyValue2];
        orY = orY + [self getTextLabHeight:@"中国" font:zhishu_font];
        
        _lab_zhishu11.frame = CGRectMake(10.0f, orY, self.frame.size.width-20, [self getTextLabHeight:uobj.keyValue3 font:zhishu_font]);
        _lab_zhishu11.text = uobj.keyValue3;
        orY = orY + [self getTextLabHeight:uobj.keyValue3 font:zhishu_font]+4;
    }
    
    if ([zhishuArray count]>1) {
        FSUserSelectObject *uobj = [zhishuArray objectAtIndex:1];
        
        _lab_zhishu2.frame = CGRectMake(10.0f, orY, self.frame.size.width-20, [self getTextLabHeight:@"中国" font:zhishu_font]);
        _lab_zhishu2.text = [NSString stringWithFormat:@"%@:%@",uobj.keyValue1,uobj.keyValue2];
        orY = orY + [self getTextLabHeight:@"中国" font:zhishu_font];
        
        _lab_zhishu22.frame = CGRectMake(10.0f, orY, self.frame.size.width-20, [self getTextLabHeight:uobj.keyValue3 font:zhishu_font]);
        _lab_zhishu22.text = uobj.keyValue3;
        orY = orY + [self getTextLabHeight:uobj.keyValue3 font:zhishu_font]+4;
    }
    
    if ([zhishuArray count]>2) {
        FSUserSelectObject *uobj = [zhishuArray objectAtIndex:2];
        
        _lab_zhishu3.frame = CGRectMake(10.0f, orY, self.frame.size.width-20, [self getTextLabHeight:@"中国" font:zhishu_font]);
        _lab_zhishu3.text = [NSString stringWithFormat:@"%@:%@",uobj.keyValue1,uobj.keyValue2];
        orY = orY + [self getTextLabHeight:@"中国" font:zhishu_font];
        
        _lab_zhishu33.frame = CGRectMake(10.0f, orY, self.frame.size.width-20, [self getTextLabHeight:uobj.keyValue3 font:zhishu_font]);
        _lab_zhishu33.text = uobj.keyValue3;
        orY = orY + [self getTextLabHeight:uobj.keyValue3 font:zhishu_font];
    }
    
    
    
    
    if (h>6 && h<18) {
        _weatherIcon.urlString = obj0.day_icon;
        _weatherIcon.localStoreFileName = getFileNameWithURLString(obj0.day_icon, getCachesPath());
    }
    else{
        _weatherIcon.urlString = obj0.night_icon;
        _weatherIcon.localStoreFileName = getFileNameWithURLString(obj0.night_icon, getCachesPath());
    }
    _weatherIcon.defaultFileName = @"";
    [_weatherIcon updateAsyncImageView];
    
    orY = orY + 16;
    
    _scrollView.contentSize = CGSizeMake(self.frame.size.width, orY);
    
    
    _line.frame = CGRectMake(10, self.frame.size.height - FUTV_height+3, self.frame.size.width - 20, 1);
    
    _lineBACK.frame = CGRectMake(10, self.frame.size.height - FUTV_height+3.8, self.frame.size.width - 20, 1);
    
    
    _NextDayWeatherMessageView1.frame = CGRectMake(10, self.frame.size.height - FUTV_height+10,(self.frame.size.width-20)/3 , FUTV_height-20);
    _NextDayWeatherMessageView2.frame = CGRectMake(10+(self.frame.size.width-20)/3, self.frame.size.height - FUTV_height+10,(self.frame.size.width-20)/3 , FUTV_height-20);
    _NextDayWeatherMessageView3.frame = CGRectMake(10+(self.frame.size.width-20)/3*2, self.frame.size.height - FUTV_height+10,(self.frame.size.width-20)/3 , FUTV_height-20);
    
    
    if ([array count]>1) {
        _NextDayWeatherMessageView1.data = [array objectAtIndex:1];
    }
    
    if ([array count]>2) {
        _NextDayWeatherMessageView2.data = [array objectAtIndex:2];
        _rightView1.frame = CGRectMake(10+(self.frame.size.width-20)/3, self.frame.size.height - FUTV_height+10, 1, FUTV_height-20);
        _rightView1BACK.frame = CGRectMake(10+(self.frame.size.width-20)/3+0.8, self.frame.size.height - FUTV_height+10, 1, FUTV_height-20);
    }
    
    if ([array count]>3) {
        _NextDayWeatherMessageView3.data = [array objectAtIndex:3];
        _rightView2.frame = CGRectMake(10+(self.frame.size.width-20)/3*2, self.frame.size.height - FUTV_height+10, 1, FUTV_height-20);
        _rightView2BACK.frame = CGRectMake(10+(self.frame.size.width-20)/3*2+0.8, self.frame.size.height - FUTV_height+10, 1, FUTV_height-20);
    }
    
    
    
    
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
                                @"十八", @"18",
                                @"十九", @"19",
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
    
    //NSLog(@"key_strday:%@ day:%@",key_strday,day);
    
    [localeCalendar release];
    if (localeComp.day>10) {
        return [NSString stringWithFormat:@"农历%@月%@",month,day];
    }
    else{
        return [NSString stringWithFormat:@"农历%@月初%@",month,day];
    }
    
    return @"";
    
}


-(NSString *)FromeDateFormat:(NSDate *)date{
    
    NSTimeInterval timeInterval_day = 60*60*24;
    
    NSDate *nextDay_date = [NSDate dateWithTimeInterval:timeInterval_day sinceDate:date];
    
    
    
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    
    
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:nextDay_date];


    localeComp = [localeCalendar components:unitFlags fromDate:date];
    
    NSString *key_str = [NSString stringWithFormat:@"%d月%d日",localeComp.month,localeComp.day];
    [localeCalendar release];
    return key_str;
}

-(CGFloat)getTextLabHeight:(NSString *)text font:(CGFloat)font{
    
    CGFloat height = 0;
    
    CGSize labs = [text sizeWithFont:[UIFont systemFontOfSize:font] constrainedToSize:CGSizeMake(self.frame.size.width - 20, 200) lineBreakMode:NSLineBreakByTruncatingMiddle];
    
    
    height = labs.height;
    return height;
}


@end
