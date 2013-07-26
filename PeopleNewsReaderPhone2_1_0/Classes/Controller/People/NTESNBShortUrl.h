//
//  NTESNBShortUrl.h
//  NewsBoard
//
//  Created by 范岩峰 on 11-2-25.
//  Copyright 2011 NetEase.com, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"

@protocol NTESNBShortUrlDelegate

- (void)requestShortUrlFinished:(ASIHTTPRequest *)request;
- (void)requestShortUrlFailed:(ASIHTTPRequest *)request;

@end


@interface NTESNBShortUrl : NSObject {
	id<NTESNBShortUrlDelegate> delegate;
	ASIHTTPRequest *articleRequest;
	ASIHTTPRequest *imageRequest;
	ASIHTTPRequest *floorRequest;
}

@property (nonatomic, assign) id<NTESNBShortUrlDelegate> delegate;

+ (NTESNBShortUrl *)sharedShortUrl;

- (void)articleShortUrlWithOrignialUrl:(NSString *)urlOrId withPrefix:(NSString *)prefix;
- (void)imageShortUrlWithOriginalUrl:(NSString *)imageUrl;
- (void)floorImageShortUrlWithFloorString:(NSDictionary *)floorInfo;
- (void)cancelCurrentRequest;

@end


