//
//  FSVerticalLayoutObject.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-8.
//
//

#import "FSVerticalLayoutObject.h"

@interface FSVerticalLayoutObject()
- (void)inner_Finallize;
@end

@implementation FSVerticalLayoutObject
@synthesize parentDelegate = _parentDelegate;

- (id)initWithContainer:(UIView *)container withAllowMaxHeight:(CGFloat)maxHeight {
    self = [super init];
    if (self) {
        _container = container;
        _allowMaxHeight = maxHeight;
        _dicLayoutViews = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)dealloc {
    [self inner_Finallize];
    [_dicLayoutViews release];
    [_rootView release];
    [super dealloc];
}

- (void)loadData {
    [self inner_Finallize];
    [_rootView release];
    
    FSVerticalLayoutStyle layoutStyle = [_parentDelegate verticalLayoutObjectStyle:self withIndex:_currentIndex];
    NSNumber *numKey = [[NSNumber alloc] initWithInt:_currentIndex];
    if (layoutStyle == FSVerticalLayoutStyle_Picture) {
        _rootView = [[FSVerticalPictureView alloc] initWithFrame:CGRectZero];
        [_dicLayoutViews setObject:_rootView forKey:numKey];
    } else if (layoutStyle == FSVerticalLayoutStyle_Text) {
        _rootView = [[FSVerticalLabelView alloc] initWithFrame:CGRectZero];
        [_dicLayoutViews setObject:_rootView forKey:numKey];
    }
    [numKey release];
}

- (void)inner_Finallize {
    NSArray *keys = [_dicLayoutViews allKeys];
    for (NSNumber *numKey in keys) {
        UIView *vLayout = [_dicLayoutViews objectForKey:numKey];
        if (vLayout) {
            [vLayout removeFromSuperview];
        }
    }
    
    [_dicLayoutViews removeAllObjects];
    _currentIndex = 0;
}

@end
