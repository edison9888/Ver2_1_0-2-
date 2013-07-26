//
//  FSScrollPageContainerView.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-1.
//
//

#import "FSScrollPageContainerView.h"

#define MAX_BUFFER_COUNT 7

@interface FSScrollPageContainerView()
- (void)removePageViews;
@end

@implementation FSScrollPageContainerView
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _pageKeys = [[NSMutableArray alloc] init];
        _buffers = [[NSMutableDictionary alloc] init];
        _svContainer = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
        _svContainer.delegate = self;
        [self addSubview:_svContainer];
        
        _pageCount = -1;
        _pageNumber = -1;
    }
    return self;
}

- (void)dealloc {
    [_svContainer release];
    [_pageKeys release];
    [_buffers release];
    [super dealloc];
}

- (void)removePageViews {
    NSArray *pageKeys = [_buffers allKeys];
    for (NSNumber *pageKey in pageKeys) {
        UIView *pageView = [_buffers objectForKey:pageKey];
        if (pageView) {
            [pageView removeFromSuperview];
        }
    }
    
    [_buffers removeAllObjects];
}

- (void)loadPageContainerData {
    //STEP 1.
    [self removePageViews];
    
    //STEP 2.
    _pageCount = [_delegate scrollPageContainerPageCount:self];
    
    
}

#pragma -
#pragma UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

@end
