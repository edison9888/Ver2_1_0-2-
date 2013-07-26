//
//  NetEaseEngine.h
//  PeopleDailyReaderPhone
//
//  Created by people.com.cn on 12-5-30.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"

@interface NetEaseEngine : NSObject {
@private
	NSString *_appKey;
	NSString *_appSecrect;
	NSString *_accessTokenKey;
	NSString *_accessTokenSecrect;
	NSString *_userId;
	NSString *_statusId;
	
	NSMutableData *_bufferData;
	NSURLConnection *_connection;
	
	id _parentDelegate;
}

@property (nonatomic, retain) NSString *appKey;
@property (nonatomic, retain) NSString *appSecrect;
@property (nonatomic, retain) NSString *accessTokenKey;
@property (nonatomic, retain) NSString *accessTokenSecrect;
@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *statusId;
@property (nonatomic, assign) id parentDelegate;

@property (nonatomic, retain) NSURLConnection *connection;

- (void)logInUsingUserID:(NSString *)theUserID password:(NSString *)thePassword;

- (void)sendNetEaseContent:(NSString *)content;
- (void)NetEaseUpdataImage:(NSData *)image;

- (BOOL)isLogIn;

- (void)logOut;

- (void) buildDataOnPost:(NSMutableData *)dataBody MultiPart:(NSMutableDictionary *)multiPart image:(NSData *)image;

- (NSMutableURLRequest *)requestPostWithFile:(NSData *)image url:(NSString *)aUrl queryString:(NSString *)allParameters;
- (NSDictionary *)parseURLQueryString:(NSString *)queryString;

@end

@protocol NetEaseEngineDelegate
@optional
- (void)netEaseEngineBeginSending:(NetEaseEngine *)sender;
- (void)netEaseEngineEndSending:(NetEaseEngine *)sender withSuccess:(BOOL)success;
@end

