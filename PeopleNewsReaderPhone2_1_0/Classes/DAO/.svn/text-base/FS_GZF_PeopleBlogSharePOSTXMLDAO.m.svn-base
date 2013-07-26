//
//  FS_GZF_PeopleBlogSharePOSTXMLDAO.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-11-9.
//
//

#import "FS_GZF_PeopleBlogSharePOSTXMLDAO.h"
#import "FSBaseDB.h"
#import "FSLoginObject.h"

#define PEOPLE_NEWS_SEND_MICRO_BLOG_URL @"http://t.people.com.cn/microblogv2/phonepublishMBpro.action"


@implementation FS_GZF_PeopleBlogSharePOSTXMLDAO

@synthesize imagedata = _imagedata;
@synthesize  message = _message;

- (id)init {
	self = [super init];
	if (self) {
		self.stringEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
		self.errorCode = 0;
	}
	return self;
}

- (NSString *)HTTPPostURLString {
	return PEOPLE_NEWS_SEND_MICRO_BLOG_URL;//url
}

-(void)getUserMessage{
     NSArray *array = [[FSBaseDB sharedFSBaseDB] getObjectsByKeyWithName:@"FSLoginObject" key:@"userKind" value:LOGIN_USER_KIND_PEOPLE_BLOG];
    if ([array count]>0) {
        FSLoginObject *o = (FSLoginObject *)[array lastObject];
        _username = o.userName;
        _userpassword = o.userPassWord;
    }
    else{
        //用户尚未登录。
    }
}

- (void)HTTPBuildPostItems:(NSMutableArray *)postItems withPostKind:(HTTPPOSTDataKind)postKind {
	//内容 @"userName=%@&password=%@", _userName,  _userPassword
    if (postKind != HTTPPOSTDataKind_MultiPart) {
		return;
	}
    [self getUserMessage];
    
    
    
    FSHTTPPOSTItem *username = [[FSHTTPPOSTItem alloc] initWithName:@"userName" withValue:_username];
    [postItems addObject:username];
    [username release];
    
    
    FSHTTPPOSTItem *userpass = [[FSHTTPPOSTItem alloc] initWithName:@"password" withValue:_userpassword];
    [postItems addObject:userpass];
    [userpass release];
    
    
    FSHTTPPOSTItem *message = [[FSHTTPPOSTItem alloc] initWithName:@"message" withValue:self.message];
    [postItems addObject:message];
    [message release];
    
    NSLog( @"userName=%@&password=%@", _username, _userpassword);
    if (self.imagedata != nil) {
        
        NSString *fn = [[NSString alloc] initWithFormat:@"%@.jpg",  dateToString([NSDate dateWithTimeIntervalSinceNow:0.0f], @"yyyyMMddHHmmss")];
        
        FSHTTPPOSTItem *data = [[FSHTTPPOSTItem alloc] initWithName:@"upload" withFileName:fn withContentType:HTTPPOST_FILE_IMAGE_JPEG_CONTENT_TYPE withData:self.imagedata];
        [postItems addObject:data];
        [data release];
        [fn release];
    
	}
     
}


//*****************************************************************

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	self.currentElementName = elementName;
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    NSLog(@"string:%@",string);
	if ([self.currentElementName isEqualToString:@"result"]) {
		_result = [string retain];
	} else if ([self.currentElementName isEqualToString:@"contentId"]) {
		_userid = string;
	} else {
		NSLog(@"Unknow elementName Value = %@", string);
	}
}

- (void)baseXMLParserComplete:(FSBaseDAO *)sender {
    
	if ([_result isEqualToString:@"success"]){//([self.result isEqualToString:@"success"]) {
        //#ifdef MYDEBUG
		NSLog(@"login requestSuccessful...");
        //#endif
        [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_SuccessfulStatus];
    }
    else{
        [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_UnknowErrorStatus];
    }
	
}


- (void) dealloc {
	;
	[super dealloc];
}


@end
