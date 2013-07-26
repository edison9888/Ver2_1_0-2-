//
//  FSTimerView.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-8.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSTimerView.h"
#import "FSConst.h"
#import <QuartzCore/QuartzCore.h>

#define A 6
#define B 5

@implementation FSTimerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _cornerRadius = 6.0;
        self.backgroundColor = COLOR_CLEAR;
        [self doSomethingAtInit];
    }
    return self;
}
/*

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    / *
	CGContextSaveGState(context);
	
    CGContextSetRGBFillColor(context, 200.0f / 255.0f, 200.0f / 255.0f, 200.0f / 255.0f, 1.0f);
	CGContextFillRect(context, rect);
	
    CGContextSetRGBStrokeColor(context, 220.0f / 255.0f, 220.0f / 255.0f, 220.0f / 255.0f, 1.0f);
        
	CGContextSetLineWidth(context, 2);
	CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
	CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect));
	CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
	CGContextAddLineToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));
	CGContextClosePath(context);
	CGContextStrokePath(context);
	
	CGContextRestoreGState(context);
    // ***********  ////
    
    
    CGRect rrect = CGRectZero;
	CGGradientRef gradient = NULL;
	CGColorSpaceRef rgb = NULL;
	
	const CGFloat *colors = CGColorGetComponents([UIColor darkGrayColor].CGColor);
	size_t colorNum = CGColorGetNumberOfComponents([UIColor darkGrayColor].CGColor);
	
	//	const CGFloat *colors = CGColorGetComponents(self.backGroundColor.CGColor);
	//	size_t colorNum = CGColorGetNumberOfComponents(self.backGroundColor.CGColor);
#ifdef MYDEBUG
	//NSLog(@"colorNum=%d", colorNum);
#endif
	CGFloat bgColors[4] = {1.0f, 1.0f, 1.0f, 1.0f};
	if (colorNum == 4) {
		bgColors[0] = colors[0];
		bgColors[1] = colors[1];
		bgColors[2] = colors[2];
		bgColors[3] = colors[3];
	} else if (colorNum == 2) {
		bgColors[0] = colors[0];
		bgColors[1] = colors[0];
		bgColors[2] = colors[0];
		bgColors[3] = colors[1];
	} else if (colorNum == 3) {
		bgColors[0] = colors[0];
		bgColors[1] = colors[1];
		bgColors[2] = colors[1];
		bgColors[3] = colors[2];
	} else {
		return;
	}
	
	const CGFloat *edgeColors = CGColorGetComponents([UIColor darkGrayColor].CGColor);
	size_t edgeColorNum = CGColorGetNumberOfComponents([UIColor darkGrayColor].CGColor);
	CGFloat edge_colors[4] = {1.0f, 1.0f, 1.0f, 1.0f};
#ifdef MYDEBUG
	//NSLog(@"self.edgeColor=%@", self.edgeColor);
	//NSLog(@"edgeColorNum=%d", edgeColorNum);
#endif	
	if (edgeColorNum == 4) {
		edge_colors[0] = edgeColors[0];
		edge_colors[1] = edgeColors[1];
		edge_colors[2] = edgeColors[2];
		edge_colors[3] = edgeColors[3];
	} else if (edgeColorNum == 2) {
		edge_colors[0] = edgeColors[0];
		edge_colors[1] = edgeColors[0];
		edge_colors[2] = edgeColors[0];
		edge_colors[3] = edgeColors[1];
	} else if (edgeColorNum == 3) {
		edge_colors[0] = edgeColors[0];
		edge_colors[1] = edgeColors[1];
		edge_colors[2] = edgeColors[1];
		edge_colors[3] = edgeColors[2];
	} else {
		edge_colors[0] = bgColors[0] + 50 / 255.0f;
		edge_colors[1] = bgColors[1] + 50 / 255.0f;
		edge_colors[2] = bgColors[2] + 50 / 255.0f;
		edge_colors[3] = 1.0f;
		if (edge_colors[0] > 1.0f) {
			edge_colors[0] = 1.0f;
		}
		
		if (edge_colors[1] > 1.0f) {
			edge_colors[1] = 1.0f;
		}
		if (edge_colors[2] > 1.0f) {
			edge_colors[2] = 1.0f;
		}
	}
	
	//STEP 1. 三角区域
#ifdef MYDEBUG
	NSLog(@"_cornerRadius=%f", _cornerRadius);
#endif
    ///  *
	CGContextSaveGState(context);
	CGContextSetRGBFillColor(context, bgColors[0], bgColors[1], bgColors[2], bgColors[3]);
    
	CGContextMoveToPoint(context, CGRectGetMinX(rect),CGRectGetMaxY(rect)/2);
	CGContextAddArcToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect)/2, CGRectGetMinX(rect), CGRectGetMinY(rect), _cornerRadius);
	CGContextAddArcToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect)/A*B, CGRectGetMinY(rect), _cornerRadius);
	CGContextAddArcToPoint(context, CGRectGetMaxX(rect)/A*B, CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMaxY(rect)/2, _cornerRadius);
	CGContextAddArcToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect)/2, CGRectGetMaxX(rect), CGRectGetMaxY(rect)/2, _cornerRadius);
	CGContextAddArcToPoint(context, CGRectGetMaxX(rect)/A*B, CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMaxY(rect), _cornerRadius);
    CGContextAddArcToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMaxY(rect)/2, _cornerRadius);
	
	CGContextAddLineToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect)/2);
    
	CGContextClosePath(context);
	CGContextFillPath(context);
	CGContextRestoreGState(context);
	
	
	
	//STEP 2.
	CGContextSaveGState(context);
	rrect = CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect), rect.size.width, rect.size.height / 2);
	CGContextMoveToPoint(context, CGRectGetMinX(rrect), CGRectGetMaxY(rrect));
	CGContextAddArcToPoint(context, CGRectGetMinX(rrect), CGRectGetMaxY(rrect), CGRectGetMinX(rrect), CGRectGetMinY(rrect), _cornerRadius);
    CGContextAddArcToPoint(context, CGRectGetMinX(rrect), CGRectGetMinY(rrect), CGRectGetMaxX(rrect)/A*B, CGRectGetMinY(rrect), _cornerRadius);
	CGContextAddArcToPoint(context, CGRectGetMaxX(rrect)/A*B, CGRectGetMinY(rrect), CGRectGetMaxX(rrect), CGRectGetMaxY(rrect), _cornerRadius);
	CGContextAddArcToPoint(context, CGRectGetMaxX(rrect), CGRectGetMaxY(rrect), CGRectGetMaxX(rrect), CGRectGetMaxY(rrect), _cornerRadius);
	CGContextAddArcToPoint(context, CGRectGetMaxX(rrect), CGRectGetMaxY(rrect), CGRectGetMinX(rrect), CGRectGetMaxY(rrect), _cornerRadius);
	CGContextAddLineToPoint(context, CGRectGetMinX(rrect), CGRectGetMaxY(rrect));
	CGContextClosePath(context);
	CGContextClip(context);
	CGFloat topColors[] = 
	{
		1.0f, 1.0f, 1.0f, 0.30,
		1.0f, 1.0f, 1.0f, 0.20,
		1.0f, 1.0f, 1.0f, 0.10
	};
	rgb = CGColorSpaceCreateDeviceRGB();
	gradient = CGGradientCreateWithColorComponents(rgb, topColors, NULL, sizeof(topColors) / (4 * sizeof(CGFloat)));
	CGContextDrawLinearGradient(context, gradient, CGPointMake(CGRectGetMidX(rrect), CGRectGetMinY(rrect)), CGPointMake(CGRectGetMidX(rrect), CGRectGetMaxY(rrect)) , 0);
	CGColorSpaceRelease(rgb);
	CGGradientRelease(gradient);
	CGContextRestoreGState(context);
    
	
	//STEP 3
	CGContextSaveGState(context);
	rrect = CGRectMake(CGRectGetMinX(rect), CGRectGetMidY(rect), rect.size.width, rect.size.height / 2);
	CGContextMoveToPoint(context, CGRectGetMinX(rrect), CGRectGetMaxY(rrect));
	CGContextAddArcToPoint(context, CGRectGetMinX(rrect), CGRectGetMinY(rrect), CGRectGetMaxX(rrect)/A*B, CGRectGetMinY(rrect), _cornerRadius);
	CGContextAddArcToPoint(context, CGRectGetMaxX(rrect)/A*B, CGRectGetMinY(rrect), CGRectGetMaxX(rrect), CGRectGetMaxY(rrect), _cornerRadius);
	CGContextAddArcToPoint(context, CGRectGetMaxX(rrect), CGRectGetMaxY(rrect), CGRectGetMaxX(rrect), CGRectGetMaxY(rrect), _cornerRadius);
	CGContextAddArcToPoint(context, CGRectGetMaxX(rrect), CGRectGetMaxY(rrect), CGRectGetMinX(rrect), CGRectGetMaxY(rrect), _cornerRadius);
	CGContextAddLineToPoint(context, CGRectGetMinX(rrect), CGRectGetMaxY(rrect));
	CGContextClosePath(context);
	CGContextClip(context);
	CGFloat bottomColors[] = 
	{
		0.0f, 0.0f, 0.0f, 0.05,
		0.0f, 0.0f, 0.0f, 0.03,
		0.0f, 0.0f, 0.0f, 0.0
	};
	rgb = CGColorSpaceCreateDeviceRGB();
	gradient = CGGradientCreateWithColorComponents(rgb, bottomColors, NULL, sizeof(bottomColors) / (4 * sizeof(CGFloat)));
	CGContextDrawLinearGradient(context, gradient, CGPointMake(CGRectGetMidX(rrect), CGRectGetMinY(rrect)), CGPointMake(CGRectGetMidX(rrect), CGRectGetMaxY(rrect)) , 0);
	CGColorSpaceRelease(rgb);
	CGGradientRelease(gradient);
	CGContextRestoreGState(context);
    // * /
	
	//STEP 4
	CGContextSaveGState(context);
	rrect = CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect), rect.size.width, rect.size.height / 2);
	CGContextMoveToPoint(context, CGRectGetMinX(rrect), CGRectGetMaxY(rrect));
	CGContextAddArcToPoint(context, CGRectGetMinX(rrect), CGRectGetMaxY(rrect), CGRectGetMaxX(rrect)/A*B, CGRectGetMinY(rrect), _cornerRadius);
	CGContextAddArcToPoint(context, CGRectGetMaxX(rrect)/A*B, CGRectGetMinY(rrect), CGRectGetMaxX(rrect), CGRectGetMaxY(rrect), _cornerRadius);
	CGContextAddArcToPoint(context, CGRectGetMaxX(rrect), CGRectGetMaxY(rrect), CGRectGetMaxX(rrect), CGRectGetMaxY(rrect), _cornerRadius);
	CGContextAddArcToPoint(context, CGRectGetMaxX(rrect), CGRectGetMaxY(rrect), CGRectGetMinX(rrect), CGRectGetMaxY(rrect), _cornerRadius);
	CGContextAddLineToPoint(context, CGRectGetMinX(rrect), CGRectGetMaxY(rrect));
	CGContextClosePath(context);
	CGContextClip(context);
	CGFloat lightColors4[] = 
	{
		1.0f, 1.0f, 1.0f, 0.0,
		1.0f, 1.0f, 1.0f, 0.1,
		1.0f, 1.0f, 1.0f, 0.14,
		1.0f, 1.0f, 1.0f, 0.2
	};
	
	rgb = CGColorSpaceCreateDeviceRGB();
	gradient = CGGradientCreateWithColorComponents(rgb, lightColors4, NULL, sizeof(lightColors4) / (4 * sizeof(CGFloat)));
	CGContextDrawRadialGradient(context, gradient, CGPointMake(CGRectGetMidX(rrect), CGRectGetMaxY(rrect)), rrect.size.height, CGPointMake(CGRectGetMidX(rrect), CGRectGetMinY(rrect)), 0, 0);
	CGColorSpaceRelease(rgb);
	CGGradientRelease(gradient);
	CGContextRestoreGState(context);
	
	//STEP 5
    rrect = CGRectMake(CGRectGetMinX(rect), CGRectGetMidY(rect), rect.size.width, rect.size.height/2);
	CGContextSaveGState(context);
	CGContextMoveToPoint(context, CGRectGetMinX(rrect), CGRectGetMinY(rrect));
	CGContextAddArcToPoint(context, CGRectGetMinX(rrect), CGRectGetMinY(rrect), CGRectGetMaxX(rrect), CGRectGetMinY(rrect), _cornerRadius);
	CGContextAddArcToPoint(context, CGRectGetMaxX(rrect), CGRectGetMinY(rrect), CGRectGetMaxX(rrect), CGRectGetMaxY(rrect), _cornerRadius);
	CGContextAddArcToPoint(context, CGRectGetMaxX(rrect), CGRectGetMaxY(rrect), CGRectGetMinX(rrect), CGRectGetMaxY(rrect), _cornerRadius);
	CGContextAddArcToPoint(context, CGRectGetMinX(rrect), CGRectGetMaxY(rrect), CGRectGetMinX(rrect), CGRectGetMinY(rrect), _cornerRadius);
	CGContextAddLineToPoint(context, CGRectGetMinX(rrect), CGRectGetMinY(rrect));
	CGContextClosePath(context);
	CGContextClip(context);
	CGFloat lightColors[] = 
	{
		1.0f, 1.0f, 1.0f, 0.0,
		1.0f, 1.0f, 1.0f, 0.1,
		1.0f, 1.0f, 1.0f, 0.14,
		1.0f, 1.0f, 1.0f, 0.2
	};
	
	rgb = CGColorSpaceCreateDeviceRGB();
	gradient = CGGradientCreateWithColorComponents(rgb, lightColors, NULL, sizeof(lightColors) / (4 * sizeof(CGFloat)));
	CGContextDrawRadialGradient(context, gradient, CGPointMake(CGRectGetMidX(rrect), CGRectGetMinY(rrect)), rrect.size.height, CGPointMake(CGRectGetMidX(rrect), CGRectGetMaxY(rrect)), 0, 0);
	CGColorSpaceRelease(rgb);
	CGGradientRelease(gradient);
	CGContextRestoreGState(context);
	
    
	
	//STEP 6
	rrect= CGRectMake(rect.origin.x + 1, rect.origin.y + 1, rect.size.width - 2, rect.size.height - 2);
	
	CGContextSaveGState(context);
	CGContextSetRGBStrokeColor(context, edge_colors[0], edge_colors[1], edge_colors[2], edge_colors[3]);
	CGContextSetLineWidth(context, 1.2);
	
	CGContextMoveToPoint(context, CGRectGetMinX(rrect),CGRectGetMaxY(rrect)/2);
	CGContextAddArcToPoint(context, CGRectGetMinX(rrect), CGRectGetMaxY(rrect)/2, CGRectGetMinX(rrect), CGRectGetMinY(rrect), _cornerRadius);
	CGContextAddArcToPoint(context, CGRectGetMinX(rrect), CGRectGetMinY(rrect), CGRectGetMaxX(rrect)/A*B, CGRectGetMinY(rrect), _cornerRadius);
	CGContextAddArcToPoint(context, CGRectGetMaxX(rrect)/A*B, CGRectGetMinY(rrect), CGRectGetMaxX(rrect), CGRectGetMaxY(rrect)/2, _cornerRadius);
	CGContextAddArcToPoint(context, CGRectGetMaxX(rrect), CGRectGetMaxY(rrect)/2, CGRectGetMaxX(rect), CGRectGetMaxY(rrect)/2, _cornerRadius);
	CGContextAddArcToPoint(context, CGRectGetMaxX(rrect)/A*B, CGRectGetMaxY(rrect), CGRectGetMinX(rrect), CGRectGetMaxY(rrect), _cornerRadius);
    CGContextAddArcToPoint(context, CGRectGetMinX(rrect), CGRectGetMaxY(rrect), CGRectGetMinX(rrect), CGRectGetMaxY(rrect)/2, _cornerRadius);
	
	CGContextAddLineToPoint(context, CGRectGetMinX(rrect), CGRectGetMaxY(rrect)/2);
	CGContextClosePath(context);
	CGContextDrawPath(context, kCGPathStroke);
	CGContextRestoreGState(context);
	
	//STEP 7
	CGContextSaveGState(context);
	CGContextSetRGBStrokeColor(context, 1.0f, 1.0f, 1.0f, 0.16f);
	CGContextSetLineWidth(context, 1.2);
	rrect = CGRectMake(CGRectGetMinX(rect) + 1, CGRectGetMidY(rect), rect.size.width - 2, rect.size.height / 2 - 1);
	CGFloat startY = rect.origin.y + _cornerRadius * 1.5;
	if (startY > CGRectGetMaxX(rect)) {
		startY = CGRectGetMaxY(rect)/2 - 2;
	}
	CGContextMoveToPoint(context, CGRectGetMaxX(rrect), startY);
	
	CGContextAddArcToPoint(context, CGRectGetMaxX(rrect)/A*B, CGRectGetMaxY(rrect), CGRectGetMinX(rrect), CGRectGetMaxY(rrect), _cornerRadius);
	CGContextAddArcToPoint(context, CGRectGetMinX(rrect), CGRectGetMaxY(rrect), CGRectGetMinX(rrect), CGRectGetMaxY(rrect)/2, _cornerRadius);
	
	CGContextAddLineToPoint(context, CGRectGetMinX(rrect), CGRectGetMaxY(rrect)/2);
	
	CGContextDrawPath(context, kCGPathStroke);
	CGContextRestoreGState(context);
     
     
}
 
 */


-(void)dealloc{
    [self doSomethingAtDealloc];
    
    [super dealloc];
}


-(void)doSomethingAtInit{
    _lab_time = [[UILabel alloc] initWithFrame:self.frame];
    _lab_time.backgroundColor = COLOR_CLEAR;
    _lab_time.textColor = COLOR_BLACK;
    _lab_time.textAlignment = UITextAlignmentCenter;
    _lab_time.numberOfLines = 1;
    _lab_time.font = [UIFont systemFontOfSize:10];
    //self.backgroundColor = [UIColor W];
    
    _clockbgimage = [[UIImageView alloc] init];
    _clockbgimage.image = [UIImage imageNamed:@"Ftiame_beijing.png"];
    
    _clockMinImage = [[UIImageView alloc] init];
    _clockMinImage.image = [UIImage imageNamed:@"Ftiame_fenzhen.png"];
    
    _clockHourImage = [[UIImageView alloc] init];
    _clockHourImage.image = [UIImage imageNamed:@"Ftiame_shizhen.png"];
    
    //_clockMinImage.contentMode = UIViewContentModeScaleAspectFit;
    [_clockMinImage layer].transform = CATransform3DMakeRotation(M_PI, 0.0f, 0.0f, 0.0f);
    [_clockHourImage layer].transform = CATransform3DMakeRotation(M_PI, 0.0f, 0.0f, 0.0f);
    [self addSubview:_clockbgimage];
    [self addSubview:_clockMinImage];
    [self addSubview:_clockHourImage];
    [self addSubview:_lab_time];
    
    _clockbgimage.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _clockMinImage.frame = CGRectMake(16.5-5, 11.7-5, 10, 10);
    _clockHourImage.frame = CGRectMake(16.5-5, 11.7-5, 10, 10);
    _lab_time.frame = CGRectMake(0, 22, 32, self.frame.size.height-22);
}

-(void)doSomethingAtDealloc{
    [_lab_time release];
    [_clockMinImage release];
    [_clockbgimage release];
    [_clockHourImage release];
}

-(void)layoutSubviews{
    
    ;
}

-(void)setTimer:(NSString *)time{
    
   //旋转值 0 - 6.25 一个循环
     //NSLog(@"time:%@",time);
    
    NSString *timeStr = [time substringFromIndex:11];
    NSString *h = [timeStr substringToIndex:2];
    NSString *m = [time substringFromIndex:14];
    
    NSInteger hhh = [h integerValue]%12;
    
    CGFloat hh = 6.25f/12*hhh;
    
    CGFloat mm = 6.25f/60*[m floatValue];
    
    //NSLog(@"hh:%f  mm:%f",hh,mm);
    
    _lab_time.text = timeStr;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    
    [_clockMinImage setNeedsDisplay];
    [_clockMinImage layer].transform = CATransform3DMakeRotation(mm, 0.0f, 0.0f, 1.0f);
    [_clockHourImage setNeedsDisplay];
    [_clockHourImage layer].transform = CATransform3DMakeRotation(hh, 0.0f, 0.0f, 1.0f);
    [UIView commitAnimations];
   
   
}


@end
