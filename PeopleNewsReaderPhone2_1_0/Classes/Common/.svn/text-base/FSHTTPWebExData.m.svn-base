//
//  FSHTTPWebExData.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-19.
//
//

#import "FSHTTPWebExData.h"

@interface FSHTTPWebExData()
- (void)inner_HTTPGetDataWithURLString:(NSString *)URLString blockCompletion:(completion)blockCompletion;
- (void)inner_HTTPPostDataWithURLString:(NSString *)URLString withParameters:(NSArray *)parameters withStringEncoding:(NSStringEncoding)stringEncoding withHTTPPOSTDataKind:(HTTPPOSTDataKind)postDataKind  blockCompletion:(completion)blockCompletion;
@end

@implementation FSHTTPWebExData

- (void)dealloc {
#ifdef MYDEBUG
    NSLog(@"%@.dealloc", self);
#endif
    [super dealloc];
}

+ (void)HTTPGetDataWithURLString:(NSString *)URLString blockCompletion:(completion)blockCompletion {
    FSHTTPWebExData *webData = [[FSHTTPWebExData alloc] init];
    [webData inner_HTTPGetDataWithURLString:URLString blockCompletion:blockCompletion];
    NSLog(@"URLString：%@",URLString);
    [webData release];
}

- (void)inner_HTTPGetDataWithURLString:(NSString *)URLString blockCompletion:(completion)blockCompletion {
    [self retain];
    _completion = [blockCompletion copy];
    [FSHTTPGetWebData HTTPGETDataWithURLString:URLString withDelegate:self];
}

+ (void)HTTPPostDataWithURLString:(NSString *)URLString withParameters:(NSArray *)parameters withStringEncoding:(NSStringEncoding)stringEncoding withHTTPPOSTDataKind:(HTTPPOSTDataKind)postDataKind  blockCompletion:(completion)blockCompletion {
    FSHTTPWebExData *webData = [[FSHTTPWebExData alloc] init];
    [webData inner_HTTPPostDataWithURLString:URLString withParameters:parameters withStringEncoding:stringEncoding withHTTPPOSTDataKind:postDataKind blockCompletion:blockCompletion];
    [webData release];
}

- (void)inner_HTTPPostDataWithURLString:(NSString *)URLString withParameters:(NSArray *)parameters withStringEncoding:(NSStringEncoding)stringEncoding withHTTPPOSTDataKind:(HTTPPOSTDataKind)postDataKind  blockCompletion:(completion)blockCompletion {
    [self retain];
    _completion = [blockCompletion retain];
    [FSHTTPPostWebData HTTPPOSTDataWithURLString:URLString withDelegate:self withParameters:parameters withStringEncoding:stringEncoding withHTTPPOSTDataKind:postDataKind];
}

- (void)fsHTTPWebDataDidFinished:(FSHTTPWebData *)sender withData:(NSData *)data {
    _completion(data, YES);
    [_completion release];
    [self release];
}

- (void)fsHTTPWebDataDidFail:(FSHTTPWebData *)sender withError:(NSError *)error {
    _completion(nil, NO);
    [_completion release];
    [self release];
}

@end
