//
//  FSNewsDitailToolBar.m
//  PeopleNewsReaderPhone
//
//  Created by Xu dandan on 12-10-31.
//
//

#import "FSNewsDitailToolBar.h"


@implementation FSNewsDitailToolBar

@synthesize touchEvenKind = _touchEvenKind;
@synthesize comment_content = _comment_content;
@synthesize isInFaverate = _isInFaverate;
@synthesize fontToolBarIsShow = _fontToolBarIsShow;

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
    [_toolbarBackground release];
    [_fontSelectBackground release];
    [_favNoticBackground release];
    
    [_bt_faverate release];
    [_bt_font release];
    [_bt_comment release];
    [_bt_share release];
    
    [_bt_font_0 release];
    [_bt_font_1 release];
    [_bt_font_2 release];
    [_bt_font_3 release];
    
    [_gtv_backgroundTop release];
    [_gtv_backgroundMin release];
    [_gtv_backgroundBt release];
    
    [_growingText release];
    
    [_backgroundBT release];
    [_lab_favNotic release];
    
    [_sendBT release];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


-(void)doSomethingAtInit{
    //self.backgroundColor = COLOR_NEWSLIST_DESCRIPTION;
    
    //注册键盘事件
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification 
                                               object:nil];
    
    
    
    _backgroundBT = [[UIButton alloc] init];
    [_backgroundBT addTarget:self action:@selector(backSelect:) forControlEvents:UIControlEventTouchUpInside];
    _backgroundBT.alpha = 0.05;
    [self addSubview:_backgroundBT];
    
    _toolbarBackground = [[UIImageView alloc] init];
    _toolbarBackground.image = [UIImage imageNamed:@"newsDitail_bar.png"];
    //_toolbarBackground.alpha = 0.9f;
    
    
    _fontSelectBackground = [[UIImageView alloc] init];
    _fontSelectBackground.image = [UIImage imageNamed:@"fonttoolbar.png"];
    
    _favNoticBackground = [[UIImageView alloc] init];
    _favNoticBackground.image = [UIImage imageNamed:@"content_tool_pop_favorited.png"];
    _favNoticBackground.alpha = 0.0f;
    
    
    [self addSubview:_toolbarBackground];
    [self addSubview:_fontSelectBackground];
    [self addSubview:_favNoticBackground];
    
    
    _lab_favNotic = [[UILabel alloc] init];
    _lab_favNotic.backgroundColor = COLOR_CLEAR;
    _lab_favNotic.textColor = COLOR_NEWSLIST_DESCRIPTION;
    _lab_favNotic.font = [UIFont systemFontOfSize:18];
    _lab_favNotic.textAlignment = UITextAlignmentCenter;
    _lab_favNotic.alpha = 0.0f;
    [self addSubview:_lab_favNotic];
    
    _fontToolBarIsShow = NO;
    
    
    _bt_faverate = [[UIButton alloc] init];
    [_bt_faverate setBackgroundImage:[UIImage imageNamed:@"newsDitail_fav_1.png"] forState:UIControlStateNormal];
    [_bt_faverate addTarget:self action:@selector(faverate:) forControlEvents:UIControlEventTouchUpInside];
    _bt_faverate.frame = CGRectZero;
    
    _bt_font = [[UIButton alloc] init];
    [_bt_font setBackgroundImage:[UIImage imageNamed:@"newsDitail_font_1.png"] forState:UIControlStateNormal];
    [_bt_font addTarget:self action:@selector(font:) forControlEvents:UIControlEventTouchUpInside];
    _bt_font.frame = CGRectZero;
    
    _bt_comment = [[UIButton alloc] init];
    [_bt_comment setBackgroundImage:[UIImage imageNamed:@"newsDitail_comment_1.png"] forState:UIControlStateNormal];
    [_bt_comment setBackgroundImage:[UIImage imageNamed:@"newsDitail_comment_2.png"] forState:UIControlStateHighlighted];
    [_bt_comment addTarget:self action:@selector(comment:) forControlEvents:UIControlEventTouchUpInside];
    _bt_comment.frame = CGRectZero;
    
    
    _bt_share = [[UIButton alloc] init];
    [_bt_share setBackgroundImage:[UIImage imageNamed:@"newsDitail_shear_1.png"] forState:UIControlStateNormal];
    [_bt_share setBackgroundImage:[UIImage imageNamed:@"newsDitail_shear_2.png"] forState:UIControlStateHighlighted];
    [_bt_share addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    _bt_share.frame = CGRectZero;
    
    [self addSubview:_bt_faverate];
    [self addSubview:_bt_font];
    [self addSubview:_bt_comment];
    [self addSubview:_bt_share];
    
    _bt_font_0 = [[UIButton alloc] init];
    [_bt_font_0 setTitle:@"小字" forState:UIControlStateNormal];
    _bt_font_0.titleLabel.font = [UIFont systemFontOfSize:11];
    [_bt_font_0 addTarget:self action:@selector(fontselect:) forControlEvents:UIControlEventTouchUpInside];
    [_bt_font_0 setTitleColor:COLOR_NEWSLIST_DESCRIPTION forState:UIControlStateNormal];
    _bt_font_0.frame = CGRectMake(0, 0, 55, 30);
    
    _bt_font_1 = [[UIButton alloc] init];
    [_bt_font_1 setTitle:@"中字" forState:UIControlStateNormal];
    _bt_font_1.titleLabel.font = [UIFont systemFontOfSize:13];
    [_bt_font_1 addTarget:self action:@selector(fontselect:) forControlEvents:UIControlEventTouchUpInside];
    [_bt_font_1 setTitleColor:COLOR_NEWSLIST_DESCRIPTION forState:UIControlStateNormal];
    _bt_font_1.frame = CGRectMake(0, 0, 55, 30);
    
    _bt_font_2 = [[UIButton alloc] init];
    [_bt_font_2 setTitle:@"大字" forState:UIControlStateNormal];
    _bt_font_2.titleLabel.font = [UIFont systemFontOfSize:15];
    [_bt_font_2 addTarget:self action:@selector(fontselect:) forControlEvents:UIControlEventTouchUpInside];
    [_bt_font_2 setTitleColor:COLOR_NEWSLIST_DESCRIPTION forState:UIControlStateNormal];
    _bt_font_2.frame = CGRectMake(0, 0, 55, 30);
    
    _bt_font_3 = [[UIButton alloc] init];
    [_bt_font_3 setTitle:@"超大字" forState:UIControlStateNormal];
    _bt_font_3.titleLabel.font = [UIFont systemFontOfSize:17];
    [_bt_font_3 addTarget:self action:@selector(fontselect:) forControlEvents:UIControlEventTouchUpInside];
    [_bt_font_3 setTitleColor:COLOR_NEWSLIST_DESCRIPTION forState:UIControlStateNormal];
    _bt_font_3.frame = CGRectMake(0, 0, 55, 30);
    
    [self addSubview:_bt_font_0];
    [self addSubview:_bt_font_1];
    [self addSubview:_bt_font_2];
    [self addSubview:_bt_font_3];
    
    
    //可变文本背景图
    _gtv_backgroundTop = [[UIImageView alloc] init];
    _gtv_backgroundTop.image = [UIImage imageNamed:@"newsDitail_up1.png"];
    
    _gtv_backgroundMin = [[UIImageView alloc] init];
    _gtv_backgroundMin.image = [UIImage imageNamed:@"newsDitail_mid1.png"];
    
    _gtv_backgroundBt = [[UIImageView alloc] init];
    _gtv_backgroundBt.image = [UIImage imageNamed:@"newsDitail_down1.png"];
    
    [self addSubview:_gtv_backgroundMin];
    [self addSubview:_gtv_backgroundTop];
    [self addSubview:_gtv_backgroundBt];
    
    //可变高度文本框
    _growingText = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(11, 14, 230, 4)];
    _growingText.minNumberOfLines = 1;
    _growingText.maxNumberOfLines = 5;
    [_growingText setDataDetectorTypes:UIDataDetectorTypeNone];
    _growingText.delegate = self;
    _growingText.hidden = YES;
    _growingText.backgroundColor = COLOR_CLEAR;
    //textView.animateHeightChange = NO; //turns off animation
    
    [self addSubview:_growingText];
    
    
    _sendBT = [[UIButton alloc] init];
    [_sendBT setBackgroundImage:[UIImage imageNamed:@"newsDitail_tijiao.png"] forState:UIControlStateNormal];
    [_sendBT setTitle:@"提交" forState:UIControlStateNormal];
    _sendBT.titleLabel.font = [UIFont systemFontOfSize:17];
    [_sendBT addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];
    _sendBT.frame = CGRectMake(10, self.frame.size.height - 40, 40, 30);
    _sendBT.alpha = 0.0f;
    [self addSubview:_sendBT];
    
    [self fontToolBarCtr];
}


-(void)doSomethingAtLayoutSubviews{
    
    _toolbarBackground.frame = CGRectMake(0, self.frame.size.height - 40, self.frame.size.width, 40);
    _bt_faverate.frame = CGRectMake(75*0+27.5f, self.frame.size.height - 40, 40, 40);
    _bt_font.frame = CGRectMake(75*1+27.5f, self.frame.size.height - 40, 40, 40);
    _bt_comment.frame = CGRectMake(75*2+27.5f, self.frame.size.height - 40, 40, 40);
    _bt_share.frame = CGRectMake(75*3+27.5f, self.frame.size.height - 40, 40, 40);
    
    
    _fontSelectBackground.frame = CGRectMake(6, self.frame.size.height - 90, 229, 50);
    
    _favNoticBackground.frame = CGRectMake(5, self.frame.size.height - 90, 100, 50);
    _lab_favNotic.frame = CGRectMake(5, self.frame.size.height - 85, 100, 30);
    NSLog(@"self.frame:%@",NSStringFromCGRect(self.frame));
    _bt_font_0.frame = CGRectMake(8, self.frame.size.height - 90, 40, 36);
    
    _bt_font_1.frame = CGRectMake(48, self.frame.size.height - 90, 42, 36);
    
    _bt_font_2.frame = CGRectMake(92, self.frame.size.height - 90, 50, 36);
    
    _bt_font_3.frame = CGRectMake(143, self.frame.size.height - 90, 94, 36);
    
    if (self.isInFaverate) {
        [_bt_faverate setBackgroundImage:[UIImage imageNamed:@"newsDitail_fav_2.png"] forState:UIControlStateNormal];
    }
    else{
        [_bt_faverate setBackgroundImage:[UIImage imageNamed:@"newsDitail_fav_1.png"] forState:UIControlStateNormal];
    }
    
}

-(void)faverate:(id)sender{
    
    if (_fontToolBarIsShow==YES) {
        _fontToolBarIsShow = NO;
        [self fontToolBarCtr];
    }
    
    self.touchEvenKind = TouchEvenKind_FaverateSelect;
    self.isInFaverate = !self.isInFaverate;
    
    if (self.isInFaverate) {
        [_bt_faverate setBackgroundImage:[UIImage imageNamed:@"newsDitail_fav_2.png"] forState:UIControlStateNormal];
    }
    else{
        [_bt_faverate setBackgroundImage:[UIImage imageNamed:@"newsDitail_fav_1.png"] forState:UIControlStateNormal];
    }
    
    [self favNoticBar];
    
    [self sendTouchEvent];
}

-(void)font:(id)sender{
    _fontToolBarIsShow = !_fontToolBarIsShow;
    [self fontToolBarCtr];
}


-(void)comment:(id)sender{
    if (_fontToolBarIsShow==YES) {
        _fontToolBarIsShow = NO;
        [self fontToolBarCtr];
    }
    
    
    _growingText.hidden = !_growingText.hidden;
    self.touchEvenKind = TouchEvenKind_CommentSelect;
    [self sendTouchEvent];
    [_growingText becomeFirstResponder];
}

-(void)share:(id)sender{
    if (_fontToolBarIsShow==YES) {
        _fontToolBarIsShow = NO;
        [self fontToolBarCtr];
    }
    self.touchEvenKind = TouchEvenKind_ShareSelect;
    [self sendTouchEvent];
}


-(void)send:(id)sender{
    self.touchEvenKind = TouchEvenKind_Commentsend;
    self.comment_content = _growingText.text;
    [self sendTouchEvent];
    [_growingText resignFirstResponder];
}


-(void)fontselect:(id)sender{
    
    NSNumber *n = [[GlobalConfig shareConfig] readFontSize];
    
    NSInteger m = -1;
    if ([sender isEqual:_bt_font_0]) {
        m = 0;
    }
    
    if ([sender isEqual:_bt_font_1]) {
        m = 1;
    }
    
    if ([sender isEqual:_bt_font_2]) {
        m = 2;
    }
    
    if ([sender isEqual:_bt_font_3]) {
        m = 3;
    }
    if([n integerValue]!=m){
        NSNumber *nm = [NSNumber numberWithInteger:m];
        [[GlobalConfig shareConfig] setFontSize:nm];
        self.touchEvenKind = TouchEvenKind_FontSizeChange;
        [self sendTouchEvent];
        //font change
    }
    
    _fontToolBarIsShow = NO;
    [self fontToolBarCtr];

}



-(void)fontToolBarCtr{
    
    if (_fontToolBarIsShow) {
        _bt_font_0.alpha = 1.0f;
        _bt_font_1.alpha = 1.0f;
        _bt_font_2.alpha = 1.0f;
        _bt_font_3.alpha = 1.0f;
        
        
        NSNumber *n = [[GlobalConfig shareConfig] readFontSize];
        
        if ([n integerValue]==0) {
            [_bt_font_0 setTitleColor:COLOR_RED forState:UIControlStateNormal];
        }
        else if([n integerValue]==1){
            [_bt_font_1 setTitleColor:COLOR_RED forState:UIControlStateNormal];
        }
        else if([n integerValue]==2){
            [_bt_font_2 setTitleColor:COLOR_RED forState:UIControlStateNormal];
        }
        else if([n integerValue]==3){
            [_bt_font_3 setTitleColor:COLOR_RED forState:UIControlStateNormal];
        }
        
        _fontSelectBackground.alpha = 1.0f;
        [_bt_font setBackgroundImage:[UIImage imageNamed:@"newsDitail_font_2.png"] forState:UIControlStateNormal];
        CGRect r = self.frame;
        r.origin.y = r.origin.y - 50;
        r.size.height =r.size.height + 50;
        self.frame = r;
        [self doSomethingAtLayoutSubviews];
    }
    else{
        _bt_font_0.alpha = 0.0f;
        _bt_font_1.alpha = 0.0f;
        _bt_font_2.alpha = 0.0f;
        _bt_font_3.alpha = 0.0f;
        [_bt_font_0 setTitleColor:COLOR_NEWSLIST_DESCRIPTION forState:UIControlStateNormal];
        [_bt_font_1 setTitleColor:COLOR_NEWSLIST_DESCRIPTION forState:UIControlStateNormal];
        [_bt_font_2 setTitleColor:COLOR_NEWSLIST_DESCRIPTION forState:UIControlStateNormal];
        [_bt_font_3 setTitleColor:COLOR_NEWSLIST_DESCRIPTION forState:UIControlStateNormal];
        _fontSelectBackground.alpha = 0.0f;
        [_bt_font setBackgroundImage:[UIImage imageNamed:@"newsDitail_font_1.png"] forState:UIControlStateNormal];
        CGRect r = self.frame;
        r.origin.y = r.origin.y + 50;
        r.size.height -= 50;
        self.frame = r;
        [self doSomethingAtLayoutSubviews];
    }
    
    NSLog(@"fontToolBarCtr");
}

-(void)favNoticBar{
    self.clipsToBounds = NO;
    if (self.isInFaverate) {
        
        _favNoticBackground.alpha = 1.0f;//已收藏
        _lab_favNotic.text = @"收藏成功";
        _lab_favNotic.alpha = 1.0f;
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:2.8];
        _lab_favNotic.alpha = 0.0f;
        _favNoticBackground.alpha = 0.0f;//已收藏
        [UIView commitAnimations];
    }
    else{
        
        _favNoticBackground.alpha = 1.0f;
        _lab_favNotic.text = @"取消收藏";
        _lab_favNotic.alpha = 1.0f;
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:2.8];
        _lab_favNotic.alpha = 0.0f;
        _favNoticBackground.alpha = 0.0f;//已收藏
        [UIView commitAnimations];
    }
}

#pragma mark -
#pragma mark HPGrowingTextViewDelegate


- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
	float diff = (growingTextView.frame.size.height - height);
	
	CGRect r = growingTextView.frame;
     r.origin.y += diff;
     growingTextView.frame = r;
    
    _gtv_backgroundTop.frame = CGRectMake(0, r.origin.y-10, self.frame.size.width, 10);
    _gtv_backgroundMin.frame = CGRectMake(0, r.origin.y-4, self.frame.size.width, r.size.height+40);
    //_gtv_backgroundBt.frame = CGRectMake(0, r.origin.y + r.size.height -2, self.frame.size.width, 10);
}

-(void)keyboardWillShow:(NSNotification *)Notification{
    
    FSLog(@"keyboardWillShow::");
    
    NSDictionary *info = [Notification userInfo];
	NSValue *value = nil;//[info objectForKey:UIKeyboardBoundsUserInfoKey];//UIKeyboardFrameEndUserInfoKey
	if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2) {
		value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
	} else {
#ifndef IOS_3_2_LATER
		value = [info objectForKey:UIKeyboardBoundsUserInfoKey];
#endif
	}
    
    _gtv_backgroundTop.alpha = 1.0f;
    _gtv_backgroundMin.alpha = 1.0f;
    _gtv_backgroundBt.alpha = 1.0f;
    _sendBT.alpha = 1.0f;
    
	CGSize keyboardSize = [value CGRectValue].size;
    
    
    CGRect rr = [UIScreen mainScreen].applicationFrame;
    
    self.frame = CGRectMake(0.0f, 0, rr.size.width, rr.size.height - keyboardSize.height);
    _backgroundBT.frame = self.frame;
    
   // NSLog(@"rr y:%f  h:%f  k:%f",rr.origin.y,rr.size.height,keyboardSize.height);
    
    _growingText.frame = CGRectMake(10, self.frame.size.height - 44 - 8 - _growingText.frame.size.height,  _growingText.frame.size.width, _growingText.frame.size.height);
    
    CGRect r = _growingText.frame;
    _gtv_backgroundTop.frame = CGRectMake(0, r.origin.y-10, self.frame.size.width, 10);
    _gtv_backgroundMin.frame = CGRectMake(0, r.origin.y-4, self.frame.size.width, r.size.height+10);
    _gtv_backgroundBt.frame = CGRectMake(0, r.origin.y + r.size.height -2, self.frame.size.width, 10);
    
    _sendBT.frame = CGRectMake(self.frame.size.width - 65, r.origin.y + r.size.height -34, 50, 35);
    
}

-(void)backSelect:(id)sender{
    [_growingText resignFirstResponder];
}


-(void)keyboardWillHide:(NSNotification *)Notification{
    _growingText.hidden = YES;
    [_growingText resignFirstResponder];
    
    _gtv_backgroundTop.alpha = 0.0f;
    _gtv_backgroundMin.alpha = 0.0f;
    _gtv_backgroundBt.alpha = 0.0f;
    _sendBT.alpha = 0.0f;
    NSDictionary *info = [Notification userInfo];
	NSValue *value = nil;//[info objectForKey:UIKeyboardBoundsUserInfoKey];//UIKeyboardFrameEndUserInfoKey
	if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2) {
		value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
	} else {
#ifndef IOS_3_2_LATER
		value = [info objectForKey:UIKeyboardBoundsUserInfoKey];
#endif
	}
    
//	CGSize keyboardSize = [value CGRectValue].size;
    
    
    CGRect rr = [UIScreen mainScreen].applicationFrame;
    
    self.frame = CGRectMake(0.0f, rr.size.height - 88, rr.size.width, 44);
    
    
}




@end
