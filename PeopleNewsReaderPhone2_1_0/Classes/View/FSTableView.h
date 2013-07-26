//
//  FSTableView.h
//  PeopleDailyReader
//
//  Created by people.com.cn on 12-3-14.
//  Copyright 2012 people.com.cn. All rights reserved.
///////////////////////////////////////////////////////////////////
//	自定义单元格父类
///////////////////////////////////////////////////////////////////
//	日期				做成者			版本
///////////////////////////////////////////////////////////////////
//	2012-03-14		chen.gsh		1.0.0
//－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
//	2012-08-17		chen.gsh		2.0.0
//－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－

#import <UIKit/UIKit.h>
#import "FSTableAssistantView.h"
#import "FSTableAssistantIIView.h"

#define FSTABLEVIEW_ASSISTANT_NO_VIEW (0)
#define FSTABLEVIEW_ASSISTANT_TOP_VIEW (1)
#define FSTABLEVIEW_ASSISTANT_BOTTOM_VIEW (1 << 1)
#define FSTABLEVIEW_ASSISTANT_BOTTOM_BUTTON_VIEW (1 << 2)

@interface FSTableView : UITableView {
@protected
	BOOL _dragging;
	CGSize _oldSize;
	NSUInteger _assistantViewFlag;
	FSTableAssistantView *_topView;
	FSTableAssistantView *_bottomView;
	FSTableAssistantIIView *_btnBottom;
	id _parentDelegate;
	//上下部分的背景图层
	CALayer *_topLayer;
	CALayer *_bottomLayer;
    BOOL _isrefreshDataSource;
    BOOL _isRefreshing;
}

@property (nonatomic, assign) id parentDelegate;
@property (nonatomic) NSUInteger assistantViewFlag;
@property (nonatomic,assign) BOOL isRefreshing;

- (void)refreshDataSource;
- (void)loaddingComplete;
- (void)tableViewDataSourceIsEnding:(BOOL)value;
- (void)bottomScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)bottomScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
@end

////////////////////////////////////////////////////
//	FSTableViewDelegate
////////////////////////////////////////////////////
@protocol FSTableViewDelegate
@optional
- (void)tableViewNextDataSource:(FSTableView *)sender;
- (void)tableViewRefreshDataSource:(FSTableView *)sender;
- (NSString *)tableViewDataSourceUpdateInformation:(FSTableView *)sender;
- (UIImage *)tableViewTopBounceAreaWithRect:(CGRect)rect;
- (UIImage *)tableViewBottomBounceAreaWithRect:(CGRect)rect;
@end



