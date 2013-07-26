//
//  FSTableAssistantIIView.h
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

#import <UIKit/UIKit.h>

typedef enum _ClickState {
	csLoadding,
	csNormal,
    csPulling
} ClickState;

@interface FSTableAssistantIIView : UIView {
@private
	CGSize _oldSize;
	UIButton *_btnBottom;
	UIActivityIndicatorView *_activityView;
	ClickState _clickState;
	
	id _parentDelegate;
}

@property (nonatomic) ClickState clickState;
@property (nonatomic, assign) id parentDelegate;

@end

@protocol FSTableAssistantIIViewDelegate
@optional
- (NSString *)tableAssistantIIViewMessage:(FSTableAssistantIIView *)sender withClickState:(ClickState)state;
- (void)tableAssistantIIViewAction:(FSTableAssistantIIView *)sender;
@end


