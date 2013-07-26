//
//  GlobalConfig.m
//  PeopleMicroBlogClient
//
//  Created by chen guoshuang on 10-8-18.
//  Copyright 2010 wesksoft. All rights reserved.
//

#import "GlobalConfig.h"
#import "PeopleNewsReaderPhoneAppDelegate.h"

#define CONFIG_UNIQUE_DEVICE_KEY @"UNIQUE_DEVICE_KEY_STRING"

//一天 
#define CONFIG_POST_CHANNEL_KEY @"CONFIG_POST_CHANNEL_KEY_STRING"
#define CONFIG_POST_CHANNEL_VALUE_ON @"1"
#define CONFIG_POST_CHANNEL_VALUE_OFF @"0"


//一天频道变更情况
#define CONFIG_CHANNEL_SELMARK_KEY @"CONFIG_CHANNEL_SELMARK_KEY"
#define CONFIG_CHANNEL_SELMARK_VALUE_ON @"1"
#define CONFIG_CHANNEL_SELMARK_VALUE_OFF @"0"

//2G 3G
#define CONFIG_DOWNLOAD_PICTURE_USEING_2G_3G_KEY @"CONFIG_DOWNLOAD_PICTURE_USEING_2G_3G_KEY_STRING"
#define CONFIG_DOWNLOAD_PICTURE_USEING_2G_3G_VALUE_ON @"1"
#define CONFIG_DOWNLOAD_PICTURE_USEING_2G_3G_VALUE_OFF @"0"

//正文字号
#define CONFIG_FONTSIZE_KEY @"CONFIG_FONTSIZE_KEY_STRING"
#define CONFIG_FONTSIZE_DEFAULT_VALUE 0

//要闻推送
#define CONFIG_IMPORTANT_NEWS_PUSH_KEY @"CONFIG_IMPORTANT_NEWS_PUSH_KEY_STRING"
#define CONFIG_IMPORTANT_NEWS_PUSH_DEFAULT_VALUE (YES)

//正文全屏设置
#define CONFIG_CONTENT_FULL_SCREEN_KEY @"CONFIG_CONTENT_FULL_SCREEN_KEY_STRING"
#define CONFIG_CONTENT_FULL_SCREEN_DEFAULT_VALUE (NO)

//设置离线阅读状态
#define OFFLINE_READING_KEY @"OFFLINE_READING_KEY_STRING"
#define OFFLINE_READING_VALUE (NO)

@interface GlobalConfig(PrivateMethod)

@end


@implementation GlobalConfig

static GlobalConfig *shareManager = nil;

#pragma mark -
#pragma mark 单例实现
/////////////////////////////////////////////////////////////////
//	获得唯一实例的静态方法
/////////////////////////////////////////////////////////////////
+ (GlobalConfig *)shareConfig {
	
	@synchronized(self) {
		if (shareManager == nil) {
			shareManager = [[self alloc] init];
		}
	}
	return shareManager;
}
/////////////////////////////////////////////////////////////////
//覆盖父类的方法
/////////////////////////////////////////////////////////////////
+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (shareManager == nil) {
            shareManager = [super allocWithZone:zone];
			return shareManager;  // assignment and return on first allocation
		}
	}
	
	return nil; //on subsequent allocation attempts return nil
}

/////////////////////////////////////////////////////////////////
//	不允许拷贝
/////////////////////////////////////////////////////////////////
- (id)copyWithZone:(NSZone *)zone {
	return self;
}

/////////////////////////////////////////////////////////////////
//	不允许保留
/////////////////////////////////////////////////////////////////
- (id)retain {
	return self;
}

/////////////////////////////////////////////////////////////////
//	返回最大引用计数
/////////////////////////////////////////////////////////////////
- (unsigned)retainCount {
	return UINT_MAX;  //denotes an object that cannot be released
}

/////////////////////////////////////////////////////////////////
//	全局的不允许释放
/////////////////////////////////////////////////////////////////
- (void)release {
	//do nothing
}

/////////////////////////////////////////////////////////////////
//	自动释放返回自己
/////////////////////////////////////////////////////////////////
- (id)autorelease {
	return self;
}

//**************************************************
// 取得设备的标识符号，卸载后不一致
//**************************************************
- (NSString *)getDeviceUnique_ID {
//	NSString *rst = nil;
//	NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//	rst = [userDefault objectForKey:CONFIG_UNIQUE_DEVICE_KEY];
//	if (rst == nil) {
//		CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
//		CFStringRef uuidstr = CFUUIDCreateString(kCFAllocatorDefault, uuid);
//		rst = (NSString *)uuidstr;
//		rst = [rst retain];
//		//存入，不改变
//		[userDefault setObject:rst forKey:CONFIG_UNIQUE_DEVICE_KEY];
//		NSDictionary *appDefaults = [NSDictionary dictionaryWithObjectsAndKeys:
//									 rst, CONFIG_UNIQUE_DEVICE_KEY,
//									 nil];
//		[userDefault registerDefaults:appDefaults];
//		[userDefault synchronize];
//		
//		CFRelease(uuidstr);
//		CFRelease(uuid);
//	} else {
//		rst = [rst retain];
//	}
//
//
//	return [rst autorelease];
	
	return [OpenUDID value];
}

- (NSManagedObjectContext *)getApplicationManagedObjectContext {
	PeopleNewsReaderPhoneAppDelegate *appDelegate = (PeopleNewsReaderPhoneAppDelegate *)[UIApplication sharedApplication].delegate;
	return appDelegate.managedObjectContext;
}

- (NSManagedObjectContext *)newManagedObjectContext {
	PeopleNewsReaderPhoneAppDelegate *appDelegate = (PeopleNewsReaderPhoneAppDelegate *)[UIApplication sharedApplication].delegate;
	NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
	[context setPersistentStoreCoordinator:appDelegate.persistentStoreCoordinator];
	return [context autorelease];
}

//**************************************************
//一天的频道选择
//**************************************************
- (BOOL)isPostChannel {
	BOOL rst = NO;
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	NSString *postChannelResult = [userDefaults objectForKey:CONFIG_POST_CHANNEL_KEY];
	if (postChannelResult == nil) {
		postChannelResult = CONFIG_POST_CHANNEL_VALUE_OFF;
		[userDefaults setObject:postChannelResult forKey:CONFIG_POST_CHANNEL_KEY];
		NSDictionary *appDefaults = [NSDictionary dictionaryWithObjectsAndKeys:postChannelResult, CONFIG_POST_CHANNEL_KEY, nil];
		
		[userDefaults registerDefaults:appDefaults];
		[userDefaults synchronize];
	} else {
		rst = ![postChannelResult isEqualToString:CONFIG_POST_CHANNEL_VALUE_OFF];
	}

	return rst;
}

- (void)setPostChannel:(BOOL)value {
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	NSString *postChannelResult = value ? CONFIG_POST_CHANNEL_VALUE_ON : CONFIG_POST_CHANNEL_VALUE_OFF;
	[userDefaults setObject:postChannelResult forKey:CONFIG_POST_CHANNEL_KEY];
	NSDictionary *appValues = [NSDictionary dictionaryWithObjectsAndKeys:postChannelResult, CONFIG_POST_CHANNEL_KEY, nil];
	[userDefaults registerDefaults:appValues];
	[userDefaults synchronize];
}

//**************************************************
//是否2g_3G网络读取图片
//**************************************************
- (BOOL)isSettingDownloadPictureUseing2G_3G {
	BOOL rst = NO;
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	NSString *dl2g_3gResult = [userDefaults objectForKey:CONFIG_DOWNLOAD_PICTURE_USEING_2G_3G_KEY];
	rst = dl2g_3gResult != nil;
	return rst;
}

- (BOOL)isDownloadPictureUseing2G_3G {
	BOOL rst = YES;
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	NSString *dl2g_3gResult = [userDefaults objectForKey:CONFIG_DOWNLOAD_PICTURE_USEING_2G_3G_KEY];
	if (dl2g_3gResult == nil) {
		dl2g_3gResult = CONFIG_DOWNLOAD_PICTURE_USEING_2G_3G_VALUE_ON;
		[userDefaults setObject:dl2g_3gResult forKey:CONFIG_DOWNLOAD_PICTURE_USEING_2G_3G_KEY];
		NSDictionary *appDefaults = [NSDictionary dictionaryWithObjectsAndKeys:dl2g_3gResult, CONFIG_DOWNLOAD_PICTURE_USEING_2G_3G_KEY, nil];
		
		[userDefaults registerDefaults:appDefaults];
		[userDefaults synchronize];
	} else {
		rst = ![dl2g_3gResult isEqualToString:CONFIG_DOWNLOAD_PICTURE_USEING_2G_3G_VALUE_OFF];
	}
	
	return rst;
}

- (void)setDownloadPictureUseing2G_3G:(BOOL)value {
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	NSString *dl2g_3gResult = value ? CONFIG_DOWNLOAD_PICTURE_USEING_2G_3G_VALUE_ON : CONFIG_DOWNLOAD_PICTURE_USEING_2G_3G_VALUE_OFF;
	[userDefaults setObject:dl2g_3gResult forKey:CONFIG_DOWNLOAD_PICTURE_USEING_2G_3G_KEY];
	NSDictionary *appValues = [NSDictionary dictionaryWithObjectsAndKeys:dl2g_3gResult, CONFIG_DOWNLOAD_PICTURE_USEING_2G_3G_KEY, nil];
	[userDefaults registerDefaults:appValues];
	[userDefaults synchronize];
}

//**************************************************
//正文字号
//**************************************************
- (void)setFontSize:(NSNumber *)value {
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	[userDefaults setObject:value forKey:CONFIG_FONTSIZE_KEY];
	NSDictionary *appValues = [NSDictionary dictionaryWithObjectsAndKeys:value, CONFIG_FONTSIZE_KEY, nil];
	[userDefaults registerDefaults:appValues];
	[userDefaults synchronize];
}

- (NSNumber *)readFontSize {
	NSNumber *rst = nil;
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	rst = [userDefaults objectForKey:CONFIG_FONTSIZE_KEY];
	if (rst == nil) {
		rst = [[[NSNumber alloc] initWithInt:CONFIG_FONTSIZE_DEFAULT_VALUE] autorelease];
		[userDefaults setObject:rst forKey:CONFIG_FONTSIZE_KEY];
		NSDictionary *appDefaults = [NSDictionary dictionaryWithObjectsAndKeys:rst, CONFIG_FONTSIZE_KEY, nil];
		
		[userDefaults registerDefaults:appDefaults];
		[userDefaults synchronize];
	}
	
	return rst;
}

//**************************************************
//要闻推送设置
//**************************************************
- (void)setImportantNewsPush:(BOOL)value {
	NSNumber *boolValue = [[NSNumber alloc] initWithBool:value];
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	[userDefaults setObject:boolValue forKey:CONFIG_IMPORTANT_NEWS_PUSH_KEY];
	NSDictionary *appValues = [NSDictionary dictionaryWithObjectsAndKeys:boolValue, CONFIG_IMPORTANT_NEWS_PUSH_KEY, nil];
	[userDefaults registerDefaults:appValues];
	[userDefaults synchronize];
	
	[boolValue release];
}

- (BOOL)readImportantNewsPush {
	BOOL rst = YES;
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	NSNumber *boolValue = [userDefaults objectForKey:CONFIG_IMPORTANT_NEWS_PUSH_KEY];
	if (boolValue == nil) {
		boolValue = [[[NSNumber alloc] initWithBool:CONFIG_IMPORTANT_NEWS_PUSH_DEFAULT_VALUE] autorelease];
		[userDefaults setObject:boolValue forKey:CONFIG_IMPORTANT_NEWS_PUSH_KEY];
		NSDictionary *appDefaults = [NSDictionary dictionaryWithObjectsAndKeys:boolValue, CONFIG_IMPORTANT_NEWS_PUSH_KEY, nil];
		
		[userDefaults registerDefaults:appDefaults];
		[userDefaults synchronize];
	}
	
	rst = [boolValue boolValue];
	
	return rst;
}

//**************************************************
//正文全屏设置
//**************************************************
- (void)setContentFullScreen:(BOOL)value {
	NSNumber *boolValue = [[NSNumber alloc] initWithBool:value];
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	[userDefaults setObject:boolValue forKey:CONFIG_CONTENT_FULL_SCREEN_KEY];
	NSDictionary *appValues = [NSDictionary dictionaryWithObjectsAndKeys:boolValue, CONFIG_CONTENT_FULL_SCREEN_KEY, nil];
	[userDefaults registerDefaults:appValues];
	[userDefaults synchronize];
	
	[boolValue release];
}

- (BOOL)readContentFullScreen {
	BOOL rst = YES;
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	NSNumber *boolValue = [userDefaults objectForKey:CONFIG_CONTENT_FULL_SCREEN_KEY];
	if (boolValue == nil) {
		boolValue = [[[NSNumber alloc] initWithBool:CONFIG_CONTENT_FULL_SCREEN_DEFAULT_VALUE] autorelease];
		[userDefaults setObject:boolValue forKey:CONFIG_CONTENT_FULL_SCREEN_KEY];
		NSDictionary *appDefaults = [NSDictionary dictionaryWithObjectsAndKeys:boolValue, CONFIG_CONTENT_FULL_SCREEN_KEY, nil];
		
		[userDefaults registerDefaults:appDefaults];
		[userDefaults synchronize];
	}
	
	rst = [boolValue boolValue];
	
	return rst;
}


//设置离线阅读状态
-(void)setOFFlineReading:(BOOL)value{
    NSNumber *boolValue = [[NSNumber alloc] initWithBool:value];
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	[userDefaults setObject:boolValue forKey:OFFLINE_READING_KEY];
	NSDictionary *appValues = [NSDictionary dictionaryWithObjectsAndKeys:boolValue, OFFLINE_READING_KEY, nil];
	[userDefaults registerDefaults:appValues];
	[userDefaults synchronize];
	
	[boolValue release];
}

-(BOOL)readOFFlineSeting{
    
    BOOL rst = YES;
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	NSNumber *boolValue = [userDefaults objectForKey:OFFLINE_READING_KEY];
	if (boolValue == nil) {
		boolValue = [[[NSNumber alloc] initWithBool:OFFLINE_READING_VALUE] autorelease];
		[userDefaults setObject:boolValue forKey:OFFLINE_READING_KEY];
		NSDictionary *appDefaults = [NSDictionary dictionaryWithObjectsAndKeys:boolValue, OFFLINE_READING_KEY, nil];
		
		[userDefaults registerDefaults:appDefaults];
		[userDefaults synchronize];
	}
	
	rst = [boolValue boolValue];
	
	return rst;
}


//我的头条变更情况
-(void)setOnedayChannalMark:(BOOL)value{
    NSNumber *boolValue = [[NSNumber alloc] initWithBool:value];
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	[userDefaults setObject:boolValue forKey:CONFIG_CHANNEL_SELMARK_KEY];
	NSDictionary *appValues = [NSDictionary dictionaryWithObjectsAndKeys:boolValue, CONFIG_CHANNEL_SELMARK_KEY, nil];
	[userDefaults registerDefaults:appValues];
	[userDefaults synchronize];
	
	[boolValue release];
    
}
-(BOOL)getOnedayChannalMark{
    
    BOOL rst = NO;
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	NSNumber *boolValue = [userDefaults objectForKey:CONFIG_CHANNEL_SELMARK_KEY];
	if (boolValue == nil) {
		boolValue = [[[NSNumber alloc] initWithBool:CONFIG_CHANNEL_SELMARK_VALUE_OFF] autorelease];
		[userDefaults setObject:boolValue forKey:CONFIG_CHANNEL_SELMARK_KEY];
		NSDictionary *appDefaults = [NSDictionary dictionaryWithObjectsAndKeys:boolValue, CONFIG_CHANNEL_SELMARK_KEY, nil];
		
		[userDefaults registerDefaults:appDefaults];
		[userDefaults synchronize];
	}
	
	rst = [boolValue boolValue];
	
	return rst;
}




//**************************************************
// 清除缓存目录中的所有文件
//**************************************************

//计算大小
// double computeFileBytesInPath(NSString *filePath) {
// double result = 0.0f;
// NSFileManager *fileManager = [NSFileManager defaultManager];
// if ([fileManager fileExistsAtPath:filePath]) {
// NSDirectoryEnumerator *directoryEnumerator = [fileManager enumeratorAtPath:filePath];
// NSString *fileName = nil;
// FSLogS(@"filePath:%@", filePath)
// while (fileName = [directoryEnumerator nextObject]) {
// NSString *fullFileName = [filePath stringByAppendingPathComponent:fileName];
// NSDictionary *fileAttr = [directoryEnumerator fileAttributes];
// NSString *fileType = [fileAttr objectForKey:NSFileType];
// if ([fileType isEqualToString:NSFileTypeDirectory]) {
// result += computeFileBytesInPath(fullFileName);
// } else {
// NSNumber *number = [fileAttr objectForKey:NSFileSize];
// FSLogS(@"%@:fileSize:%@", fileName, number)
// result += [number unsignedLongLongValue];
// }
// }
// }
// return result;
// }



- (BOOL)clearBufferWithPath:(NSString *)path {
	BOOL rst = YES;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSDirectoryEnumerator *directoryEnumerator = [fileManager enumeratorAtPath:path];
        NSString *fileName = nil;
        //FSLog(@"filePath:%@", path);
        while (fileName = [directoryEnumerator nextObject]) {
            //FSLog(@"fileName:%@", fileName);
            if ([fileName hasSuffix:@".sqlite"]) {
                continue;
            }
            NSError *error = nil;
            NSString *fullFileName = [path stringByAppendingPathComponent:fileName];
            NSLog(@"fullFileName:%@",fullFileName);
            if (![fileManager removeItemAtPath:fullFileName error:&error]) {
                rst = NO;
#ifdef MYDEBUG
                NSLog(@"removeItemAtPath:%@[error:%@]", [path stringByAppendingPathComponent:fileName], [error localizedDescription]);
#endif
            }
           
//            
//            NSDictionary *fileAttr = [directoryEnumerator fileAttributes];
//            NSString *fileType = [fileAttr objectForKey:NSFileType];
//            if ([fileType isEqualToString:NSFileTypeDirectory]) {
//                rst= [self clearBufferWithPath:fullFileName];
//            } else {
//                
//                //FSLog(@"fullFileName:%@", fullFileName);
//                if (![fileManager removeItemAtPath:fullFileName error:&error]) {
//                    rst = NO;
//#ifdef MYDEBUG
//                    NSLog(@"removeItemAtPath:%@[error:%@]", [path stringByAppendingPathComponent:fileName], [error localizedDescription]);
//#endif
//                }
//            }
        }
    }

	return rst;
}


@end
