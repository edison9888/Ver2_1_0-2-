//
//  FSDeepTextView.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-7.
//
//

#import "FSDeepTextView.h"
#import "FSHTTPWebExData.h"
#import "FSCommonFunction.h"
#import "FSVerticalLabelView.h"
#import "FSVerticalPictureView.h"

#define FSDEEP_TEXT_LEFT_RIGHT_SPACE 12.0f
#define FSDEEP_TEXT_ROW_SPACE 8.0f
#define FSDEEP_TEXT_TOP_BOTTOM_SPACE 12.0f

@interface FSDeepTextView()
- (void)inner_Layout;
@end

@implementation FSDeepTextView
@synthesize contentObject = _contentObject;
@synthesize pictureFlag = _pictureFlag;
@synthesize textFlag = _textFlag;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moreThanMaxHeight:) name:FSVERTICAL_LAYOUT_MORE_THAN_MAXHEIGHT_NOTIFICATION object:nil];
    }
    return self;
}

- (void)dealloc {

    [_layoutViews removeAllObjects];
    [_layoutViews release];
    [_btnMore release];
    
    [_contentObject release];
    [super dealloc];
}

- (void)setFrame:(CGRect)value {
    BOOL needLayout = CGSizeEqualToSize(self.frame.size, value.size);
    [super setFrame:value];
    if (needLayout) {
        
        [self inner_Layout];
    }
}

- (void)setContentObject:(FSDeepContentObject *)value {
    if (value != _contentObject) {
        [_contentObject release];
        _contentObject = [value retain];

        for (UIView *childView in _layoutViews) {
            [childView removeFromSuperview];
        }
        
        [_layoutViews removeAllObjects];
        
        [self inner_Layout];
    }
}

- (void)inner_Layout {

    CGFloat left = FSDEEP_TEXT_LEFT_RIGHT_SPACE;
    CGFloat top = FSDEEP_TEXT_TOP_BOTTOM_SPACE;
    CGFloat clientWidth = self.frame.size.width - FSDEEP_TEXT_LEFT_RIGHT_SPACE * 2.0f;
    
    //STEP 1.
    FSVerticalLabelView *rootView = [[FSVerticalLabelView alloc] initWithFrame:CGRectZero];
    [rootView setFont:[UIFont boldSystemFontOfSize:18.0f]];
    [rootView setNumberOfLines:3];
    rootView.fixWidth = clientWidth;
    rootView.top = top;
    rootView.left = left;
    rootView.parentDelegate = self;
    rootView.allowMaxHeight = self.frame.size.height - 24;
    [_layoutViews addObject:rootView];
    [self addSubview:rootView];
    rootView.content = _contentObject.title;
    [rootView release];
    
    FSVerticalLayoutView *parentView = rootView;
    
    //STEP 2.
    NSString *subTitle = nil;
    if ((_contentObject.pubDate != nil && ![_contentObject.pubDate isEqualToString:@""]) ||
        (_contentObject.source != nil && ![_contentObject.source isEqualToString:@""])) {
        
        if (_contentObject.pubDate != nil && ![_contentObject.pubDate isEqualToString:@""] &&
            _contentObject.source != nil && ![_contentObject.source isEqualToString:@""]) {
            //全部存在
            subTitle = [[NSString alloc] initWithFormat:@"%@    %@", _contentObject.pubDate, _contentObject.source];
        } else if (_contentObject.pubDate != nil && ![_contentObject.pubDate isEqualToString:@""]) {
            subTitle = [[NSString alloc] initWithFormat:@"%@", _contentObject.pubDate];
        } else if (_contentObject.source != nil && ![_contentObject.source isEqualToString:@""]) {
            subTitle = [[NSString alloc] initWithFormat:@"%@", _contentObject.source];
        }
        
        FSVerticalLabelView *subTitleView = [[FSVerticalLabelView alloc] initWithFrame:CGRectZero];
        [subTitleView setFont:[UIFont systemFontOfSize:16.0f]];
        [subTitleView setNumberOfLines:1];
        [self addSubview:subTitleView];
        [_layoutViews addObject:subTitleView];
        [parentView setVerticalLayoutView:subTitleView];
        subTitleView.content = subTitle;
        parentView = subTitleView;
        [subTitleView release];
    }
    [subTitle release];

    //STEP 3.
    NSSet *contentSet = _contentObject.childContent;
    FSLog(@"contentSet.count:%d", [contentSet count]);
    NSEnumerator *enumerator = [contentSet objectEnumerator];
    //进行一次排序
    NSArray *allObjects = [[enumerator allObjects] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if ([obj1 isKindOfClass:[FSDeepContent_ChildObject class]] &&
            [obj2 isKindOfClass:[FSDeepContent_ChildObject class]]) {
            NSInteger obj1Index = [((FSDeepContent_ChildObject *)obj1).orderIndex intValue];
            NSInteger obj2Index = [((FSDeepContent_ChildObject *)obj2).orderIndex intValue];
            
            if (obj1Index > obj2Index) {
                return (NSComparisonResult)NSOrderedDescending;
            } else if (obj1Index < obj2Index) {
                return (NSComparisonResult)NSOrderedAscending;
            } else  {
                return (NSComparisonResult)NSOrderedSame;
            }
        } else {
            return NSOrderedSame;
        }
    }];
    FSLog(@"allObjects:%d", [allObjects count]);
    for (int i = 0; i < [allObjects count]; i++) {
        FSDeepContent_ChildObject *childObj = (FSDeepContent_ChildObject *)[allObjects objectAtIndex:i];
        NSInteger flag = [childObj.flag intValue];
        FSLog(@"flag:%@", childObj.flag);
        if (flag == _textFlag) {
            FSVerticalLabelView *lblView = [[FSVerticalLabelView alloc] initWithFrame:CGRectZero];
            [lblView setFont:[UIFont systemFontOfSize:16.0f]];
            [lblView setNumberOfLines:1024];
            [self addSubview:lblView];
            [_layoutViews addObject:lblView];
            [parentView setVerticalLayoutView:lblView];
            lblView.content = childObj.content;
            parentView = lblView;
            [lblView release];
        } else if (flag == _pictureFlag) {
            FSVerticalPictureView *picView = [[FSVerticalPictureView alloc] initWithFrame:CGRectZero];
            [self addSubview:picView];
            [_layoutViews addObject:picView];
            [parentView setVerticalLayoutView:picView];
            picView.content = childObj.content;
            parentView = picView;
            [picView release];
        }
    }
    
    FSLog(@"DEEPText.subviews:%@", [self subviews]);
}

- (void)verticalLayoutMoreThanMaxHeight:(FSVerticalLayoutView *)sender {
    FSLog(@"morethanMaxHeight");
}

- (void)verticalLayoutRelease:(FSVerticalLayoutView *)sender {
    NSInteger objIndex = [_layoutViews indexOfObject:sender];
    if (objIndex >= 0 && objIndex < [_layoutViews count]) {
        [sender removeFromSuperview];
        [_layoutViews removeObject:sender];
    }
}

@end
