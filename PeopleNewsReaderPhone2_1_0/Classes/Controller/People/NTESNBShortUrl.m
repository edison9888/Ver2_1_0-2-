//
//  NTESNBShortUrl.m
//  NewsBoard
//
//  Created by 范岩峰 on 11-2-25.
//  Copyright 2011 NetEase.com, Inc. All rights reserved.
//

#import "NTESNBShortUrl.h"

static NTESNBShortUrl *instance = nil;

@implementation NTESNBShortUrl

@synthesize delegate;

+ (NTESNBShortUrl *)sharedShortUrl {
	@synchronized(self) {
		if (instance == nil) {
			instance = [[NTESNBShortUrl alloc] init];
		}
	}
	
	return instance;
}

- (void)articleShortUrlWithOrignialUrl:(NSString *)urlOrId withPrefix:(NSString *)prefix {
	//NSLog(@"urlOrId : [%@] prefix :[%@]", urlOrId, prefix);
	NSDictionary *userDic = [NSDictionary dictionaryWithObject:prefix forKey:@"linktype"];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://people.com.cn/api/m/%@/%@.html",prefix, urlOrId]];
	articleRequest = [ASIFormDataRequest requestWithURL:url];
	NSLog(@"url:%@",url);
	[articleRequest setUserInfo:userDic];
	[articleRequest setDelegate:self];
	[articleRequest startAsynchronous];
}

- (void)imageShortUrlWithOriginalUrl:(NSString *)imageUrl {
	NSLog(@"imageUrl! : [%@]", imageUrl);
	NSDictionary *userDic = [NSDictionary dictionaryWithObject:@"image" forKey:@"linktype"];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://people.com.cn/api/o/%@.html", imageUrl]];
	imageRequest = [ASIFormDataRequest requestWithURL:url];
	[imageRequest setUserInfo:userDic];
	[imageRequest setDelegate:self];
	[imageRequest startAsynchronous];
}

- (void)floorImageShortUrlWithFloorString:(NSDictionary *)floorInfo {
	NSDictionary *userDic = [NSDictionary dictionaryWithObject:@"floor" forKey:@"linktype"];
	NSDictionary *dic = floorInfo;	
	NSString *floorUrl = [NSString stringWithFormat:@"http://people.com.cn/api/n/%@/%@/%@.html",	
	[dic objectForKey:@"board"], [dic objectForKey:@"postid"], [dic objectForKey:@"floorid"]];
	
	NSLog(@"floorUrl : %@", floorUrl);	
	floorRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:floorUrl]];
	[floorRequest setUserInfo:userDic];
	[floorRequest setDelegate:self];
	[floorRequest startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request {
	[delegate requestShortUrlFinished:request];	
	
	if (articleRequest) {
		//[articleRequest release];
		articleRequest = nil;
	}
	if (imageRequest) {
		//[imageRequest release];
		imageRequest = nil;
	}
	if (floorRequest) {
		//[floorRequest release];
		floorRequest = nil;
	}
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	[delegate requestShortUrlFailed:request];
	
	if (articleRequest) {
		//[articleRequest release];
		articleRequest = nil;
	}
	if (imageRequest) {
		//[imageRequest release];
		imageRequest = nil;
	}
	if (floorRequest) {
		//[floorRequest release];
		floorRequest = nil;
	}
}

- (void)cancelCurrentRequest {
	if (articleRequest) {
		[articleRequest clearDelegatesAndCancel];
		//[articleRequest release];
		articleRequest = nil;
	}
	
	if (imageRequest) {
		[imageRequest clearDelegatesAndCancel];
		//[imageRequest release];
		imageRequest = nil;
	}
	
	if (floorRequest) {
		[floorRequest clearDelegatesAndCancel];
		//[floorRequest release];
		floorRequest = nil;
	}
}

- (void)dealloc {
	[super dealloc];
}

@end
