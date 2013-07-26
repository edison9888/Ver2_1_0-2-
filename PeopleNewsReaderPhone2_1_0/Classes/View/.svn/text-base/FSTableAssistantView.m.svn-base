//
//  FSTableAssistantView.m
//  PeopleDailyReader
//
//  Created by people.com.cn on 12-3-14.
//  Copyright 2012 people.com.cn. All rights reserved.
///////////////////////////////////////////////////////////////////
//	自定义单元格助手
///////////////////////////////////////////////////////////////////
//	日期				做成者			版本
///////////////////////////////////////////////////////////////////
//	2012-03-14		chen.gsh		1.0.0
//－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－

#import "FSTableAssistantView.h"
#import "FSCommonFunction.h"

#define ASSISTANT_LEFT_SPACE 8.0f
#define ASSISTANT_COL_SPACE 1.0f

#define ASSISTANT_TOP_BOTTOM_SPACE 10.0f
#define ASSISTANT_ROW_SPACE 2.0f
#define ASSISTANT_ARROW_WIDTH 16.0f
#define ASSISTANT_ARROW_HEIGHT 36.0f

@interface FSTableAssistantView(PrivateMethod)
- (UIImage *)arrowImageWithDirector:(AssistantArrowDirection)direction;
- (void)layoutViews_Inner;
- (void)layoutLabels;
@end

@implementation FSTableAssistantView
@synthesize dragState = _dragState;
@synthesize assistantArrowDirection = _assistantArrowDirection;
@synthesize parentDelegate = _parentDelegate;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		
		_oldSize = CGSizeZero;
		_dragState = dsUnknow;
		
		_ivArrow = [[UIImageView alloc] initWithFrame:CGRectZero];
		self.assistantArrowDirection = aadUnknow;
		//[self addSubview:_ivArrow];
		
		_activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        
		[self addSubview:_activityView];
		
		_lblMessage = [[UILabel alloc] initWithFrame:CGRectZero];
		[_lblMessage setBackgroundColor:[UIColor clearColor]];
		[_lblMessage setFont:[UIFont boldSystemFontOfSize:14.0f]];
		[_lblMessage setTextColor:[UIColor blackColor]];
		[_lblMessage setTextAlignment:UITextAlignmentCenter];
		[self addSubview:_lblMessage];
		
		_lblUpdateInfo = [[UILabel alloc] initWithFrame:CGRectZero];
		[_lblUpdateInfo setBackgroundColor:[UIColor clearColor]];
		[_lblUpdateInfo setFont:[UIFont systemFontOfSize:12.0f]];
		[_lblUpdateInfo setTextColor:[UIColor grayColor]];
		[_lblUpdateInfo setTextAlignment:UITextAlignmentCenter];
		[self addSubview:_lblUpdateInfo];
		
		[pool release];
    }
    return self;
}

- (void) layoutSubviews {
	[super layoutSubviews];
	if (!CGSizeEqualToSize(self.frame.size, _oldSize)) {
		_oldSize = self.frame.size;
		[self layoutViews_Inner];
	}
}

////////////////////////////////////////////////////
//	设置当前的拖拽状态
////////////////////////////////////////////////////
- (void)setDragState:(DragState)value {
	if (value != _dragState) {
		_dragState = value;
		
		//拖拽的文本信息
		if ([_parentDelegate respondsToSelector:@selector(tableAssistantViewText:withDragState:)]) {
			_lblMessage.text = [_parentDelegate tableAssistantViewText:self withDragState:_dragState];
		}
		
		//更新的文本信息
		if ([_parentDelegate respondsToSelector:@selector(tableAssistantUpdateText:)]) {
			_lblUpdateInfo.text = [_parentDelegate tableAssistantUpdateText:self];
		}
		//重新布局
		[self layoutLabels];
		
		//状态
		if (value == dsNormal) {
			if ([_activityView isAnimating]) {
				[_activityView stopAnimating];
			}
			_ivArrow.hidden = NO;
			[UIView beginAnimations:@"NormalAnimation" context:nil];
			_ivArrow.transform = CGAffineTransformIdentity;
			[UIView setAnimationCurve:0.3];
			[UIView commitAnimations];
		} else if (value == dsPulling) {
			if ([_activityView isAnimating]) {
				[_activityView stopAnimating];
			}
			_ivArrow.hidden = NO;
			[UIView beginAnimations:@"PullAnimation" context:nil];
			_ivArrow.transform = CGAffineTransformMakeRotation(M_PI);
			[UIView setAnimationCurve:0.3];
			[UIView commitAnimations];
		} else if (value == dsLoadding) {
			_ivArrow.transform = CGAffineTransformIdentity;
			_ivArrow.hidden = YES;
			[_activityView startAnimating];
		} else {
			if ([_activityView isAnimating]) {
				[_activityView stopAnimating];
			}
			_ivArrow.hidden = NO;
			[UIView beginAnimations:@"NormalAnimation" context:nil];
			_ivArrow.transform = CGAffineTransformIdentity;
			[UIView setAnimationCurve:0.3];
			[UIView commitAnimations];
		}
	}
}

- (void)resetDragState {
	if ([_activityView isAnimating]) {
		[_activityView stopAnimating];
	}
	_ivArrow.hidden = NO;
	_ivArrow.transform = CGAffineTransformIdentity;
}

////////////////////////////////////////////////////
//	设置箭头方向
////////////////////////////////////////////////////
- (void)setAssistantArrowDirection:(AssistantArrowDirection)value {
	if (value != _assistantArrowDirection) {
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		
		_assistantArrowDirection = value;
        
		//_ivArrow.image = [self arrowImageWithDirector:_assistantArrowDirection];
		
		[pool release];
	}
}

- (void)dealloc {
#ifdef MYDEBUG
	NSLog(@"FSTableAssistantView.dealloc:%@", self);
#endif
	[_activityView release];
	[_ivArrow release];
	[_lblMessage release];
	[_lblUpdateInfo release];
    [super dealloc];
}

////////////////////////////////////////////////////
//	绘制需要的箭头
////////////////////////////////////////////////////
- (UIImage *)arrowImageWithDirector:(AssistantArrowDirection)direction {
	if (direction == aadUnknow) {
		return nil;
	}
	
	UIImage *image = nil;
	
	CGRect rect = CGRectMake(0.0f, 0.0f, ASSISTANT_ARROW_WIDTH, ASSISTANT_ARROW_HEIGHT);
	CGFloat arrowHeight = rect.size.height / 3.0f;
	CGFloat leftRightSpace = rect.size.width / 4.0f;
	
	//STEP 1.构建上下文
	CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, 
												 rect.size.width, 
												 rect.size.height, 
												 8,
												 0,
												 rgb, 
												 (kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Little));
	
	
	
	
	
	
	
	//STEP 3.绘制图形
	CGFloat colors[] = 
	{
		30.0f / 255.0f, 30.0f / 255.0f, 30.0f / 255.0f, 1.0f,
		30.0f / 255.0f, 30.0f / 255.0f, 30.0f / 255.0f, 0.90,
		30.0f / 255.0f, 30.0f / 255.0f, 30.0f / 255.0f, 0.80,
		30.0f / 255.0f, 30.0f / 255.0f, 30.0f / 255.0f, 0.70,
		30.0f / 255.0f, 30.0f / 255.0f, 30.0f / 255.0f, 0.55,
		30.0f / 255.0f, 30.0f / 255.0f, 30.0f / 255.0f, 0.40,
		30.0f / 255.0f, 30.0f / 255.0f, 30.0f / 255.0f, 0.25,
		30.0f / 255.0f, 30.0f / 255.0f, 30.0f / 255.0f, 0.05,
		30.0f / 255.0f, 30.0f / 255.0f, 30.0f / 255.0f, 0.0,
	};
	
	CGGradientRef gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors) / (4 * sizeof(CGFloat)));
	
	if (direction == aadBottom) {
		CGContextSaveGState(context);
		CGContextMoveToPoint(context, CGRectGetMidX(rect), CGRectGetMinY(rect));
		CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect) + arrowHeight);
		CGContextAddLineToPoint(context, CGRectGetMaxX(rect) - leftRightSpace, CGRectGetMinY(rect) + arrowHeight);
		CGContextAddLineToPoint(context, CGRectGetMaxX(rect) - leftRightSpace, CGRectGetMaxY(rect));
		CGContextAddLineToPoint(context, CGRectGetMinX(rect) + leftRightSpace, CGRectGetMaxY(rect));
		CGContextAddLineToPoint(context, CGRectGetMinX(rect) + leftRightSpace, CGRectGetMinY(rect) + arrowHeight);
		CGContextAddLineToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect) + arrowHeight);
		CGContextClosePath(context);
		CGContextClip(context);
		CGContextDrawLinearGradient(context, 
									gradient, 
									CGPointMake(CGRectGetMidX(rect), 
												CGRectGetMinY(rect)), 
									CGPointMake(CGRectGetMidX(rect), 
												CGRectGetMaxY(rect)), 
									0);
		
		CGContextRestoreGState(context);
	} else if (direction == aadTop) {
		CGContextSaveGState(context);
		CGContextMoveToPoint(context, CGRectGetMidX(rect), CGRectGetMaxY(rect));
		CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect) - arrowHeight);
		CGContextAddLineToPoint(context, CGRectGetMaxX(rect) - leftRightSpace, CGRectGetMaxY(rect) - arrowHeight);
		CGContextAddLineToPoint(context, CGRectGetMaxX(rect) - leftRightSpace, CGRectGetMinY(rect));
		CGContextAddLineToPoint(context, CGRectGetMinX(rect) + leftRightSpace, CGRectGetMinY(rect));
		CGContextAddLineToPoint(context, CGRectGetMinX(rect) + leftRightSpace, CGRectGetMaxY(rect) - arrowHeight);
		CGContextAddLineToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect) - arrowHeight);
		CGContextClosePath(context);
		CGContextClip(context);
		CGContextDrawLinearGradient(context, 
									gradient, 
									CGPointMake(CGRectGetMidX(rect), 
												CGRectGetMaxY(rect)), 
									CGPointMake(CGRectGetMidX(rect), 
												CGRectGetMinY(rect)), 
									0);
		
		CGContextRestoreGState(context);
	}

	CGGradientRelease(gradient);
	
	//STEP 3.2构建UIImage对象
	CGImageRef imageRef = CGBitmapContextCreateImage(context);
	image = [UIImage imageWithCGImage:imageRef];
#ifdef MYDEBUG
	//[UIImagePNGRepresentation(image) writeToFile:[[[GlobalConfig shareConfig] getDocumentPath] stringByAppendingPathComponent:@"2.png"] atomically:YES];
#endif
	CGImageRelease(imageRef);
	
	//STEP 3.3恢复状态
	
	
	//STEP 4.释放资源
	CGContextRelease(context);
	CGColorSpaceRelease(rgb);
	
	
	return image;
}

////////////////////////////////////////////////////
//	仅仅在frame发生改变的时候调用
////////////////////////////////////////////////////
- (void)layoutViews_Inner {
	//STEP 1.ImageWidth
	CGFloat imageWidth = ASSISTANT_ARROW_HEIGHT;//self.frame.size.height;
	_activityView.frame = CGRectMake((imageWidth - _activityView.frame.size.width) / 2.0f, 
									 (self.frame.size.height - _activityView.frame.size.height) / 2.0f, 
									 _activityView.frame.size.width, 
									 _activityView.frame.size.height);
	
	_ivArrow.frame = CGRectMake((imageWidth - _ivArrow.image.size.width) / 2.0f, 
								(self.frame.size.height - _ivArrow.image.size.height) / 2.0f, 
								_ivArrow.image.size.width, 
								_ivArrow.image.size.height);
	
	//STEP 2.TextWidth
	CGFloat textWidth = self.frame.size.width - imageWidth * 2.0f - ASSISTANT_COL_SPACE;
	CGFloat textHeight = (self.frame.size.height - ASSISTANT_ROW_SPACE  - ASSISTANT_TOP_BOTTOM_SPACE * 2.0f) / 2.0f;
	CGFloat textLeft = imageWidth + ASSISTANT_COL_SPACE;
	CGFloat textTop = ASSISTANT_TOP_BOTTOM_SPACE;
	
	_lblMessage.frame = roundToRect(CGRectMake(textLeft, textTop, textWidth, textHeight));
	textTop += (ASSISTANT_ROW_SPACE + textHeight);
	_lblUpdateInfo.frame = roundToRect(CGRectMake(textLeft, textTop, textWidth, textHeight));
	
}

////////////////////////////////////////////////////
//	每次取数据都要调用
////////////////////////////////////////////////////
- (void)layoutLabels {
    
    
    
    if (_assistantArrowDirection == aadBottom) {
        _lblMessage.textColor = [UIColor whiteColor];
        _lblUpdateInfo.textColor = [UIColor whiteColor];
    }
    else{
        
        _lblMessage.textColor = [UIColor blackColor];
    }
    
    
	CGFloat top = ASSISTANT_TOP_BOTTOM_SPACE;
	CGFloat textHeight = 0.0f;
	
	CGSize sizeTmp = CGSizeZero;
	CGRect rect = CGRectZero;
	sizeTmp = [_lblMessage.text sizeWithFont:_lblMessage.font];
	rect = _lblMessage.frame;
	rect.size.height = sizeTmp.height;
	_lblMessage.frame = rect;
	textHeight += sizeTmp.height;
	
	sizeTmp = [_lblUpdateInfo.text sizeWithFont:_lblUpdateInfo.font];
	textHeight += ([_lblUpdateInfo.text isEqualToString:@""] ? 0.0f : sizeTmp.height);
//#ifdef MYDEBUG
//	NSLog(@"textHeight:%f", textHeight);
//#endif
	rect = _lblUpdateInfo.frame;
	rect.size.height = sizeTmp.height;
	_lblUpdateInfo.frame = rect;
	
	top = (self.frame.size.height - textHeight - ASSISTANT_ROW_SPACE) / 2.0f;
	rect = _lblMessage.frame;
	rect.origin.y = top;
	_lblMessage.frame = rect;
	
	rect = _lblUpdateInfo.frame;
	rect.origin.y = top + _lblMessage.frame.size.height + ASSISTANT_ROW_SPACE;
	_lblUpdateInfo.frame = rect;
}


@end
