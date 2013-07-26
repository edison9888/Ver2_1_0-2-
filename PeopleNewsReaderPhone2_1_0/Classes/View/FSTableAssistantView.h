//
//  FSTableAssistantView.h
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
#import <QuartzCore/QuartzCore.h>

typedef enum _DragState {
	dsUnknow,
	dsPulling,
	dsNormal,
	dsLoadding
} DragState;

typedef enum _AssistantArrowDirection {
	aadUnknow,
	aadTop,
	aadBottom
} AssistantArrowDirection;


@interface FSTableAssistantView : UIView {
@private
	CGSize _oldSize;
	UILabel *_lblMessage;
	UILabel *_lblUpdateInfo;
	UIImageView *_ivArrow;
	UIActivityIndicatorView *_activityView;
	
	DragState _dragState;
	AssistantArrowDirection _assistantArrowDirection;
	id _parentDelegate;
}

@property (nonatomic, assign) id parentDelegate;
@property (nonatomic) DragState dragState;
@property (nonatomic) AssistantArrowDirection assistantArrowDirection;

- (void)resetDragState;

@end

@protocol FSTableAssistantViewDelegate
@optional
- (NSString *)tableAssistantViewText:(FSTableAssistantView *)sender withDragState:(DragState)state;
- (NSString *)tableAssistantUpdateText:(FSTableAssistantView *)sender;
@end
