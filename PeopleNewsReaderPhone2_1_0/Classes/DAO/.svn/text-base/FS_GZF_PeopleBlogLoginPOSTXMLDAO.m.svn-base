//
//  FS_GZF_PeopleBlogLoginPOSTXMLDAO.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-11-9.
//
//

#import "FS_GZF_PeopleBlogLoginPOSTXMLDAO.h"
#import "FSLoginObject.h"

#import "FSBaseDB.h"


/////////////////////////////////////////////////////////////////////////////////////////////
//人民微博分享
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#define NEWS_SHARE_MICROBLOG_NODE_ROOT @"root"
#define NEWS_SHARE_MICROBLOG_NODE_RESULT @"result"
#define NEWS_SHARE_MICROBLOG_NODE_ERRORCODE @"errorCode"
#define NEWS_SHARE_MICROBLOG_NODE_USERID @"userId"
#define MICRO_BLOG_NODE_RESULT @"result"
#define MICRO_BLOG_NODE_ERRORCODE @"errorCode"
#define SEND_MICRO_BLOG_NODE_CONTENTID @"contentId"
#define POST_SUCCESSFUL @"success"

#define LOGIN_URL @"http://t.people.com.cn/microblogv2/phonelogin.action"



@implementation FS_GZF_PeopleBlogLoginPOSTXMLDAO

@synthesize userId = _userId;
@synthesize userName = _userName;
@synthesize userPassword = _userPassword;

@synthesize result = _result;




- (NSString *)HTTPPostURLString {
	return LOGIN_URL;
}

- (void)HTTPBuildPostItems:(NSMutableArray *)postItems withPostKind:(HTTPPOSTDataKind)postKind {
	//内容 @"userName=%@&password=%@", _userName,  _userPassword
    FSHTTPPOSTItem *user = [[FSHTTPPOSTItem alloc] initWithName:@"userName" withValue:self.userName];
    [postItems addObject:user];
    [user release];
    
    
    FSHTTPPOSTItem *pass = [[FSHTTPPOSTItem alloc] initWithName:@"password" withValue:self.userPassword];
    [postItems addObject:pass];
    [pass release];
}




//*****************************************************************

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	self.currentElementName = elementName;
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    NSLog(@"string:%@",string);
	if ([self.currentElementName isEqualToString:MICRO_BLOG_NODE_RESULT]) {
		self.result = string;
	} else if ([self.currentElementName isEqualToString:NEWS_SHARE_MICROBLOG_NODE_USERID]) {
		self.userId = string;
	} else {
		NSLog(@"Unknow elementName Value = %@", string);
	}
}

- (void)baseXMLParserComplete:(FSBaseDAO *)sender {
    
    _isSuccessful = NO;
	if ([self.result isEqualToString:POST_SUCCESSFUL]) {
        //#ifdef MYDEBUG
		NSLog(@"login requestSuccessful...");
        //#endif
		_isSuccessful = YES;
        
       FSLoginObject *o = (FSLoginObject *)[[FSBaseDB sharedFSBaseDB] insertObject:@"FSLoginObject"];
        o.userName = self.userName;
        o.userPassWord = self.userPassword;
        o.userid = self.userId;
        o.userKind = LOGIN_USER_KIND_PEOPLE_BLOG;
        [[FSBaseDB sharedFSBaseDB].managedObjectContext save:nil];
        [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_SuccessfulStatus];
    }
    else{
        [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_UnknowErrorStatus];
    }
    
	
}


- (void) dealloc {
	[_userId release];
	[_userName release];
	[_userPassword release];
	[super dealloc];
}


/*
- (void) postData{
	[self postDataByURL:LOGIN_URL];
}

- (void) buildDataOnPost:(NSMutableData *)dataBody{
	NSString *loginPost = [[NSString alloc] initWithFormat:@"userName=%@&password=%@", _userName,  _userPassword];
	[dataBody appendData:[loginPost dataUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)]];
	[loginPost release];
}


- (void) postDataByURL:(NSString *)sURL{
	//首先检查网络状态是否可用
	if (!checkNetworkIsValid) {
		//网络不可用;
		return;
	}
	if (sURL == nil || sURL == NULL) {
		// url 为空
		return;
	}
	NSLog(@"postDataByURL Begin-----%@", sURL);
	//显示屏幕状态 提示
	
	
	//定义数据类型
	NSString *contentType = nil;
	NSMutableData *dataBody = [[NSMutableData alloc] init];

    contentType = [[NSString alloc] initWithFormat: @"application/x-www-form-urlencoded"];
    //填充数据
    [self buildDataOnPost:dataBody];
	
	//如果生成的NSData为零字节则不调用，一般不会发生
	if ([dataBody length] == 0) {
		[dataBody release];
		return;
	}
	
	//开始POST数据
	NSURL *url = [[NSURL alloc] initWithString:sURL];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	NSString *dataLength = [[NSString alloc] initWithFormat:@"%d", [dataBody length]];
	[request setURL:url];
	[request setHTTPMethod:@"POST"];
	//设置数据类型
	
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
			
	[request setValue:dataLength forHTTPHeaderField:@"Content-Length"];
	[request setHTTPBody:dataBody];
	[request setHTTPShouldHandleCookies:YES];
	[self setCookie:sURL Request:request];
	[request setTimeoutInterval:60];
	
	//异步向服务器提交数据
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
	//释放对象
	[connection release];
	[request release];
	[dataLength release];
	[url release];
	[contentType release];
	[dataBody release];
	NSLog(@"postDataByURL End-----");
}


#pragma mark -
#pragma mark 设置cookie
- (void) setCookie:(NSString *)hostURL Request:(NSMutableURLRequest *)request {
	NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
	NSURL *url = [NSURL URLWithString:hostURL];
	NSArray *cookies = [cookieStorage cookiesForURL:url];
	//找到属于自己的cookie
	NSDictionary *headers = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
	[request setAllHTTPHeaderFields:headers];
	//加入到request中
}
*/

@end
