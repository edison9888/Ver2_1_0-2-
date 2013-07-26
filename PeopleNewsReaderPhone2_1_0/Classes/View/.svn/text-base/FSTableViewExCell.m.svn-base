//
//  FSTableViewExCell.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-12.
//
//

#import "FSTableViewExCell.h"

@implementation FSTableViewExCell
@synthesize indexPath = _indexPath;
@synthesize data = _data;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _layoutSize = CGSizeZero;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_data release];
    [_indexPath release];
    [super dealloc];
}

- (CGFloat)cellWidth {
    CGFloat result = 0.0f;
    if (self.superview != nil) {
        result = self.superview.frame.size.width;
    }
    return result;
}

- (CGFloat)cellHeight {
    if (CGSizeEqualToSize(_layoutSize, CGSizeZero)) {
        _layoutSize = [self layoutCellSubviews:NO];
        return _layoutSize.height;
    }
    return _layoutSize.height;
}

- (void)setFrame:(CGRect)value {
    CGRect rOld = self.frame;
    [super setFrame:value];
    if (_data) {
        BOOL isNeedLayout = !CGSizeEqualToSize(rOld.size, self.frame.size);
        if (isNeedLayout) {
            _layoutSize = [self layoutCellSubviews:YES];
        }
    }
}

- (void)setData:(NSObject *)value {
    if (value != _data) {
        [_data release];
        _data = [value retain];
        
        if (_data) {
            _layoutSize = [self layoutCellSubviews:YES];
        }
    }
}

- (CGSize)layoutCellSubviews:(BOOL)isLayout {
    CGSize result = CGSizeZero;
    return result;
}

@end
