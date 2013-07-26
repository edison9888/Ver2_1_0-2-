//
//  FSALLSettingViewController.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-31.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSALLSettingViewController.h"

#import "FSNewsTextFontSettingController.h"
//#import "FSLanguageSettingViewController.h"
#import "FSChannelSettingForOneDayViewController.h"
#import "FSAuthorizationViewController.h"

#define FSSETTING_VIEW_NAVBAR_HEIGHT 44.0f


@implementation FSALLSettingViewController

- (id)init {
	self = [super init];
	if (self) {
		
	}
	return self;
}

- (void)dealloc {
    [super dealloc];
}



-(NSString *)setTitle{
    _fsALLSettingContainerView.flag = 0;
    return @"设置";
}

-(void)returnBack:(id)sender{
    FSLog(@"returnBack");
    
    if (self.isnavTopBar){
        [self dismissModalViewControllerAnimated:YES];
        return;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



#pragma mark - 
#pragma FSTableContainerViewDelegate mark

-(NSInteger)tableViewSectionNumber:(FSTableContainerView *)sender{
    return 2;
}

-(NSInteger)tableViewNumberInSection:(FSTableContainerView *)sender section:(NSInteger)section{
    if (section == 0) {
        //return 4;
        return 3;
    }
    
    if (section == 1) {
        return 2;
    }
    return 0;
}

-(NSString *)tableViewSectionTitle:(FSTableContainerView *)sender section:(NSInteger)section{
        return @"";
}



-(NSObject *)tableViewCellData:(FSTableContainerView *)sender withIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath section] == 1) {
        //sender.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CellBackground"]];
        switch ([indexPath row]) {
            case 4:
                return @"要闻推送";
                break;
            case 0:
                return @"正文全屏功能";
                break;
            case 1:
                return @"只WiFi网络加载图片";
                break;
            case 3:
                return @"账号管理";
            default:
                break;
        }
    }
    
    return @"all_setting";
}



-(void)tableViewDataSourceDidSelected:(FSTableContainerView *)sender withIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    if (section == 0) {
        NSLog(@"FSNewsTextFontSettingControllerFSNewsTextFontSettingController:%d",row);
        if (row == 0) {
            //字体设置
            if (self.isnavTopBar) {
                FSNewsTextFontSettingController *fsNewsTextFontSettingController = [[FSNewsTextFontSettingController alloc] init];
                fsNewsTextFontSettingController.isnavTopBar = YES;
                [self presentModalViewController:fsNewsTextFontSettingController animated:YES];
                [fsNewsTextFontSettingController release];
            }
            else{
                FSNewsTextFontSettingController *fsSettingViewController = [[FSNewsTextFontSettingController alloc] init];
                //[self.navigationController presentModalViewController:fsSettingViewController animated:YES];
                [self.navigationController pushViewController:fsSettingViewController animated:YES];
                [fsSettingViewController release];
            }
            
        }
//        if (row == 1){
//            
//            //语言设置
//            FSLanguageSettingViewController *fsLanguageSettingViewController = [[FSLanguageSettingViewController alloc] init];
//            //[self.navigationController presentModalViewController:fsSettingViewController animated:YES];
//            [self.navigationController pushViewController:fsLanguageSettingViewController animated:YES];
//            [fsLanguageSettingViewController release];
//            
//        }
        
        if (row == 1){
           
            //偏好设置
            if (self.isnavTopBar) {
                FSChannelSettingForOneDayViewController *fsChannelSettingForOneDayViewController = [[FSChannelSettingForOneDayViewController alloc] init];
                fsChannelSettingForOneDayViewController.isReSetting = YES;
                [self presentModalViewController:fsChannelSettingForOneDayViewController animated:YES];
                [fsChannelSettingForOneDayViewController release];
            }
            else{
                FSChannelSettingForOneDayViewController *fsChannelSettingForOneDayViewController = [[FSChannelSettingForOneDayViewController alloc] init];
                fsChannelSettingForOneDayViewController.isReSetting = YES;
                [self.navigationController presentModalViewController:fsChannelSettingForOneDayViewController animated:YES];
                //[self.navigationController pushViewController:fsChannelSettingForOneDayViewController animated:YES];
                [fsChannelSettingForOneDayViewController release];
            }
            
        } 
        if (row == 2){
             //账号绑定
            if (self.isnavTopBar) {
                FSAuthorizationViewController *fsAuthorizationViewController = [[FSAuthorizationViewController alloc] init];
                fsAuthorizationViewController.isnavTopBar = YES;
                [self presentModalViewController:fsAuthorizationViewController animated:YES];
                [fsAuthorizationViewController release];
            }
            else{
                FSAuthorizationViewController *fsAuthorizationViewController = [[FSAuthorizationViewController alloc] init];
                //[self.navigationController presentModalViewController:fsAuthorizationViewController animated:YES];
                [self.navigationController pushViewController:fsAuthorizationViewController animated:YES];
                [fsAuthorizationViewController release];
            }
           
            
            
        }
    }
}


-(void)tableViewTouchPicture:(FSTableContainerView *)sender withImageURLString:(NSString *)imageURLString withImageLocalPath:(NSString *)imageLocalPath imageID:(NSString *)imageID{
    NSLog(@"channel did selected!!");
}


-(void)tableViewTouchEvent:(FSTableContainerView *)sender cell:(FSTableViewCell *)cellSender{
    NSLog(@"tableViewTouchEvent");
    
}

@end
