//
//  FSVerticalLayoutObject.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-8.
//
//

#import <Foundation/Foundation.h>
#import "FSVerticalLabelView.h"
#import "FSVerticalPictureView.h"

typedef enum _FSVerticalLayoutStyle {
    FSVerticalLayoutStyle_None,
    FSVerticalLayoutStyle_Text,
    FSVerticalLayoutStyle_Picture
} FSVerticalLayoutStyle;

@interface FSVerticalLayoutObject : NSObject {
@private
    UIView *_container;
    CGFloat _allowMaxHeight;
    FSVerticalLayoutView *_rootView;
    
    id _parentDelegate;
    NSUInteger _currentIndex;
    NSMutableDictionary *_dicLayoutViews;

}

@property (nonatomic, retain) id parentDelegate;

- (id)initWithContainer:(UIView *)container withAllowMaxHeight:(CGFloat)maxHeight;

- (void)loadData;

@end


@protocol FSVerticalLayoutObject <NSObject>
- (FSVerticalLayoutStyle)verticalLayoutObjectStyle:(FSVerticalLayoutObject *)sender withIndex:(NSInteger)index;

@end

