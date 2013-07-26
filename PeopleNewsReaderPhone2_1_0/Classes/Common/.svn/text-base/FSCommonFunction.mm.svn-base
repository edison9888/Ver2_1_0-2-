//
//  FSCommonFunction.mm
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-7.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSCommonFunction.h"
#import <zlib.h>


NSString *stringCat(NSString *oneStr, NSString *twoStr) {
	NSString *tmpOne = oneStr;
	NSString *tmpTwo = twoStr;
	if (tmpOne == nil) {
		tmpOne = @"";
	}
	if (tmpTwo == nil) {
		tmpTwo = @"";
	}
	return [NSString stringWithFormat:@"%@%@", tmpOne, tmpTwo];
}

NSString *encodingString(NSString *sourceString, CFStringEncoding encoding) {
	NSString *result = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)sourceString, NULL, CFSTR(":/?#[]@!$&’()*+,;="), encoding);
	return [result autorelease];
}

NSString *encodingUTF8String(NSString *sourceString) {
	return encodingString(sourceString, kCFStringEncodingUTF8);
}

NSString *encodingGB2312String(NSString *sourceString) {
	return encodingString(sourceString, kCFStringEncodingGB_18030_2000);
}


SCNetworkReachabilityFlags getNetworkFlags() {
	SCNetworkReachabilityFlags flags;
	
	struct sockaddr_in zeroAddress;
	bzero(&zeroAddress, sizeof(zeroAddress));
	zeroAddress.sin_len = sizeof(zeroAddress);
	zeroAddress.sin_family = AF_INET;
	
	
	SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
	
	if (!SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags)) {
		flags = 0;
	}
	CFRelease(defaultRouteReachability);
	
	return flags;
}

BOOL checkNetworkIsValid() {
	SCNetworkReachabilityFlags flags = getNetworkFlags();
	
	BOOL isReachable = (flags & kSCNetworkFlagsReachable) == kSCNetworkFlagsReachable;
	BOOL needsConnection = (flags & kSCNetworkFlagsConnectionRequired) == kSCNetworkFlagsConnectionRequired;
	BOOL nonWifi = (flags & kSCNetworkReachabilityFlagsTransientConnection) == kSCNetworkReachabilityFlagsTransientConnection;
	BOOL moveNet = (flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN;
	
	return ((isReachable && !needsConnection) || nonWifi || moveNet) ? YES : NO;	
}

BOOL checkNetworkIsOnlyMobile() {
	SCNetworkReachabilityFlags flags = getNetworkFlags();
	BOOL isReachable = (flags & kSCNetworkFlagsReachable) == kSCNetworkFlagsReachable;
	BOOL needsConnection = (flags & kSCNetworkFlagsConnectionRequired) == kSCNetworkFlagsConnectionRequired;
	BOOL moveNet = (flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN;
#ifdef MYDEBUG
	//NSLog(@"是否是2G/3G网络:%@", moveNet ? @"YES" : @"NO");
#endif
	return ((isReachable && !needsConnection) && moveNet) ? YES : NO;
}

NSString *dateToString(NSDate *date, NSString *formatString) {
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:formatString];
	NSString *result = [dateFormatter stringFromDate:date];
	[dateFormatter release];
	return result;
}

NSString *dateToString_YMDHM(NSDate *date){
    return dateToString(date, @"yyyy-MM-dd HH:mm");
}

NSString *dateToString_YMD(NSDate *date) {
	return dateToString(date, @"yyyy-MM-dd");
}

NSString *dateToString_MDHM(NSDate *date){
    return dateToString(date, @"MM-dd HH:mm");
}

NSString *dateToString_HMS(NSDate *date) {
	return dateToString(date, @"HH:mm:ss");
}

NSString *dateToString_HM(NSDate *date) {
	return dateToString(date, @"HH:mm");
}

NSString *timeIntervalStringSinceNow(NSDate *date){
    
    
    NSInteger seconds = 0 - (NSInteger)[date timeIntervalSinceNow];
	
	if (seconds < 60)
	{
		return @"刚刚";
	}
	else if (seconds >= 60 && seconds < 3600)
	{
		return  [NSString stringWithFormat:@"%d分钟前", seconds / 60];
	}
	else if (seconds >= 3600 && seconds < 86400)
	{
		return [NSString stringWithFormat:@"%d小时前", seconds / 3600];
	}
	else {
         //直接显示日期
         return dateToString_YMD(date);
    }
	return @"未知";
}

CGRect roundToRect(CGRect sourceRect) {
	CGRect r = CGRectMake((int)sourceRect.origin.x, (int)sourceRect.origin.y, (int)sourceRect.size.width, (int)sourceRect.size.height);
	return r;
}


NSString *MD5String(NSString *sourceString) {
	const char *strData = [sourceString UTF8String];
	unsigned char result[16] = {};
	CC_MD5(strData, strlen(strData), result);
	NSMutableString *strRst = [[NSMutableString alloc] init];
	for (int i = 0; i < 16; i++) {
		[strRst appendString:[NSString stringWithFormat:@"%02x", result[i]]];
	}
	return [strRst autorelease];
}

NSString *EncryptString(NSString *sourceString, NSString *key) {
	const char *cKey = [key UTF8String];
	const char *cValue = [sourceString UTF8String];
	
	size_t bufferPtrSize = 512;
	uint8_t *bufferPtr = (uint8_t *)malloc(bufferPtrSize * sizeof(uint8_t));
	size_t movedBytes = 0;    
	memset((void *)bufferPtr, 0, bufferPtrSize);
	
	CCCryptorStatus ccStatus = CCCrypt(kCCEncrypt,
									   kCCAlgorithmDES,
									   kCCOptionPKCS7Padding | kCCOptionECBMode, 
									   cKey,
									   strlen(cKey),
									   NULL,
									   cValue,
									   strlen(cValue),
									   (void *)bufferPtr,
									   bufferPtrSize,
									   &movedBytes);
//	NSLog(@"ccStatus=%d", ccStatus);
//	NSLog(@"movedBytes=%d", movedBytes);
	if (ccStatus == kCCSuccess) {
		NSMutableString *strDes = [[NSMutableString alloc] init];
		for (int i = 0; i < movedBytes; i++) {
			[strDes appendString:[NSString stringWithFormat:@"%02X", bufferPtr[i]]];
		}
		return [strDes autorelease];
	} else {
		return nil;
	}
}

NSString *getDocumentPath() {
	NSArray *paths = nil;
	paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	//得到文档目录
	NSString *documentsDirectory = @"";
	if ([paths count] > 0) {
		return [paths objectAtIndex:0];
	} 	
	return documentsDirectory;
}

NSString *getCachesPath() {
	NSArray *paths = nil;
	paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	//得到文档目录
	NSString *cachesDirectory = @"";
	if ([paths count] > 0) {
        //NSLog(@"cachesDirectory:%@",paths);
		return [paths objectAtIndex:0];
	}
	return cachesDirectory;
}

NSString *getCustomPathWithParentPath(NSString *parentPath, NSString *pathName) {
	NSString *customPath = [parentPath stringByAppendingPathComponent:pathName];
	NSFileManager *fm = [NSFileManager defaultManager];
	if (![fm fileExistsAtPath:customPath]) {
		NSError *error = nil;
		if (![fm createDirectoryAtPath:customPath withIntermediateDirectories:YES attributes:nil error:&error]) {
#ifdef MYDEBUG
			NSLog(@"error at create custompath:%@", [error localizedDescription]);
#endif
			return @"";
		}
	}
	return customPath;
}

NSString *getCustomDrawImagePath() {
	return getCustomPathWithParentPath(getCachesPath(), @"UserCustomImage");
}

NSString *trimString(NSString *sourceString) {
	return [sourceString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

double computeFileBytesInPath(NSString *filePath) {
	double result = 0.0f;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if ([fileManager fileExistsAtPath:filePath]) {
		NSDirectoryEnumerator *directoryEnumerator = [fileManager enumeratorAtPath:filePath];
		NSString *fileName = nil;
		while (fileName = [directoryEnumerator nextObject]) {
			NSString *fullFileName = [filePath stringByAppendingPathComponent:fileName];
			NSDictionary *fileAttr = [directoryEnumerator fileAttributes];
			NSString *fileType = [fileAttr objectForKey:NSFileType];
			if ([fileType isEqualToString:NSFileTypeDirectory]) {
				result += computeFileBytesInPath(fullFileName);
			} else {
				NSNumber *number = [fileAttr objectForKey:NSFileSize];
				result += [number unsignedLongLongValue];
			}
		}
	}
	return result;
}

void removeAllFilesInPath(NSString *filePath) {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if ([fileManager fileExistsAtPath:filePath]) {
		NSDirectoryEnumerator *directoryEnumerator = [fileManager enumeratorAtPath:filePath];
		NSString *fileName = nil;
		while (fileName = [directoryEnumerator nextObject]) {
			NSString *fullFileName = [filePath stringByAppendingPathComponent:fileName];
			NSDictionary *fileAttr = [directoryEnumerator fileAttributes];
			NSString *fileType = [fileAttr objectForKey:NSFileType];
			if ([fileType isEqualToString:NSFileTypeDirectory]) {
				removeAllFilesInPath(fullFileName);
			} 
			NSError *error = nil;
			if (![fileManager removeItemAtPath:fullFileName error:&error]) {
#ifdef MYDEBUG
				NSLog(@"removeFile:%@[error:%@]", fullFileName, error);
#endif
			}
		}
	}
}

NSString *getFileNameWithURLString(NSString *URLString, NSString *basePath) {
	NSString *fileName = @"";
    if (URLString==nil) {
        FSLog(@"URLString==nil");
        return @"";
    }
	NSURL *url = [[NSURL alloc] initWithString:URLString];
	NSString *filePath =  getCustomPathWithParentPath(basePath, [[url host] stringByAppendingPathComponent:[[url path] stringByDeletingLastPathComponent]]);
	fileName = [filePath stringByAppendingPathComponent:[URLString lastPathComponent]];
	[url release];
	return fileName;
}

BOOL deleteFileWithURLString(NSString *URLString, NSString *basePath) {
	BOOL rst = YES;
	NSURL *url = [[NSURL alloc] initWithString:URLString];
	NSString *fileName = [basePath stringByAppendingPathComponent:[[url host] stringByAppendingPathComponent:[url path]]];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if ([fileManager fileExistsAtPath:fileName]) {
		NSError *error = nil;
		if (![fileManager removeItemAtPath:fileName error:&error]) {
			rst = NO;
#ifdef MYDEBUG
			NSLog(@"delete.fileName:[%@][error:%@]", fileName, error);
#endif
		}
	}
	[url release];
	return rst;
}

NSMutableData *decompressionZipDataWithSource(NSData *data) {
	BOOL done = NO;
	
	if ([data length] > 0) {
		//构建一个临时的data
		NSData *tempData = [[NSData alloc] initWithData:data];
		
		if ([tempData length] > 0) {
			//
			unsigned full_length = [tempData length];
			unsigned half_length = [tempData length] / 2;
			
			NSMutableData *decompressed = [[NSMutableData alloc] initWithLength:full_length + half_length]; 
			int status;

			z_stream strm;
			
			strm.next_in = (Bytef *)[tempData bytes];
			
			strm.avail_in = [tempData length];
			
			strm.total_out = 0;
			
			strm.zalloc = Z_NULL;
			
			strm.zfree = Z_NULL;
			
			
			
			if (inflateInit2(&strm, (15 + 32)) != Z_OK) {
				//return nil
			} else {
				while (!done){
					
					if (strm.total_out >= [decompressed length]) {
						[decompressed increaseLengthBy: half_length];
					}
					strm.next_out = ((BytePtr)[decompressed mutableBytes] + strm.total_out);
					
					strm.avail_out = [decompressed length] - strm.total_out;
					
					// Inflate another chunk.
					
					status = inflate (&strm, Z_SYNC_FLUSH);
					
					if (status == Z_STREAM_END) {
						done = YES;
					} else if (status != Z_OK) {
						break;
					}
				}
			}

			if (inflateEnd(&strm) != Z_OK) {
				done = NO;
			} else {
				// Set real length.
				if (done){
					[decompressed setLength: strm.total_out];
				}
			}
			
			NSMutableData *result = [[[NSMutableData alloc] initWithData:decompressed] autorelease];
			
			//[tempData release];
			[decompressed release];
			
			if (done) {
                [tempData release];
				return result;
			}
		}
        [tempData release];
	}
	
	return nil;
} 

void openAppStoreComment(NSString *applicationID) {
	NSString *urlString = [[NSString alloc] initWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple%%20Software&id=%@", applicationID];
	NSURL *urlComment = [[NSURL alloc] initWithString:urlString];
	[[UIApplication sharedApplication] openURL:urlComment];
	[urlComment release];
    [urlString release];
}

CGSize scalImageSizeFixWidth(UIImage *image, CGFloat fixWidth) {
    CGSize sizeResult = image.size;
    if (sizeResult.width > fixWidth) {
        sizeResult.width = fixWidth;
        sizeResult.height = sizeResult.width * image.size.height / image.size.width;
    }
    return sizeResult;
}

CGSize scalImageSizeFixHeight(UIImage *image, CGFloat fixHeight) {
    CGSize sizeResult = image.size;
    if (sizeResult.height > fixHeight) {
        sizeResult.height = fixHeight;
        sizeResult.width = sizeResult.height * image.size.width / image.size.height;
    }
    return sizeResult;
}

CGSize scalImageSizeInSize(UIImage *image, CGSize size) {
    CGSize sizeResult = image.size;
    
    if (sizeResult.width > size.width) {
        sizeResult.width = size.width;
        sizeResult.height = sizeResult.width * image.size.height / image.size.width;
    }
    
    if (sizeResult.height > size.height) {
        sizeResult.height = size.height;
        sizeResult.width = sizeResult.height * image.size.width / image.size.height;
    }
    
    return sizeResult;
}

NSString *toHTMLString(NSString *source) {
    NSString *result = source;
    result = [result stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
    result = [result stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"];
    result = [result stringByReplacingOccurrencesOfString:@"<" withString:@"&lt;"];
    result = [result stringByReplacingOccurrencesOfString:@">" withString:@"&gt;"];
    result = [result stringByReplacingOccurrencesOfString:@"\r\n" withString:@"<br>"];
    result = [result stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];

    
//    result = [result stringByReplacingOccurrencesOfString:@"" withString:@""];
//    result = [result stringByReplacingOccurrencesOfString:@"" withString:@""];
    return result;
}
