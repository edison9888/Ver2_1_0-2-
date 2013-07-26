//
//  FSDeepPriorListCell.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-12.
//
//

#import <UIKit/UIKit.h>
#import "FSDeepPriorListExView.h"

@interface FSDeepPriorListCell : UITableViewCell {
@private
    FSDeepPriorListExView *_oneExView;
    FSDeepPriorListExView *_twoExView;
    
    NSIndexPath *_indexPath;
    CGFloat _cellShouldWidth;
    id _parentDelegate;
    
    UIImageView *_topBGRimage;
    UIImageView *_mBGRimage;
    UIImageView *_bottomBGRimage;
}

@property (nonatomic, assign) id parentDelegate;
@property (nonatomic) CGFloat cellShouldWidth;
@property (nonatomic, retain) NSIndexPath *indexPath;

- (void)setOneTopicPriorObject:(FSTopicPriorObject *)value;
- (void)setTwoTopicPriorObject:(FSTopicPriorObject *)value;

@end

@protocol FSDeepPriorListCell <NSObject>
@optional
- (void)deepPriorListCell:(FSDeepPriorListCell *)sender withDeepPriorListExView:(FSDeepPriorListExView *)listView;
@end

