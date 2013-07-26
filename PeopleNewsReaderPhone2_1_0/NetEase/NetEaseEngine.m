//
//  NetEaseEngine.m
//  PeopleDailyReaderPhone
//
//  Created by people.com.cn on 12-5-30.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "NetEaseEngine.h"


#import <stdlib.h>
#import <CommonCrypto/CommonHMAC.h>
#import "SFHFKeychainUtils.h"
#import "FSInformationMessageView.h"
#import "SBJSON.h"



#define NETEASE_WBURLSchemePrefix              @"NETEASE_WB_"
#define NETEASE_WBKeychainServiceNameSuffix    @"_NETEASEWeiBoServiceName"
#define NETEASE_WBKeychainUserID               @"NETEASEWeiBoUserID"
#define NETEASE_WBKeychainAccessToken          @"NETEASEWeiBoAccessToken"
#define NETEASE_WBKeychainAccessTokenSecrect	@"NETEASEWeiBoAccessTokenSecrect"
#define NETEASE_WBKeychainExpireTime           @"NETEASEWeiBoExpireTime"


//////////////
#define NETEASE_ACCESS_TOKEN_URL @"http://api.t.163.com/oauth/access_token"

#define NETEASE_PUBLISH_WEIBO_URL @"http://api.t.163.com/statuses/update.json"
#define NETEASE_UPLOADIMAGE_WEIBO_URL @"http://api.t.163.com/statuses/upload.json"

#define KEY_NETEASE @"V0skcKbagsimroli"
#define SECRETKEY_NETEASE @"lco2cORI8YVujqtoUfsC9cnkPQJuZdOh"


#define OAuthVersion @"1.0"
#define OAuthParameterPrefix @"oauth_"
#define OAuthConsumerKeyKey @"oauth_consumer_key"
#define OAuthCallbackKey @"oauth_callback"
#define OAuthVersionKey @"oauth_version"
#define OAuthSignatureMethodKey @"oauth_signature_method"
#define OAuthSignatureKey @"oauth_signature"
#define OAuthTimestampKey @"oauth_timestamp"
#define OAuthNonceKey @"oauth_nonce"
#define OAuthTokenKey @"oauth_token"
#define oAauthVerifier @"oauth_verifier"
#define OAuthTokenSecretKey @"oauth_token_secret"
#define HMACSHA1SignatureType @"HMAC-SHA1"

#define XAUTH_USERNAME @"x_auth_username"
#define XAUTH_PASSWORD @"x_auth_password"
#define XAUTH_PASSWORDTYPE @"x_auth_passtype"
#define XAUTH_PASSWORDTYPE_VALUE @"1"
#define XAUTH_MODE @"x_auth_mode"
#define XAUTH_MODE_VALUE @"client_auth"

#define NETEASE_CONTENT_STATUS @"status"

#define BOUNDARY_STR @"qtfsgss7da2ced220a6a"

#define FILE_FORM_ITEM @"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\nContent-Type:%@\r\n\r\n"

#define JPEG_TYPE @"image/jpeg"



#define NETEASE_QUERY_STRING @"oauth_consumer_key=%@&" \
"oauth_signature_method=HMAC-SHA1&" \
"oauth_signature=%@&" \
"oauth_timestamp=%@&" \
"oauth_nonce=%@&" \
"oauth_version=1.0&" \
"x_auth_username=%@&" \
"x_auth_password=%@&" \
"x_auth_mode=client_auth"


#define NETEASE_PUBLISH_STRING @"oauth_consumer_key=%@&" \
"oauth_nonce=%@&" \
"oauth_signature_method=HMAC-SHA1&" \
"oauth_timestamp=%@&" \
"oauth_token=%@&" \
"oauth_version=1.0&" \
"status=%@&" \
"oauth_signature=%@"


#define NETEASE_PUBLISH_IMAGEFILE @"oauth_consumer_key=%@&" \
"oauth_nonce=%@&" \
"oauth_signature_method=HMAC-SHA1&" \
"oauth_timestamp=%@&" \
"oauth_token=%@&" \
"oauth_version=1.0&" \
"oauth_signature=%@"




//签名用
static NSInteger SortParameter(NSString *key1, NSString *key2, void *context) {
	NSComparisonResult r = [key1 compare:key2];
	if(r == NSOrderedSame) { // compare by value in this case
		NSDictionary *dict = (NSDictionary *)context;
		NSString *value1 = [dict objectForKey:key1];
		NSString *value2 = [dict objectForKey:key2];
		return [value1 compare:value2];
	}
	return r;
}

static NSData *HMAC_SHA1(NSString *data, NSString *key) {
	unsigned char buf[CC_SHA1_DIGEST_LENGTH];
	CCHmac(kCCHmacAlgSHA1, [key UTF8String], [key length], [data UTF8String], [data length], buf);
	return [NSData dataWithBytes:buf length:CC_SHA1_DIGEST_LENGTH];
}
//签名用

@interface NetEaseEngine(PrivateMethod)
- (NSString *)URLEncodedString:(NSString *)source;
- (NSString*)URLDecodedString:(NSString *)source;
- (NSString *)base64EncodedStringWithData:(NSData *)data;
- (NSURL *)smartURLForString:(NSString *)str;

- (NSString *)generateNonce;
- (NSString *)generateTimeStamp;
- (NSString *)generateSignatureWithUrl:(NSURL *)aUrl
						 customeSecret:(NSString *)aConsumerSecret 
						   tokenSecret:(NSString *)aTokenSecret 
							httpMethod:(NSString *)aHttpMethod 
							parameters:(NSDictionary *)aPatameters 
						 normalizedUrl:(NSString **)aNormalizedUrl 
		   normalizedRequestParameters:(NSString **)aNormalizedRequestParameters;

- (NSString *)generateSignatureBaseWithUrl:(NSURL *)aUrl 
								httpMethod:(NSString *)aHttpMethod 
								parameters:(NSDictionary *)aParameters 
							 normalizedUrl:(NSString **)aNormalizedUrl 
			   normalizedRequestParameters:(NSString **)aNormalizedRequestParameters;


//发送微博精简
//+ (NSMutableURLRequest *)requestPost:(NSString *)aUrl queryString:(NSString *)aQueryString;
//存储用
- (NSString *)urlSchemeString;
- (void)readAuthorizeDataFromKeychain;
- (void)saveAuthorizeDataToKeychain;
- (void)deleteAuthorizeDataInKeychain;
@end


@implementation NetEaseEngine


@synthesize appKey = _appKey;
@synthesize appSecrect = _appSecrect;
@synthesize accessTokenKey = _accessTokenKey;
@synthesize accessTokenSecrect = _accessTokenSecrect;
@synthesize userId = _userId;

@synthesize connection = _connection;
@synthesize parentDelegate = _parentDelegate;
@synthesize statusId = _statusId;

- (id)init {
	self = [super init];
	if (self) {
		self.appKey = KEY_NETEASE;
		self.appSecrect = SECRETKEY_NETEASE;
		[self readAuthorizeDataFromKeychain];
	}
	return self;
}

- (void)dealloc {
	[_userId release];
	[_appKey release];
	[_appSecrect release];
	[_accessTokenKey release];
	[_accessTokenSecrect release];
	
	[_connection cancel];
	[_connection release];
	[_statusId release];
	[_bufferData release];
	[super dealloc];
}

- (BOOL)isLogIn {
	return (_userId && _accessTokenKey && _accessTokenSecrect && ![_userId isEqualToString:@""] && ![_accessTokenKey isEqualToString:@""] && ![_accessTokenSecrect isEqualToString:@""]);
}

- (void)logOut {
	[self deleteAuthorizeDataInKeychain];
}

- (void)sendNetEaseContent:(NSString *)content {
	NSString *oauth_consumer_key = KEY_NETEASE;
	NSString *oauth_nonce = [self generateNonce];
	NSString *oauth_signature_method = HMACSHA1SignatureType;
	NSString *oauth_timestamp = [self generateTimeStamp];
	//
	NSMutableDictionary *allParameters = [[NSMutableDictionary alloc] init];
	[allParameters setObject:oauth_nonce forKey:OAuthNonceKey];
	[allParameters setObject:oauth_timestamp forKey:OAuthTimestampKey];
	[allParameters setObject:OAuthVersion forKey:OAuthVersionKey];
	[allParameters setObject:oauth_signature_method forKey:OAuthSignatureMethodKey];
	[allParameters setObject:oauth_consumer_key forKey:OAuthConsumerKeyKey];
	[allParameters setObject:self.accessTokenKey forKey:OAuthTokenKey];
	[allParameters setObject:content forKey:NETEASE_CONTENT_STATUS];

	//NSString *encodedUrl = [NETEASE_PUBLISH_WEIBO_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSURL *url = [self smartURLForString:NETEASE_PUBLISH_WEIBO_URL];
	
	NSString *normalizedUrl = nil;
	NSMutableString *normalizedRequestParameters = nil;
	NSString *oauth_signature = [self generateSignatureWithUrl:url 
												 customeSecret:SECRETKEY_NETEASE 
												   tokenSecret:self.accessTokenSecrect 
													httpMethod:@"POST" 
													parameters:allParameters 
												 normalizedUrl:&normalizedUrl 
								   normalizedRequestParameters:&normalizedRequestParameters];
	
	oauth_signature = [self URLEncodedString:oauth_signature];
	
	[allParameters release];
	
	NSString *queryString = [[NSString alloc] initWithFormat:NETEASE_PUBLISH_STRING,
							 self.appKey,
							 oauth_nonce,
							 oauth_timestamp,
							 self.accessTokenKey,
							 content,
							 oauth_signature];
	
	NSLog(@"queryString:%@", queryString);
    
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
	[request setHTTPMethod:@"POST"];
	[request setTimeoutInterval:20.0f];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[request setHTTPBody:[queryString dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSURLConnection *con = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	self.connection = con;
	[con release];
	[request release];
	[queryString release];
}

-(void)NetEaseUpdataImage:(NSData *)image{
    //NSString *content = @"12345678";
    NSString *oauth_consumer_key = KEY_NETEASE;
	NSString *oauth_nonce = [self generateNonce];
	NSString *oauth_signature_method = HMACSHA1SignatureType;
	NSString *oauth_timestamp = [self generateTimeStamp];
	
    
	//NSString *encodedUrl = [NETEASE_PUBLISH_WEIBO_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	//NSURL *url = [self smartURLForString:NETEASE_UPLOADIMAGE_WEIBO_URL];
	
	    
	//NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSMutableURLRequest *request = [self requestPostWithFile:image url:NETEASE_UPLOADIMAGE_WEIBO_URL queryString:@""];
	[request setHTTPMethod:@"POST"];
	[request setTimeoutInterval:20.0f];
	//[request setValue:@"Multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    
    
    
    [request setValue:oauth_nonce forHTTPHeaderField:OAuthNonceKey];
	[request setValue:oauth_timestamp forHTTPHeaderField:OAuthTimestampKey];
	[request setValue:OAuthVersion forHTTPHeaderField:OAuthVersionKey];
	[request setValue:oauth_signature_method forHTTPHeaderField:OAuthSignatureMethodKey];
	[request setValue:oauth_consumer_key forHTTPHeaderField:OAuthConsumerKeyKey];
	[request setValue:self.accessTokenKey forHTTPHeaderField:OAuthTokenKey];
	
    //[request setValue:@"Multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    //[request setAllHTTPHeaderFields:allParameters];
	//[request setHTTPBody:[queryString dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //[self buildDataOnPost:nil MultiPart:nil image:image];
    
	NSURLConnection *con = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	self.connection = con;
	[con release];
	[request release];
     
}

- (void)logInUsingUserID:(NSString *)theUserID password:(NSString *)thePassword {
    
    NSLog(@"theUserID:%@ thePassword:%@",theUserID,thePassword);
    
	NSString *oauth_consumer_key = KEY_NETEASE;
	NSString *oauth_nonce = [self generateNonce];
	NSString *oauth_signature_method = HMACSHA1SignatureType;
	NSString *oauth_timestamp = [self generateTimeStamp];
	
	//
	NSMutableDictionary *allParameters = [[NSMutableDictionary alloc] init];
	[allParameters setObject:oauth_nonce forKey:OAuthNonceKey];
	[allParameters setObject:oauth_timestamp forKey:OAuthTimestampKey];
	[allParameters setObject:OAuthVersion forKey:OAuthVersionKey];
	[allParameters setObject:oauth_signature_method forKey:OAuthSignatureMethodKey];
	[allParameters setObject:oauth_consumer_key forKey:OAuthConsumerKeyKey];
	//xauth
	[allParameters setObject:theUserID forKey:XAUTH_USERNAME];
	[allParameters setObject:thePassword forKey:XAUTH_PASSWORD];
	[allParameters setObject:XAUTH_MODE_VALUE forKey:XAUTH_MODE];
	
	NSString *encodedUrl = [NETEASE_ACCESS_TOKEN_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSURL *url = [self smartURLForString:encodedUrl];

	NSString *normalizedUrl = nil;
	NSMutableString *normalizedRequestParameters = nil;
	NSString *oauth_signature = [self generateSignatureWithUrl:url 
												 customeSecret:SECRETKEY_NETEASE 
												   tokenSecret:nil 
													httpMethod:@"GET" 
													parameters:allParameters 
												 normalizedUrl:&normalizedUrl 
								   normalizedRequestParameters:&normalizedRequestParameters];

	oauth_signature = [self URLEncodedString:oauth_signature];

	[allParameters release];


	NSString *queryString = [[NSString alloc] initWithFormat:NETEASE_QUERY_STRING, 
							 KEY_NETEASE,
							 oauth_signature,
							 oauth_timestamp,
							 oauth_nonce,
							 theUserID,
							 thePassword];
	
	NSString *strURL = [[NSString alloc] initWithFormat:@"%@?%@", NETEASE_ACCESS_TOKEN_URL, queryString];
//#ifdef MYDEBUG
	NSLog(@"strURL:%@", strURL);
//#endif
	NSURL *accessTokeURL = [[NSURL alloc] initWithString:strURL];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:accessTokeURL 
																 cachePolicy:NSURLRequestReloadIgnoringLocalCacheData 
															 timeoutInterval:20.0f];

	
	NSURLResponse *response = nil;
	NSError *error = nil;
	NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//#ifdef MYDEBUG
	NSLog(@"data:%@", retStr);
//#endif
	NSArray *tokens = [retStr componentsSeparatedByString:@"&"];
	for (NSString *token in tokens) {
		NSArray *keyValues = [token componentsSeparatedByString:@"="];
		if ([keyValues count] > 1) {
			NSString *key = [keyValues objectAtIndex:0];
			NSString *value = [keyValues objectAtIndex:1];
			if ([key isEqualToString:OAuthTokenKey]) {
				self.accessTokenKey = value;
			} else if ([key isEqualToString:OAuthTokenSecretKey]) {
				self.accessTokenSecrect = value;
			}
		}
	}
	
	if (self.accessTokenKey != nil && ![self.accessTokenKey isEqualToString:@""] &&
		self.accessTokenSecrect != nil && ![self.accessTokenSecrect isEqualToString:@""]) {
		self.userId = theUserID;
		[self saveAuthorizeDataToKeychain];
	} else {
		//[CommonFuncs showMessage:@"人民新闻" ContentMessage:@"授权失败"];
        
	}

	
	[retStr release];
	[request release];
	
	[accessTokeURL release];
	[strURL release];
	[queryString release];
}

////私有方法
- (NSString *)generateNonce {
	// Just a simple implementation of a random number between 123400 and 9999999
	return [NSString stringWithFormat:@"%u", arc4random() % (9999999 - 123400) + 123400];
}

- (NSString *)generateTimeStamp {
	
	return [NSString stringWithFormat:@"%d", (int)[[NSDate date] timeIntervalSince1970]];
}

//Generates a signature using the HMAC-SHA1 algorithm
- (NSString *)generateSignatureWithUrl:(NSURL *)aUrl
						 customeSecret:(NSString *)aConsumerSecret 
						   tokenSecret:(NSString *)aTokenSecret 
							httpMethod:(NSString *)aHttpMethod 
							parameters:(NSDictionary *)aPatameters 
						 normalizedUrl:(NSString **)aNormalizedUrl 
		   normalizedRequestParameters:(NSString **)aNormalizedRequestParameters {
	
	NSString *signatureBase = [self generateSignatureBaseWithUrl:aUrl 
													  httpMethod:aHttpMethod 
													  parameters:aPatameters 
												   normalizedUrl:aNormalizedUrl 
									 normalizedRequestParameters: aNormalizedRequestParameters];
//	NSString *signatureKey = [NSString stringWithFormat:@"%@&%@", [aConsumerSecret URLEncodedString], aTokenSecret ? [aTokenSecret URLEncodedString] : @""];
	NSString *signatureKey = [NSString stringWithFormat:@"%@&%@", [self URLEncodedString:aConsumerSecret], aTokenSecret ? [self URLEncodedString:aTokenSecret] : @""];
//	NSString *signatureKey = [NSString stringWithFormat:@"%@&", [self URLEncodedString:aConsumerSecret]];
	NSLog(@"signatureKey:%@", signatureKey);
	NSData *signature = HMAC_SHA1(signatureBase, signatureKey);
//	NSString *base64Signature = [signature base64EncodedString];
	NSString *base64Signature = [self base64EncodedStringWithData:signature];
	
	NSLog(@"base64Signature:%@", base64Signature);
	
	return base64Signature;
}

//Generate the signature base that is used to produce the signature
- (NSString *)generateSignatureBaseWithUrl:(NSURL *)aUrl 
								httpMethod:(NSString *)aHttpMethod 
								parameters:(NSDictionary *)aParameters 
							 normalizedUrl:(NSString **)aNormalizedUrl 
			   normalizedRequestParameters:(NSString **)aNormalizedRequestParameters {
	
	*aNormalizedUrl = nil;
	*aNormalizedRequestParameters = nil;
	
	if ([aUrl port]) {
		*aNormalizedUrl = [NSString stringWithFormat:@"%@:%@//%@%@", [aUrl scheme], [aUrl port], [aUrl host], [aUrl path]];
	} else {
		*aNormalizedUrl = [NSString stringWithFormat:@"%@://%@%@", [aUrl scheme], [aUrl host], [aUrl path]];
	}
	
	
	NSMutableArray *parametersArray = [NSMutableArray array];
	NSArray *sortedKeys = [[aParameters allKeys] sortedArrayUsingFunction:SortParameter context:aParameters];
	for (NSString *key in sortedKeys) {
		NSString *value = [aParameters valueForKey:key];
//		[parametersArray addObject:[NSString stringWithFormat:@"%@=%@", key, [value URLEncodedString]]];
		[parametersArray addObject:[NSString stringWithFormat:@"%@=%@", key, [self URLEncodedString:value]]];
	}
	*aNormalizedRequestParameters = [parametersArray componentsJoinedByString:@"&"];
	
//	NSString *signatureBaseString = [NSString stringWithFormat:@"%@&%@&%@",
//									 aHttpMethod, [*aNormalizedUrl URLEncodedString], [*aNormalizedRequestParameters URLEncodedString]];
	NSString *signatureBaseString = [NSString stringWithFormat:@"%@&%@&%@",
									 aHttpMethod, [self URLEncodedString:*aNormalizedUrl], [self URLEncodedString:*aNormalizedRequestParameters]];    
	
	NSLog(@"signatureBaseString:%@", signatureBaseString);
	
	return signatureBaseString;
}

- (NSString *)URLEncodedString:(NSString *)source 
{
    NSString *result = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)source,
                                            NULL,
                                            CFSTR("!*'();:@&=+$,/?%#[]"),
                                            kCFStringEncodingUTF8);
    [result autorelease];
	return result;
}

- (NSString*)URLDecodedString:(NSString *)source
{
	NSString *result = (NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                    (CFStringRef)source,
                                                    CFSTR(""),
                                                    kCFStringEncodingUTF8);
    [result autorelease];
	return result;	
}



//------------------------------------------------
- (void) buildDataOnPost:(NSMutableData *)dataBody MultiPart:(NSMutableDictionary *)multiPart image:(NSData *)image {
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths    objectAtIndex:0];
    NSString *filename=[path stringByAppendingPathComponent:@"0.gif"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filename])
    {
        NSLog(@"it is -------- ");
    }
    
    NSURL * url = [NSURL URLWithString:NETEASE_UPLOADIMAGE_WEIBO_URL];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request setUseKeychainPersistence:YES];
    [request setDelegate:self];
    
    
    NSString *oauth_consumer_key = KEY_NETEASE;
	NSString *oauth_nonce = [self generateNonce];
	NSString *oauth_signature_method = HMACSHA1SignatureType;
	NSString *oauth_timestamp = [self generateTimeStamp];
    
    
    [request addRequestHeader:OAuthNonceKey value:oauth_nonce];
    [request addRequestHeader:OAuthTimestampKey value:oauth_timestamp];
    [request addRequestHeader:OAuthVersionKey value:OAuthVersion];
    [request addRequestHeader:OAuthSignatureMethodKey value:oauth_signature_method];
    [request addRequestHeader:OAuthConsumerKeyKey value:oauth_consumer_key];
    [request addRequestHeader:OAuthTokenKey value:self.accessTokenKey];
    
    
    [request setData:image withFileName:filename andContentType:@"multipart/form-data" forKey:@"pic"];
    
    [request setRequestMethod:@"POST"];
    
    [request startSynchronous];    
    
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    NSError *error = [request error];
	NSLog(@"Error: %@", error);
}



-(void)requestFinished:(ASIHTTPRequest *)request{
    
    NSString *responseString = [request responseString];
    NSLog(@"requestFinished:%@",responseString);
}

//- (NSMutableURLRequest *)requestPostWithFile:(NSDictionary *)files url:(NSString *)aUrl queryString:(NSString *)aQueryString 
- (NSMutableURLRequest *)requestPostWithFile:(NSData *)image url:(NSString *)aUrl queryString:(NSString *)allParameters{
	
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:[self smartURLForString:aUrl]] autorelease];
	[request setHTTPMethod:@"POST"];
	[request setTimeoutInterval:20.0f];
    
    
    
    
	
	[request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", BOUNDARY_STR] forHTTPHeaderField:@"Content-Type"];
    
    NSMutableData *bodyData = [[NSMutableData alloc] init];
    
	if(image != nil){
        NSMutableString *strFile = [[NSMutableString alloc] init];
        //构造分隔线
        [strFile appendString:@"--"];
        [strFile appendString:BOUNDARY_STR];
        [strFile appendString:@"\r\n"];
        //增加文件Item描述
        //NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
        NSString *fn = [[NSString alloc] initWithFormat:@"%@.jpg", dateToString_YMD([NSDate dateWithTimeIntervalSinceNow:0.0f])];
        
        //@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\nContent-Type:%@\r\n\r\n"
        [strFile appendFormat:FILE_FORM_ITEM, @"pic", fn, JPEG_TYPE];
        [bodyData appendData:[strFile dataUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)]];
        NSLog(@"strFile:%@",strFile);
        [strFile release];
        //增加二进制实体
        [bodyData appendData:image];
        //增加数据段结尾的回车换行符
        [bodyData appendData:[@"\r\n" dataUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)]];
        
        NSMutableString *dataTail = [[NSMutableString alloc] init];
        [dataTail appendString:@"--"];
        [dataTail appendString:BOUNDARY_STR];
        [dataTail appendString:@"--\r\n\r\n"];
        NSLog(@"dataTail:%@",dataTail);
        [bodyData appendData:[dataTail dataUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)]];
        
    }
    
    //NSLog(@"bodyData:%@",bodyData);
    [request setValue:[NSString stringWithFormat:@"%d", [bodyData length]] forHTTPHeaderField:@"Content-Length"];
	[request setHTTPBody:bodyData];
    
	return request;
}

- (NSDictionary *)parseURLQueryString:(NSString *)queryString {
	
	NSMutableDictionary *dict = [NSMutableDictionary dictionary];
	NSArray *pairs = [queryString componentsSeparatedByString:@"&"];
	for(NSString *pair in pairs) {
		NSArray *keyValue = [pair componentsSeparatedByString:@"="];
		if([keyValue count] == 2) {
			NSString *key = [keyValue objectAtIndex:0];
			NSString *value = [keyValue objectAtIndex:1];
			value = [value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
			if(key && value)
				[dict setObject:value forKey:key];
		}
	}
	return [NSDictionary dictionaryWithDictionary:dict];
}




//------------------------------------

////////
#define CHAR64(c) (index_64[(unsigned char)(c)])

#define BASE64_GETC (length > 0 ? (length--, bytes++, (unsigned int)(bytes[-1])) : (unsigned int)EOF)
#define BASE64_PUTC(c) [buffer appendBytes: &c length: 1]

static char basis_64[] =
"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

static inline void output64Chunk( int c1, int c2, int c3, int pads, NSMutableData * buffer )
{
	char pad = '=';
	BASE64_PUTC(basis_64[c1 >> 2]);
	BASE64_PUTC(basis_64[((c1 & 0x3) << 4) | ((c2 & 0xF0) >> 4)]);
	
	switch ( pads )
	{
		case 2:
			BASE64_PUTC(pad);
			BASE64_PUTC(pad);
			break;
			
		case 1:
			BASE64_PUTC(basis_64[((c2 & 0xF) << 2) | ((c3 & 0xC0) >> 6)]);
			BASE64_PUTC(pad);
			break;
			
		default:
		case 0:
			BASE64_PUTC(basis_64[((c2 & 0xF) << 2) | ((c3 & 0xC0) >> 6)]);
			BASE64_PUTC(basis_64[c3 & 0x3F]);
			break;
	}
}

- (NSString *)base64EncodedStringWithData:(NSData *)data {
	NSMutableData * buffer = [NSMutableData data];
	const unsigned char * bytes;
	NSUInteger length;
	unsigned int c1, c2, c3;
	
	bytes = [data bytes];
	length = [data length];
	
	while ( (c1 = BASE64_GETC) != (unsigned int)EOF )
	{
		c2 = BASE64_GETC;
		if ( c2 == (unsigned int)EOF )
		{
			output64Chunk( c1, 0, 0, 2, buffer );
		}
		else
		{
			c3 = BASE64_GETC;
			if ( c3 == (unsigned int)EOF )
				output64Chunk( c1, c2, 0, 1, buffer );
			else
				output64Chunk( c1, c2, c3, 0, buffer );
		}
	}
	
	return ( [[[NSString allocWithZone: [data zone]] initWithData: buffer encoding: NSASCIIStringEncoding] autorelease] );
}

- (NSURL *)smartURLForString:(NSString *)str {
	NSURL *     result;
	NSString *  trimmedStr;
	NSRange     schemeMarkerRange;
	NSString *  scheme;
	
	assert(str != nil);
	
	result = nil;
	
	trimmedStr = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	if ( (trimmedStr != nil) && (trimmedStr.length != 0) ) {
		schemeMarkerRange = [trimmedStr rangeOfString:@"://"];
		
		if (schemeMarkerRange.location == NSNotFound) {
			result = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", trimmedStr]];
		} else {
			scheme = [trimmedStr substringWithRange:NSMakeRange(0, schemeMarkerRange.location)];
			assert(scheme != nil);
			
			if ( ([scheme compare:@"http"  options:NSCaseInsensitiveSearch] == NSOrderedSame)
				|| ([scheme compare:@"https" options:NSCaseInsensitiveSearch] == NSOrderedSame) ) {
				result = [NSURL URLWithString:trimmedStr];
			} else {
				// It looks like this is some unsupported URL scheme.
			}
		}
	}
	
	return result;
}

- (NSString *)urlSchemeString {
	return [NSString stringWithFormat:@"%@%@", NETEASE_WBURLSchemePrefix, _appKey];
}

- (void)readAuthorizeDataFromKeychain {
	NSString *serviceName = [[self urlSchemeString] stringByAppendingString:NETEASE_WBKeychainServiceNameSuffix];
    self.userId = [SFHFKeychainUtils getPasswordForUsername:NETEASE_WBKeychainUserID andServiceName:serviceName error:nil];
    self.accessTokenKey = [SFHFKeychainUtils getPasswordForUsername:NETEASE_WBKeychainAccessToken andServiceName:serviceName error:nil];
	self.accessTokenSecrect = [SFHFKeychainUtils getPasswordForUsername:NETEASE_WBKeychainAccessTokenSecrect andServiceName:serviceName error:nil];
	
    //self.expireTime = [[SFHFKeychainUtils getPasswordForUsername:NETEASE_WBKeychainExpireTime andServiceName:serviceName error:nil] doubleValue];
}

- (void)saveAuthorizeDataToKeychain {
	NSString *serviceName = [[self urlSchemeString] stringByAppendingString:NETEASE_WBKeychainServiceNameSuffix];
    [SFHFKeychainUtils storeUsername:NETEASE_WBKeychainUserID andPassword:self.userId forServiceName:serviceName updateExisting:YES error:nil];
	[SFHFKeychainUtils storeUsername:NETEASE_WBKeychainAccessToken andPassword:self.accessTokenKey forServiceName:serviceName updateExisting:YES error:nil];
	[SFHFKeychainUtils storeUsername:NETEASE_WBKeychainAccessTokenSecrect andPassword:self.accessTokenSecrect forServiceName:serviceName updateExisting:YES error:nil];
}

- (void)deleteAuthorizeDataInKeychain {
	self.userId = nil;
	self.accessTokenKey = nil;
	self.accessTokenSecrect = nil;
    
    NSString *serviceName = [[self urlSchemeString] stringByAppendingString:NETEASE_WBKeychainServiceNameSuffix];
    [SFHFKeychainUtils deleteItemForUsername:NETEASE_WBKeychainUserID andServiceName:serviceName error:nil];
	[SFHFKeychainUtils deleteItemForUsername:NETEASE_WBKeychainAccessToken andServiceName:serviceName error:nil];
	[SFHFKeychainUtils deleteItemForUsername:NETEASE_WBKeychainAccessTokenSecrect andServiceName:serviceName error:nil];
}

///////////////////////////////////////
////////////////////////////////////////////////////////////////////////
//	开始接收数据
////////////////////////////////////////////////////////////////////////
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {

	//NSLog(@"response:%@",response.MIMEType);
    
	if ([_parentDelegate respondsToSelector:@selector(netEaseEngineBeginSending:)]) {
		[_parentDelegate netEaseEngineBeginSending:self];
	}
	if (_bufferData == nil) {
		_bufferData = [[NSMutableData alloc] init];
	}
	

}

////////////////////////////////////////////////////////////////////////
//	接收数据过程，数据量大，可能分段取得
////////////////////////////////////////////////////////////////////////
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    //NSString *retString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //NSLog(@"didReceiveData:%@",retString);
	[_bufferData appendData:data];
	
}

////////////////////////////////////////////////////////////////////////
//	接收数据错误
////////////////////////////////////////////////////////////////////////
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	//接受数据错误，查看是网络错误还是连接超时，向界面显示消息

	NSLog(@"connection didFailWithError.%@", [error localizedDescription]);


	if ([_parentDelegate respondsToSelector:@selector(netEaseEngineEndSending:withSuccess:)]) {
		[_parentDelegate netEaseEngineEndSending:self withSuccess:NO];
	}
	[_bufferData release];
	_bufferData = nil;

}

////////////////////////////////////////////////////////////////////////
//	接受数据完成
////////////////////////////////////////////////////////////////////////
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"_bufferData:%d",[_bufferData length]);
	NSString *retString = [[NSString alloc] initWithData:_bufferData encoding:NSUTF8StringEncoding];
	NSLog(@"retString:%@", retString);
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    id jsonObject = [parser objectWithString:retString];
    self.statusId = (NSString *)[jsonObject objectForKey:@"id"];
    NSLog(@"%@", _statusId);
	if (self.statusId == nil || [self.statusId isEqualToString:@""]) {
		if ([_parentDelegate respondsToSelector:@selector(netEaseEngineEndSending:withSuccess:)]) {
			[_parentDelegate netEaseEngineEndSending:self withSuccess:NO];
		}
	} else {
		if ([_parentDelegate respondsToSelector:@selector(netEaseEngineEndSending:withSuccess:)]) {
			[_parentDelegate netEaseEngineEndSending:self withSuccess:YES];
		}
	}

    [parser release];
    [retString release];
	[_bufferData release];
	_bufferData = nil;
	
}
 
 


@end
