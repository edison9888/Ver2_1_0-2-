//
//  FS_GZF_FeedbackPOSTXMLDAO.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-12-15.
//
//

#import "FS_GZF_FeedbackPOSTXMLDAO.h"

#define FEEDBACK_POST_URL @"http://mobile.app.people.com.cn:81/news2/news.php?act=feedback"

/*
message  留言
device_type 设备类型（如android,iphone）
device_model 设备型号（htc xxx,iphone）
client_ver 新闻客户端版本
contact 联系信息"
 */

#define COMMENT_POST_RESULT_ERROR @"errorCode"

#define FEEDBACK_POST_MESSAGE @"message"
#define FEEDBACK_POST_DEVICE_TYPE @"device_type"
#define FEEDBACK_POST_DEVICE_MODEL @"device_model"
#define FEEDBACK_POST_CLIENT_VER @"client_ver"
#define FEEDBACK_POST_CONTACT @"contact"


@implementation FS_GZF_FeedbackPOSTXMLDAO

@synthesize message = _message;
@synthesize device_type = _device_type;
@synthesize device_model = _device_model;
@synthesize client_ver = _client_ver;
@synthesize contact = _contact;
@synthesize result = _result;


- (id)init {
	self = [super init];
	if (self) {
		self.stringEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
		self.errorCode = -1;
        self.device_type = @"ios";
        self.client_ver = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
        self.device_model = [UIDevice currentDevice].model;
	}
	return self;
}

- (NSString *)HTTPPostURLString {
	return FEEDBACK_POST_URL;
}

// message = _message;
// device_type = _device_type;
// device_model = _device_model;
// client_ver = _client_ver;
// contact = _contact;

- (void)HTTPBuildPostItems:(NSMutableArray *)postItems withPostKind:(HTTPPOSTDataKind)postKind {
	//内容  devicetype=ios,content=@"",newsid=12346,nickname=user,columnid=channelid
    
    FSHTTPPOSTItem *devicetype = [[FSHTTPPOSTItem alloc] initWithName:FEEDBACK_POST_DEVICE_TYPE withValue:self.device_type];//self.device_type @"ios"
    [postItems addObject:devicetype];
    [devicetype release];
    
    
    FSHTTPPOSTItem *meg = [[FSHTTPPOSTItem alloc] initWithName:FEEDBACK_POST_MESSAGE withValue:self.message];
    [postItems addObject:meg];
    [meg release];
    
    FSHTTPPOSTItem *devMode = [[FSHTTPPOSTItem alloc] initWithName:FEEDBACK_POST_DEVICE_MODEL withValue:self.device_model];
    [postItems addObject:devMode];
    [devMode release];
    
    
    FSHTTPPOSTItem *clitentVersion = [[FSHTTPPOSTItem alloc] initWithName:FEEDBACK_POST_CLIENT_VER withValue:self.client_ver];
    [postItems addObject:clitentVersion];
    [clitentVersion release];
    
    FSHTTPPOSTItem *con = [[FSHTTPPOSTItem alloc] initWithName:FEEDBACK_POST_CONTACT withValue:self.contact];
    [postItems addObject:con];
    [con release];
    
    
   // NSLog(@"postItems is %@",postItems);
}


#pragma mark -
#pragma mark NSCMLParserDelegate

//Sent by a parser object to its delegate when it encounters a start tag for a given element.
//elementName    A string that is the name of an element (in its start tag)
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    
	self.currentElementName = elementName;
    //NSLog(@"self.currentElementName111 %@",self.currentElementName);
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
}

//Sent by a parser object to provide its delegate with a string representing all or part of the characters of the current element.
//string   A string representing the complete or partial textual content of the current element.
//errCode 0 success

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
       NSLog(@"currentElementNamess %@ ",self.currentElementName);
    
   if ([self.currentElementName isEqualToString:COMMENT_POST_RESULT_ERROR]) {
       if ([string isEqualToString:@"0"]) {
           NSLog(@"success");
           self.result = @"0";
       }else{
           NSLog(@"fail");
           //self.result = @"-1";
       }
	}
     
}

- (void)baseXMLParserComplete:(FSBaseDAO *)sender {
    
    _isSuccessful = NO;
    
	if ([self.result isEqualToString:@"0"]) {
        //#ifdef MYDEBUG
		NSLog(@"login requestSuccessful...");
        //#endif
		_isSuccessful = YES;
        [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_SuccessfulStatus];
    }
    else{
        NSLog(@"login request fail");
        [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_UnknowErrorStatus];
    }
    
    
    
    
	
}


- (void) dealloc {
	;
	[super dealloc];
}


@end
