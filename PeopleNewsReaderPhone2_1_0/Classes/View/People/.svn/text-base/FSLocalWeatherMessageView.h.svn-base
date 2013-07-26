//
//  FSLocalWeatherMessageView.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-3-18.
//
//

#import <UIKit/UIKit.h>
#import "FSBaseContainerView.h"
#import "FSAsyncImageView.h"

@class FSLocalNextDayWeatherMessageView;

@interface FSLocalWeatherMessageView : FSBaseContainerView<UIScrollViewDelegate>{
@protected
    
    UIScrollView *_scrollView;
    
    UILabel *_lab_date;
    UILabel *_lab_updataDate;
    UILabel *_lab_tp;
    UILabel *_lab_meteorology;
    UILabel *_lab_wind;
    
    
    UILabel *_lab_zhishu1;
    UILabel *_lab_zhishu11;
    
    UILabel *_lab_zhishu2;
    UILabel *_lab_zhishu22;
    
    UILabel *_lab_zhishu3;
    UILabel *_lab_zhishu33;
    
    FSAsyncImageView *_weatherIcon;
    UIView *_line;
    UIView *_lineBACK;
    
    FSLocalNextDayWeatherMessageView *_NextDayWeatherMessageView1;
    FSLocalNextDayWeatherMessageView *_NextDayWeatherMessageView2;
    FSLocalNextDayWeatherMessageView *_NextDayWeatherMessageView3;
    
    
    UIView *_rightView1;
    UIView *_rightView2;
    
    UIView *_rightView1BACK;
    UIView *_rightView2BACK;
    
    NSString *_group;
}

@property(nonatomic,retain) NSString *group;

-(NSString *)getCHineseDate:(NSDate *)date;
-(CGFloat)getTextLabHeight:(NSString *)text font:(CGFloat)font;

-(NSString *)FromeDateFormat:(NSDate *)date;

@end
