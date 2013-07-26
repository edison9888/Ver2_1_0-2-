//
//  FS_GZF_PushTokenPOSTXMLDAO.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-3-26.
//
//

#import "FS_GZF_PushTokenPOSTXMLDAO.h"



#define PUSHTOKEN_URL @"http://mobile.app.people.com.cn:81/news2/news.php?act=iostoken"

/*
 
 参数：appid: 应用id devicetoken:设备token  POST方式
 
 appid对应关系
 人民日报Ipad-1
 人民日报iphone-2
 人民日报Android Phone-3
 人民日报Android Pad-4
 人民日报Windows Phone-5
 人民新闻iphone-6
 人民新闻ipad-7
 人民新闻Android Phone-8
 人民新闻Android Pad-9
 人民新闻Windows Phone-10
 
 结果
 
 <root>
 <errorCode>0</errorCode>
 </root>
 
 */

#define COMMENT_POST_RESULT_ERROR @"errorCode"


@implementation FS_GZF_PushTokenPOSTXMLDAO

@synthesize token = _token;

- (NSString *)HTTPPostURLString {
	return PUSHTOKEN_URL;
}

- (void)HTTPBuildPostItems:(NSMutableArray *)postItems withPostKind:(HTTPPOSTDataKind)postKind {
	//内容 @"userName=%@&password=%@", _userName,  _userPassword
    

    FSHTTPPOSTItem *appid = [[FSHTTPPOSTItem alloc] initWithName:@"appid" withValue:@"6"];
    [postItems addObject:appid];
    [appid release];
    
    FSHTTPPOSTItem *appversion = [[FSHTTPPOSTItem alloc] initWithName:@"devicetoken" withValue:self.token];
    [postItems addObject:appversion];
    [appversion release];
    
    
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
            
        }else{
            NSLog(@"fail");
            
        }
	}
    
}

- (void)baseXMLParserComplete:(FSBaseDAO *)sender {
    
//    _isSuccessful = NO;
//    
//	if ([self.result isEqualToString:@"0"]) {
//        //#ifdef MYDEBUG
//		NSLog(@"login requestSuccessful...");
//        //#endif
//		_isSuccessful = YES;
//        [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_SuccessfulStatus];
//    }
//    else{
//        NSLog(@"login request fail");
//        [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_UnknowErrorStatus];
//    }
    
	
}



@end
