//
//  FS_GZF_TimestampDAO.m
//  PeopleNewsReaderPhone
//
//  Created by Xu dandan on 12-10-25.
//
//

#import "FS_GZF_TimestampDAO.h"
#import "FSCommonFunction.h"

#define FS_TIMESTAMP_NODE_NAME @"result"


@implementation FS_GZF_TimestampDAO

@synthesize Timestamp = _Timestamp;

-(void)getTimestampWithURL:(NSString *)urlString{
    
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (!error) {
        NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
        xmlParser.delegate = self;
        @try {
            if ([xmlParser parse]) {
                return;
                
            } else {
                
            }
        }
        @catch (NSException * e) {
#ifdef MYDEBUG
            NSLog(@"NSXMLParser.ExceptionT:%@", [e reason]);
#endif
        }
        @finally {
            
        }
        
        [xmlParser release];
    }
    [request release];
    [url release];
}


- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
#ifdef MYDEBUG
	NSLog(@"XMLParser Error:%@[%d][%@]", [parseError localizedDescription], [parseError code], self);
#endif
	
	//回调错误

}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	_result = elementName;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	//NSLog(@"foundCharacters:%@",string);
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock {
    if ([_result isEqualToString:FS_TIMESTAMP_NODE_NAME]) {
        NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        NSString *temp = trimString(content);
        NSNumber *tempNumber = [[NSNumber alloc] initWithInt:[temp intValue]];
        _Timestamp = [tempNumber doubleValue];
        [content release];
        [tempNumber release];
        
    }
}

@end
