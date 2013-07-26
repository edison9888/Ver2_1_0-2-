//
//  FSDeepPageControllView.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-1-16.
//
//

#import "FSDeepPageControllView.h"
#import <QuartzCore/QuartzCore.h>

#define LEFT_RIGHT_SPACE 21.0f

@implementation FSDeepPageControllView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _leftArrow = [[UIImageView alloc] initWithFrame:CGRectZero];
        _leftArrow.image = [UIImage imageNamed:@"Deep_pageline.png"];
        _rightArrow = [[UIImageView alloc] initWithFrame:CGRectZero];
        _rightArrow.image = [UIImage imageNamed:@"Deep_pageline.png"];
        
        
        _leftArrow.transform = CGAffineTransformMakeRotation(M_PI);
        
        //[_leftArrow layer].transform = CATransform3DMakeRotation(-1, 0.0f, 0.0f, 1.0f);
        
        _midleImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        _midleImage.image = [UIImage imageNamed:@"deep_pageM.png"];
        
        
        _lab_pageIndex = [[UILabel alloc] initWithFrame:CGRectZero];
        _lab_pageIndex.backgroundColor = [UIColor clearColor];
        _lab_pageIndex.textColor = [UIColor redColor];
        _lab_pageIndex.textAlignment = UITextAlignmentRight;
        
        
        _lab_pageCount = [[UILabel alloc] initWithFrame:CGRectZero];
        _lab_pageCount.backgroundColor = [UIColor clearColor];
        _lab_pageCount.textColor = [UIColor darkGrayColor];
        _lab_pageCount.textAlignment = UITextAlignmentLeft;
        
        
        //[self addSubview:_midleImage];
        [self addSubview:_leftArrow];
        [self addSubview:_rightArrow];
        
        [self addSubview:_lab_pageIndex];
        [self addSubview:_lab_pageCount];
        
    }
    return self;
}

-(void)dealloc{
    
    [_leftArrow release];
    [_rightArrow release];
    [_midleImage release];
    
    [_lab_pageIndex release];
    [_lab_pageCount release];
    
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


-(void)setPageCount:(NSInteger)pageCount{
    
    _pageCount = pageCount;
    _pageIndex = 1;
    
//    if (_pageCount == 1 && _pageIndex == 0) {
//        _leftArrow.alpha = 0.0f;
//        _rightArrow.alpha = 0.0f;
//    }
//    
//    if (_pageCount>1) {
//        _leftArrow.alpha = 1.0f;
//        _rightArrow.alpha = 1.0f;
//        if (_pageIndex == 0) {
//            _leftArrow.alpha = 0.0f;
//        }
//        
//        if (_pageIndex == _pageCount-1) {
//            _rightArrow.alpha = 0.0f;
//        }
//    }
    _lab_pageCount.text = [NSString stringWithFormat:@"/%d",_pageCount];
    [self layoutImages];
}


-(void)setPageIndex:(NSInteger)pageIndex{
    _pageIndex = pageIndex+1;
    
    _lab_pageIndex.text = [NSString stringWithFormat:@"%d",_pageIndex];
    
//    if (_pageCount == 1 && _pageIndex == 0) {
//        _leftArrow.alpha = 0.0f;
//        _rightArrow.alpha = 0.0f;
//    }
//    
//    if (_pageCount>1) {
//        _leftArrow.alpha = 1.0f;
//        _rightArrow.alpha = 1.0f;
//        if (_pageIndex == 0) {
//            _leftArrow.alpha = 0.0f;
//        }
//        
//        if (_pageIndex == _pageCount-1) {
//            _rightArrow.alpha = 0.0f;
//        }
//    }
    //[self layoutImages];
    
}

-(void)layoutImages{
    
    _leftArrow.frame = CGRectMake(30, (self.frame.size.height - _leftArrow.image.size.height)/2, _leftArrow.image.size.width, _leftArrow.image.size.height);
    _rightArrow.frame = CGRectMake(self.frame.size.width-30-_rightArrow.image.size.width, (self.frame.size.height - _rightArrow.image.size.height)/2, _rightArrow.image.size.width, _rightArrow.image.size.height);
    
    
    _lab_pageCount.frame = CGRectMake(self.frame.size.width/2, 0, 80, self.frame.size.height);
    
    _lab_pageIndex.frame = CGRectMake(self.frame.size.width/2-80, 0, 80, self.frame.size.height);
    
    _midleImage.frame = CGRectMake(LEFT_RIGHT_SPACE*2, (self.frame.size.height - _midleImage.image.size.height)/2, _midleImage.image.size.width, _midleImage.image.size.height);
}


@end
