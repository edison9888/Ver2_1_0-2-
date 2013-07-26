//
//  FSCommonFunction.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-7.
//  Copyright 2012 people.com.cn. All rights reserved.
//////////////////////////////////////////////////////////////////
//	版本			时间				说明
//////////////////////////////////////////////////////////////////
//	1.0			2012-08-07		初版做成
//****************************************************************

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#import <netinet/in.h>
//MD5必须
#import <CommonCrypto/CommonDigest.h>
//DES必须
#import <CommonCrypto/CommonCryptor.h>

FOUNDATION_EXTERN NSString *stringCat(NSString *oneStr, NSString *twoStr);

FOUNDATION_EXTERN NSString *encodingString(NSString *sourceString, CFStringEncoding encoding);

FOUNDATION_EXTERN NSString *encodingUTF8String(NSString *sourceString);

FOUNDATION_EXTERN NSString *encodingGB2312String(NSString *sourceString);

FOUNDATION_EXTERN SCNetworkReachabilityFlags getNetworkFlags(); 

FOUNDATION_EXTERN BOOL checkNetworkIsValid();

FOUNDATION_EXTERN BOOL checkNetworkIsOnlyMobile();

FOUNDATION_EXTERN NSString *dateToString(NSDate *date, NSString *formatString);

FOUNDATION_EXTERN NSString *dateToString_YMDHM(NSDate *date);

FOUNDATION_EXTERN NSString *dateToString_YMD(NSDate *date);

FOUNDATION_EXTERN NSString *dateToString_MDHM(NSDate *date);

FOUNDATION_EXTERN NSString *dateToString_HMS(NSDate *date);

FOUNDATION_EXTERN NSString *dateToString_HM(NSDate *date);

FOUNDATION_EXTERN NSString *timeIntervalStringSinceNow(NSDate *date);

FOUNDATION_EXTERN CGRect roundToRect(CGRect sourceRect);

FOUNDATION_EXTERN NSString *MD5String(NSString *sourceString);

FOUNDATION_EXTERN NSString *EncryptString(NSString *sourceString, NSString *key);

FOUNDATION_EXTERN NSString *getDocumentPath();

FOUNDATION_EXTERN NSString *getCachesPath();

FOUNDATION_EXTERN NSString *getCustomDrawImagePath();

FOUNDATION_EXTERN NSString *getCustomPathWithParentPath(NSString *parentPath, NSString *pathName);

FOUNDATION_EXTERN NSString *trimString(NSString *sourceString);

FOUNDATION_EXTERN double computeFileBytesInPath(NSString *filePath);

FOUNDATION_EXTERN void removeAllFilesInPath(NSString *filePath);

FOUNDATION_EXTERN NSString *getFileNameWithURLString(NSString *URLString, NSString *basePath); 

FOUNDATION_EXTERN BOOL deleteFileWithURLString(NSString *URLString, NSString *basePath);

FOUNDATION_EXTERN NSMutableData *decompressionZipDataWithSource(NSData *data);

FOUNDATION_EXTERN void openAppStoreComment(NSString *applicationID);

FOUNDATION_EXPORT CGSize scalImageSizeFixWidth(UIImage *image, CGFloat fixWidth);

FOUNDATION_EXPORT CGSize scalImageSizeFixHeight(UIImage *image, CGFloat fixHeight); 

FOUNDATION_EXPORT CGSize scalImageSizeInSize(UIImage *image, CGSize size);

FOUNDATION_EXPORT NSString *toHTMLString(NSString *source);


