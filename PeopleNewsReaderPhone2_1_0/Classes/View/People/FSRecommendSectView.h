//
//  FSRecommendSectView.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-3-20.
//
//

#import <UIKit/UIKit.h>
#import "FSBaseContainerView.h"

@class FS_GZF_PageControllView;

@interface FSRecommendSectView : FSBaseContainerView<UIScrollViewDelegate>{
@protected
    UIScrollView *_scrollView;
    NSInteger _currentIndex;
    
    UILabel *_lab_sectionTitle;
    UIImageView *_sectionBGR;
    
    UILabel *_lab_more;
    UIButton *_MoreButton;
    
    FS_GZF_PageControllView *_fs_GZF_PageControllView;
    NSInteger _currentPage;
}

@property (nonatomic,assign) NSInteger currentIndex;

@end
