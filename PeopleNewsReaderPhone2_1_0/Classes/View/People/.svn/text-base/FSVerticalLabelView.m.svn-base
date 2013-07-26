//
//  FSVerticalLabelView.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-7.
//
//

#import "FSVerticalLabelView.h"

@implementation FSVerticalLabelView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _lblContent = [[UILabel alloc] initWithFrame:CGRectZero];
        [_lblContent setBackgroundColor:[UIColor clearColor]];
        [_lblContent setTextColor:[UIColor blackColor]];
        [_lblContent setFont:[UIFont systemFontOfSize:16.0f]];
        [_lblContent setNumberOfLines:1024];
        [self addSubview:_lblContent];
    }
    return self;
}

- (void)dealloc {
    [_lblContent release];
    [super dealloc];
}

- (void)setFont:(UIFont *)value {
    [_lblContent setFont:value];
}

- (void)setNumberOfLines:(NSInteger)value {
    [_lblContent setNumberOfLines:value];
}

- (void)doSomethingWithContent:(NSString *)content {
    if (!content) {
        return;
    }
    
    _lblContent.text = content;
    CGSize sizeContent = CGSizeZero;
    
    if (_lblContent.numberOfLines == 1) {
        sizeContent = [_lblContent.text sizeWithFont:_lblContent.font];
    } else {
        sizeContent = [_lblContent.text sizeWithFont:_lblContent.font
                                   constrainedToSize:CGSizeMake(self.fixWidth, 8192)
                                       lineBreakMode:_lblContent.lineBreakMode];
    }
    
    _lblContent.frame = CGRectMake((self.fixWidth - sizeContent.width) / 2.0f,
                                   0.0f,
                                   sizeContent.width,
                                   sizeContent.height);
    
    self.layoutSize = CGSizeMake(self.fixWidth, sizeContent.height);
}

- (CGFloat)adjustmentHeightWithDistanceToBottom:(CGFloat)distance {
    CGRect rLbl = _lblContent.frame;
    rLbl.size.height = distance;
    _lblContent.frame = rLbl;
    return distance;
}

@end
