//
//  FSFeedBackNomalQContentView.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-1-25.
//
//

#import "FSFeedBackNomalQContentView.h"

@implementation FSFeedBackNomalQContentView

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
    [_scrollView release];
}

-(void)doSomethingAtInit{
    
    self.backgroundColor = COLOR_NEWSLIST_TITLE_WHITE;
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.delegate = self;
    _scrollView.backgroundColor = COLOR_CLEAR;
    [self addSubview:_scrollView];
    
    
}


-(void)doSomethingAtLayoutSubviews{
    
//    if (self.data == nil) {
//        return;
//    }
    _scrollView.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
    
    NSArray *viewS = [_scrollView subviews];
    for (UIView *o in viewS) {
        [o removeFromSuperview];
    }

    CGFloat breakSpace = 6.0f;
   CGFloat top = 10;
    CGSize sizeTemp = CGSizeZero;
    //for (NSInteger i=0;i<3;i++) {
        UILabel *lab_Q1 = [[UILabel alloc] init];
        lab_Q1.backgroundColor = COLOR_CLEAR;
        lab_Q1.font = [UIFont systemFontOfSize:14];
        lab_Q1.textColor = COLOR_NEWSLIST_TITLE;
        lab_Q1.numberOfLines = 4;
        lab_Q1.text = @"Q：为什么有时候数据加载很慢？";
        
        
        UILabel *lab_A1 = [[UILabel alloc] init];
        lab_A1.backgroundColor = COLOR_CLEAR;
        lab_A1.textColor = COLOR_NEWSLIST_DESCRIPTION;
        lab_A1.font = [UIFont systemFontOfSize:13];
        lab_A1.numberOfLines = 10;
        lab_A1.text = @"A：有可能您所处的网络信号不稳定，导致加载时间过长，建议您稍后再尝试重新加载。如果长期频繁出现此问题，请反馈给我们。";
    
    
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0];
        
    
    sizeTemp = [lab_Q1.text sizeWithFont:lab_Q1.font constrainedToSize:CGSizeMake(self.frame.size.width - 48, 1024) lineBreakMode:lab_Q1.lineBreakMode];
    
    lab_Q1.frame = CGRectMake(24, top, self.frame.size.width - 48, sizeTemp.height);
    top = top + sizeTemp.height + breakSpace;
    
    sizeTemp = [lab_A1.text sizeWithFont:lab_A1.font constrainedToSize:CGSizeMake(self.frame.size.width - 48, 1024) lineBreakMode:lab_A1.lineBreakMode];
    lab_A1.frame = CGRectMake(24, top, self.frame.size.width - 48, sizeTemp.height);
    top = top + sizeTemp.height + breakSpace*3;
    
    lineView1.frame = CGRectMake(24, top-breakSpace*1.5, self.frame.size.width - 48, 1);
        
        [_scrollView addSubview:lab_Q1];
        [_scrollView addSubview:lab_A1];
        [_scrollView addSubview:lineView1];
        [lab_Q1 release];
        [lab_A1 release];
    [lineView1 release];
    
    UILabel *lab_Q2 = [[UILabel alloc] init];
    lab_Q2.backgroundColor = COLOR_CLEAR;
    lab_Q2.font = [UIFont systemFontOfSize:14];
    lab_Q2.textColor = COLOR_NEWSLIST_TITLE;
    lab_Q2.numberOfLines = 4;
    lab_Q2.text = @"Q：如何更改“我的头条”中已订阅的新闻类目？ ";
    
    
    UILabel *lab_A2 = [[UILabel alloc] init];
    lab_A2.backgroundColor = COLOR_CLEAR;
    lab_A2.textColor = COLOR_NEWSLIST_DESCRIPTION;
    lab_A2.font = [UIFont systemFontOfSize:13];
    lab_A2.numberOfLines = 10;
    lab_A2.text = @" A：在工具栏或设置中点击“订阅我的头条”可以重新选择“我的头条”内的新闻类目，选择完毕后点击”完成“按钮即可。";
    
    
    
    
    sizeTemp = [lab_Q2.text sizeWithFont:lab_Q2.font constrainedToSize:CGSizeMake(self.frame.size.width - 48, 1024) lineBreakMode:lab_Q2.lineBreakMode];
    
    lab_Q2.frame = CGRectMake(24, top, self.frame.size.width - 48, sizeTemp.height);
    top = top + sizeTemp.height + breakSpace;
    
    sizeTemp = [lab_A2.text sizeWithFont:lab_A2.font constrainedToSize:CGSizeMake(self.frame.size.width - 48, 1024) lineBreakMode:lab_A2.lineBreakMode];
    lab_A2.frame = CGRectMake(24, top, self.frame.size.width - 48, sizeTemp.height);
    top = top + sizeTemp.height + breakSpace*3;
    
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0];
    lineView2.frame = CGRectMake(24, top-breakSpace*1.5, self.frame.size.width - 48, 1);
    
    [_scrollView addSubview:lab_Q2];
    [_scrollView addSubview:lab_A2];
    [_scrollView addSubview:lineView2];
    [lab_Q2 release];
    [lab_A2 release];
    [lineView2 release];
    
    
    UILabel *lab_Q3 = [[UILabel alloc] init];
    lab_Q3.backgroundColor = COLOR_CLEAR;
    lab_Q3.font = [UIFont systemFontOfSize:14];
    lab_Q3.textColor = COLOR_NEWSLIST_TITLE;
    lab_Q3.numberOfLines = 4;
    lab_Q3.text = @"Q：如何升级客户端版本？";
    
    
    UILabel *lab_A3 = [[UILabel alloc] init];
    lab_A3.backgroundColor = COLOR_CLEAR;
    lab_A3.textColor = COLOR_NEWSLIST_DESCRIPTION;
    lab_A3.font = [UIFont systemFontOfSize:13];
    lab_A3.numberOfLines = 10;
    lab_A3.text = @"A：有新版本时，客户端会自动向您发出通知，您选择“更新”即可完成升级；您可以登录手机人民网（http://3g.people.com.cn）点击“下载”，检查您的客户端版本是否为最新；您也可通过APP Store或iTunes进行更新。";
    
    
    sizeTemp = [lab_Q3.text sizeWithFont:lab_Q3.font constrainedToSize:CGSizeMake(self.frame.size.width - 48, 1024) lineBreakMode:lab_Q3.lineBreakMode];
    
    lab_Q3.frame = CGRectMake(24, top, self.frame.size.width - 48, sizeTemp.height);
    top = top + sizeTemp.height + breakSpace;
    
    sizeTemp = [lab_A3.text sizeWithFont:lab_A3.font constrainedToSize:CGSizeMake(self.frame.size.width - 48, 1024) lineBreakMode:lab_A3.lineBreakMode];
    lab_A3.frame = CGRectMake(24, top, self.frame.size.width - 48, sizeTemp.height);
    top = top + sizeTemp.height + breakSpace*3;
    
    UIView *lineView3 = [[UIView alloc] init];
    lineView3.backgroundColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0];
    lineView3.frame = CGRectMake(24, top-breakSpace*1.5, self.frame.size.width - 48, 1);
    
    
    [_scrollView addSubview:lab_Q3];
    [_scrollView addSubview:lab_A3];
    [_scrollView addSubview:lineView3];
    [lab_Q3 release];
    [lab_A3 release];
    [lineView3 release];
    
    
    UILabel *lab_Q4 = [[UILabel alloc] init];
    lab_Q4.backgroundColor = COLOR_CLEAR;
    lab_Q4.font = [UIFont systemFontOfSize:14];
    lab_Q4.textColor = COLOR_NEWSLIST_TITLE;
    lab_Q4.numberOfLines = 4;
    lab_Q4.text = @"Q：如何联系我们？";
    
    
    UILabel *lab_A4 = [[UILabel alloc] init];
    lab_A4.backgroundColor = COLOR_CLEAR;
    lab_A4.textColor = COLOR_NEWSLIST_DESCRIPTION;
    lab_A4.font = [UIFont systemFontOfSize:13];
    lab_A4.numberOfLines = 10;
    lab_A4.text = @"A：互动qq群号：249081558 \r\n      微信公众号：renminxw \r\n      客服邮箱：wap@people.cn";
    
    
    sizeTemp = [lab_Q4.text sizeWithFont:lab_Q3.font constrainedToSize:CGSizeMake(self.frame.size.width - 48, 1024) lineBreakMode:lab_Q4.lineBreakMode];
    
    lab_Q4.frame = CGRectMake(24, top, self.frame.size.width - 48, sizeTemp.height);
    top = top + sizeTemp.height + breakSpace;
    
    sizeTemp = [lab_A4.text sizeWithFont:lab_A4.font constrainedToSize:CGSizeMake(self.frame.size.width - 48, 1024) lineBreakMode:lab_A4.lineBreakMode];
    lab_A4.frame = CGRectMake(24, top, self.frame.size.width - 48, sizeTemp.height);
    top = top + sizeTemp.height + breakSpace*3;
    
    [_scrollView addSubview:lab_Q4];
    [_scrollView addSubview:lab_A4];
    [lab_Q4 release];
    [lab_A4 release];
    
    _scrollView.contentSize = CGSizeMake(self.frame.size.width, top);
    
        //return;
   // }
    
    
}



@end
