//
//  FSTableViewCell.h
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
#import <QuartzCore/QuartzCore.h>
#import "FSConst.h"
#import "FSCellContainerObject.h"
#import "FSAsyncImageView.h"

/////////////////////////////////////////////////////////////////////////
//	自定义表格
/////////////////////////////////////////////////////////////////////////
@interface FSTableViewCell : UITableViewCell {
@protected
	CGSize _clientSize;
	NSInteger _rowIndex;
	NSInteger _sectionIndex;
	id _parentDelegate;
	NSObject *_data;
	CGFloat _cellShouldWidth;
}

//************************************************************
//	填充cell的数据
//************************************************************
@property (nonatomic, retain, setter = setData:) NSObject *data;
//************************************************************
//	cell行索引
//************************************************************
@property (nonatomic) NSInteger rowIndex;
//************************************************************
//	cell段索引
//************************************************************
@property (nonatomic) NSInteger sectionIndex;
//************************************************************
//	cell代理
//************************************************************
@property (nonatomic, assign) id parentDelegate;
//************************************************************
//	cell应该宽度
//************************************************************
@property (nonatomic) CGFloat cellShouldWidth;
//************************************************************
//	cell高度计算，必须覆盖
//************************************************************
+ (CGFloat)computCellHeight:(NSObject *)cellData cellWidth:(CGFloat)cellWidth;
//************************************************************
//	cell初始化
//************************************************************
-(void)doSomethingAtInit;
//************************************************************
//	cell销毁
//************************************************************
-(void)doSomethingAtDealloc;
//************************************************************
//	cell控件布局
//************************************************************
-(void)doSomethingAtLayoutSubviews;

@end

/////////////////////////////////////////////////////////////////////////
//	自定义表格的协议
/////////////////////////////////////////////////////////////////////////
@protocol FSTableViewCellDelegate
@optional
- (void)tableViewCellPictureTouched:(NSInteger)index;

-(void)tableViewCellTouchEvent:(FSTableViewCell *)sender;
@end

