//
//  NTESNBToast.m
//  NewsBoard
//
//  Created by 黄旭 on 1/14/11.
//  Copyright 2011 NetEase.com, Inc. All rights reserved.
//

#import "NTESNBToast.h"
static NTESNBToast *myToast = nil;

@implementation NTESNBToast
@synthesize backgroundImage;
//@synthesize infoLab;



+ (NTESNBToast *)sharedToast
{
	if (myToast == nil) {
		myToast = [[NTESNBToast alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
	}
	
    return myToast;
}

//- init {
//	if (self = [super init]) {
//		
//	}
//	return self;
//}

- (id)initWithFrame:(CGRect)frame;{
	if (self = [super initWithFrame:frame]) {
		//backgroundImage = [[UIImageView alloc] initWithFrame:frame];
		//backgroundImage.backgroundColor = [UIColor blackColor];
		//[self addSubview:backgroundImage];
		//[backgroundImage release];
		self.backgroundColor = [UIColor clearColor];
		
		//未来添加字符串内容更长的情况
		infoLab = [[UILabel alloc] initWithFrame:frame];
		infoLab.textAlignment = UITextAlignmentCenter;
		infoLab.font = [UIFont systemFontOfSize:13];
		infoLab.textColor = [UIColor whiteColor];
		infoLab.backgroundColor = [UIColor clearColor];
		[self addSubview:infoLab];
		[infoLab release];
		
		self.alpha = 0.0;
	};
	return self;
}

- (void)drawRect:(CGRect)rect {
	CGFloat width = rect.size.width;
	CGFloat height = rect.size.height;
	
	CGRect centerRect = CGRectMake(
								   (rect.origin.x + rect.size.width - width) / 2,
								   (rect.origin.y + rect.size.height - height) / 2,
								   width, height);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	if (isWarning) {
		UIColor* bgColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.618];
		[bgColor set];
	}else {
		UIColor* bgColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.618];
		[bgColor set];
	}

	CGContextBeginPath(context);
    [self drawRoundedRect:centerRect inContext:context withSize:CGSizeMake(6,6)];
    CGContextFillPath(context);
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
    [super dealloc];
}

- (void)showUpWithInfo:(NSString *)info{
	if (isWarning==YES) {
		isWarning = NO;
		[self setNeedsDisplay];//换色
	}
	[self showUp:info];
}


- (void)showUpWithWarningInfo:(NSString *)info{
	if (isWarning==NO) {
		isWarning = YES;
		[self setNeedsDisplay];
	}
	[self showUp:info];
}


- (void)removeSelf{
	self.hidden = YES;
}
#pragma mark -
#pragma mark private methods
- (void)showUp:(NSString *)info{
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
	self.hidden = NO;
	UIWindow *topWindow = [[[UIApplication sharedApplication] windows] lastObject];
	if ([self superview]) {
		[self removeFromSuperview];
	}
	[topWindow addSubview: self];
	self.center = CGPointMake(160, 420);
	
	infoLab.text = info;
	
	[UIView beginAnimations:@"showUp" context:nil];
	[UIView setAnimationDuration:0.75];
	self.alpha = 1.0;
	[UIView commitAnimations];
	
	[self performSelector:@selector(hideInfo) withObject:nil afterDelay:1.5];
}


- (void)hideInfo{
	//self.alpha = 1.0;
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
	[UIView beginAnimations:@"fadeOut" context:nil];
	[UIView setAnimationDuration:1.0];
	//[UIView setAnimationDidStopSelector:@selector(removeSelf)];
	self.alpha = 0.0;
	[UIView commitAnimations];
}
-(void) drawRoundedRect:(CGRect) rect inContext:(CGContextRef)context withSize:(CGSize) size
{
	float ovalWidth = size.width;
	float ovalHeight = size.height;
	
    float fw, fh;
	
    if (ovalWidth == 0 || ovalHeight == 0) {// 1
        CGContextAddRect(context, rect);
        return;
    }
	
    CGContextSaveGState(context);// 2
	
    CGContextTranslateCTM (context, CGRectGetMinX(rect),//确定原点
						   CGRectGetMinY(rect));
    CGContextScaleCTM (context, ovalWidth, ovalHeight);//设定单元步长
    fw = CGRectGetWidth (rect) / ovalWidth;// 计算新单元坐标系的长宽
    fh = CGRectGetHeight (rect) / ovalHeight;// 6
    CGContextMoveToPoint(context, fw, fh/2); // 7
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);// 8
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);// 9
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);// 10
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // 11
    CGContextClosePath(context);// 12
	
    CGContextRestoreGState(context);// 13
	
}
@end
