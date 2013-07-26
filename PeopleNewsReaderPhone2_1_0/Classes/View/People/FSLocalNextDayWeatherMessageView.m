//
//  FSLocalNextDayWeatherMessageView.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-3-18.
//
//

#import "FSLocalNextDayWeatherMessageView.h"
#import "FSWeatherObject.h"
#import "FSCommonFunction.h"

@implementation FSLocalNextDayWeatherMessageView

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
    [_lab_tp release];
    [_weatherIcon release];
}

-(void)doSomethingAtInit{
    
    
    _lab_date = [[UILabel alloc] init];
    _lab_tp = [[UILabel alloc] init];
    
    _lab_date.textColor = COLOR_NEWSLIST_DESCRIPTION;
    _lab_tp.textColor = COLOR_NEWSLIST_TITLE;
    
    
    _lab_date.textAlignment = UITextAlignmentCenter;
    _lab_tp.textAlignment = UITextAlignmentCenter;
    
    _lab_date.font = [UIFont systemFontOfSize:16];
    _lab_tp.font = [UIFont systemFontOfSize:12];
 
    
    
    _lab_date.backgroundColor = COLOR_CLEAR;
    _lab_tp.backgroundColor = COLOR_CLEAR;
 
    
    _weatherIcon = [[FSAsyncImageView alloc] init];
    _weatherIcon.imageCuttingKind = ImageCuttingKind_fixrect;
    _weatherIcon.borderColor = COLOR_CLEAR;
    _weatherIcon.backgroundColor = COLOR_CLEAR;
    
    
    [self addSubview:_lab_date];
    [self addSubview:_lab_tp];
    [self addSubview:_weatherIcon];
    
}




-(void)doSomethingAtLayoutSubviews{
    
    
    if (self.data==nil) {
        return;
    }
    
    FSWeatherObject *obj = (FSWeatherObject *)self.data;
    
    //NSLog(@"obj:%@",obj);
    
    if ([obj.day isEqualToString:@"1"]) {
        _lab_date.text = @"明天";
    }
    
    if ([obj.day isEqualToString:@"2"]) {
        _lab_date.text = @"后天";
    }
    
    if ([obj.day isEqualToString:@"3"]) {
        _lab_date.text = @"大后天";
    }
    
    _lab_tp.text = [NSString stringWithFormat:@"%@ ~ %@",obj.night_tp,obj.day_tp];
    
    CGFloat orY = 6.0f;
    
    
    _lab_date.frame = CGRectMake(10.0f, orY, self.frame.size.width-20, 20);
    orY = orY + 20 + 2;
    _weatherIcon.frame = CGRectMake(10.0f, orY, self.frame.size.width-20, self.frame.size.width-20);
    _lab_tp.frame = CGRectMake(0.0f, self.frame.size.height-26, self.frame.size.width, 20);
   
    
    NSString *time = dateToString_HM([NSDate dateWithTimeIntervalSinceNow:0.0f]);
    
    time = [time substringToIndex:2];
    //NSLog(@"time:%@",time);
    NSInteger h = [time integerValue];
    
    if (h>6 && h<18) {
        _weatherIcon.urlString = obj.day_icon;
        //NSLog(@"obj.day_icon:%@",obj.day_icon);
        _weatherIcon.localStoreFileName = getFileNameWithURLString(obj.day_icon, getCachesPath());
    }
    else{
        _weatherIcon.urlString = obj.night_icon;
        _weatherIcon.localStoreFileName = getFileNameWithURLString(obj.night_icon, getCachesPath());
    }
    _weatherIcon.defaultFileName = @"";
    [_weatherIcon updateAsyncImageView];
}

@end
