//
//  NSDate+Ex.m
//  NewsBoard
//
//  Created by 王聪 on 11-1-17.
//  Copyright 2011 NetEase.com, Inc. All rights reserved.
//

#import "NSDate+Ex.h"

@implementation NSDate (Netease)

- (NSString *) timeIntervalStringSinceNow
{
	NSInteger seconds = 0 - (NSInteger)[self timeIntervalSinceNow];
	
	if (seconds < 60)
	{
		return @"刚刚";
		//return [NSString stringWithFormat:@"%d秒前", seconds];
	}
	else if (seconds >= 60 && seconds < 3600)
	{
		return  [NSString stringWithFormat:@"%d分钟前", seconds / 60];
	}
	else if (seconds >= 3600 && seconds < 86400)
	{
		return [NSString stringWithFormat:@"%d小时前", seconds / 3600];
	}
	/*else if (seconds >= 86400 && seconds< 86400*3)
	{
		return [NSString stringWithFormat:@"%d天前", seconds / 86400];
	}*/else {
		//直接显示日期
		return [[self description] substringToIndex:10];
	}

	return @"未知";
}

+ (NSDate *) dateFromNeteaseString:(NSString *) dateString
{
	static NSDateFormatter *parser = nil;
	if (parser == nil) {
		parser = [[NSDateFormatter alloc] init];
		//[parser setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
		[parser setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	}
	NSDate *date = [parser dateFromString:dateString];
	return date;
}
@end

