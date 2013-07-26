//
//  FSHTTPWebExData.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-19.
//
//

#import <Foundation/Foundation.h>
#import "FSHTTPGetWebData.h"
#import "FSHTTPPostWebData.h"

typedef void (^completion)(NSData *data, BOOL success);

@interface FSHTTPWebExData : NSObject {
@protected
    completion _completion;
}

+ (void)HTTPGetDataWithURLString:(NSString *)URLString blockCompletion:(completion)blockCompletion;

+ (void)HTTPPostDataWithURLString:(NSString *)URLString withParameters:(NSArray *)parameters withStringEncoding:(NSStringEncoding)stringEncoding withHTTPPOSTDataKind:(HTTPPOSTDataKind)postDataKind blockCompletion:(completion)blockCompletion;

@end
