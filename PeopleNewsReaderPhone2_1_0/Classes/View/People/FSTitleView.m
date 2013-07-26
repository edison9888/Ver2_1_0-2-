//
//  FSTitleView.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-13.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSTitleView.h"
#import "FSConst.h"

#define CITYNAME_FRONT_SIZE 20.0f
#define TEMPERATURE_FRONT_SIZE 9.0f

@implementation FSTitleView

@synthesize parentDelegate = _parentDelegate;
@synthesize hidRefreshBt = _hidRefreshBt;
@synthesize toBottom = _toBottom;
@synthesize data = _data;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self doSomethingAtInit];
    }
    return self;
}

-(void)dealloc{
    [self doSomethingAtDealloc];
    [super dealloc];
}


-(void)doSomethingAtInit{
    _hidRefreshBt = NO;
    _toBottom = NO;
    _image_ListIcon = [[UIImageView alloc] init];
    _image_Refresh = [[UIImageView alloc] init];
    _lab_CityName = [[UILabel alloc] init];
    
    _clear_backBT1 = [[UIButton alloc] init];
    _clear_backBT2 = [[UIButton alloc] init];
    
    [self addSubview:_image_ListIcon];
    [self addSubview:_image_Refresh];
    [self addSubview:_lab_CityName];
    
    [self addSubview:_clear_backBT1];
    [self addSubview:_clear_backBT2];
    
    [self initVariable];
}

-(void)doSomethingAtDealloc{
    [_image_ListIcon release];
    [_image_Refresh release];
    [_lab_CityName release];
    [_clear_backBT1 release];
    [_clear_backBT2 release];
}

-(void)initVariable{
    _lab_CityName.backgroundColor = COLOR_CLEAR;
    //_lab_CityName.textColor = COLOR_NEWSLIST_CHANNEL_TITLE;
    _lab_CityName.textAlignment = UITextAlignmentRight;
    _lab_CityName.numberOfLines = 1;
    _lab_CityName.font = [UIFont systemFontOfSize:CITYNAME_FRONT_SIZE];
    
    [_clear_backBT1 addTarget:self action:@selector(cityListBt:) forControlEvents:UIControlEventTouchUpInside];
    [_clear_backBT2 addTarget:self action:@selector(refreshBt:) forControlEvents:UIControlEventTouchUpInside];
}


-(void)setContent{
     _lab_CityName.text = @"";
    
    if (_data!=nil) {
        _lab_CityName.text = (NSString *)_data;
    }
   
    
    _image_ListIcon.image = [UIImage imageNamed:@"shouqi.png"];
   
    
    _image_Refresh.image = [UIImage imageNamed:@"refleshBT.png"];
    if (_toBottom){
       _lab_CityName.text = (NSString *)_data;
        
        _image_ListIcon.image = [UIImage imageNamed:@"zhankai.png"];
        
        //_image_ListIcon.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI);
    }
}

-(void)reSetFrame{
    [self setContent];
    //NSLog(@"self.frame.size.width:%f",self.frame.size.width);
    CGFloat textWidth = [self getTitleTextWidth:_lab_CityName.text];
    _lab_CityName.frame = CGRectMake((self.frame.size.width-textWidth-30)/2+6, 0, textWidth, self.frame.size.height);
    _image_ListIcon.frame = CGRectMake((self.frame.size.width-textWidth-30)/2+6+textWidth, 20, 11, 6);
    _clear_backBT1.frame = CGRectMake(66, 0, self.frame.size.width/2, 44);
    _clear_backBT2.frame = CGRectMake(self.frame.size.width/2+86, 0, self.frame.size.width/2-66, 44);
    _image_Refresh.frame = CGRectMake(self.frame.size.width-40, 10, 24, 22);
    if (_hidRefreshBt) {
        _clear_backBT2.userInteractionEnabled = NO;
        _clear_backBT2.multipleTouchEnabled = NO;
        _image_Refresh.alpha = 0.0;
    }
    //NSLog(@"_lab_CityName.text:%@",_lab_CityName.text);
}

-(CGFloat)getTitleTextWidth:(NSString *)text{
    CGFloat width;
    
    CGSize size= [text sizeWithFont:_lab_CityName.font constrainedToSize:CGSizeMake(self.frame.size.width, self.frame.size.height) lineBreakMode:UILineBreakModeCharacterWrap];
    width = size.width;
    return width;
}

- (void)setData:(NSObject *)value {
	if (value != _data && value != nil) {
		[_data release];
		_data = [value retain];
		[self reSetFrame];
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


-(void)cityListBt:(id)sender{
    NSLog(@"cityListBtcityListBt");
    if (_hidRefreshBt) {
        if ([_parentDelegate conformsToProtocol:@protocol(FSTitleViewDelegate)] && [_parentDelegate respondsToSelector:@selector(FSTitleViewTouchEvent:)]) {
            [_parentDelegate FSTitleViewTouchEvent:self];
        }
    }
    else{
        [[NSNotificationCenter defaultCenter] postNotificationName:NSNOTIF_POPOCITYLISTCONTROLLER object:nil];
    }
    
}

-(void)refreshBt:(id)sender{
    NSLog(@"refreshBtrefreshBtrefreshBt");
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNOTIF_LOCALNEWSLISTREFRESH object:nil];
}



@end
