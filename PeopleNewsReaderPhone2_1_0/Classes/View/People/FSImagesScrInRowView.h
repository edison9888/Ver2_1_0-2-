//
//  FSImagesScrInRowView.h
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-9-6.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSBaseContainerView.h"

#import "FS_GZF_PageControllView.h"

@interface FSImagesScrInRowView : FSBaseContainerView<UIScrollViewDelegate>{
@protected
    UIScrollView *_scrollView;
    CGSize _imageSize;
    //UIPageControl *_pageControl;
    BOOL _pageControlViewShow;
    NSInteger _imageIndex;
    CGFloat _spacing;
    
    NSInteger _currentPage;
    BOOL _isMove;
    UIImageView *_bottonBGR;
    CGFloat _bottonHeigh;
    
    FS_GZF_PageControllView *_fs_GZF_PageControllView;
}

@property (nonatomic, assign) CGSize imageSize;
@property (nonatomic, assign) CGFloat spacing;
@property (nonatomic, assign) CGFloat bottonHeigh;
@property (nonatomic, assign) NSInteger imageIndex;
@property (nonatomic, assign) BOOL pageControlViewShow;
@property (nonatomic, assign) BOOL isMove;

-(BOOL)turnTOpage:(NSInteger)index;

@end
