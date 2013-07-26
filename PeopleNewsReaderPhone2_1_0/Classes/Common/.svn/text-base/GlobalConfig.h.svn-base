//
//  GlobalConfig.h
//  PeopleMicroBlogClient
//
//  Created by chen guoshuang on 10-8-18.
//  Copyright 2010 wesksoft. All rights reserved.
//
//////////////////////////////////////////////////////////////////
//	版本			时间				说明
//////////////////////////////////////////////////////////////////
//	1.0			2010-08-18		初版做成
//****************************************************************
//	1.2			2011-06-28		整理全局单例配置类，去除不必要的东西
//////////////////////////////////////////////////////////////////
//	1.3			2012-03-12		整理全局单例配置类，去除不必要的东西
//////////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "OpenUDID.h"

@interface GlobalConfig : NSObject {	
@private
	
}

+ (GlobalConfig *)shareConfig;

- (NSString *)getDeviceUnique_ID;
- (NSManagedObjectContext *)getApplicationManagedObjectContext;
- (NSManagedObjectContext *)newManagedObjectContext;

//一天的频道是否选择过
- (BOOL)isPostChannel;
- (void)setPostChannel:(BOOL)value;

//是否2g_3G网络读取图片
- (BOOL)isSettingDownloadPictureUseing2G_3G;
- (BOOL)isDownloadPictureUseing2G_3G;
- (void)setDownloadPictureUseing2G_3G:(BOOL)value;
//正文字号 
- (void)setFontSize:(NSNumber *)value;
- (NSNumber *)readFontSize;

//要闻推送
- (void)setImportantNewsPush:(BOOL)value;
- (BOOL)readImportantNewsPush;

//正文全屏设置
- (void)setContentFullScreen:(BOOL)value;
- (BOOL)readContentFullScreen;

//设置离线阅读状态
-(void)setOFFlineReading:(BOOL)value;
-(BOOL)readOFFlineSeting;

//清除目录中的所有文件
- (BOOL)clearBufferWithPath:(NSString *)path;

//我的头条变更情况
-(void)setOnedayChannalMark:(BOOL)value;
-(BOOL)getOnedayChannalMark;

@end




