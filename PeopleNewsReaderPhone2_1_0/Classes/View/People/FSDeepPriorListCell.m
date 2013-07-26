//
//  FSDeepPriorListCell.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-12.
//
//

#import "FSDeepPriorListCell.h"

@implementation FSDeepPriorListCell
@synthesize indexPath = _indexPath;
@synthesize cellShouldWidth = _cellShouldWidth;
@synthesize parentDelegate = _parentDelegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *contentBGR = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"deep_baground.png"]];
        self.backgroundView = contentBGR;
        [contentBGR release];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        [self.contentView addGestureRecognizer:tapGesture];
        [tapGesture release];
        
        _topBGRimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"deep_history_cellTOP.png"]];
        _mBGRimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"deep_history_cellM.png"]];
        _bottomBGRimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"deep_history_cellBOT.png"]];
        
        [self.contentView addSubview:_mBGRimage];
        [self.contentView addSubview:_topBGRimage];
        [self.contentView addSubview:_bottomBGRimage];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_oneExView release];
    [_twoExView release];
    [_indexPath release];
    [_topBGRimage release];
    [_mBGRimage release];
    [_bottomBGRimage release];
    [super dealloc];
}

- (void)setOneTopicPriorObject:(FSTopicPriorObject *)value {
    if (value != nil) {
        if (_oneExView == nil) {
            _oneExView = [[FSDeepPriorListExView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _cellShouldWidth / 2.0f, self.frame.size.height)];
            [self.contentView addSubview:_oneExView];
        }
        _oneExView.indexPath = [NSIndexPath indexPathForRow:_indexPath.row * 2 + 0 inSection:_indexPath.section];
        _oneExView.topicPriorObject = value;
    } else {
        if (_oneExView != nil) {
            [_oneExView removeFromSuperview];
            [_oneExView release];
            _oneExView = nil;
        }
    }
}

- (void)setFrame:(CGRect)value {
    //BOOL needLayout = !CGSizeEqualToSize(value.size, self.frame.size);
    [super setFrame:value];
//    if (needLayout) {
//        _oneExView.frame = CGRectMake(0.0f, 0.0f, _cellShouldWidth / 2.0f, self.frame.size.height);
//        _twoExView.frame = CGRectMake(_cellShouldWidth / 2.0f, 0.0f, _cellShouldWidth / 2.0f, self.frame.size.height);
//    }
    
    _topBGRimage.frame = CGRectMake(0.0f, 4.0f, self.frame.size.width, _topBGRimage.image.size.height);
    
    _mBGRimage.frame = CGRectMake(0.0f, _topBGRimage.image.size.height, self.frame.size.width, self.frame.size.height-_topBGRimage.image.size.height- _bottomBGRimage.image.size.height+4);
    
    _bottomBGRimage.frame = CGRectMake(0.0f, self.frame.size.height-_bottomBGRimage.image.size.height-4, self.frame.size.width, _bottomBGRimage.image.size.height);
    
    _oneExView.frame = CGRectMake(0.0f, 0.0f, _cellShouldWidth / 2.0f, self.frame.size.height);
    _twoExView.frame = CGRectMake(_cellShouldWidth / 2.0f, 0.0f, _cellShouldWidth / 2.0f, self.frame.size.height);
}

- (void)setTwoTopicPriorObject:(FSTopicPriorObject *)value {
    if (value != nil) {
        if (_twoExView == nil) {
            _twoExView = [[FSDeepPriorListExView alloc] initWithFrame:CGRectMake(_cellShouldWidth / 2.0f, 0.0f, _cellShouldWidth / 2.0f, self.frame.size.height)];
            [self.contentView addSubview:_twoExView];
        }
        _twoExView.indexPath = [NSIndexPath indexPathForRow:_indexPath.row * 2 + 1 inSection:_indexPath.section];
        _twoExView.topicPriorObject = value;
    } else {
        if (_twoExView != nil) {
            [_twoExView removeFromSuperview];
            [_twoExView release];
            _twoExView = nil;
        }
    }
}

- (void)handleGesture:(UIGestureRecognizer *)gesture {
    NSLog(@"deepPriorListCell: handleGesture");
    if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
        CGPoint pt = [gesture locationInView:self.contentView];
        UIView *touchView = [self.contentView hitTest:pt withEvent:nil];
        NSLog(@"touchView:%@",touchView);
        if ([touchView isKindOfClass:[FSDeepPriorListExView class]]) {
            if ([_parentDelegate respondsToSelector:@selector(deepPriorListCell:withDeepPriorListExView:)]) {
                [_parentDelegate deepPriorListCell:self withDeepPriorListExView:(FSDeepPriorListExView *)touchView];
            }
        }
    }
}

@end
