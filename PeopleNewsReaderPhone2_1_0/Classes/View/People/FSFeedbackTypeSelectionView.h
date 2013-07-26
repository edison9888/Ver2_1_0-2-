//
//  FSFeedbackTypeSelectionView.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-10-8.
//
//

#import <UIKit/UIKit.h>
#import "FSBaseContainerView.h"

@interface FSFeedbackTypeSelectionView : FSBaseContainerView<UIScrollViewDelegate>{
@protected
    UIScrollView *_scrollView;
    UILabel *_selectedBGR;
    CGFloat _textwidth;
    NSInteger _currentIndex;
}

@property (nonatomic,assign) NSInteger currentIndex;

@end
