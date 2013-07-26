//
//  FSScrollPageContainerView.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-1.
//
//

#import <UIKit/UIKit.h>

@protocol FSScrollPageContainerViewDelegate;

@interface FSScrollPageContainerView : UIView <UIScrollViewDelegate> {
@private
    UIScrollView *_svContainer;
    NSMutableDictionary *_buffers;
    NSMutableArray *_pageKeys;
    
    NSInteger _pageCount;
    NSInteger _pageNumber;
    
    NSObject<FSScrollPageContainerViewDelegate> *_delegate;
}

@property (nonatomic, assign) NSObject<FSScrollPageContainerViewDelegate> *delegate;

- (void)loadPageContainerData;

@end

@protocol FSScrollPageContainerViewDelegate <NSObject>
//返回页面的数量
- (NSInteger)scrollPageContainerPageCount:(FSScrollPageContainerView *)sender;
//返回页面的类型
- (Class)scrollPageClass:(FSScrollPageContainerView *)sender withPageNumber:(NSInteger)pageNum;
//给页面赋值
- (void)scrollPageInitialze:(FSScrollPageContainerView *)sender withPageNumber:(NSInteger)pageNum withPageView:(UIView *)pageView;
@optional
//当前页面
- (void)scrollPageContainerCurrentPage:(FSScrollPageContainerView *)sender withCurrentPageNumber:(NSInteger)currentPageName;
@end

