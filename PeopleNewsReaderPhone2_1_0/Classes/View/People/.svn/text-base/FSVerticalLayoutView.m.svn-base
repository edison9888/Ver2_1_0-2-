//
//  FSVerticalLayoutView.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-7.
//
//

#import "FSVerticalLayoutView.h"

@interface FSVerticalLayoutView()
- (void)inner_LayoutSize;
- (void)inner_ReleaseLayoutView;
@end

@implementation FSVerticalLayoutView
@synthesize content = _content;
@synthesize top = _top;
@synthesize lineSpace = _lineSpace;
@synthesize bottom = _bottom;
@synthesize layoutSize = _layoutSize;
@synthesize fixWidth = _fixWidth;
@synthesize allowMaxHeight = _allowMaxHeight;
@synthesize parentDelegate = _parentDelgate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _nextLayoutView = nil;
        _layoutSize = CGSizeZero;
        _fixWidth = 0;
        _lineSpace = 8.0f;
        _bottom = 12.0f;
        _top = 12.0f;
        _left = 12.0f;
    }
    return self;
}

- (void)dealloc {
    FSLog(@"%@.dealloc", self);
    [_nextLayoutView release];
    [_content release];
    [super dealloc];
}

- (void)setParentDelegate:(id)value {
    _parentDelgate = value;
    if (_nextLayoutView) {
        _nextLayoutView.parentDelegate = _parentDelgate;
    }
}

- (void)setFixWidth:(CGFloat)value {
    if (value != _fixWidth) {
        _fixWidth = value;
        
        [self doSomethingWithContent:_content];
    }
}

- (void)setAllowMaxHeight:(CGFloat)value {
    if (value != _allowMaxHeight) {
        _allowMaxHeight = value;
        if (_nextLayoutView) {
            _nextLayoutView.allowMaxHeight = _allowMaxHeight;
        }
    }
}

- (void)setLeft:(CGFloat)value {
    if (value != _left) {
        _left = value;
        CGRect rFrame = self.frame;
        rFrame.origin.x = _left;
        self.frame = rFrame;
        if (_nextLayoutView) {
            _nextLayoutView.left = _left;
        }
    }
}

- (void)setTop:(CGFloat)value {
    if (value != _top) {
        _top = value;
        
        [self inner_LayoutSize];
    }
}

- (void)setLayoutSize:(CGSize)value {
    if (!CGSizeEqualToSize(value, _layoutSize)) {
        _layoutSize = value;
        [self inner_LayoutSize];
    }
}

- (void)inner_LayoutSize {
    CGRect rFrame = self.frame;
    rFrame.origin.y = _top;
    rFrame.origin.x = _left;
    rFrame.size.width = _layoutSize.width;
    rFrame.size.height = _layoutSize.height;
    
    CGFloat nextSpace = _nextLayoutView ? _lineSpace : _bottom;
    
    
    if (_allowMaxHeight > 0 && rFrame.origin.y + _layoutSize.height + nextSpace > _allowMaxHeight) {
        rFrame.size.height = [self adjustmentHeightWithDistanceToBottom:(_allowMaxHeight - rFrame.origin.y - nextSpace)];
        self.frame = rFrame;
        
        if ([_parentDelgate respondsToSelector:@selector(verticalLayoutMoreThanMaxHeight:)]) {
            [_parentDelgate verticalLayoutMoreThanMaxHeight:self];
        }
        
//        if (_nextLayoutView) {
//            _nextLayoutView.top = _top + rFrame.size.height + _lineSpace;
//        }
        
        if (rFrame.size.height > 0) {
            [self setVerticalLayoutView:nil];
            
            if (_nextLayoutView) {
                [_nextLayoutView inner_ReleaseLayoutView];
            }
        }

    } else  {
        
        self.frame = rFrame;
        
        if (_nextLayoutView) {
            _nextLayoutView.top = _top + _layoutSize.height + _lineSpace;
        }
    }
    
    if ([_parentDelgate respondsToSelector:@selector(verticalLayoutCurrentHeight:withCurrentHeight:)]) {
        [_parentDelgate verticalLayoutCurrentHeight:self withCurrentHeight:self.frame.origin.y + self.frame.size.height + nextSpace];
    }
}

- (CGFloat)adjustmentHeightWithDistanceToBottom:(CGFloat)distance {
    return 0;
}

- (void)setVerticalLayoutView:(FSVerticalLayoutView *)value {
    if (value != _nextLayoutView) {
        [_nextLayoutView release];
        _nextLayoutView = [value retain];
        if (_nextLayoutView) {
            _nextLayoutView.fixWidth = _fixWidth;
            _nextLayoutView.allowMaxHeight = _allowMaxHeight;
            _nextLayoutView.left = _left;
            _nextLayoutView.parentDelegate = _parentDelgate;
            _nextLayoutView.top = _top + _layoutSize.height + _lineSpace;
            FSLog(@"_nextLayoutView.top:%f", _nextLayoutView.top);
        }
    }
}

- (void)setContent:(NSString *)value {
    if (value != _content) {
        [_content release];
        _content = [value retain];
        
        [self doSomethingWithContent:_content];
    }
}

- (void)doSomethingWithContent:(NSString *)content {
    //处理图片或者文字
    
}

- (void)inner_ReleaseLayoutView {
    if ([_parentDelgate respondsToSelector:@selector(verticalLayoutRelease:)]) {
        [_parentDelgate verticalLayoutRelease:self];
    }
    
    [self setVerticalLayoutView:nil];
    
    if (_nextLayoutView) {
        [_nextLayoutView inner_ReleaseLayoutView];
    }
}

@end
