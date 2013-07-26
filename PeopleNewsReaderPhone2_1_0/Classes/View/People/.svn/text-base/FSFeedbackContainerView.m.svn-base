//
//  FSFeedbackContainerView.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-9-28.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSFeedbackContainerView.h"
#import <QuartzCore/QuartzCore.h>
#import "FSFeedBackNomalQContentView.h"


@implementation FSFeedbackContainerView

@synthesize contact = _contact;
@synthesize message = _message;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)doSomethingAtDealloc{
    
    [_background2 release];
    [_lab_fx release];
    [_lab_qq release];
    [_fsFeedBackNomalQContentView release];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

-(void)doSomethingAtInit{
    _background2 = [[UIImageView alloc] init];
    _background2.image = [UIImage imageNamed:@"feedBack_line.png"];
    _isFirstShow = YES;
    self.backgroundColor = COLOR_NEWSLIST_TITLE_WHITE;
    
    _fsFeedBackNomalQContentView = [[FSFeedBackNomalQContentView alloc] init];
    _fsFeedBackNomalQContentView.alpha = 0.0f;
    
    
    
    _bt_feedBack = [UIButton buttonWithType:UIButtonTypeCustom];
    _bt_feedBack.backgroundColor = COLOR_RED;
    [_bt_feedBack setTitleColor:COLOR_NEWSLIST_TITLE_WHITE forState:UIControlStateNormal];
    [_bt_feedBack setTitle:@"意见反馈" forState:UIControlStateNormal];
    [_bt_feedBack addTarget:self action:@selector(feedBackSelect:) forControlEvents:UIControlEventTouchUpInside];
    
    _bt_nomalQ = [UIButton buttonWithType:UIButtonTypeCustom];
    _bt_nomalQ.backgroundColor = COLOR_CLEAR;
    [_bt_nomalQ setTitleColor:COLOR_NEWSLIST_DESCRIPTION forState:UIControlStateNormal];
    [_bt_nomalQ setTitle:@"常见问题" forState:UIControlStateNormal];
    [_bt_nomalQ addTarget:self action:@selector(nomalQSelect:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_bt_feedBack];
    [self addSubview:_bt_nomalQ];
    
    
    _feedbackwords = [[UITextView alloc] init];
    _feedbackwords.layer.cornerRadius = 3.0f;
	_feedbackwords.layer.masksToBounds = YES;
    _feedbackwords.delegate = self;
	_feedbackwords.layer.borderColor = [UIColor colorWithRed:204.0f / 255.0f green:204.0f / 255.0f blue:204.0f / 255.0f alpha:1.0f].CGColor;
	_feedbackwords.layer.borderWidth = 1.0f;
    _feedbackwords.font = [UIFont systemFontOfSize:16];//[UIFont fontWithName:@"Arial"size:18.0];//设置字体名字和字体大小
    
    _communication = [[UITextView alloc] init];
    _communication.layer.cornerRadius = 3.0f;
    _communication.layer.masksToBounds = YES;
    _communication.delegate = self;
    _communication.layer.borderColor = [UIColor colorWithRed:204.0f / 255.0f green:204.0f / 255.0f blue:204.0f / 255.0f alpha:1.0f].CGColor;
    _communication.layer.borderWidth = 1.0f;
    _communication.font = [UIFont systemFontOfSize:15];
    
    _lab_qq = [[UILabel alloc] init];
    _lab_qq.backgroundColor = COLOR_CLEAR;
    _lab_qq.text = @"互动QQ群:23544127";
    _lab_qq.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    _lab_qq.textColor = [UIColor colorWithRed:136.0/255.0 green:136.0/255.0 blue:136.0/255.0 alpha:1];
    
    _lab_fx = [[UILabel alloc] init];
    _lab_fx.backgroundColor = COLOR_CLEAR;
    _lab_fx.text = @"飞信:123242333";
    _lab_fx.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    _lab_fx.textColor = [UIColor colorWithRed:136.0/255.0 green:136.0/255.0 blue:136.0/255.0 alpha:1];
    
    _lab_com = [[UILabel alloc]init];
    _lab_com.backgroundColor = COLOR_CLEAR;
    _lab_com.text = @"联系方式";
    _lab_com.textColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1];
    
    _lab_fb = [[UILabel alloc] init];
    _lab_fb.backgroundColor = COLOR_CLEAR;
    _lab_fb.text = @"反馈内容";
    _lab_fb.textColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1];
    
//    _btn_submit = [[UIButton alloc] init];
//    _btn_submit.backgroundColor = COLOR_CLEAR;
//    [_btn_submit setTitle:@"提交" forState:UIControlStateNormal];
//    [_btn_submit setBackgroundImage:[UIImage imageNamed:@"tabItemBG_Sel"] forState:UIControlStateNormal];
    
    
    [self addSubview:_background2];
    [self addSubview:_feedbackwords];
    [self addSubview:_communication];
    //[self addSubview:_lab_qq];
    //[self addSubview:_lab_fx];
    [self addSubview:_lab_com];
    [self addSubview:_lab_fb];
    [self addSubview:_fsFeedBackNomalQContentView];
   // [self addSubview:_btn_submit];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

-(void)doSomethingAtLayoutSubviews{
    NSLog(@"doSomethingAtLayoutSubviews");
//   _background2.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//    _feedbackwords.frame = CGRectMake(12, 10, self.frame.size.width-24, 80);
//    _lab_qq.frame = CGRectMake(12, 95, self.frame.size.width - 24, 20);
//    _lab_fx.frame = CGRectMake(12, 120, self.frame.size.width - 24, 20);
//    _lab_qq.frame = CGRectMake(12, 165, 170, 12);
//    _lab_qq.backgroundColor = [UIColor redColor];
//    _lab_fx.frame = CGRectMake(12, 182, 170, 12);
    
    CGFloat top = 12.0f;
    
    _bt_feedBack.frame = CGRectMake(24, top, (self.frame.size.width-24*2)/2, 25);
    _bt_nomalQ.frame = CGRectMake(self.frame.size.width/2, top, (self.frame.size.width-24*2)/2, 25);
    
    _background2.frame = CGRectMake(24, top + 25, self.frame.size.width-24*2, 2);
    
    top = top + 25 + 10;
    
    _fsFeedBackNomalQContentView.frame = CGRectMake(0, top, self.frame.size.width, self.frame.size.height-top - 50);
    
    _lab_com.frame = CGRectMake(24, top, self.frame.size.width - 48, 15);
    
    top = top + 15 + 5;
    
    _communication.frame = CGRectMake(24, top, self.frame.size.width - 48, 30);
    
    top = top + 30 + 5;
    
    _lab_fb.frame = CGRectMake(24, top, self.frame.size.width - 48, 15);
    
    
    top = top + 15 + 5;
    
    _feedbackwords.frame = CGRectMake(24, top, self.frame.size.width - 48, 70);


    
    [_communication becomeFirstResponder];
}


-(void)feedBackSelect:(id)sender{
    _bt_feedBack.backgroundColor = COLOR_RED;
    [_bt_feedBack setTitleColor:COLOR_NEWSLIST_TITLE_WHITE forState:UIControlStateNormal];
    
    _bt_nomalQ.backgroundColor = COLOR_CLEAR;
    [_bt_nomalQ setTitleColor:COLOR_NEWSLIST_DESCRIPTION forState:UIControlStateNormal];
    _fsFeedBackNomalQContentView.alpha = 0.0f;
    _isFirstShow = YES;
    [_communication becomeFirstResponder];
}

-(void)nomalQSelect:(id)sender{
    _bt_nomalQ.backgroundColor = COLOR_RED;
    [_bt_nomalQ setTitleColor:COLOR_NEWSLIST_TITLE_WHITE forState:UIControlStateNormal];
    
    _bt_feedBack.backgroundColor = COLOR_CLEAR;
    [_bt_feedBack setTitleColor:COLOR_NEWSLIST_DESCRIPTION forState:UIControlStateNormal];
    _fsFeedBackNomalQContentView.alpha = 1.0f;
    //_fsFeedBackNomalQContentView.backgroundColor = COLOR_RED;
    [_fsFeedBackNomalQContentView doSomethingAtLayoutSubviews];
    
    [_communication resignFirstResponder];
}


-(void)keyboardWillShow:(NSNotification *)aNotification{
    
    NSLog(@"keyboardWillShow");
    //NSLog(@"object:%@",aNotification.userInfo);
    
    NSDictionary *info = [aNotification userInfo];
	NSValue *value = nil;//[info objectForKey:UIKeyboardBoundsUserInfoKey];//UIKeyboardFrameEndUserInfoKey
	if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2) {
		value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
	} else {
#ifndef IOS_3_2_LATER
		value = [info objectForKey:UIKeyboardBoundsUserInfoKey];
#endif
	}
    
	CGSize keyboardSize = [value CGRectValue].size;
    
    CGFloat top = _lab_fb.frame.origin.y + _lab_fb.frame.size.height +5;
    
    _feedbackwords.frame = CGRectMake(24, top, self.frame.size.width - 48, self.frame.size.height-top-8-keyboardSize.height);
    
//    _lab_qq.frame = CGRectMake(12,  self.frame.size.height-keyboardSize.height-26, 170, 12);
//    _lab_fx.frame = CGRectMake(12, self.frame.size.height-keyboardSize.height-14, 170, 12);
}


-(NSString *)getFeedbackMessage{
    
    self.contact = _communication.text;
    self.message = _feedbackwords.text;
    
    //NSLog(@"contact = %@, message = %@",self.contact,self.message);
    //NSLog(@"_feedbackwords.text %@",_feedbackwords.text);
    
    return _feedbackwords.text;
}  

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


//UITextViewDelegate
//**********************************************************


- (void)textViewDidBeginEditing:(UITextView *)textView{
    NSLog(@"textViewDidBeginEditing:%@",textView);
    if (_isFirstShow) {
        _isFirstShow = NO;
        return;
    }
    if ([textView isEqual:_feedbackwords]) {
        [self reLayoutChiledView:0];
    }
    
    if ([textView isEqual:_communication]) {
        [self reLayoutChiledView:1];
    }
}


-(void)reLayoutChiledView:(NSInteger)make{
    if (make == 0) {
        
        _bt_feedBack.alpha = 0.0f;
        _bt_nomalQ.alpha = 0.0f;
        _background2.alpha = 0.0f;
        
        CGFloat top = -32.0f;
        _bt_feedBack.frame = CGRectMake(24, top, (self.frame.size.width-24*2)/2, 25);
        _bt_nomalQ.frame = CGRectMake(self.frame.size.width/2, top, (self.frame.size.width-24*2)/2, 25);
        _background2.frame = CGRectMake(24, top + 25, self.frame.size.width-24*2, 2);
        top = top + 25 + 10;
        _fsFeedBackNomalQContentView.frame = CGRectMake(0, top, self.frame.size.width, self.frame.size.height-top - 50);
        _lab_com.frame = CGRectMake(24, top, self.frame.size.width - 48, 15);
        top = top + 15 + 5;
        _communication.frame = CGRectMake(24, top, self.frame.size.width - 48, 30);
        top = top + 30 + 5;
        _lab_fb.frame = CGRectMake(24, top, self.frame.size.width - 48, 15);
        top = top + 15 + 5;
        _feedbackwords.frame = CGRectMake(24, top, self.frame.size.width - 48, _feedbackwords.frame.size.height+44);
    }
    
    if (make == 1) {
        
        _bt_feedBack.alpha = 1.0f;
        _bt_nomalQ.alpha = 1.0f;
        _background2.alpha = 1.0f;
        
        CGFloat top = 12.0f;
        _bt_feedBack.frame = CGRectMake(24, top, (self.frame.size.width-24*2)/2, 25);
        _bt_nomalQ.frame = CGRectMake(self.frame.size.width/2, top, (self.frame.size.width-24*2)/2, 25);
        _background2.frame = CGRectMake(24, top + 25, self.frame.size.width-24*2, 2);
        top = top + 25 + 10;
        _fsFeedBackNomalQContentView.frame = CGRectMake(0, top, self.frame.size.width, self.frame.size.height-top - 50);
        _lab_com.frame = CGRectMake(24, top, self.frame.size.width - 48, 15);
        top = top + 15 + 5;
        _communication.frame = CGRectMake(24, top, self.frame.size.width - 48, 30);
        top = top + 30 + 5;
        _lab_fb.frame = CGRectMake(24, top, self.frame.size.width - 48, 15);
        top = top + 15 + 5;
        _feedbackwords.frame = CGRectMake(24, top, self.frame.size.width - 48, _feedbackwords.frame.size.height-44);
    }
}



@end
