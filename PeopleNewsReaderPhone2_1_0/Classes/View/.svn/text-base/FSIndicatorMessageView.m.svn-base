//
//  FSIndicatorMessageView.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-8.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSIndicatorMessageView.h"
#import "FSGraphicsEx.h"
#import "FSCommonFunction.h"

#define FS_INDICATOR_MESSAGE_VIEW__TAG 8912

#define FS_INDICATOR_MESSAGE_VIEW__WIDTH ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 240 : 160) + FS_INDICATOR_MESSAGE_VIEW__ROUND_SPACE * 2.0f)
#define FS_INDICATOR_MESSAGE_VIEW__HEIGHT ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 136 : 90) + FS_INDICATOR_MESSAGE_VIEW__ROUND_SPACE * 2.0f)

#define FS_INDICATOR_MESSAGE_VIEW__ROUND_SPACE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 20.0f : 14.0f)
#define FS_INDICATOR_MESSAGE_VIEW__RADIUS (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 12.0f : 8.0f)
#define FS_INDICATOR_MESSAGE_VIEW__LEFT_RIGHT_SPACE 4.0f
#define FS_INDICATOR_MESSAGE_VIEW__ROW_SPACE 8.0f
#define FS_INDICATOR_MESSAGE_VIEW__TOP_BOTTOM_SAPCE 8.0f
#define FS_INDICATOR_MESSAGE_VIEW__FONTSIZE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 16.0f : 14.0f)

@interface FSIndicatorMessageView(PrivateMethod)
- (UIImage *)drawIndicatorViewBackgroundImageWithRect:(CGRect)rect;
- (void)inner_layoutSubviews;
- (UILabel *)labelMessage;
- (UIActivityIndicatorView *)activityIndicatorView;
@end


@implementation FSIndicatorMessageView


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		
//		_backgroundLayer = [[CALayer alloc] init];
//		[self.layer addSublayer:_backgroundLayer];
		
		self.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:75.0f / 255.0f green:75.0f / 255.0f blue:75.0f / 255.0f alpha:0.80f];
		
		_lblMessage = [[UILabel alloc] initWithFrame:CGRectZero];
		[_lblMessage setBackgroundColor:[UIColor clearColor]];
		[_lblMessage setFont:[UIFont boldSystemFontOfSize:FS_INDICATOR_MESSAGE_VIEW__FONTSIZE]];
		[_lblMessage setTextAlignment:UITextAlignmentCenter];
		[_lblMessage setTextColor:[UIColor darkGrayColor]];
		[_lblMessage setNumberOfLines:10];
		[self addSubview:_lblMessage];
		
		_indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		[self addSubview:_indicator];
		
		self.alpha = 0.0f;
		self.tag = FS_INDICATOR_MESSAGE_VIEW__TAG;
		self.layer.shadowOffset = CGSizeZero;
		self.layer.shadowColor = [UIColor blackColor].CGColor;
		
		self.layer.cornerRadius = FS_INDICATOR_MESSAGE_VIEW__RADIUS;
		self.layer.shadowOpacity = 0.6;
		self.layer.shadowRadius = FS_INDICATOR_MESSAGE_VIEW__RADIUS;
		
		[pool release];
    }
    return self;
}

- (void)dealloc {
	[_indicator release];
	[_lblMessage release];
//	[_backgroundLayer release];
    [super dealloc];
}

- (UIImage *)drawIndicatorViewBackgroundImageWithRect:(CGRect)rect {
	UIImage *image = nil;
	
	UIColor *fillBorderColoor = [[UIColor alloc] initWithRed:45.0f / 255.0f green:45.0f / 255.0f blue:45.0f / 255.0f alpha:0.75];
	image = drawBackgroundImageWithRoundRect(rect, 
											 FS_INDICATOR_MESSAGE_VIEW__ROUND_SPACE, 
											 FS_INDICATOR_MESSAGE_VIEW__RADIUS, 
											 fillBorderColoor.CGColor, 
											 fillBorderColoor.CGColor);
	[fillBorderColoor release];
	
	return image;

}

- (UILabel *)labelMessage {
	return _lblMessage;
}
- (UIActivityIndicatorView *)activityIndicatorView {
	return _indicator;
}

- (void)showIndicatorMessageViewInView:(UIView *)parentView withMessage:(NSString *)message {
	FSIndicatorMessageView *indicatorMessageView = [FSIndicatorMessageView getIndicatorMessageViewInView:parentView];
	if (indicatorMessageView != nil) {
		[indicatorMessageView labelMessage].text = message;
		[indicatorMessageView inner_layoutSubviews];
		return;
	}
	[self retain];
//	//使用gcd来延迟文件读写操作
//	dispatch_queue_t queue = dispatch_queue_create("net.ifreework.www_FSIndicatorMessageView", NULL);
//	dispatch_async(queue, ^(void) {
//		NSString *imageFileName = [getCustomDrawImagePath() stringByAppendingPathComponent:[NSStringFromClass([FSIndicatorMessageView class]) stringByAppendingString:@".png"]];
//		UIImage *backgroundImage = nil;
//		if ([[NSFileManager defaultManager] fileExistsAtPath:imageFileName]) {
//			backgroundImage = [UIImage imageWithContentsOfFile:imageFileName];
//#ifdef MYDEBUG
//			NSLog(@"从文件获取背景图");
//#endif
//		} else {
//			backgroundImage = [self drawIndicatorViewBackgroundImageWithRect:CGRectMake(0.0f, 0.0f, FS_INDICATOR_MESSAGE_VIEW__WIDTH, FS_INDICATOR_MESSAGE_VIEW__HEIGHT)];
//			NSData *imageData = UIImagePNGRepresentation(backgroundImage);
//			[imageData writeToFile:imageFileName atomically:YES];
//		}
//		
//		dispatch_async(dispatch_get_main_queue(), ^(void) {
//			_lblMessage.text = message;
////			_backgroundLayer.frame = CGRectMake(0.0f, 0.0f, FS_INDICATOR_MESSAGE_VIEW__WIDTH, FS_INDICATOR_MESSAGE_VIEW__HEIGHT);
////			_backgroundLayer.contents = (id)backgroundImage.CGImage;
//			self.frame = CGRectMake(0.0f, 0.0f, FS_INDICATOR_MESSAGE_VIEW__WIDTH, FS_INDICATOR_MESSAGE_VIEW__HEIGHT);
//			[parentView addSubview:self];
//			
//			[self inner_layoutSubviews];
//			
//			[UIView beginAnimations:nil context:nil];
//			self.alpha = 1.0f;
//			[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
//			[UIView setAnimationDuration:0.3];
//			[UIView commitAnimations];
//			
//			
//		});
//	});
//	dispatch_release(queue);
	_lblMessage.text = message;
	//self.frame = CGRectMake(0.0f, 0.0f, FS_INDICATOR_MESSAGE_VIEW__WIDTH, FS_INDICATOR_MESSAGE_VIEW__HEIGHT);
	[parentView addSubview:self];
	
	[self inner_layoutSubviews];
	
	[UIView beginAnimations:nil context:nil];
	self.alpha = 1.0f;
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	[UIView setAnimationDuration:0.3];
	[UIView commitAnimations];
}

+ (FSIndicatorMessageView *)getIndicatorMessageViewInView:(UIView *)parentView {
	FSIndicatorMessageView *indicatorMessageView = nil;
	if (parentView != nil) {
		UIView *childView = [parentView viewWithTag:FS_INDICATOR_MESSAGE_VIEW__TAG];
		if (childView != nil && [childView isKindOfClass:[FSIndicatorMessageView class]]) {
			indicatorMessageView = (FSIndicatorMessageView *)childView;
		}
	}
	return indicatorMessageView;
}

+ (BOOL)dismissIndicatorMessageViewInView:(UIView *)parentView {
	BOOL rst = YES;
	FSIndicatorMessageView *indicatorMessageView = [FSIndicatorMessageView getIndicatorMessageViewInView:parentView];
	if (indicatorMessageView != nil) {
		indicatorMessageView.tag = 0;
		[UIView beginAnimations:nil context:NULL];
		indicatorMessageView.alpha = 0.0f;
		[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
		[UIView setAnimationDelegate:indicatorMessageView];
		[UIView setAnimationDidStopSelector:@selector(animationDidStopForDismiss)];
		[UIView commitAnimations];
		//[indicatorMessageView removeFromSuperview];
	} else {
		rst = NO;
	}

	return rst;
}

- (void)animationDidStopForDismiss {
	[self removeFromSuperview];
	[self release];
}

+ (void)layoutIndicatorMessageViewInView:(UIView *)parentView {
	FSIndicatorMessageView *indicatorMessageView = [FSIndicatorMessageView getIndicatorMessageViewInView:parentView];
	indicatorMessageView.center = CGPointMake(parentView.frame.size.width / 2.0f, parentView.frame.size.height / 2.0f);
}

- (void)inner_layoutSubviews {	
	//优化这块
	CGFloat clientHeight = FS_INDICATOR_MESSAGE_VIEW__HEIGHT - _indicator.frame.size.height - FS_INDICATOR_MESSAGE_VIEW__ROUND_SPACE * 2.0f - FS_INDICATOR_MESSAGE_VIEW__ROW_SPACE - FS_INDICATOR_MESSAGE_VIEW__TOP_BOTTOM_SAPCE * 2.0f;
//	CGFloat clientHeight = _indicator.frame.size.height 
	
	CGFloat clientWith = FS_INDICATOR_MESSAGE_VIEW__WIDTH - FS_INDICATOR_MESSAGE_VIEW__ROUND_SPACE * 2.0f - FS_INDICATOR_MESSAGE_VIEW__LEFT_RIGHT_SPACE * 2.0f;
	
	CGSize sizeTmp = [_lblMessage.text sizeWithFont:_lblMessage.font 
								  constrainedToSize:CGSizeMake(clientWith, clientHeight) 
									  lineBreakMode:_lblMessage.lineBreakMode];
	
	clientHeight = _indicator.frame.size.height + FS_INDICATOR_MESSAGE_VIEW__TOP_BOTTOM_SAPCE * 2.0f + FS_INDICATOR_MESSAGE_VIEW__ROW_SPACE + FS_INDICATOR_MESSAGE_VIEW__ROUND_SPACE * 2.0f;
	
	self.frame = CGRectMake(0.0f, 0.0f, FS_INDICATOR_MESSAGE_VIEW__WIDTH, clientHeight);
	
	
	CGFloat topBottomSpace = (clientHeight - FS_INDICATOR_MESSAGE_VIEW__ROUND_SPACE * 2.0f - _indicator.frame.size.height - FS_INDICATOR_MESSAGE_VIEW__ROW_SPACE - sizeTmp.height) / 2.0f;
	
	_indicator.frame = CGRectMake((self.frame.size.width - _indicator.frame.size.width) / 2.0f, 
								  FS_INDICATOR_MESSAGE_VIEW__ROUND_SPACE + topBottomSpace, 
								  _indicator.frame.size.width, 
								  _indicator.frame.size.height);
	
	_lblMessage.frame = CGRectMake(FS_INDICATOR_MESSAGE_VIEW__ROUND_SPACE + FS_INDICATOR_MESSAGE_VIEW__LEFT_RIGHT_SPACE, 
								   _indicator.frame.origin.y + _indicator.frame.size.height + FS_INDICATOR_MESSAGE_VIEW__ROW_SPACE, 
								   clientWith, 
								   sizeTmp.height);
	
	self.center = CGPointMake(self.superview.frame.size.width / 2.0f, self.superview.frame.size.height / 2.0f);
	[_indicator startAnimating];
}


@end
