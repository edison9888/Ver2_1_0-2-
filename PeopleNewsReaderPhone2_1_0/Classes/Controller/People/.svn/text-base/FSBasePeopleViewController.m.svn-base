    //
//  FSBasePeopleViewController.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-13.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSBasePeopleViewController.h"
#import "FSSlideViewController.h"
#import "FSLoadingImageView.h"
//#import "FSWeatherViewController.h"
#import "FSLocalWeatherViewController.h"
#import "FSSettingViewController.h"

#import "FSBaseDB.h"
#import "FSWeatherObject.h"


@implementation FSBasePeopleViewController

- (id)init {
	self = [super init];
	if (self) {
		_left_lock = NO;
        _right_lock = NO;
	}
	return self;
}

- (void)dealloc {
    [_fsWeatherView release];
    [super dealloc];
}
-(void)showLoadingView{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    FSLoadingImageView *loadingView = [[FSLoadingImageView alloc] initWithFrame:CGRectMake(-320, 0, 320, 480)];
    loadingView.parentDelegate = self;
    [UIView beginAnimations:@"xxxxxx" context:nil];
    [UIView setAnimationDuration:0.5];
    //[UIView setAnimationTransition:<#(UIViewAnimationTransition)#> forView:<#(UIView *)#> cache:<#(BOOL)#>]
    [window addSubview:loadingView];
    loadingView.frame = CGRectMake(0, 0, 320, 480);
    [UIView commitAnimations];
    
    [loadingView release];
}
-(void)addWeatherView
{
    _fsWeatherView = [[FSWeatherView alloc] init];
    _fsWeatherView.frame = CGRectMake(0, 0, 96, 44);
    _fsWeatherView.userInteractionEnabled = NO;
    _fsWeatherView.multipleTouchEnabled = NO;
    UIButton *weatcherBt = [[UIButton alloc] init];
    weatcherBt.frame = CGRectMake(0, 0, 50, 44);
    [weatcherBt addSubview:_fsWeatherView];
    [weatcherBt addTarget:self action:@selector(weatherNewsAction:) forControlEvents:UIControlEventTouchUpInside];
    [weatcherBt addTarget:self action:@selector(weatherNewsActionLock:) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *weatcherBarItem = [[UIBarButtonItem alloc] initWithCustomView:weatcherBt];
    self.navigationItem.leftBarButtonItem = weatcherBarItem;
    [_fsWeatherView release];
    [weatcherBt release];
    [weatcherBarItem release];
}
-(void)addLeftButtonItem
{
    UIBarButtonItem * leftbutton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"peopleLogo.png"] style:UIBarButtonItemStylePlain target:self action:@selector(showLoadingView)];
	self.navigationItem.leftBarButtonItem = leftbutton;
    [leftbutton release];
}
-(void)addRightButtonItem
{
    UIButton *btnNaviOption = [[UIButton alloc] initWithFrame:CGRectZero];
	UIImage *imageBG = [UIImage imageNamed:@"naviOption.png"];
	[btnNaviOption setBackgroundImage:imageBG forState:UIControlStateNormal];
	[btnNaviOption setBackgroundImage:imageBG forState:UIControlStateHighlighted];
    btnNaviOption.highlighted = YES;
    
	[btnNaviOption addTarget:self action:@selector(settingAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [btnNaviOption addTarget:self action:@selector(settingActionLock:) forControlEvents:UIControlEventTouchDown];
    
	UIBarButtonItem *settingBarItem = [[UIBarButtonItem alloc] initWithCustomView:btnNaviOption];
	btnNaviOption.frame = CGRectMake(0.0f, 0.0f, 42.0f, 33.0f);
	self.navigationItem.rightBarButtonItem = settingBarItem;
    
	[settingBarItem release];
	[btnNaviOption release];
}
- (void)loadChildView {
	//self.title = NSLocalizedString(@"人民新闻", nil);
	UIImageView *ivLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"peopleLogo.png"]];
	self.navigationItem.titleView = ivLogo;
	[ivLogo release];
	[self addLeftButtonItem];
    [self addRightButtonItem];
   
	
	
    [self updataWeatherMessage];
}

- (void)layoutControllerViewWithRect:(CGRect)rect {
}

#pragma mark -
#pragma mark PrivateMethod
- (void)weatherNewsAction:(id)sender {
    
    if (_left_lock) {
        _right_lock = NO;
        return;
    }
    
	//[self.fsSlideViewController pushViewControllerWithKind:PushViewControllerKind_Left withAnimated:YES];
//	FSWeatherViewController *weatherCtrl = [[FSWeatherViewController alloc] init];
//	[self.fsSlideViewController slideViewController:weatherCtrl withKind:PushViewControllerKind_Left withAnimation:YES];
//	[weatherCtrl release];
    
    
    if ([self.fsSlideViewController.leftViewController isKindOfClass:[FSLocalWeatherViewController class]]) {
        [self.fsSlideViewController slideViewController:self.fsSlideViewController.leftViewController withKind:PushViewControllerKind_Left withAnimation:YES];
    }
    else{
        FSLocalWeatherViewController *weatherCtrl = [[FSLocalWeatherViewController alloc] init];
        [self.fsSlideViewController slideViewController:weatherCtrl withKind:PushViewControllerKind_Left withAnimation:YES];
        [weatherCtrl release];
    }
    
    _right_lock = NO;
}

- (void)weatherNewsActionLock:(id)sender{
    _right_lock = YES;
}

- (void)settingAction:(id)sender {
    NSLog(@"settingAction");
    if (_right_lock) {
        _left_lock = NO;
        return;
    }
	//[self.fsSlideViewController pushViewControllerWithKind:PushViewControllerKind_Right withAnimated:YES];
    
    if ([self.fsSlideViewController.rightViewController isKindOfClass:[FSSettingViewController class]]) {
        [self.fsSlideViewController slideViewController:self.fsSlideViewController.rightViewController withKind:PushViewControllerKind_Right withAnimation:YES];
    }
    else{
        FSSettingViewController *settingCtrl = [[FSSettingViewController alloc] init];
        [self.fsSlideViewController slideViewController:settingCtrl withKind:PushViewControllerKind_Right withAnimation:YES];
        [settingCtrl release];
    }
    
    _left_lock = NO;
}

-(void)settingActionLock:(id)sender{
    NSLog(@"settingActionLock");
    _left_lock = YES;
}

- (UIImage *)tabBarItemNormalImage {
	return nil;
}

- (NSString *)tabBarItemText {
	return nil;
}

- (UIImage *)tabBarItemSelectedImage {
	return nil;
}

-(void)updataWeatherMessage{
   NSArray *array = [[FSBaseDB sharedFSBaseDB] getObjectsByKeyWithName:@"FSWeatherObject" key:@"group" value:@""];
    
    for (FSWeatherObject *obj in array) {
        if ([obj.day isEqualToString:@"0"]) {
            _fsWeatherView.data = obj;
            [_fsWeatherView doSomethingAtLayoutSubviews];
        }
    }
    
}

@end
