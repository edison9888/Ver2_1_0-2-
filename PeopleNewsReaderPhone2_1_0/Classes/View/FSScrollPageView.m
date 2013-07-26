//
//  FSScrollPageView.m
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

#import "FSScrollPageView.h"

#define MAX_CHILD_VIEW_COUNT 3

@interface FSScrollPageView(PrivateMethod)
- (void)doSomethingWithCurrentPageNumber:(NSInteger)number;
- (void)releasePages;
- (void)createChildViewWith:(NSInteger)index withKey:(NSNumber *)numberKey;
@end


@implementation FSScrollPageView
@synthesize parentDelegate = _parentDelegate;
@synthesize pageCount = _pageCount;
@synthesize pageNumber = _pageNumber;
@synthesize leftRightSpace = _leftRightSpace;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		
		_queue = dispatch_queue_create(NULL, NULL);
		
		[self setBackgroundColor:[UIColor clearColor]];
		
        _oldSize = CGSizeZero;
		_pageCount = 0;
		_pageNumber = -1;
		_bufferPageCount = MAX_CHILD_VIEW_COUNT;
		_initialized = NO;
		self.pagingEnabled = YES;
		self.delegate = self;
		[self setShowsVerticalScrollIndicator:NO];
		[self setShowsHorizontalScrollIndicator:NO];

		_dicPages = [[NSMutableDictionary alloc] init];
        _leftRightSpace = 0.0f;
		
		[pool release];
    }
    return self;
}

- (void)dealloc {
	[self releasePages];
	[_dicPages release];
    [_indexPaths release];
	dispatch_release(_queue);
    [super dealloc];
}

- (NSIndexPath *)indexPathWithPageNumber:(NSInteger)pageNum {
    NSIndexPath *indexPath = nil;
    if (_indexPaths == nil) {
        _indexPaths = [[NSMutableDictionary alloc] init];
    }
    NSNumber *pageKey = [[NSNumber alloc] initWithInt:pageNum];
    indexPath = [_indexPaths objectForKey:pageKey];
    if (indexPath == nil) {
        indexPath = [NSIndexPath indexPathForRow:pageNum inSection:0];
        [_indexPaths setObject:indexPath forKey:pageKey];
    }
    [pageKey release];
    
    return indexPath;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	if (!CGSizeEqualToSize(_oldSize, self.frame.size) &&
		!CGSizeEqualToSize(CGSizeZero, self.frame.size)) {
		_oldSize = self.frame.size;
		//重新布局
		self.delegate = nil;
		self.contentSize = CGSizeMake(_pageCount * self.frame.size.width, self.frame.size.height);
		self.contentOffset = CGPointMake(_pageNumber * self.frame.size.width, 0.0f);
		NSArray *numberKeys = [_dicPages allKeys];
		for (NSNumber *numberKey in numberKeys) {
			UIView *view = [_dicPages objectForKey:numberKey];
			view.frame = CGRectMake([numberKey intValue] * self.frame.size.width + self.leftRightSpace, 0.0f, self.frame.size.width - self.leftRightSpace * 2.0f, self.frame.size.height);
		}
		
		self.delegate = self;
	}
}

- (void)setFrame:(CGRect)value {
	[super setFrame:value];
	[self layoutSubviews];
}

/////////////////////////////////////////////////////////////////
//	属性方法
/////////////////////////////////////////////////////////////////
- (void)setPageNumber:(NSInteger)value {
	if (value != _pageNumber) {
		_pageNumber = value;
		if (_pageNumber * self.frame.size.width != self.contentOffset.x) {
			[self setContentOffset:CGPointMake(_pageNumber * self.frame.size.width, 0.0f) animated:YES];
		} else {
			[self scrollViewDidScroll:self];
		}
	}
}
/////////////////////////////////////////////////////////////////
//	触发page事件
/////////////////////////////////////////////////////////////////
- (void)loadPageData {
	
	[self releasePages];
	//调整缓存的视图,----
	_pageCount = [_parentDelegate pageCountInScrollPageView:self];
	_pageNumber = 0;
	_initialized = YES;
	
	if (_pageCount <= 0) {

	} else {
		self.contentSize = CGSizeMake(_pageCount * self.frame.size.width, self.frame.size.height); 
		NSInteger newPageNumber = _pageNumber < 0 ? 0 : _pageNumber;
		if (newPageNumber * self.frame.size.width != self.contentOffset.x) {
			[self setContentOffset:CGPointMake(newPageNumber * self.frame.size.width, 0.0f) animated:YES];
		} else {
			[self scrollViewDidScroll:self];
		}
	}
}

/////////////////////////////////////////////////////////////////
//	UIScrollViewDelegate
/////////////////////////////////////////////////////////////////
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	if (_pageCount <= 0) {
		return;
	}
	
	NSInteger offsetX = (NSInteger)scrollView.contentOffset.x;
	NSInteger pageWidth = (NSInteger)scrollView.frame.size.width;
	
	if (offsetX % pageWidth != 0) {
		
		return;
	}
	
	NSInteger currentPageNumber = offsetX / pageWidth;
	if (currentPageNumber != _pageNumber || _initialized) {
		//--开始显示
#ifdef MYDEBUG
		NSLog(@"当前页码.currentPageNumber:%d", currentPageNumber);
#endif
		_pageNumber = currentPageNumber;
		_initialized = NO;
	
		NSNumber *numberKey = [[NSNumber alloc] initWithInt:_pageNumber];
		if ([_dicPages objectForKey:numberKey] == nil) {
			[self createChildViewWith:_pageNumber withKey:numberKey];
		}
		[numberKey release];
		
		[self doSomethingWithCurrentPageNumber:_pageNumber];
	}
}

- (void)createChildViewWith:(NSInteger)index withKey:(NSNumber *)numberKey {
	CGRect rChild = CGRectMake(index * self.frame.size.width + self.leftRightSpace, 0.0f, self.frame.size.width - self.leftRightSpace * 2.0f, self.frame.size.height);//set ..............
	UIView *childView = [[[_parentDelegate pageViewClassForScrollPageView:self] alloc] initWithFrame:rChild];
	[self addSubview:childView];
	childView.frame = rChild;
	if ([(id)_parentDelegate respondsToSelector:@selector(fillPageViewInScrollPageView:withPageView:withCurrentPageNumber:)]) {
		[_parentDelegate fillPageViewInScrollPageView:self withPageView:childView withCurrentPageNumber:index];
	}
	
	[_dicPages setObject:childView forKey:numberKey];
	[childView release];
}

/////////////////////////////////////////////////////////////////
//	私有方法:处理缓存页码的视图
/////////////////////////////////////////////////////////////////
- (void)doSomethingWithCurrentPageNumber:(NSInteger)number {
	
	
	dispatch_async(_queue, ^(void) {
		NSArray *numberKeys = [_dicPages allKeys];
		NSInteger realBufferCount = MIN(_bufferPageCount, _pageCount);
		NSInteger sidePageCount = realBufferCount / 2;
		NSInteger beginPageIndex = number - sidePageCount;
		NSInteger endPageIndex = beginPageIndex + realBufferCount - 1;
		if (beginPageIndex < 0) {
			beginPageIndex = 0;
			endPageIndex = beginPageIndex + realBufferCount - 1;
		} else if (endPageIndex >= _pageCount) {
			endPageIndex = _pageCount - 1;
			beginPageIndex = _pageCount - realBufferCount;
		}
		
		//构建新的view
		for (int i = beginPageIndex; i <= endPageIndex; i++) {
            
            NSNumber *numberKey = [[NSNumber alloc] initWithInt:i];
			UIView *view = [_dicPages objectForKey:numberKey];
            
			if (i == number) {
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    if ([(id)_parentDelegate respondsToSelector:@selector(pageViewDidSelected:withPageView:withPageNum:)]) {
                        [_parentDelegate pageViewDidSelected:self withPageView:view withPageNum:number];
                    }
                });
				
			} else {
                if (!view) {
                    dispatch_async(dispatch_get_main_queue(), ^(void) {
                        [self createChildViewWith:i withKey:numberKey];
                    });
                }
            }

			[numberKey release];
		}
		
		//移除不必要的view
		for (int i = 0; i < [numberKeys count]; i++) {
			NSNumber *numberKey = [numberKeys objectAtIndex:i];
			NSInteger pageIndex = [numberKey intValue];
			if (pageIndex >= beginPageIndex && pageIndex <= endPageIndex) {
				//没事
			} else {
				dispatch_async(dispatch_get_main_queue(), ^(void) {
					UIView *view = [_dicPages objectForKey:numberKey];
					if ([(id)_parentDelegate respondsToSelector:@selector(releasePageViewFromScrollPageView:withPageView:withCurrentPageNumber:)]) {
						[_parentDelegate releasePageViewFromScrollPageView:self withPageView:view withCurrentPageNumber:[numberKey intValue]];
					}
					[view removeFromSuperview];
					[_dicPages removeObjectForKey:numberKey];
				});
			}
		}
#ifdef MYDEBUG
		//NSLog(@"_dicPages:%@", _dicPages);
#endif
	});
}

- (void)releasePages {
	NSArray *numberKeys = [_dicPages allKeys];
	for (NSNumber *numberKey in numberKeys) {
		UIView *view = [_dicPages objectForKey:numberKey];
		[view removeFromSuperview];
		[_dicPages removeObjectForKey:numberKey];
	}
}

@end
