//
//  FSNewSettingView.h
//  PeopleNewsReaderPhone
//
//  Created by Qin,Zhuoran on 12-11-28.
//
//

#import <UIKit/UIKit.h>
#import "FSWeatherView.h"
#define BUTTON_LENGTH 150
#define BUTTON_WIDTH 50
#define BUTTON_SPACE 10


@protocol FSNewSettingViewDelegate <NSObject>

@required
- (void)tappedInSettingView:(UIView *)settingView downloadButton:(UIButton *)button;//正文字号
- (void)tappedInSettingView:(UIView *)settingView nightModeButton:(UIButton *)button;//订阅中心
- (void)tappedInSettingView:(UIView *)settingView myCollectionButton:(UIButton *)button;//我的收藏
- (void)tappedInSettingView:(UIView *)settingView clearMemoryButton:(UIButton *)button;//清理内存
- (void)tappedInSettingView:(UIView *)settingView updateButton:(UIButton *)button;//检查更新

@end



@interface FSNewSettingView : UIView <UIScrollViewDelegate,FSNewSettingViewDelegate>{
@protected
    UIButton *btnDownLoad;
    UIButton *btnNigthMode;
    UIButton *btnMyCollection;
    UIButton *btnClearMemory;
    UIButton *btnUpdate;
    UIScrollView *scrollView;
}


@property (nonatomic, assign, readwrite) id <FSNewSettingViewDelegate> delegate;
@property(nonatomic,retain)FSWeatherView * fsWeatherView;

@end
