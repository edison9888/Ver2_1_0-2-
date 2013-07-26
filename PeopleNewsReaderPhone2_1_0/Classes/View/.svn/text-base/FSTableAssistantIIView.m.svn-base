//
//  FSTableAssistantIIView.m
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

#import "FSTableAssistantIIView.h"
#import "FSGraphicsEx.h"

#define BOTTOMINFO_VIEW_BUTTON_HEIGHT 34.0f
#define BOTTOMINFO_VIEW_LEFT_RIGHT_SPACE 16.0f

@implementation FSTableAssistantIIView
@synthesize parentDelegate = _parentDelegate;
@synthesize clickState = _clickState;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		
		//self.backgroundColor = [UIColor blackColor];
		_oldSize = CGSizeZero;
		
		_btnBottom = [[UIButton alloc] initWithFrame:CGRectZero];
        
		[_btnBottom addTarget:self action:@selector(bottomButtonAction:) forControlEvents:UIControlEventTouchUpInside];
		[_btnBottom.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
		//[_btnBottom setTitle:@"获取更多数据" forState:UIControlStateNormal];
		[_btnBottom setTitleColor:[UIColor colorWithRed:64.0f / 255.0f green:64.0f / 255.0f blue:64.0f / 255.0f alpha:1.0f] forState:UIControlStateNormal];
        [_btnBottom setBackgroundImage:[UIImage imageNamed:@"Bottom_download.png"] forState:UIControlStateNormal];
		[self addSubview:_btnBottom];
		
		_activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		[self addSubview:_activityView];
		
		[pool release];
    }
    return self;
}

- (void)dealloc {
	[_btnBottom release];
	[_activityView release];
    [super dealloc];
}

- (void) layoutSubviews {
	[super layoutSubviews];
	if (!CGSizeEqualToSize(self.frame.size, _oldSize)) {
		_oldSize = self.frame.size;
		
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		
		_btnBottom.frame = CGRectMake(BOTTOMINFO_VIEW_LEFT_RIGHT_SPACE, 
									  (self.frame.size.height - BOTTOMINFO_VIEW_BUTTON_HEIGHT) / 2.0f, 
									  self.frame.size.width - BOTTOMINFO_VIEW_LEFT_RIGHT_SPACE * 2.0f, 
									  BOTTOMINFO_VIEW_BUTTON_HEIGHT);
		
//		UIColor *btnColor = [[UIColor alloc] initWithRed:218.0f / 255.0f green:218.0f / 255.0f blue:218.0f / 255.0f alpha:1.0f];
//		UIImage *imgBtn = createImageWithRect(CGRectMake(0.0f, 
//														 0.0f, 
//														 self.frame.size.width - BOTTOMINFO_VIEW_LEFT_RIGHT_SPACE * 2.0f, BOTTOMINFO_VIEW_BUTTON_HEIGHT), 
//											  4.0f, 
//											  CGColorGetComponents(btnColor.CGColor), 
//											  CGColorGetNumberOfComponents(btnColor.CGColor));
//		//[_btnBottom setBackgroundImage:imgBtn forState:UIControlStateNormal];
//		[btnColor release];
		[_btnBottom setBackgroundImage:[UIImage imageNamed:@"Bottom_download.png"] forState:UIControlStateNormal];
		_activityView.frame = CGRectMake(_btnBottom.frame.origin.y + _activityView.frame.size.width * 1.5, 
										 (self.frame.size.height - _activityView.frame.size.height) / 2.0f, 
										 _activityView.frame.size.width, 
										 _activityView.frame.size.height);
		
		[pool release];
	}
}

- (void)setClickState:(ClickState)value {
	if (value != _clickState) {
		_clickState = value;
		
		if ([_parentDelegate respondsToSelector:@selector(tableAssistantIIViewMessage:withClickState:)]) {
			NSString *btnTitle = [_parentDelegate tableAssistantIIViewMessage:self withClickState:_clickState];
			[_btnBottom setTitle:btnTitle forState:UIControlStateNormal];
		}
		
		if (_clickState == csNormal) {
			[_activityView stopAnimating];
			_activityView.hidden = YES;
			_btnBottom.enabled = YES;
		} else if (_clickState == csLoadding) {
			_activityView.hidden = NO;
			_btnBottom.enabled = NO;
			[_activityView startAnimating];
		}
	}
}

- (void)bottomButtonAction:(id)sender {
#ifdef MYDEBUG
	NSLog(@"bottomButtonAction.....");
#endif
	if (_clickState == csNormal) {
		self.clickState = csLoadding;
		if ([_parentDelegate respondsToSelector:@selector(tableAssistantIIViewAction:)]) {
			[_parentDelegate tableAssistantIIViewAction:self];
		}
	}
}


@end
