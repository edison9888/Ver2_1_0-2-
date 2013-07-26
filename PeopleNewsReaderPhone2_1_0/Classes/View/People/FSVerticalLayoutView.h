//
//  FSVerticalLayoutView.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-7.
//
//

#import <UIKit/UIKit.h>

#define FSVERTICAL_LAYOUT_MORE_THAN_MAXHEIGHT_NOTIFICATION @"FSVERTICAL_LAYOUT_MORE_THAN_MAXHEIGHT_NOTIFICATION_STRING"


@interface FSVerticalLayoutView : UIView {
@private
    CGFloat _top;
    CGFloat _left;
    CGFloat _bottom;
    CGFloat _lineSpace;
    CGFloat _fixWidth;
    CGFloat _allowMaxHeight;

    FSVerticalLayoutView *_nextLayoutView;
    FSVerticalLayoutView *_parentLayoutView;
    CGSize _layoutSize;
    
    NSString *_content;
    
    id _parentDelgate;
}

@property (nonatomic) CGSize layoutSize;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat lineSpace;
@property (nonatomic) CGFloat fixWidth;
@property (nonatomic) CGFloat allowMaxHeight;
@property (nonatomic, assign) id parentDelegate;

@property (nonatomic, retain) NSString *content;

- (void)setVerticalLayoutView:(FSVerticalLayoutView *)value;

- (void)doSomethingWithContent:(NSString *)content;

- (CGFloat)adjustmentHeightWithDistanceToBottom:(CGFloat)distance;

@end

@protocol FSVerticalLayoutViewDelegate <NSObject>
@optional
- (void)verticalLayoutMoreThanMaxHeight:(FSVerticalLayoutView *)sender;
- (void)verticalLayoutCurrentHeight:(FSVerticalLayoutView *)sender withCurrentHeight:(CGFloat)currentHeight;
- (void)verticalLayoutRelease:(FSVerticalLayoutView *)sender;
@end


