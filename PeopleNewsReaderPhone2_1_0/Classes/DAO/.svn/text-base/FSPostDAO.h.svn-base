//
//  FSPostDAO.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-24.
//
//

#import <Foundation/Foundation.h>
#import "FSBaseDAO.h"
#import "FSCommonFunction.h"
#import "GlobalConfig.h"
#import "FSHTTPWebExData.h"
#import "FSXMLParserObject.h"
#import "FSStoreObject.h"

@interface FSPostDAO : FSBaseDAO {
@private
    NSInteger _errorCode;
	NSString *_errorMessage;
	NSStringEncoding _stringEncoding;
}

@property (nonatomic) NSStringEncoding stringEncoding;
@property (nonatomic) NSInteger errorCode;
@property (nonatomic, retain) NSString *errorMessage;

- (void)POSTData:(HTTPPOSTDataKind)postKind;


@end
