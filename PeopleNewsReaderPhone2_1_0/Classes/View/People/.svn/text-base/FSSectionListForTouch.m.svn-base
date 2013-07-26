//
//  FSSectionListForTouch.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-12-18.
//
//

#import "FSSectionListForTouch.h"

@implementation FSSectionListForTouch

@synthesize currentIdex = _currentIndex;



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)doSomethingAtDealloc{
    
    [_background release];
}


-(void)doSomethingAtInit{
    
    _background = [[UIImageView alloc] init];
    _background.image = [UIImage imageNamed:@"cityList.png"];
    
    [self addSubview:_background];
    
}



-(void)doSomethingAtLayoutSubviews{
    
    _background.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
    _background.alpha = 0.0f;
    NSArray *content = (NSArray *)self.data;
    
    lindheight = self.frame.size.height/[content count];
    
    for (NSInteger i=0; i<[content count]; i++) {
        UILabel *lab = [[UILabel alloc] init];
        lab.text = [content objectAtIndex:i];
        lab.frame = CGRectMake(0, lindheight*i, self.frame.size.width, lindheight);
        lab.textAlignment = UITextAlignmentCenter;
        lab.textColor = COLOR_NEWSLIST_TITLE;
        lab.backgroundColor = COLOR_CLEAR;
        lab.font = [UIFont systemFontOfSize:lindheight-8];
        lab.tag = i;
        lab.userInteractionEnabled = YES;
        [self addSubview:lab];
        [lab release];
    }
    UILongPressGestureRecognizer *tapGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleGes:)];
    tapGes.minimumPressDuration = 0.08;
    [self addGestureRecognizer:tapGes];
    [tapGes release];
    
}


- (void)handleGes:(UILongPressGestureRecognizer *)ges {
    
    if (ges.state == UIGestureRecognizerStateChanged) {
        
        CGPoint pt = [ges locationInView:self];
        _background.alpha = 1.0f;
        self.currentIdex = pt.y/lindheight;
        if (self.currentIdex<0) {
            self.currentIdex = 0;
            return;
        }
        [self sendTouchEvent];
        
    }else if (ges.state == UIGestureRecognizerStateBegan){
        _background.alpha = 1.0f;
        return;
    }else if (ges.state == UIGestureRecognizerStateEnded){
        _background.alpha = 0.0f;
        return;
    }
}


@end
