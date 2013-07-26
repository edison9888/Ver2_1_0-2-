//
//  FSAboutContaierView.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-9-3.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSAboutContaierView.h"

@implementation FSAboutContaierView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

-(void)doSomethingAtDealloc{
    [_logoIcon release];
    [_adWord release];
    [_appName release];
    [_Version release];
    [_copyRight release];
    [_background release];

}

-(void)doSomethingAtInit{
//    _background = [[UIImageView alloc] init];
//    _background.image = [UIImage imageNamed:@"ChannelSettingViewBGR.png"];
//    
//    [self addSubview:_background];
    
    
    self.backgroundColor = COLOR_NEWSLIST_TITLE_WHITE;
     
    _logoIcon = [[UIImageView alloc] init];
    _adWord = [[UILabel alloc] init];
    _adWord.backgroundColor = COLOR_CLEAR;
    _adWord.textAlignment = UITextAlignmentCenter;
    
    _appName = [[UILabel alloc] init];
    _appName.backgroundColor = COLOR_CLEAR;
    _appName.textAlignment = UITextAlignmentCenter;
    
    _Version = [[UILabel alloc] init];
    _Version.backgroundColor = COLOR_CLEAR;
    _Version.textAlignment = UITextAlignmentCenter;
    
    _copyRight = [[UILabel alloc] init];
    _copyRight.backgroundColor = COLOR_CLEAR;
    _copyRight.textAlignment = UITextAlignmentCenter;
    
    
    [self addSubview:_logoIcon];
    [self addSubview:_adWord];
    [self addSubview:_appName];
    [self addSubview:_Version];
    [self addSubview:_copyRight];
}

-(void)doSomethingAtLayoutSubviews{
    
    _background.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    _logoIcon.image = [UIImage imageNamed:@"aboutIcon.png"];
    _logoIcon.frame = CGRectMake(80, 70, 160, 160);
    
    _adWord.text = @"您忠实的新闻官";
    _adWord.font = [UIFont systemFontOfSize:22];
    _adWord.frame = CGRectMake(0, 250, self.frame.size.width, 40);
    _adWord.textColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1];
    
    _appName.text = @"人民新闻";
    _appName.font = [UIFont systemFontOfSize:16];
    _appName.frame = CGRectMake(0, 300, self.frame.size.width, 20);
    _appName.textColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1];
    
    _Version.text = [NSString stringWithFormat:@"版本号：%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleVersionKey]];
    _Version.font = [UIFont systemFontOfSize:16];
    _Version.frame = CGRectMake(0, 320, self.frame.size.width, 20);
    _Version.textColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1];
    
    _copyRight.text = @"版权所有  人民网股份有限公司";
    _copyRight.font = [UIFont systemFontOfSize:12];
    _copyRight.frame = CGRectMake(0, 350, self.frame.size.width, 20);
    _copyRight.textColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1];
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
