//
//  PeopleNewsReaderPhoneAppDelegate.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-7-30.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "FSUINavigationController.h"
#import "FSLoadingImageView.h"
#import "WXApi.h"
#import "MobClick.h"

@class FSTabBarViewCotnroller;
@class FSSlideViewController;
@class FSChannelSettingForOneDayViewController;
@class FSNewsContainerViewController;

@interface PeopleNewsReaderPhoneAppDelegate : NSObject <UIApplicationDelegate,FSLoadingImageViewDelegate,WXApiDelegate> {
	FSUINavigationController *_navChannelSettingController;
	FSSlideViewController *_slideViewController;
    FSTabBarViewCotnroller *_rootViewController;
    UIWindow *window;
    
    
    
@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
    
    NSDictionary *pushInof;
    NSTimeInterval _TimeForeground;
    
    FSNewsContainerViewController *_fsNewsContainerViewController_forPush;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory;
- (void)saveContext;

//微信
-(void)ShareWeiXinSetting;
- (BOOL)sendWXTextMessage:(NSString *)content;
- (BOOL)sendWXMidiaMessage:(NSString *)title content:(NSString *)content thumbImage:(UIImage *)thumbImage webURL:(NSString *)webURL;
- (BOOL)sendWXMidiaMessagePYQ:(NSString *)title content:(NSString *)content thumbImage:(UIImage *)thumbImage webURL:(NSString *)webURL;
//友盟
-(NSString *)macString;

//激活统计
-(void)postStatistice;


//推送
-(void)DidRecivePushMessage:(NSDictionary *)Inof;
-(void)ShowPushMessage:(NSDictionary *)Inof;
//更新更多界面
-(void)updateMoreControllerView;
@end

