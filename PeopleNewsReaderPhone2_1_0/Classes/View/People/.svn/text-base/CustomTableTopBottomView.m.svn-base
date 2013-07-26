//
//  CustomTableTopBottomView.m
//  PeopleNewsReader
//
//  Created by bo bo on 11-2-19.
//  Copyright 2011 www.people.com.cn. All rights reserved.
//

#import "CustomTableTopBottomView.h"
#import "NSDate+Ex.h"
#import <QuartzCore/QuartzCore.h>
#import "FSConst.h"


//#define BORDER_COLOR [UIColor colorWithRed:0.341 green:0.737 blue:0.537 alpha:1.0]

@implementation CustomTableTopBottomView

@synthesize isFlipped, lastUpdatedDate;

//注意，这里的HeaderViewStyleBlack是用在List里的，White是用在图集里的
- (id)initWithFrame:(CGRect)frame withStyle:(HeaderViewStyle)style{
    if (self = [super initWithFrame:frame])
	{
		self.backgroundColor = [UIColor clearColor];
		
		lastUpdatedLabel = [[UILabel alloc] initWithFrame:
							CGRectMake(0.0f, frame.size.height - 30.0f,
									   320.0f, 20.0f)];
		lastUpdatedLabel.font = [UIFont systemFontOfSize:12.0f];
		lastUpdatedLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
		lastUpdatedLabel.backgroundColor = self.backgroundColor;
		lastUpdatedLabel.opaque = YES;
		lastUpdatedLabel.textAlignment = UITextAlignmentCenter;
		[self addSubview:lastUpdatedLabel];
		[lastUpdatedLabel release];
		
		statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,
                                                                frame.size.height - 48.0f, 320.0f, 20.0f)];
		statusLabel.font = [UIFont boldSystemFontOfSize:13.0f];
		statusLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
		statusLabel.backgroundColor = self.backgroundColor;
		statusLabel.opaque = YES;
		statusLabel.textAlignment = UITextAlignmentCenter;
		[self setStatus:kPullToReloadStatus];
		[self addSubview:statusLabel];
		[statusLabel release];
		
        NSLog(@"HeaderViewStyleBlack:%f %f",self.frame.origin.y,self.frame.size.height);
        
		arrowImage = [[UIImageView alloc] initWithFrame:
					  CGRectMake(60.0f, frame.size.height
								 - 50.0f, 40.0f, 40.0f)];
		arrowImage.contentMode = UIViewContentModeScaleAspectFit;
		arrowImage.image = [UIImage imageNamed:@"pulltorefresh_arraw.png"];
		[arrowImage layer].transform =
		CATransform3DMakeRotation(M_PI, 0.0f, 0.0f, 1.0f);
		[self addSubview:arrowImage];
		[arrowImage release];
		
		if (style == HeaderViewStyleBlack) {
			//背景
			self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pulltorefresh_background.png"]];
			//阴影
			UIImageView *shadow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pulltorefresh_shadow.png"]];
			
            NSLog(@"HeaderViewStyleBlack");
			shadow.frame = frame;
			//[shadow layer].transform = CATransform3DMakeRotation(M_PI, 0.0f, 0.0f, 1.0f);
			
			[self addSubview:shadow];
			[shadow release];
		}
        
		activityView = [[UIActivityIndicatorView alloc]
						initWithFrame:CGRectMake(70.0f, frame.size.height
												 - 38.0f, 20.0f, 20.0f)];
		activityView.hidesWhenStopped = YES;
		[self addSubview:activityView];
		[activityView release];
		
		isFlipped = NO;
		
		if (style == HeaderViewStyleBlack) {
			activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
			lastUpdatedLabel.textColor = COLOR_TITLE;
			statusLabel.textColor = COLOR_TITLE;
			lastUpdatedLabel.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
			statusLabel.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		}
		else {
			activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
			lastUpdatedLabel.textColor = [UIColor whiteColor];
			statusLabel.textColor = [UIColor whiteColor];
			lastUpdatedLabel.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0f];
			statusLabel.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0f];
		}
    }
    return self;
}
/*
 - (void)drawRect:(CGRect)rect{
 CGContextRef context = UIGraphicsGetCurrentContext();
 CGContextDrawPath(context,  kCGPathFillStroke);
 [BORDER_COLOR setStroke];
 CGContextBeginPath(context);
 CGContextMoveToPoint(context, 0.0f, self.bounds.size.height - 1);
 CGContextAddLineToPoint(context, self.bounds.size.width,
 self.bounds.size.height - 1);
 CGContextStrokePath(context);
 }*/

- (void)flipImageAnimated:(BOOL)animated
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:animated ? .18 : 0.0];
	[arrowImage layer].transform = isFlipped ?
	CATransform3DMakeRotation(M_PI, 0.0f, 0.0f, 1.0f) :
	CATransform3DMakeRotation(M_PI * 2, 0.0f, 0.0f, 1.0f);
	[UIView commitAnimations];
	
	isFlipped = !isFlipped;
}

- (void)setLastUpdatedDate:(NSDate *)newDate
{
	if (newDate)
	{
		if (lastUpdatedDate != newDate)
		{
			[lastUpdatedDate release];
		}
		
		lastUpdatedDate = [newDate retain];
        
		lastUpdatedLabel.text = [NSString stringWithFormat:
								 @"上次刷新时间: %@", [lastUpdatedDate timeIntervalStringSinceNow]];
	}
	else
	{
		lastUpdatedDate = nil;
		lastUpdatedLabel.text = @"上次刷新时间: 从未";
	}
}

- (void)setStatus:(int)status
{
	if (lastUpdatedDate!=nil) {
		lastUpdatedLabel.text = [NSString stringWithFormat:
								 @"上次刷新时间: %@", [lastUpdatedDate timeIntervalStringSinceNow]];
	}
	switch (status) {
		case kReleaseToReloadStatus:
			statusLabel.text = @"释放立即刷新";
			break;
		case kPullToReloadStatus:
			statusLabel.text = @"下拉刷新";
			break;
		case kLoadingStatus:
			statusLabel.text = @"正在刷新";
			break;
		default:
			break;
	}
}

- (void)toggleActivityView:(BOOL)isON
{
	if (!isON)
	{
		[activityView stopAnimating];
		arrowImage.hidden = NO;
	}
	else
	{
		[activityView startAnimating];
		arrowImage.hidden = YES;
		[self setStatus:kLoadingStatus];
	}
}

- (void)dealloc
{
	activityView = nil;
	statusLabel = nil;
	arrowImage = nil;
	lastUpdatedLabel = nil;
    [super dealloc];
}

@end