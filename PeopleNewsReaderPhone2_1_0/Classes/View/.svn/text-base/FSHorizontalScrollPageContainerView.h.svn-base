//
//  FSHorizontalScrollPageContainerView.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-9.
//
//

#import <UIKit/UIKit.h>

@protocol FSHorizontalScrollPageContainerViewDelegate;


@interface FSHorizontalScrollPageContainerView : UIView <UIScrollViewDelegate> {
@private
    NSMutableDictionary *_dicPages;
    NSMutableDictionary *_dicIndexPaths;
    NSInteger _pageCount;
    NSInteger _selectedPageNumber;
    
    UIScrollView *_svContainer;
    NSObject<FSHorizontalScrollPageContainerViewDelegate> *_delegate;
    BOOL _canTouchPage;
    UITapGestureRecognizer *_tapGestureForPage;
}

@property (nonatomic, setter = setCanTouchPage:) BOOL canTouchPage;
@property (nonatomic, readonly) NSInteger pageCount;
@property (nonatomic, readonly) NSInteger selectedPageNumber;
@property (nonatomic, assign) NSObject<FSHorizontalScrollPageContainerViewDelegate> *delegate;

- (void)loadPages;
- (UIView *)pageViewWithPageNumber:(NSInteger)pageNumber;
- (NSIndexPath *)indexPathWithPageNumber:(NSInteger)pageNumber;

@end

@protocol FSHorizontalScrollPageContainerViewDelegate <NSObject>
//视图数量
- (NSInteger)horizontalScrollPageContainerViewPageCount:(FSHorizontalScrollPageContainerView *)sender;
//视图
- (UIView *)horizontalScrollPageContainerViewPageView:(FSHorizontalScrollPageContainerView *)sender withPageNumber:(NSInteger)pageNumber;
@optional
//选中的视图
- (void)horizontalScrollPageContainerViewDidSelected:(FSHorizontalScrollPageContainerView *)sender withPageNumber:(NSInteger)pageNumber;
//滚动倒焦点的视图
- (void)horizontalScrollPageContainerViewDidScroll:(FSHorizontalScrollPageContainerView *)sender withPageNumber:(NSInteger)pageNumber;
//移走的视图
- (void)horizontalScrollPageContainerViewRemovePageView:(FSHorizontalScrollPageContainerView *)sender withPageNumber:(NSInteger)pageNumber;
//视图的frame调整
- (void)horizontalScrollPageContainerViewFrameChanged:(FSHorizontalScrollPageContainerView *)sender withPageNumber:(NSInteger)pageNumber withRect:(CGRect)rect;
@end

