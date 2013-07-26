//
//  FS_GZF_NewsCommentPOSTXMLDAO.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-11-13.
//
//


/*
 <root>
 <errorCode>0</errorCode>
 <newsid>1</newsid>
 <commentCount>5</commentCount>
 </root>
 
 
 errorCode :
 -1  newsid 参数错误
 -2  content 参数错误
 -3  devicetype 参数错误
 -4  系统忙
 
*/

#import "FS_GZF_NewsCommentPOSTXMLDAO.h"





#define COMMENT_UPDATA_URL @"http://mobile.app.people.com.cn:81/news2/news.php?&act=postcomment"

#define COMMENT_POST_RESULT_ERROR @"errorCode"
#define COMMENT_POST_RESULT_NEWSID @"newsid"
#define COMMENT_POST_RESULT_COUNT @"commentCount"


@implementation FS_GZF_NewsCommentPOSTXMLDAO


@synthesize newsid = _newsid;
@synthesize channelid = _channelid;
@synthesize content = _content;
@synthesize username = _username;
@synthesize result = _result;




- (id)init {
	self = [super init];
	if (self) {
		self.stringEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
		self.errorCode = 0;
	}
	return self;
}

- (NSString *)HTTPPostURLString {
	return COMMENT_UPDATA_URL;
}

//@synthesize newsid = _newsid;
//@synthesize channelid = _channelid;
//@synthesize content = _content;
//@synthesize username = _username;
//@synthesize result = _result;

- (void)HTTPBuildPostItems:(NSMutableArray *)postItems withPostKind:(HTTPPOSTDataKind)postKind {
	//内容  devicetype=ios,content=@"",newsid=12346,nickname=user,columnid=channelid
    FSHTTPPOSTItem *devicetype = [[FSHTTPPOSTItem alloc] initWithName:@"devicetype" withValue:@"ios"];
    [postItems addObject:devicetype];
    [devicetype release];
    
    
    FSHTTPPOSTItem *newsid = [[FSHTTPPOSTItem alloc] initWithName:@"newsid" withValue:self.newsid];
    [postItems addObject:newsid];
    [newsid release];
    
    FSHTTPPOSTItem *columnid = [[FSHTTPPOSTItem alloc] initWithName:@"columnid" withValue:self.channelid];
    [postItems addObject:columnid];
    [columnid release];
    
    
    FSHTTPPOSTItem *content = [[FSHTTPPOSTItem alloc] initWithName:@"content" withValue:self.content];
    [postItems addObject:content];
    [content release];
    
    FSHTTPPOSTItem *nickname = [[FSHTTPPOSTItem alloc] initWithName:@"nickname" withValue:self.username];
    [postItems addObject:nickname];
    [nickname release];
}


//*****************************************************************

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    
	self.currentElementName = elementName;
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    NSLog(@"string:%@",string);
    
    NSString *strUnion = nil;
    if ([self.currentElementName isEqualToString:COMMENT_POST_RESULT_ERROR]) {
        strUnion = stringCat(self.result, trimString(string));
        self.result = strUnion;
    }else {
		NSLog(@"Unknow elementName Value = %@", string);
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
        
        [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_UnknowErrorStatus];
    }
    
	
}


- (void) dealloc {
	;
	[super dealloc];
}



@end
