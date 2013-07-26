//
//  FSTableContainerView.h
//  PeopleDailyReader
//
//  Created by people.com.cn on 12-3-14.
//  Copyright 2012 people.com.cn. All rights reserved.
///////////////////////////////////////////////////////////////////
//	自定义表格容器类
///////////////////////////////////////////////////////////////////
//	日期				做成者			版本
///////////////////////////////////////////////////////////////////
//	2012-03-14		chen.gsh		1.0.0
//－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
//	2012-08-17		chen.gsh		2.0.0
//－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－

#import <UIKit/UIKit.h>
#import "GlobalConfig.h"
#import "FSTableView.h"
#import "FSTableViewCell.h"
#import "FSCommonFunction.h"
#import "FSGraphicsEx.h"

typedef enum _TableDataSource {
	tdsRefreshFirst,
	tdsNextSection
} TableDataSource;

@protocol FSTableContainerViewDelegate;


@interface FSTableContainerView : UIView <UITableViewDelegate, UITableViewDataSource, FSTableViewDelegate,FSTableViewCellDelegate> {
@protected
	FSTableView *_tvList;
	CGSize _tvSize;
	id<FSTableContainerViewDelegate> _parentDelegate;
	GlobalConfig *_config;
    NSInteger _oldCount;
}

@property (nonatomic, assign) id<FSTableContainerViewDelegate> parentDelegate;
//开始加载数据
- (void)loadData;
- (void)loadDataWithOutCompelet;
//动画刷新
- (void)refreshDataSource;
//刷新完成
- (void)loaddingComplete;
//顶部图像
- (UIImage *)topBounceAreaImageWithRect:(CGRect)rect;
//底部的图像
- (UIImage *)bottomBounceAreaImageWithRect:(CGRect)rect;
//图像的纹理底图
- (NSString *)bounceGrainFileName:(NSInteger)direction;
//选择的行
- (NSInteger)getSelectedRow;
//选择的段
- (NSInteger)getSelectedSection;
//tableview的类型
- (UITableViewStyle)initializeTableViewStyle;
//得到对象通过nsindexpath
- (NSObject *)cellDataObjectWithIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCellSelectionStyle)cellSelectionStyl:(NSIndexPath *)indexPath;
//标识符号,必须覆盖
- (NSString *)cellIdentifierStringWithIndexPath:(NSIndexPath *)indexPath;
//cellclass，必须覆盖
- (Class)cellClassWithIndexPath:(NSIndexPath *)indexPath;
//非FSTableViewCell子类做的工作
- (void)initializeCell:(UITableViewCell *)cell withData:(NSObject *)data withIndexPath:(NSIndexPath *)indexPath;
-(void)reSetAssistantViewFlag:(NSInteger)arrayCount;
@end

@protocol FSTableContainerViewDelegate
//每个cell的data
- (NSObject *)tableViewCellData:(FSTableContainerView *)sender withIndexPath:(NSIndexPath *)indexPath;
//cell数量
- (NSInteger)tableViewNumberInSection:(FSTableContainerView *)sender section:(NSInteger)section;
@optional
//刷新
- (void)tableViewDataSource:(FSTableContainerView *)sender withTableDataSource:(TableDataSource)dataSource;
//选择
- (void)tableViewDataSourceDidSelected:(FSTableContainerView *)sender withIndexPath:(NSIndexPath *)indexPath;
//section数量
- (NSInteger)tableViewSectionNumber:(FSTableContainerView *)sender;
//section 分组标题
- (NSString *)tableViewSectionTitle:(FSTableContainerView *)sender section:(NSInteger)section;
//选择状态类型
- (UITableViewCellSelectionStyle)tableViewCellSelectionStyl:(FSTableContainerView *)sender withIndexPath:(NSIndexPath *)indexPath;
//tabale的文字
- (NSString *)tableViewDataSourceUpdateMessage:(FSTableContainerView *)sender;
//cell的图片
- (void)tableViewTouchPicture:(FSTableContainerView *)sender index:(NSInteger)index;


-(void)tableViewTouchEvent:(FSTableContainerView *)sender cell:(FSTableViewCell *)cellSender;

@end
