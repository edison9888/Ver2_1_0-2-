//
//  FSShareNoticView.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-12-16.
//
//

#import "FSShareNoticView.h"

@implementation FSShareNoticView

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
    [_lab_title release];
}


-(void)doSomethingAtInit{
    
    _background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Share_tishi.png"]];
    _lab_title = [[UILabel alloc] init];
    _lab_title.textAlignment = UITextAlignmentCenter;
    _lab_title.textColor = COLOR_NEWSLIST_TITLE;
    _lab_title.font = [UIFont systemFontOfSize:16.0f];
    _lab_title.backgroundColor = COLOR_CLEAR;
    
    [self addSubview:_background];
    [self addSubview:_lab_title];
    
}


-(void)doSomethingAtLayoutSubviews{
    
    if (self.data!=nil) {
        _lab_title.text = (NSString *)self.data;
    }
    
    _background.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _lab_title.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
}



@end
