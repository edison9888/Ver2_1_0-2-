//
//  FSNewbieGuideView.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-4-3.
//
//

#import "FSNewbieGuideView.h"

@implementation FSNewbieGuideView

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
    
}

-(void)doSomethingAtInit{
    _stepIndex = 0;
    self.backgroundColor = [UIColor colorWithRed:239.0f/255.0f green:239.0f/255.0f blue:239.0f/255.0f alpha:1.0];//239 239 239
    
}

-(void)doSomethingAtLayoutSubviews{
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftAction:)];
    swipeRight.delegate = self;
    swipeRight.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swipeRight];
    [swipeRight release];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightAction:)];
    swipeLeft.delegate = self;
    swipeLeft.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:swipeLeft];
    [swipeLeft release];
    
    [self shouView:_stepIndex];
}


-(void)shouView:(NSInteger)index{
    
    CGFloat titleBegin = 20;
    if (self.frame.size.height>480) {
        titleBegin = 40;
    }
    
    NSArray *array = [self subviews];
    for (UIView *v in array) {
        [v removeFromSuperview];
    }
    
    if (index==0) {
        UILabel *lab_1 = [[UILabel alloc] init];
        lab_1.backgroundColor = COLOR_CLEAR;
        lab_1.textColor = COLOR_RED;
        lab_1.text = @"我的头条";
        lab_1.textAlignment = UITextAlignmentCenter;
        lab_1.font = [UIFont systemFontOfSize:24];
        
        
        UILabel *lab_2 = [[UILabel alloc] init];
        lab_2.backgroundColor = COLOR_CLEAR;
        lab_2.textColor = COLOR_NEWSLIST_DESCRIPTION;
        lab_2.text = @"订阅精品频道，挑选我的最爱\rDIY我自己的剪报夹";
        lab_2.textAlignment = UITextAlignmentCenter;
        lab_2.font = [UIFont systemFontOfSize:16];
        lab_2.numberOfLines = 5;
        
        UILabel *lab_3 = [[UILabel alloc] init];
        lab_3.backgroundColor = COLOR_CLEAR;
        lab_3.textColor = COLOR_RED;
        lab_3.text = @"1/3";
        lab_3.textAlignment = UITextAlignmentCenter;
        lab_3.font = [UIFont systemFontOfSize:16];
        
        UIImageView *imageview = [[UIImageView alloc] init];
        imageview.image = [UIImage imageNamed:@"toutiao.png"];
        
        UIButton *button = [[UIButton alloc] init];
        UIImage *btimage = [UIImage imageNamed:@"next_btn.png"];
        [button setImage:btimage forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonSelect:) forControlEvents:UIControlEventTouchUpInside];
        
        
        imageview.frame = CGRectMake((self.frame.size.width-imageview.image.size.width)/2, (self.frame.size.height-imageview.image.size.height)/2, imageview.image.size.width, imageview.image.size.height);
        
        lab_1.frame = CGRectMake(0, titleBegin, self.frame.size.width, 30);
        lab_2.frame = CGRectMake(0, titleBegin+30, self.frame.size.width, 80);
        
        button.frame = CGRectMake((self.frame.size.width - btimage.size.width)/2, self.frame.size.height-110, btimage.size.width, btimage.size.height);
        lab_3.frame = CGRectMake(0, button.frame.origin.y +button.frame.size.height+10, self.frame.size.width, 30);
        
        [self addSubview:button];
        [self addSubview:imageview];
        [self addSubview:lab_1];
        [self addSubview:lab_2];
        [self addSubview:lab_3];
        [lab_1 release];
        [lab_2 release];
        [lab_3 release];
        [imageview release];
        [button release];
    }
    
    if (index==1) {
        UILabel *lab_1 = [[UILabel alloc] init];
        lab_1.backgroundColor = COLOR_CLEAR;
        lab_1.textColor = COLOR_RED;
        lab_1.text = @"深度";
        lab_1.textAlignment = UITextAlignmentCenter;
        lab_1.font = [UIFont systemFontOfSize:24];
        
        
        UILabel *lab_2 = [[UILabel alloc] init];
        lab_2.backgroundColor = COLOR_CLEAR;
        lab_2.textColor = COLOR_NEWSLIST_DESCRIPTION;
        lab_2.text = @"每周\"十问\",日日精彩\r深度杂志一手掌控";
        lab_2.textAlignment = UITextAlignmentCenter;
        lab_2.font = [UIFont systemFontOfSize:16];
        lab_2.numberOfLines = 5;
        
        UILabel *lab_3 = [[UILabel alloc] init];
        lab_3.backgroundColor = COLOR_CLEAR;
        lab_3.textColor = COLOR_RED;
        lab_3.text = @"2/3";
        lab_3.textAlignment = UITextAlignmentCenter;
        lab_3.font = [UIFont systemFontOfSize:16];
        
        UIImageView *imageview = [[UIImageView alloc] init];
        imageview.image = [UIImage imageNamed:@"shendu.png"];
        
        UIButton *button = [[UIButton alloc] init];
        UIImage *btimage = [UIImage imageNamed:@"next_btn.png"];
        [button setImage:btimage forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonSelect:) forControlEvents:UIControlEventTouchUpInside];
        
        
        imageview.frame = CGRectMake((self.frame.size.width-imageview.image.size.width)/2, (self.frame.size.height-imageview.image.size.height)/2, imageview.image.size.width, imageview.image.size.height);
        
        lab_1.frame = CGRectMake(0, titleBegin, self.frame.size.width, 30);
        lab_2.frame = CGRectMake(0, titleBegin+30, self.frame.size.width, 80);
        
        button.frame = CGRectMake((self.frame.size.width - btimage.size.width)/2, self.frame.size.height-110, btimage.size.width, btimage.size.height);
        lab_3.frame = CGRectMake(0, button.frame.origin.y +button.frame.size.height+10, self.frame.size.width, 30);
        
        [self addSubview:button];
        [self addSubview:imageview];
        [self addSubview:lab_1];
        [self addSubview:lab_2];
        [self addSubview:lab_3];
        [lab_1 release];
        [lab_2 release];
        [lab_3 release];
        [imageview release];
        [button release];
    }
    
    if (index==2) {
        UILabel *lab_1 = [[UILabel alloc] init];
        lab_1.backgroundColor = COLOR_CLEAR;
        lab_1.textColor = COLOR_RED;
        lab_1.text = @"人民新闻客户端";
        lab_1.textAlignment = UITextAlignmentCenter;
        lab_1.font = [UIFont systemFontOfSize:24];
        
        
        UILabel *lab_2 = [[UILabel alloc] init];
        lab_2.backgroundColor = COLOR_CLEAR;
        lab_2.textColor = COLOR_NEWSLIST_DESCRIPTION;
        lab_2.text = @"望看高层动态,倾听百姓里短;\r品读国际百味，关注环球军情;\r融入身边世界，我们做有温度的新闻。";
        lab_2.textAlignment = UITextAlignmentCenter;
        lab_2.font = [UIFont systemFontOfSize:16];
        lab_2.numberOfLines = 5;
        
        UILabel *lab_3 = [[UILabel alloc] init];
        lab_3.backgroundColor = COLOR_CLEAR;
        lab_3.textColor = COLOR_RED;
        lab_3.text = @"3/3";
        lab_3.textAlignment = UITextAlignmentCenter;
        lab_3.font = [UIFont systemFontOfSize:16];
        
        UIImageView *imageview = [[UIImageView alloc] init];
        imageview.image = [UIImage imageNamed:@"kehuduan.png"];
        
        UIButton *button = [[UIButton alloc] init];
        UIImage *btimage = [UIImage imageNamed:@"read_btn.png"];
        [button setImage:btimage forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonSelect:) forControlEvents:UIControlEventTouchUpInside];
        
        
        imageview.frame = CGRectMake((self.frame.size.width-imageview.image.size.width)/2, (self.frame.size.height-imageview.image.size.height)/2, imageview.image.size.width, imageview.image.size.height);
        
        lab_1.frame = CGRectMake(0, titleBegin, self.frame.size.width, 30);
        lab_2.frame = CGRectMake(0, titleBegin+30, self.frame.size.width, 80);
        
        button.frame = CGRectMake((self.frame.size.width - btimage.size.width)/2, self.frame.size.height-110, btimage.size.width, btimage.size.height);
        lab_3.frame = CGRectMake(0, button.frame.origin.y +button.frame.size.height+10, self.frame.size.width, 30);
        
        [self addSubview:button];
        [self addSubview:imageview];
        [self addSubview:lab_1];
        [self addSubview:lab_2];
        [self addSubview:lab_3];
        [lab_1 release];
        [lab_2 release];
        [lab_3 release];
        [imageview release];
        [button release];
    }
    
}

-(void)buttonSelect:(id)sender{
    _stepIndex++;
    if (_stepIndex>2) {
        self.alpha = 0.0f;
        [self sendTouchEvent];
        return;
    }
    [self shouView:_stepIndex];
}

-(void)swipeLeftAction:(id)sender{
    _stepIndex++;
    if (_stepIndex>2) {
        self.alpha = 0.0f;
        [self sendTouchEvent];
        return;
    }
    [self shouView:_stepIndex];
}


-(void)swipeRightAction:(id)sender{
    if (_stepIndex>0) {
        _stepIndex--;
    }
    [self shouView:_stepIndex];
}

@end
