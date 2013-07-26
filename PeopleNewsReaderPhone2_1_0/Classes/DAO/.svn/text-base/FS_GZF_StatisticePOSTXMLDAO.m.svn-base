//
//  FS_GZF_StatisticePOSTXMLDAO.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-3-4.
//
//



/*
 app统计接口
 url: http://wap.people.com.cn/interface/app_active_stat.php
 请求方式：post
 参数：
 deviceid(必选):设备id
 appid(必选):应用程序代表的id（不能重复，区分不同平台设备的）
 appversion(必选)：应用版本
 devicetype:设备类型 IOS  ANDROID WP
 appname:应用名称
 osversion：平台版本
 appid对应关系
 人民日报Ipad-1
 人民日报iphone-2
 人民日报Android Phone-3
 人民日报Android Pad-4
 人民日报Windows Phone-5
 人民新闻iphone-6
 人民新闻ipad-7
 人民新闻Android Phone-8
 人民新闻Android Pad-9
 人民新闻Windows Phone-10
 成功返回:ok
 
 */



#import "FS_GZF_StatisticePOSTXMLDAO.h"
#import "GlobalConfig.h"

#define STATISTICE_POST_URL @"http://wap.people.com.cn/interface/app_active_stat.php"



@implementation FS_GZF_StatisticePOSTXMLDAO


- (NSString *)HTTPPostURLString {
	return STATISTICE_POST_URL;
}

- (void)HTTPBuildPostItems:(NSMutableArray *)postItems withPostKind:(HTTPPOSTDataKind)postKind {
	//内容 @"userName=%@&password=%@", _userName,  _userPassword
    
    NSString *dyid = [[GlobalConfig shareConfig] getDeviceUnique_ID];
    FSHTTPPOSTItem *deviceid = [[FSHTTPPOSTItem alloc] initWithName:@"deviceid" withValue:dyid];
    [postItems addObject:deviceid];
    [deviceid release];
    
    
    FSHTTPPOSTItem *appid = [[FSHTTPPOSTItem alloc] initWithName:@"appid" withValue:@"6"];
    [postItems addObject:appid];
    [appid release];
    
    FSHTTPPOSTItem *appversion = [[FSHTTPPOSTItem alloc] initWithName:@"appversion" withValue:@"2.0"];
    [postItems addObject:appversion];
    [appversion release];
    
    FSHTTPPOSTItem *devicetype = [[FSHTTPPOSTItem alloc] initWithName:@"devicetype" withValue:@"IOS"];
    [postItems addObject:devicetype];
    [devicetype release];
    
    
    FSHTTPPOSTItem *appname = [[FSHTTPPOSTItem alloc] initWithName:@"appname" withValue:@"人民新闻"];
    [postItems addObject:appname];
    [appname release];
    
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    
    FSHTTPPOSTItem *osversion = [[FSHTTPPOSTItem alloc] initWithName:@"osversion" withValue:systemVersion];
    [postItems addObject:osversion];
    [osversion release];
    
    
}



@end
