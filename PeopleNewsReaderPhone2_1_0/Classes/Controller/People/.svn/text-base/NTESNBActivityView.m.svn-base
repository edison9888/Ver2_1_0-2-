//
//  BlogActivityView.m
//  BlogPress
//
//  Created by Feng Huajun on 08-6-18.
//  Copyright 2008 Coollittlethings. All rights reserved.
//

#import "NTESNBActivityView.h"
#import "FSConst.h"

static NTESNBActivityView *myActivityView = nil;

@implementation NTESNBActivityView
@synthesize text,activeDelegate;
- (void)dealloc {
	[super dealloc];
}

-(void) setText:(NSString*) txt
{
	label.text = txt;
}

-(NSString*) text
{
	return label.text;
}

+ (NTESNBActivityView *)sharedActivityView{
	if (myActivityView == nil) {
		myActivityView = [[NTESNBActivityView alloc] initWithFrame:CGRectMake(0, 20, 320, 460)];
	}
	
    return myActivityView;
}


- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		self.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		//
		activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		activityIndicator.hidesWhenStopped = YES;
		[self addSubview:activityIndicator];
		activityIndicator.center = CGPointMake(frame.size.width/2, 50);
		[activityIndicator release];
		//
		label = [[UILabel alloc] initWithFrame:CGRectMake(0, 45, 160, 70)];
		label.numberOfLines = 0;
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = UITextAlignmentCenter;
		label.shadowOffset = CGSizeMake(-1.0, 1.0);
		label.shadowColor = RGBACOLOR(0,0,0,0.4);
		label.font = [UIFont boldSystemFontOfSize:16];
		label.adjustsFontSizeToFitWidth = YES;
		label.textColor = [UIColor whiteColor];
		[self addSubview:label];
		[label release];
		
		backView = [[UIView alloc] initWithFrame:frame];
		backView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
		backView.backgroundColor = RGBACOLOR(0,0,0,0.1);
		backView.hidden = YES;
		
		button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.frame = CGRectMake(0, 0, 80, 24);
		button.titleLabel.font = [UIFont systemFontOfSize:14];
		button.titleLabel.textAlignment = UITextAlignmentCenter;
		[button setTitleColor:RGBACOLOR(64,64,64,1) forState:UIControlStateNormal];
		[button setTitleShadowColor:[UIColor colorWithRed:223 green:223 blue:223 alpha:.5] forState:UIControlStateNormal];
		button.titleLabel.shadowOffset = CGSizeMake(0, 1.0);
		//[button setImage:[UIImage imageNamed:@"vote_vote_button.png"] forState:UIControlStateNormal];
		[button setBackgroundImage:[UIImage imageNamed:@"vote_vote_button.png"] forState:UIControlStateNormal];
		[button addTarget:self action:@selector(fadeOut:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:button];
		button.hidden = NO;
		
		self.alpha = 0.0;
	}
	return self;
}

- (void)startSpinWithInfo:(NSString *)info withButtonTitle:(NSString *)buttonTitle
{	
	
	//这个方法己经调整逻辑，buttonTitle为空时，不会出现activityindicator
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
	
	//这里要重新取topwindow, 所以要先remove在add
	if ([backView superview]) {
		[backView removeFromSuperview];
	}
	NSArray *windows = [[UIApplication sharedApplication] windows];
	UIWindow *topWindow = [windows lastObject];
	[topWindow addSubview:backView];
	if ([self superview]) {
		[self removeFromSuperview];
	}
	
	[topWindow addSubview:self];
	
	
    backView.frame = self.frame = CGRectMake(0, 20, 320, 460);
	
    //backView.frame = self.frame = CGRectMake(0, 20, 480, 300);
	[self setNeedsDisplay];
	
	
	label.text = info;

	
	//对于无需按钮交互的信息
	if (buttonTitle == nil) {
		[self performSelector:@selector(fadeOut:) withObject:nil afterDelay:1.5];
		[button setHidden:YES];
	}else {
		[button setTitle:buttonTitle forState:UIControlStateNormal];
		button.hidden = NO;
		[activityIndicator startAnimating];
		NSLog(@"%@",button);
	}

	backView.hidden = NO;
	
	[self showUp];
}



- (void)stopSpinWithInfo:(NSString *)info withButtonTitle:(NSString *)buttonTitle
{
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
	[activityIndicator stopAnimating];
	label.text = info;
	
	//对于无需按钮交互的信息
	if (buttonTitle == nil) {
		[self performSelector:@selector(fadeOut:) withObject:nil afterDelay:0.5];
		[button setHidden:YES];
	}else {
		[button setTitle:buttonTitle forState:UIControlStateNormal];
		button.hidden = NO;
	}
	//布局按钮
	//[self layoutButton:arr InRect:CGRectMake(0, 110, 160, 45)];
	backView.hidden = YES;
	[self setNeedsDisplay];
	[self showUp];
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	NSLog(@"layout subviews");
	activityIndicator.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2-40);
	
	button.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2+45);
	label.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2+5);
	//处理旋转否则方块就变形了，必须重新画一下
	[self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
	//NSLog(@"draw rect[%f][%f]",rect.size.width,rect.size.height);
	CGFloat width = 160;
	CGFloat height = 160;
	
	CGRect centerRect = CGRectMake(
					(rect.origin.x + rect.size.width - width) / 2,
					(rect.origin.y + rect.size.height - height) / 2,
								   width, height);
	
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	UIColor* bgColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.618];
	[bgColor set];
	
	CGContextBeginPath(context);
    [self drawRoundedRect:centerRect inContext:context withSize:CGSizeMake(10,10)];
    CGContextFillPath(context);
}
#pragma mark private methods
- (void) drawRoundedRect:(CGRect) rect inContext:(CGContextRef)context withSize:(CGSize) size
{
	float ovalWidth = size.width;
	float ovalHeight = size.height;
	
    float fw, fh;
	
    if (ovalWidth == 0 || ovalHeight == 0) {// 1
        CGContextAddRect(context, rect);
        return;
    }
	
    CGContextSaveGState(context);// 2
	
    CGContextTranslateCTM (context, CGRectGetMinX(rect),// 3
						   CGRectGetMinY(rect));
    CGContextScaleCTM (context, ovalWidth, ovalHeight);// 4
    fw = CGRectGetWidth (rect) / ovalWidth;// 5
    fh = CGRectGetHeight (rect) / ovalHeight;// 6
	
    CGContextMoveToPoint(context, fw, fh/2); // 7
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);// 8
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);// 9
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);// 10
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // 11
    CGContextClosePath(context);// 12
	
    CGContextRestoreGState(context);// 13
	
}

- (void)showUp{	
	//backView.hidden = NO;
	[UIView beginAnimations:@"showUp" context:nil];
	[UIView setAnimationDuration:0.25];
	self.alpha = 1.0;
	[UIView commitAnimations];
}
- (void)fadeOut:(id)sender{
	UIButton *btn = (UIButton *)sender;	
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
	backView.hidden = YES;
	[UIView beginAnimations:@"fadeOut" context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationDelegate:self];
	//[UIView setAnimationDidStopSelector:@selector(hideBackView)];
	self.alpha = 0.0;
	[UIView commitAnimations];
	//如果view中有button
	if (btn && activeDelegate) {
		//NSString *df = btn.titleLabel.text;
		[activeDelegate buttonSelected:btn.titleLabel.text];
	}
}

@end