//
//  FSChannelListForNewsContentView.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-17.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSChannelListForNewsContentView.h"
#import "FSChannelObject.h"

@implementation FSChannelListForNewsContentView


@synthesize  TitleobjectList = _TitleobjectList;
@synthesize selected_channelID = _selected_channelID;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)doSomethingAtInit{
    _background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ChannelSettingViewBGR.png"]];
    [self addSubview:_background];
    [super doSomethingAtInit];
      
}


-(void)doSomethingAtDealloc{
    [super doSomethingAtDealloc];
    [_background release];
}

-(void)layoutIcons{
    _scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _background.frame = self.frame;
    //_scrollView.backgroundColor = COLOR_CLEAR;
    if ([_objectList count]>0) {
            NSInteger i=0;
            NSInteger line = 0;
            NSInteger row = 0;
            CGFloat spacing = 9;
            CGFloat imageSize = self.frame.size.width/_IconsInOneLine - spacing*2;
            for (FSChannelObject *o in _objectList) {
                line = i/_IconsInOneLine;
                row = i%_IconsInOneLine;
                
                FSAsyncCheckImageView *imageView = [[FSAsyncCheckImageView alloc] initWithFrame:CGRectMake(imageSize*row+spacing*(2*row+1), 10+(imageSize+ 20 + spacing)*line, imageSize, imageSize)];
                //                NSString *defaultDBPath = [getDocumentPath() stringByAppendingPathComponent:[o.channel_normal lastPathComponent]];
                imageView.normalURLString = o.channel_normal;
                imageView.heighlightURLString = o.channel_highlight;
                imageView.selectedURLString = o.channel_selected;
                imageView.imageCheckType = [self getChannelCheckType:o.channelid];//
                imageView.channelID = o.channelid;
                imageView.tag = i;
                //imageView.backgroundColor = [UIColor redColor];
                [_scrollView addSubview:imageView];
                
                [imageView updataCheckImageView];
                UILongPressGestureRecognizer *tapGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleGes:)];
                tapGes.minimumPressDuration = 0.08;
                [_scrollView addGestureRecognizer:tapGes];
                [tapGes release];
                [imageView release];
                
                UILabel *titleLab = [[UILabel alloc] init];
                titleLab.frame = CGRectMake(imageSize*row+spacing*(2*row+1), 10+(imageSize+20+spacing)*line+imageSize, imageSize, 18);
                titleLab.textAlignment = UITextAlignmentCenter;
                titleLab.backgroundColor = [UIColor clearColor];
                titleLab.text = o.channelname;
                [_scrollView addSubview:titleLab];
                [titleLab release];
                i++;
                
            }
            _scrollView.contentSize = CGSizeMake(self.frame.size.width, 20+(imageSize+20+spacing)*line +imageSize+18);
    }

}


-(ImageCheckType)getChannelCheckType:(NSString *)channelid{
    return ImageCheckType_normal;
}


- (void)handleGes:(UILongPressGestureRecognizer *)ges {
    CGPoint pt = [ges locationInView:_scrollView];
    UIView *hitView = [_scrollView hitTest:pt withEvent:nil];
    FSAsyncCheckImageView *asycImageView = nil;
    if ([hitView isKindOfClass:[FSAsyncCheckImageView class]] && ges.state == UIGestureRecognizerStateEnded) {
        asycImageView = (FSAsyncCheckImageView *)hitView;
        _selected_channelID = asycImageView.channelID;
        if ([_parentDelegate respondsToSelector:@selector(fsChannelListSelectFinish:)]) {
            [_parentDelegate fsChannelListSelectFinish:self];
        }
    }
}


-(void)dealloc{
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

@end
