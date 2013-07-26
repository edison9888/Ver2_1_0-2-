//
//  FSInformationMessageView.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-8.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSInformationMessageView.h"

#define FS_INFORMATION_MESSAGE_VIEW__TAG 16384

#define FS_INFORMATION_MESSAGE_VIEW__FONTSIZE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 16.0f : 14.0f)

#define FS_INFORMATION_MESSAGE_VIEW__ROUND_SPACE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 20.0f : 18.0f)
#define FS_INFORMATION_MESSAGE_VIEW_RADIUS (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 12.0f : 8.0f)
#define FS_INFORMATION_MESSAGE_VIEW__LEFT_RIGHT_SPACE 12.0f
#define FS_INFORMATION_MESSAGE_VIEW__TOP_BOTTOM_SPACE 12.0f


#define FS_INFORMATION_MESSAGE_VIEW__MAX_WIDTH (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 320.0f : 240.0f)
#define FS_INFORMATION_MESSAGE_VIEW__MAX_HEIGHT (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 240.0f : 180.0f)

@interface FSInformationMessageView(PrivateMethod)
- (UIImage *)drawInformationMessageViewBackgroundWithRect:(CGRect)rect;
- (void)inner_layoutSubviews;
- (UILabel *)labelMessage;
- (void)dismissWithAnimation;
@end


@implementation FSInformationMessageView
@synthesize parentDelegate = _parentDelegate;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		
		_backgroundLayer = [[CALayer alloc] init];
		[self.layer addSublayer:_backgroundLayer];
		
		_lblMessage = [[UILabel alloc] initWithFrame:CGRectZero];
		[_lblMessage setBackgroundColor:[UIColor clearColor]];
		[_lblMessage setFont:[UIFont boldSystemFontOfSize:FS_INFORMATION_MESSAGE_VIEW__FONTSIZE]];
		[_lblMessage setTextAlignment:UITextAlignmentCenter];
		[_lblMessage setTextColor:[UIColor whiteColor]];
		[_lblMessage setNumberOfLines:5];
		[self addSubview:_lblMessage];
		
		self.tag = FS_INFORMATION_MESSAGE_VIEW__TAG;
		
		self.alpha = 0.0f;
		
		[pool release];
    }
    return self;
}

- (void)dealloc {
	[_lblMessage release];
	[_backgroundLayer release];
	[_tapGesture removeTarget:self action:@selector(handleInformationMessageViewGesture:)];
	[_tapGesture release];
	
	if (_delaySeconds == 0) {
		if ([_parentDelegate respondsToSelector:@selector(informationMessageViewTouchClosed:)]) {
			[_parentDelegate informationMessageViewTouchClosed:self];
		}
	}
#ifdef MYDEBUG
	NSLog(@"informationView.dealloc:%@", self);
#endif
	//[_parentDelegate release];
    [super dealloc];
}

- (void)handleInformationMessageViewGesture:(UIGestureRecognizer *)gesture {
	if (_delaySeconds != 0) {
		return;
	}
	if (gesture.state == UIGestureRecognizerStateEnded) {
		if ([gesture isKindOfClass:[UITapGestureRecognizer class]] && [gesture isEqual:_tapGesture]) {
			[self removeGestureRecognizer:_tapGesture];
			[self dismissWithAnimation];
		}
	}
}

- (UIImage *)drawInformationMessageViewBackgroundWithRect:(CGRect)rect {
	UIImage *image = nil;
	UIColor *bgColor = [[UIColor alloc] initWithRed:100.0f / 255.0f green:100.0f / 255.0f blue:100.0f / 255.0f alpha:0.5];
	image = drawBackgroundImageWithRoundRect(rect, FS_INFORMATION_MESSAGE_VIEW__ROUND_SPACE, FS_INFORMATION_MESSAGE_VIEW_RADIUS, bgColor.CGColor, bgColor.CGColor);
    [bgColor release];
	return image;
}

- (UILabel *)labelMessage {
	return _lblMessage;
}

- (void)showInformationMessageViewInView:(UIView *)parentView withMessage:(NSString *)message withDelaySeconds:(NSTimeInterval)delaySeconds withPositionKind:(PositionKind)positionKind withOffset:(CGFloat)offset {
	FSInformationMessageView *informationMessageView = [FSInformationMessageView getInformationMessageViewInView:parentView];
	if (informationMessageView != nil) {
		[informationMessageView labelMessage].text = message;
		[informationMessageView inner_layoutSubviews];
		return;
	}
	
	[self retain];
	
	dispatch_queue_t queue = dispatch_queue_create(NULL, NULL);
	dispatch_async(queue, ^(void) {
		
		_messageSize = [message sizeWithFont:_lblMessage.font 
						   constrainedToSize:CGSizeMake(FS_INFORMATION_MESSAGE_VIEW__MAX_WIDTH, 
														FS_INFORMATION_MESSAGE_VIEW__MAX_HEIGHT) 
							   lineBreakMode:_lblMessage.lineBreakMode];
		
		_clientSize = CGSizeMake(_messageSize.width + FS_INFORMATION_MESSAGE_VIEW__LEFT_RIGHT_SPACE * 2.0f + FS_INFORMATION_MESSAGE_VIEW__ROUND_SPACE * 2.0f, 
								 _messageSize.height + FS_INFORMATION_MESSAGE_VIEW__TOP_BOTTOM_SPACE * 2.0f + FS_INFORMATION_MESSAGE_VIEW__ROUND_SPACE * 2.0f);
		
		UIImage *backgroundImage = [self drawInformationMessageViewBackgroundWithRect:CGRectMake(0.0f, 0.0f, _clientSize.width, _clientSize.height)];
		
		dispatch_async(dispatch_get_main_queue(), ^(void) {
			_positionKind = positionKind;
			_offset = offset;
			_delaySeconds = delaySeconds;
			_lblMessage.text = message;
			_backgroundLayer.contents = (id)backgroundImage.CGImage;
			[parentView addSubview:self];
			
			if (_delaySeconds == 0) {
				_tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleInformationMessageViewGesture:)];
				[self addGestureRecognizer:_tapGesture];
			}
			[self inner_layoutSubviews];
			
			
			[UIView beginAnimations:nil context:nil];
			self.alpha = 1.0f;
			[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
			[UIView setAnimationDuration:0.3];
			[UIView setAnimationDelegate:self];
			[UIView setAnimationDidStopSelector:@selector(animationStartCompelte)];
			[UIView commitAnimations];
			
			
		});
	});
	dispatch_release(queue);
	
}

- (void)animationStartCompelte {
	if (_delaySeconds == 0) {
		
	} else {
		[NSTimer scheduledTimerWithTimeInterval:_delaySeconds target:self selector:@selector(timerAction:) userInfo:nil repeats:NO];
	}

}

- (void)dismissWithAnimation {
	[UIView beginAnimations:nil context:NULL];
	self.alpha = 0.0f;
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStopForDismiss)];
	[UIView commitAnimations];
}

- (void)animationDidStopForDismiss {
	[self removeFromSuperview];
	[self release];
}

- (void)timerAction:(id)sender {
	[self dismissWithAnimation];
}

+ (FSInformationMessageView *)getInformationMessageViewInView:(UIView *)parentView {
	FSInformationMessageView *informationMessageView = nil;
	if (parentView != nil) {
		UIView *childView = [parentView viewWithTag:FS_INFORMATION_MESSAGE_VIEW__TAG];
		if (childView != nil && [childView isKindOfClass:[FSInformationMessageView class]]) {
			informationMessageView = (FSInformationMessageView *)childView;
		}
	}
	return informationMessageView;
}

+ (void)layoutInformationMessageViewInView:(UIView *)parentView {
	FSInformationMessageView *informationMessageView = [FSInformationMessageView getInformationMessageViewInView:parentView];
	if (informationMessageView != nil) {
//		informationMessageView.center 
		[informationMessageView inner_layoutSubviews];
		
	}
}

- (void)inner_layoutSubviews {
	
	CGRect rClient = CGRectMake(0.0f, 
								0.0f, 
								_clientSize.width, 
								_clientSize.height);
	_backgroundLayer.frame = rClient;
	
	self.frame = rClient;

	_lblMessage.frame = CGRectMake((rClient.size.width - _messageSize.width) / 2.0f, 
								   (rClient.size.height - _messageSize.height) / 2.0f, 
								   _messageSize.width, 
								   _messageSize.height);
	
	if (_positionKind == PositionKind_Vertical_Horizontal_Center) {
		self.center = CGPointMake(self.superview.frame.size.width / 2.0f, self.superview.frame.size.height / 2.0f);
	} else if (_positionKind == PositionKind_Vertical_Center) {
		//垂直
		self.frame = CGRectMake(_offset, (self.superview.frame.size.height - rClient.size.height) / 2.0f, rClient.size.width, rClient.size.height);
	} else if (_positionKind == PositionKind_Horizontal_Center) {
		//水平
		self.frame = CGRectMake((self.superview.frame.size.width - rClient.size.width) / 2.0f, 
								_offset, 
								rClient.size.width, 
								rClient.size.height);
	} else {
		self.center = CGPointMake(self.superview.frame.size.width / 2.0f, self.superview.frame.size.height / 2.0f);
	}

}

@end
