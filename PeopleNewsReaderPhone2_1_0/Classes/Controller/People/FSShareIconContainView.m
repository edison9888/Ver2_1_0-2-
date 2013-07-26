//
//  FSShareIconContainView.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-12-13.
//
//

#import "FSShareIconContainView.h"

@implementation FSShareIconContainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGes:)];
        [self addGestureRecognizer:tapGes];
        [tapGes release];
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
    [_lab_title release];
    [_bt_return release];
}

-(void)doSomethingAtInit{
    _lab_title = [[UILabel alloc] init];
    _lab_title.backgroundColor = COLOR_CLEAR;
    _lab_title.textColor = COLOR_NEWSLIST_TITLE_WHITE;
    _lab_title.textAlignment = UITextAlignmentCenter;
    _lab_title.font = [UIFont systemFontOfSize:18.0f];
    _lab_title.tag = 99;
    [self addSubview:_lab_title];
    
    _bt_return = [[UIButton alloc] init];
    [_bt_return setBackgroundImage:[UIImage imageNamed:@"beijingtiao.png"] forState:UIControlStateNormal];
    [_bt_return setTitle:NSLocalizedString(@"取消" ,nil) forState:UIControlStateNormal];
    [_bt_return addTarget:self action:@selector(returnBTselect:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_bt_return];
    
    
    self.shareSelectEvent = ShareSelectEvent_return;
    self.isShow = NO;
    
    self.backgroundColor = COLOR_BLACK_FOR_SHAREVIEW;
}

-(void)doSomethingAtLayoutSubviews{
    
    _lab_title.text = @"分享到";
    _lab_title.frame = CGRectMake(0, 8, self.frame.size.width, 30);
    _bt_return.frame = CGRectMake(20, self.frame.size.height - 60, self.frame.size.width - 40, 40);
    
    [self layoutIcons];
    
}

-(void)returnBTselect:(id)sender{
    NSLog(@"取消取消取消");
    self.shareSelectEvent = ShareSelectEvent_return;
    [self sendTouchEvent];
}

-(void)layoutIcons{
    
    CGFloat iconHeight = 58;
    CGFloat iconWidth = 58;
    CGFloat labHeight = 30;
    NSInteger lineNUM = 3;
    NSInteger i = 0;
    CGFloat leftSpase = 22;
    CGFloat spase = (self.frame.size.width-iconWidth*lineNUM)/lineNUM;
    
    UIImageView *sinaIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weibo.png"]];
    sinaIcon.tag = ShareSelectEvent_sina;
    sinaIcon.userInteractionEnabled = YES;
    sinaIcon.frame = CGRectMake(leftSpase+spase*i+iconWidth *i, 50+10, iconWidth, iconHeight);
    UILabel *sinaName = [[UILabel alloc] init];
    sinaName.userInteractionEnabled = YES;
    sinaName.tag = ShareSelectEvent_sina;
    sinaName.text = @"新浪微博";
    sinaName.textColor = COLOR_NEWSLIST_TITLE_WHITE;
    sinaName.textAlignment = UITextAlignmentCenter;
    sinaName.backgroundColor = COLOR_CLEAR;
    sinaName.font = [UIFont systemFontOfSize:14];
    sinaName.frame = CGRectMake(leftSpase+spase*i+iconWidth *i, 50+10 +iconHeight, iconWidth, labHeight);
    [self addSubview:sinaIcon];
    [self addSubview:sinaName];
    
    [sinaIcon release];
    [sinaName release];
    i++;
    
    UIImageView *neteaseIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"163.png"]];
    neteaseIcon.tag = ShareSelectEvent_netease;
    neteaseIcon.userInteractionEnabled = YES;
    neteaseIcon.frame = CGRectMake(leftSpase+spase*i+iconWidth *i, 50+10, iconWidth, iconHeight);
    UILabel *neteaseName = [[UILabel alloc] init];
    neteaseName.userInteractionEnabled = YES;
    neteaseName.tag = ShareSelectEvent_netease;
    neteaseName.text = @"网易微博";
    neteaseName.textColor = COLOR_NEWSLIST_TITLE_WHITE;
    neteaseName.textAlignment = UITextAlignmentCenter;
    neteaseName.backgroundColor = COLOR_CLEAR;
    neteaseName.font = [UIFont systemFontOfSize:14];
    neteaseName.frame = CGRectMake(leftSpase+spase*i+iconWidth *i, 50+10 +iconHeight, iconWidth, labHeight);
    [self addSubview:neteaseIcon];
    [self addSubview:neteaseName];
    [neteaseIcon release];
    [neteaseName release];
    i++;
    
    UIImageView *weixinIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weixin.PNG"]];
    weixinIcon.tag = ShareSelectEvent_weixin;
    weixinIcon.userInteractionEnabled = YES;
    weixinIcon.frame = CGRectMake(leftSpase+spase*i+iconWidth *i, 50+10, iconWidth, iconHeight);
    UILabel *weixinName = [[UILabel alloc] init];
    weixinName.userInteractionEnabled = YES;
    weixinName.tag = ShareSelectEvent_weixin;
    weixinName.text = @"微信好友";
    weixinName.textColor = COLOR_NEWSLIST_TITLE_WHITE;
    weixinName.textAlignment = UITextAlignmentCenter;
    weixinName.backgroundColor = COLOR_CLEAR;
    weixinName.font = [UIFont systemFontOfSize:14];
    weixinName.frame = CGRectMake(leftSpase+spase*i+iconWidth *i, 50+10 +iconHeight, iconWidth, labHeight);
    [self addSubview:weixinIcon];
    [self addSubview:weixinName];
    [weixinIcon release];
    [weixinName release];
    
    
    i=0;
    UIImageView *peopleBlogIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"renmin.png"]];
    peopleBlogIcon.tag = ShareSelectEvent_peopleBlog;
    peopleBlogIcon.userInteractionEnabled = YES;
    peopleBlogIcon.frame = CGRectMake(leftSpase+spase*i+iconWidth *i, 50+10+10+iconHeight+labHeight, iconWidth, iconHeight);
    UILabel *peopleBlogName = [[UILabel alloc] init];
    peopleBlogName.userInteractionEnabled = YES;
    peopleBlogName.tag = ShareSelectEvent_peopleBlog;
    peopleBlogName.text = @"人民微博";
    peopleBlogName.textColor = COLOR_NEWSLIST_TITLE_WHITE;
    peopleBlogName.textAlignment = UITextAlignmentCenter;
    peopleBlogName.backgroundColor = COLOR_CLEAR;
    peopleBlogName.font = [UIFont systemFontOfSize:14];
    peopleBlogName.frame = CGRectMake(leftSpase+spase*i+iconWidth *i, 50+10+10+iconHeight+labHeight +iconHeight, iconWidth, labHeight);
    [self addSubview:peopleBlogIcon];
    [self addSubview:peopleBlogName];
    [peopleBlogIcon release];
    [peopleBlogName release];
    i++;
    
    UIImageView *mailIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mail.png"]];
    mailIcon.tag = ShareSelectEvent_mail;
    mailIcon.userInteractionEnabled  = YES;
    mailIcon.frame = CGRectMake(leftSpase+spase*i+iconWidth *i, 50+10+10+iconHeight+labHeight, iconWidth, iconHeight);
    UILabel *mailName = [[UILabel alloc] init];
    mailName.userInteractionEnabled = YES;
    mailName.tag = ShareSelectEvent_mail;
    mailName.text = @"邮件";
    mailName.textColor = COLOR_NEWSLIST_TITLE_WHITE;
    mailName.textAlignment = UITextAlignmentCenter;
    mailName.backgroundColor = COLOR_CLEAR;
    mailName.font = [UIFont systemFontOfSize:14];
    mailName.frame = CGRectMake(leftSpase+spase*i+iconWidth *i, 50+10+10+iconHeight+labHeight +iconHeight, iconWidth, labHeight);
    [self addSubview:mailIcon];
    [self addSubview:mailName];
    [mailIcon release];
    [mailName release];
    i++;
    
    UIImageView *messageIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"短信.PNG"]];
    messageIcon.tag = ShareSelectEvent_message;
    messageIcon.userInteractionEnabled = YES;
    messageIcon.frame = CGRectMake(leftSpase+spase*i+iconWidth *i, 50+10+10+iconHeight+labHeight, iconWidth, iconHeight);
    UILabel *messageName = [[UILabel alloc] init];
    messageName.userInteractionEnabled = YES;
    messageName.tag = ShareSelectEvent_message;
    messageName.text = @"信息";
    messageName.textColor = COLOR_NEWSLIST_TITLE_WHITE;
    messageName.textAlignment = UITextAlignmentCenter;
    messageName.backgroundColor = COLOR_CLEAR;
    messageName.font = [UIFont systemFontOfSize:14];
    messageName.frame = CGRectMake(leftSpase+spase*i+iconWidth *i, 50+10+10+iconHeight+labHeight +iconHeight, iconWidth, labHeight);
    [self addSubview:messageIcon];
    [self addSubview:messageName];
    [messageIcon release];
    [messageName release];
    i++;
    

    
}

-(CGFloat)getHeight{
    CGFloat height = 60.0f;
    
    height = height +98*2;
    
    height = height +60;
    
    
    return height;
}

- (void)handleGes:(UITapGestureRecognizer *)ges {
    
    if (ges.state == UIGestureRecognizerStateEnded) {
        
        CGPoint pt = [ges locationInView:self];
        UIView *hitView = [self hitTest:pt withEvent:nil];
        NSLog(@"UIGestureRecognizerStateEnded:%@",hitView);
        if ([hitView isKindOfClass:[UIImageView class]]) {
            UIImageView *asycImageView = nil;
            asycImageView = (UIImageView *)hitView;
            self.shareSelectEvent = asycImageView.tag;
            [self sendTouchEvent];
        }
        
        if ([hitView isKindOfClass:[UIButton class]]) {
            self.shareSelectEvent = ShareSelectEvent_return;
            [self sendTouchEvent];
        }
        
        if ([hitView isKindOfClass:[UILabel class]]) {
            UILabel *asycImageView = nil;
            asycImageView = (UILabel *)hitView;
            self.shareSelectEvent = asycImageView.tag;
            [self sendTouchEvent];
        }
        
    }else{
        return;
    }
}



@end
