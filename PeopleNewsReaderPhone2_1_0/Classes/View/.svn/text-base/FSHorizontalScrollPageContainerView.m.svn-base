//
//  FSHorizontalScrollPageContainerView.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-9.
//
//

#import "FSHorizontalScrollPageContainerView.h"

#define FSHORIZONTAL_SCROLL_PAGE_CONTAINER_OFFSET 2

@interface FSHorizontalScrollPageContainerView()
- (void)inner_RemoveAllPageViews;
- (void)inner_ShowPageViewWithPageNumber:(NSInteger)pageNumber;
@end

@implementation FSHorizontalScrollPageContainerView
@synthesize pageCount =_pageCount;
@synthesize selectedPageNumber = _selectedPageNumber;
@synthesize delegate = _delegate;
@synthesize canTouchPage = _canTouchPage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _pageCount = 0;
        _selectedPageNumber = -1;
        
        _dicPages = [[NSMutableDictionary alloc] init];
        
        _svContainer = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
        [_svContainer setShowsHorizontalScrollIndicator:NO];
        [_svContainer setShowsVerticalScrollIndicator:NO];
        [_svContainer setPagingEnabled:YES];
        _svContainer.delegate = self;
        [self addSubview:_svContainer];
        
        [self setCanTouchPage:YES];
    }
    return self;
}

- (void)dealloc {
    [self inner_RemoveAllPageViews];
    [_dicPages release];
    [_dicIndexPaths release];
    [_svContainer release];
    [_tapGestureForPage release];
    [super dealloc];
}

- (void)setCanTouchPage:(BOOL)value {
    _canTouchPage = value;
    if (value) {
        if ([[_svContainer gestureRecognizers] indexOfObject:_tapGestureForPage] == NSNotFound) {
            [_tapGestureForPage removeTarget:self action:@selector(handleGesture:)];
            [_tapGestureForPage release];
            _tapGestureForPage = nil;
            
            _tapGestureForPage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
            [_svContainer addGestureRecognizer:_tapGestureForPage];
        }
    } else {
        if ([[_svContainer gestureRecognizers] indexOfObject:_tapGestureForPage] != NSNotFound) {
            [_tapGestureForPage removeTarget:self action:@selector(handleGesture:)];
            [_tapGestureForPage release];
            _tapGestureForPage = nil;
        }
    }
}

- (void)setFrame:(CGRect)value {
    BOOL needLayout = !CGSizeEqualToSize(value.size, self.frame.size);
    [super setFrame:value];
    if (needLayout) {
        _svContainer.frame = CGRectMake(0.0f, 0.0f, value.size.width, value.size.height);
        _svContainer.contentSize = CGSizeMake(_pageCount * _svContainer.frame.size.width, _svContainer.frame.size.height);
        NSArray *pageKeys = [_dicPages allKeys];
        for (NSNumber *pageKey in pageKeys) {
            UIView *pageView = [_dicPages objectForKey:pageKey];
            if (pageView) {
                pageView.frame = CGRectMake([pageKey intValue] * _svContainer.frame.size.width, 0.0f, _svContainer.frame.size.width, _svContainer.frame.size.height);
            }
        }
    }
}

#pragma -
#pragma PublicMethod
- (void)loadPages {
    [self inner_RemoveAllPageViews];
    
    _pageCount = [_delegate horizontalScrollPageContainerViewPageCount:self];
    _selectedPageNumber = -1;
    
    _svContainer.contentSize = CGSizeMake(_pageCount * _svContainer.frame.size.width, _svContainer.frame.size.height);
    
    if (_pageCount > 0) {
        [_svContainer.delegate scrollViewDidScroll:_svContainer];
    }
}

- (UIView *)pageViewWithPageNumber:(NSInteger)pageNumber {
    UIView *result = nil;
    NSNumber *pageKey = [[NSNumber alloc] initWithInt:pageNumber];
    result = [_dicPages objectForKey:pageKey];
    [pageKey release];
    return result;
}

- (NSIndexPath *)indexPathWithPageNumber:(NSInteger)pageNumber {
    NSIndexPath *indexPath = nil;
    NSNumber *pageKey = [[NSNumber alloc] initWithInt:pageNumber];
    if (_dicIndexPaths == nil) {
        _dicIndexPaths = [[NSMutableDictionary alloc] init];
    }
    indexPath = [_dicIndexPaths objectForKey:pageKey];
    if (!indexPath) {
        indexPath = [NSIndexPath indexPathForRow:pageNumber inSection:0];
        [_dicIndexPaths setObject:indexPath forKey:pageKey];
    }
    [pageKey release];
    return indexPath;
}

#pragma -
#pragma PrivateMethod
- (void)handleGesture:(UIGestureRecognizer *)gesture {
    if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
        CGPoint pt = [gesture locationInView:_svContainer];
        UIView *view = [_svContainer hitTest:pt withEvent:nil];
        if (view) {
            NSArray *pageKeys = [_dicPages allKeys];
            for (NSNumber *pageKey in pageKeys) {
                UIView *pageView = [_dicPages objectForKey:pageKey];
                if (pageView && [view isEqual:pageView]) {
                    if ([_delegate respondsToSelector:@selector(horizontalScrollPageContainerViewDidSelected:withPageNumber:)]) {
                        [_delegate horizontalScrollPageContainerViewDidSelected:self withPageNumber:[pageKey intValue]];
                    }
                    break;
                }
            }
        }
    }
}

- (void)inner_RemoveAllPageViews {
    NSArray *pageKeys = [_dicPages allKeys];
    for (NSNumber *numberPageKey in pageKeys) {
        UIView *pageView = [_dicPages objectForKey:numberPageKey];
        if (pageView) {
            [pageView removeFromSuperview];
        }
    }
    
    [_dicPages removeAllObjects];
    [_dicIndexPaths removeAllObjects];
}

- (void)inner_ShowPageViewWithPageNumber:(NSInteger)pageNumber {
    NSNumber *pageKey = [[NSNumber alloc] initWithInt:pageNumber];
    UIView *pageView = [_dicPages objectForKey:pageKey];
    
    if (!pageView) {
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        
        pageView = [_delegate horizontalScrollPageContainerViewPageView:self withPageNumber:pageNumber];
        if (pageView) {
            [_svContainer addSubview:pageView];
            pageView.frame = CGRectMake(pageNumber * _svContainer.frame.size.width, 0.0f, _svContainer.frame.size.width, _svContainer.frame.size.height);
            if ([_delegate respondsToSelector:@selector(horizontalScrollPageContainerViewFrameChanged:withPageNumber:withRect:)]) {
                [_delegate horizontalScrollPageContainerViewFrameChanged:self withPageNumber:pageNumber withRect:pageView.frame];
            }
            
            [_dicPages setObject:pageView forKey:pageKey];
        }
        
        [pool release];
    }
    
    if (pageNumber == _selectedPageNumber) {
        if ([_delegate respondsToSelector:@selector(horizontalScrollPageContainerViewDidScroll:withPageNumber:)]) {
            [_delegate horizontalScrollPageContainerViewDidScroll:self withPageNumber:pageNumber];
        }
//        if ([_delegate respondsToSelector:@selector(horizontalScrollPageContainerViewDidSelected:withPageNumber:)]) {
//            [_delegate horizontalScrollPageContainerViewDidSelected:self withPageNumber:pageNumber];
//        }
    }
    
    [pageKey release];
}

#pragma -
#pragma UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger curPage = (int)(scrollView.contentOffset.x / scrollView.frame.size.width);
    if (curPage == _selectedPageNumber) {
        return;
    }
    
    _selectedPageNumber = curPage;
    [self inner_ShowPageViewWithPageNumber:_selectedPageNumber];
    
    NSInteger beginPageNum = _selectedPageNumber - FSHORIZONTAL_SCROLL_PAGE_CONTAINER_OFFSET;
    NSInteger endPageNum = _selectedPageNumber + FSHORIZONTAL_SCROLL_PAGE_CONTAINER_OFFSET;
    
    if (beginPageNum < 0) {
        beginPageNum = 0;
    }
    
    if (endPageNum > _pageCount - 1) {
        endPageNum = _pageCount - 1;
    }
    
    NSArray *pageKeys = [_dicPages allKeys];
    for (NSNumber *pageKey in pageKeys) {
        NSInteger pageKeyValue = [pageKey intValue];
        if (pageKeyValue < beginPageNum || pageKeyValue > endPageNum) {
            UIView *pageView = [_dicPages objectForKey:pageKey];
            [pageView removeFromSuperview];
            [_dicPages removeObjectForKey:pageKey];
            if ([_delegate respondsToSelector:@selector(horizontalScrollPageContainerViewRemovePageView:withPageNumber:)]) {
                [_delegate horizontalScrollPageContainerViewRemovePageView:self withPageNumber:pageKeyValue];
            }
        }
    }
    
    for (int pageIdx = beginPageNum; pageIdx <= endPageNum; pageIdx++) {
        if (pageIdx == _selectedPageNumber) {
            continue;
        }
        
        [self inner_ShowPageViewWithPageNumber:pageIdx];
    }
}

@end
