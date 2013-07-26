//
//  FSPageControlViewController.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-27.
//
//

#import <UIKit/UIKit.h>
#import "FSBaseDataViewController.h"
#import "FSPageControlView.h"
#import "FSHorizontalScrollPageContainerView.h"

#import "FSDeepPageControllView.h"


@interface FSPageControlViewController : FSBaseDataViewController <UIScrollViewDelegate> {
@private
    //FSPageControlView *_pageControlView;
    FSDeepPageControllView *_pageControlView;
    UIScrollView *_svContainer;
    
    NSMutableDictionary *_buffers;
    NSMutableDictionary *_indexPaths;
    
    NSInteger _pageCount;
    NSInteger _pageNumber;
    UIBarButtonItem *_refreshButton;
    
    BOOL _isPopoNext;
    BOOL _isParentController;
}

@property (nonatomic, readonly) NSInteger pageNumber;
@property (nonatomic, readonly) NSInteger pageCount;

- (CGFloat)pageControlHeight;

- (NSIndexPath *)indexPathWithPageNum:(NSInteger)pageNum;

- (void)setPageControllerCount:(NSInteger)value;

- (Class)pageControllerClassWithPageNum:(NSInteger)pageNum;

- (void)initializePageController:(UIViewController *)viewController withPageNum:(NSInteger)pageNum;

- (void)focusViewController:(UIViewController *)viewController withPageNum:(NSInteger)pageNum;



@end


