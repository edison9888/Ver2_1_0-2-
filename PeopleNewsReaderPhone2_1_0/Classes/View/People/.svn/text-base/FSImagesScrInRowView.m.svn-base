//
//  FSImagesScrInRowView.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-9-6.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSImagesScrInRowView.h"
#import "FSAsyncImageView.h"
#import "FSCommonFunction.h"
#import "FSFocusTopObject.h"

@implementation FSImagesScrInRowView

@synthesize imageSize = _imageSize;
@synthesize spacing = _spacing;
@synthesize imageIndex = _imageIndex;
@synthesize pageControlViewShow = _pageControlViewShow;
@synthesize isMove = _isMove;
@synthesize bottonHeigh = _bottonHeigh;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)doSomethingAtDealloc{
    [_scrollView release];
    
    [_bottonBGR release];
    [_fs_GZF_PageControllView release];
}

-(void)doSomethingAtInit{
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
    _spacing = 0.0f;
    _bottonHeigh = 0.0f;
    _pageControlViewShow = NO;
    
    _currentPage = 0;
    
    
    _bottonBGR = [[UIImageView alloc] init];
    _bottonBGR.image = [UIImage imageNamed:@"图片下的条.png"];
    _bottonBGR.alpha = 0.8f;
    [self addSubview:_bottonBGR];
    
    
    _fs_GZF_PageControllView = [[FS_GZF_PageControllView alloc] init];
    _fs_GZF_PageControllView.backgroundColor = COLOR_CLEAR;
    _fs_GZF_PageControllView.FocusColor = COLOR_RED;
    _fs_GZF_PageControllView.NonFocusColor = COLOR_NEWSLIST_DESCRIPTION;
    [self addSubview:_fs_GZF_PageControllView];
    //[self addSubview:_pageControl];
}

-(void)doSomethingAtLayoutSubviews{
    _scrollView.frame = CGRectMake(0, 0, 320, self.frame.size.height);
    _bottonBGR.frame = CGRectMake(0, self.frame.size.height-_bottonHeigh, self.frame.size.width, _bottonHeigh);
    
    NSInteger i=0;
    CGSize size = CGSizeMake(_imageSize.width+_spacing,_imageSize.height);
    NSArray *subViews = [_scrollView subviews];
    for (FSAsyncImageView *o in subViews){
        [o removeFromSuperview];
    }
    CGPoint p = CGPointMake(0, 0);
    [_scrollView setContentOffset:p animated:NO];
    //NSLog(@"_imageSize.height:%f",size.width);
    for (FSFocusTopObject *o in _objectList) {
        FSAsyncImageView *imageView = [[FSAsyncImageView alloc] initWithFrame:CGRectMake(size.width*i + _spacing, _spacing, _imageSize.width, _imageSize.height)];
        
        NSString *loaclFile = getFileNameWithURLString(o.picture, getCachesPath());
//#ifdef MYDEBUG
//        NSLog(@"size.width*i + _spacing:%f",size.width*i + _spacing);
//#endif
        imageView.urlString = o.picture;
        imageView.localStoreFileName = loaclFile;
        imageView.imageCuttingKind = ImageCuttingKind_None;
        imageView.tag = i;
		[_scrollView addSubview:imageView];
        //[imageView performSelector:@selector(updateAsyncImageView) withObject:nil afterDelay:0.3];
        [imageView updateAsyncImageView];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGes:)];
        [_scrollView addGestureRecognizer:tapGes];
        [tapGes release];
        [imageView release];
        i++;
    }
    NSLog(@"i:%d",i);
    _scrollView.contentSize = CGSizeMake(i*size.width+_spacing, self.frame.size.height);
    if (_pageControlViewShow) {
        
        _fs_GZF_PageControllView.frame = CGRectMake(0, self.frame.size.height-TODAYNEWSLIST_TOP_BOTTOM_HEIGHT, self.frame.size.width-5, TODAYNEWSLIST_TOP_BOTTOM_HEIGHT);
        
        _fs_GZF_PageControllView.Radius = 3;
        _fs_GZF_PageControllView.Spacing = 12;
        _fs_GZF_PageControllView.PageNumber = [_objectList count];
        _fs_GZF_PageControllView.CurrentPage = 0;
    }
    else{
        
    }

}





//UIScrollViewDelegate


- (void) pageTurn: (UIPageControl *) pageControl{
    
#ifdef MYDEBUG
	NSLog(@"pageTurn:%d",pageControl.currentPage);
#endif
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //NSLog(@"scrollViewDidScroll:%f",scrollView.contentOffset.x);
    //计算当前页码
    int page = floor((scrollView.contentOffset.x - self.frame.size.width / 2) / self.frame.size.width) + 1;
    if (page==_currentPage || page<0 || scrollView.contentOffset.x>scrollView.contentSize.width - self.frame.size.width) {
        return;
    }
    _currentPage = page;
    _imageIndex = page;
    _fs_GZF_PageControllView.CurrentPage = _currentPage;
    _isMove = YES;
    [self sendTouchEvent];
}

-(BOOL)turnTOpage:(NSInteger)index{
    if (index==1) {
        if (_scrollView.contentOffset.x>=_scrollView.contentSize.width - self.frame.size.width) {
            return 0;
        }
        CGPoint p = CGPointMake(_scrollView.contentOffset.x +self.frame.size.width, 0);
        [_scrollView setContentOffset:p animated:YES];
        return 1;
    }
    
    if (index==-1) {
        if (_scrollView.contentOffset.x == 0) {
            return 0;
        }
        CGPoint p = CGPointMake(_scrollView.contentOffset.x - self.frame.size.width, 0);
        [_scrollView setContentOffset:p animated:YES];
        return 1;
    }
    return 0;
}


//touch
- (void)handleGes:(UITapGestureRecognizer *)ges {

    if (ges.state == UIGestureRecognizerStateEnded) {
        CGPoint pt = [ges locationInView:_scrollView];  
        UIView *hitView = [_scrollView hitTest:pt withEvent:nil];
#ifndef MYDEBUG
        NSLog(@"UITapGestureRecognizer hitView:%@",[hitView class]);
#endif
        FSAsyncImageView *asycImageView;
        if ([hitView isKindOfClass:[FSAsyncImageView class]]) {
            asycImageView = (FSAsyncImageView *)hitView;
            _isMove = NO;
            [self sendTouchEvent];
        }
        else{
            return;
        }
    }
    
}




@end
