//
//  FSScrollPageView.h
//  PeopleDailyReader
//
//  Created by people.com.cn on 12-3-20.
//  Copyright 2012 people.com.cn. All rights reserved.
///////////////////////////////////////////////////////////////////
//	以页方式浏览的UIScrollView
///////////////////////////////////////////////////////////////////
//	日期				做成者			版本
///////////////////////////////////////////////////////////////////
//	2012-03-20		chen.gsh		1.0.0
//－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－

#import <UIKit/UIKit.h>

@protocol FSScrollPageViewPageDelegate;



@interface FSScrollPageView : UIScrollView <UIScrollViewDelegate> {
@private
	CGSize _oldSize;
	id<FSScrollPageViewPageDelegate> _parentDelegate;
	//总页码、当前页码、子视图集合（部分）、缓存子视图的数量（可能由于总页码太小，子视图数量可能和总页码一样多）
	NSInteger _pageCount;
	NSInteger _pageNumber;
	NSInteger _bufferPageCount;	
	//New Version
	NSMutableDictionary *_dicPages;
    NSMutableDictionary *_indexPaths;
	
	BOOL _initialized;
	
	dispatch_queue_t _queue;
    
    CGFloat _leftRightSpace;
}

@property (nonatomic, assign) id<FSScrollPageViewPageDelegate> parentDelegate;
@property (nonatomic) NSInteger pageNumber;
@property (nonatomic, readonly) NSInteger pageCount;
@property (nonatomic) CGFloat leftRightSpace;

- (void)loadPageData;

- (NSIndexPath *)indexPathWithPageNumber:(NSInteger)pageNum;

@end

@protocol FSScrollPageViewPageDelegate
//返回页数
- (NSInteger)pageCountInScrollPageView:(FSScrollPageView *)sender;
//每页的视图元类
- (Class)pageViewClassForScrollPageView:(FSScrollPageView *)sender;
@optional
//可选的填充页视图的代理方法
- (void)fillPageViewInScrollPageView:(FSScrollPageView *)sender withPageView:(UIView *)pageView withCurrentPageNumber:(NSInteger)currentPageNumber;
- (void)pageViewDidSelected:(FSScrollPageView *)sender withPageView:(UIView *)pageView withPageNum:(NSInteger)pageNum;
- (void)releasePageViewFromScrollPageView:(FSScrollPageView *)sender withPageView:(UIView *)pageView withCurrentPageNumber:(NSInteger)currentPageNumber;

@end


