//
//  NTESNBSMSManager.h
//  NewsBoard
//	管理短信分享
//  Created by 黄旭 on 2/26/11.
//  Copyright 2011 NetEase.com, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NTESNBShortUrl.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>


/*@protocol NTESNBSMSManagerDelegate
@optional
- (void)smsPreparedSucceed;
- (void)smsPreparedFailed;
@end
*/

@interface NTESNBSMSManager : NSObject<MFMessageComposeViewControllerDelegate,NTESNBShortUrlDelegate> {
	NSString *smsBody;
	NSInteger linkCount;
	UINavigationController *pushNavigation;
	//id<NTESNBSMSManagerDelegate> smsMngDelegate;
}
+ (NTESNBSMSManager *) sharedSMSManager;
@property (nonatomic, assign) NSString *smsBody;
@property (nonatomic, assign) UINavigationController *pushNavigation;
//@property (nonatomic, assign) id<NTESNBSMSManagerDelegate> smsMngDelegate;
-(void)pushSMSComposer;
- (void)presentComposerWithOrignialUrl:(NSString *)originUrl;
@end
