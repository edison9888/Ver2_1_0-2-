//
//  FSHTTPPostWebData.h
//  PeopleDailyReaderPhone
//
//  Created by people.com.cn on 12-8-29.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSHTTPWebData.h"


#define HTTPPOST_FILE_IMAGE_JPEG_CONTENT_TYPE @"image/pjpeg"
#define HTTPPOST_FILE_STREAM_CONTENT_TYPE @"application/octet-stream"
#define HTTPPOST_FILE_TEXT_FILE_CONTENT_TYPE @"text/plain"

typedef enum _HTTPPOSTDataKind {
	HTTPPOSTDataKind_Normal,
	HTTPPOSTDataKind_MultiPart
} HTTPPOSTDataKind;

@interface FSHTTPPostWebData : FSHTTPWebData {

}

+ (void)HTTPPOSTDataWithURLString:(NSString *)URLString withDelegate:(id)delegate withParameters:(NSArray *)parameters withStringEncoding:(NSStringEncoding)stringEncoding withHTTPPOSTDataKind:(HTTPPOSTDataKind)postDataKind;

@end


typedef enum _HTTPPOSTItemKind {
	HTTPPOSTItemKind_Normal,
	HTTPPOSTItemKind_Binary
} HTTPPOSTItemKind;

@interface FSHTTPPOSTItem : NSObject {
@private
	NSString *_fieldName;
	NSString *_fieldValue;
	NSString *_fieldFileName;
	NSString *_fieldContentType;
	NSData *_fieldData;
	HTTPPOSTItemKind _postItemKind;
}

@property (nonatomic, readonly) HTTPPOSTItemKind postItemKind;
@property (nonatomic, retain, readonly) NSString *fieldName;
@property (nonatomic, retain, readonly) NSString *fieldValue;
@property (nonatomic, retain, readonly) NSString *fieldFileName;
@property (nonatomic, retain, readonly) NSString *fieldContentType;
@property (nonatomic, retain, readonly) NSData *fieldData;


- (id)initWithName:(NSString *)name withValue:(NSString *)value;
- (id)initWithName:(NSString *)name withFileName:(NSString *)fileName withContentType:(NSString *)contentType withData:(NSData *)data;

@end

