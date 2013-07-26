//
//  FSFeedbackTypeSelectionView.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-10-8.
//
//

#import "FSFeedbackTypeSelectionView.h"
#import <QuartzCore/QuartzCore.h>

@implementation FSFeedbackTypeSelectionView

@synthesize currentIndex = _currentIndex;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)doSomethingAtDealloc{
    [_scrollView release];
    [_selectedBGR release];
}


-(void)doSomethingAtInit{
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.delegate = self;
    _selectedBGR = [[UILabel alloc] init];
    _selectedBGR.layer.cornerRadius = 6.0;
    _selectedBGR.tag = 9999;
    _currentIndex = 0;
    _selectedBGR.backgroundColor = COLOR_RED_TYPE;
    [self addSubview:_scrollView];
}

-(void)doSomethingAtLayoutSubviews{
    _scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    NSArray *v = [_scrollView subviews];
    for (UIView *o in v) {
        [o removeFromSuperview];
    }
    [_scrollView addSubview:_selectedBGR];
    _textwidth = 36.0f;
    int i=0;
    for (i=0; i<10; i++) {
    
        UILabel *lab_type = [[UILabel alloc] init];
        lab_type.userInteractionEnabled = YES;
        lab_type.text = @"反馈类型";
        lab_type.textAlignment = UITextAlignmentCenter;
        lab_type.backgroundColor = COLOR_CLEAR;
        //lab_type.textColor = COLOR_NEWSLIST_TITLE_WHITE;
        lab_type.font = [UIFont systemFontOfSize:8];
        lab_type.frame = CGRectMake(3+_textwidth*i, 2, _textwidth, self.frame.size.height-4);
        lab_type.tag = i;
        [_scrollView addSubview:lab_type];
        [lab_type release];
         
    }
    _selectedBGR.frame = CGRectMake(3+_textwidth*_currentIndex, 2, _textwidth, self.frame.size.height-4);
    _scrollView.contentSize = CGSizeMake(6+_textwidth*i, self.frame.size.height);
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGes:)];
    [_scrollView addGestureRecognizer:tapGes];
    [tapGes release];
}


//touch
- (void)handleGes:(UITapGestureRecognizer *)ges {
    
    if (ges.state == UIGestureRecognizerStateEnded) {
        CGPoint pt = [ges locationInView:_scrollView];
        UIView *hitView = [_scrollView hitTest:pt withEvent:nil];
//#ifndef MYDEBUG
        NSLog(@"UITapGestureRecognizer hitView:%@",[hitView class]);
//#endif
        UILabel *lab_type;
        if ([hitView isKindOfClass:[UILabel class]]) {
            lab_type = (UILabel *)hitView;
            if (lab_type.tag != 9999) {
                _currentIndex = lab_type.tag;
                _selectedBGR.frame = CGRectMake(3+_textwidth*_currentIndex, 2, _textwidth, self.frame.size.height-4);
                [self sendTouchEvent];
            }
        }
        else{
            return;
        }
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
