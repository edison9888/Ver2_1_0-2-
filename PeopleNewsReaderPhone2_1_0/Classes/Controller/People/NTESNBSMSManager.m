//
//  NTESNBSMSManager.m
//  NewsBoard
//
//  Created by 黄旭 on 2/26/11.
//  Copyright 2011 NetEase.com, Inc. All rights reserved.
//

#import "NTESNBSMSManager.h"
#import "NTESNBActivityView.h"
#import "NTESNBToast.h"
#import "JSON.h"
#import <MessageUI/MessageUI.h>

static NTESNBSMSManager *smsManager = nil;

@implementation NTESNBSMSManager
@synthesize smsBody;
//@synthesize smsMngDelegate;
@synthesize pushNavigation;
+ (NTESNBSMSManager *) sharedSMSManager
{
	@synchronized(self)
    {
		if (smsManager == nil)
		{
			smsManager = [[NTESNBSMSManager alloc] init];
		}
	}
	return smsManager;
}

- (void)setSmsBody:(NSString *)string{
	smsBody = [string retain];
} 

- (void)presentComposerWithOrignialUrl:(NSString *)originUrl{
	[NTESNBShortUrl sharedShortUrl].delegate = self;
	linkCount = 0;
	
	
	//todo没有加取消的功能!!!!!
	//[NTESNBActivityView sharedActivityView].activeDelegate = self;
	//[[NTESNBActivityView sharedActivityView] startSpinWithInfo:@"正在获取链接" withButtonTitle:@"取消"];
    [[NTESNBToast sharedToast] showUpWithInfo:@"正在获取链接！"];


	[[NTESNBShortUrl sharedShortUrl] articleShortUrlWithOrignialUrl:originUrl withPrefix:@"www"];
	if (![originUrl hasPrefix:@"http://"]) {
		//有http代表是图集或是跟贴,没有3g地址,只有文章有3g地址
		[[NTESNBShortUrl sharedShortUrl] articleShortUrlWithOrignialUrl:originUrl withPrefix:@"wap"];

	}else {
		linkCount++;
	}

}

- (void)pushSMSComposer{
	//[[NTESNBActivityView sharedActivityView] fadeOut:nil];
	
	Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
	if (messageClass != nil) {
        [[NTESNBActivityView sharedActivityView] startSpinWithInfo:@"启动短信..." withButtonTitle:nil];
		if ([messageClass canSendText]) {	
			//UITabBarController *tabBar = [(NTESNBAppDelegate *)([UIApplication sharedApplication].delegate) getAppTabBar];
			
            
			MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
			picker.body = smsBody;
			picker.messageComposeDelegate = self;			
			[pushNavigation presentModalViewController:picker animated:YES];
			picker.navigationBar.topItem.title = @"短信分享";
			[picker release];
			return;
		}
	}
	
	UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
	pasteboard.string = smsBody;
	[[NTESNBToast sharedToast] showUpWithInfo:@"已粘贴到剪贴板！"];
	
}

- (void) dealloc
{
	[smsBody release];
	[super dealloc];
}
#pragma mark -
#pragma mark NTESNBShortUrlDelegate Method
- (void)requestShortUrlFinished:(ASIHTTPRequest *)request{
    
	request.responseEncoding = NSUTF8StringEncoding;
	NSString *responseString = [request responseString];
	NSString *shortUrl = nil;
	@try {
		NSDictionary *dic = [responseString JSONValue];
		
		if (dic) {
			shortUrl = [dic objectForKey:@"shortURL"];
		}else {
            [[NTESNBToast sharedToast] showUpWithInfo:@"链接有错误！"];
			//[[NTESNBActivityView sharedActivityView] stopSpinWithInfo:@"链接有错误" withButtonTitle:@"确定"];
			return;
		}
	}
	@catch (NSException * e) {
         [[NTESNBToast sharedToast] showUpWithInfo:@"链接有错误！"];
		//[[NTESNBActivityView sharedActivityView] stopSpinWithInfo:@"链接有错误" withButtonTitle:@"确定"];
		return;
	}



	if ([[request.userInfo objectForKey:@"linktype"] isEqualToString:@"www"]) {
		self.smsBody = [smsBody stringByAppendingFormat:@"，电脑访问 %@",shortUrl];
	}else {
		self.smsBody = [smsBody stringByAppendingFormat:@"，手机访问 %@",shortUrl];
	}

	
	
	linkCount++;
	if (linkCount == 2) {
		//[smsMngDelegate smsPreparedSucceed];
		[self pushSMSComposer];
	}
	
}
- (void)requestShortUrlFailed:(ASIHTTPRequest *)request{
     [[NTESNBToast sharedToast] showUpWithInfo:@"分享遇到问题，请检查网络！"];
	//[[NTESNBActivityView sharedActivityView] stopSpinWithInfo:@"分享遇到问题，请检查网络" withButtonTitle:@"确定"];
}
#pragma mark -
#pragma mark MFMessageComposeViewControllerDelegate Method
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller 
				 didFinishWithResult:(MessageComposeResult)result {
	
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MessageComposeResultCancelled:
			//[[NTESNBToast sharedToast] showUpWithInfo:@"发送取消！"];
			break;
		case MessageComposeResultSent:
			[[NTESNBToast sharedToast] showUpWithInfo:@"发送成功！"];
			break;
		case MessageComposeResultFailed:
			[[NTESNBToast sharedToast] showUpWithInfo:@"发送失败！"];
			break;
		default:
			break;
	}
	[pushNavigation dismissModalViewControllerAnimated:YES];
}
#pragma mark -
#pragma mark ActiveViewDelegate delegate
- (void)buttonSelected:(NSString *)btnTitle{
	NSLog(@"%@",btnTitle);
	if ([btnTitle isEqualToString:@"取消"]) {
		[[NTESNBShortUrl sharedShortUrl] cancelCurrentRequest];	
	}
}
@end
