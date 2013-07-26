//
//  FSChannelIconsView.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-9-10.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSChannelIconsView.h"
#import "FSChannelObject.h"

#import "FSBaseDB.h"

@implementation FSChannelIconsView

@synthesize IconsInOneLine = _IconsInOneLine;
@synthesize channelForNewsList = _channelForNewsList;
@synthesize  selectChannelid = _selectChannelid;

@synthesize isForOrdinnews = _isForOrdinnews;

@synthesize layoutWithLocalData = _layoutWithLocalData;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)doSomethingAtDealloc{
    [_scrollView release];
}

-(void)doSomethingAtInit{
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    _isForOrdinnews = NO;
    _selectChannelid = @"";
    _layoutWithLocalData = NO;
}

-(void)doSomethingAtLayoutSubviews{
    
    [self layoutIcons];
}

-(void)layoutIcons{
    _scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    

    NSArray *subViews = [_scrollView subviews];
    for (FSAsyncCheckImageView *o in subViews){
        [o removeFromSuperview];
    }
    
    if (self.layoutWithLocalData == YES) {
        [self layoutLocalIcons];
    }
    else{
        if ([_objectList count]>0) {
            NSObject *o = [_objectList objectAtIndex:0];
            if ([o isKindOfClass:[FSChannelObject class]]) {
                NSInteger i=0;
                NSInteger line = 0;
                NSInteger row = 0;
                CGFloat spacing = 9;
                CGFloat imageSize = self.frame.size.width/_IconsInOneLine - spacing*2;
                for (FSChannelObject *o in _objectList) {
                    line = i/_IconsInOneLine;
                    row = i%_IconsInOneLine;
                    
                    FSAsyncCheckImageView *imageView = [[FSAsyncCheckImageView alloc] initWithFrame:CGRectMake(imageSize*row+spacing*(2*row+1), 10+(imageSize+spacing)*line, imageSize, imageSize)];
                    //NSString *defaultDBPath = [getDocumentPath() stringByAppendingPathComponent:[o.channel_normal lastPathComponent]];
                    imageView.normalURLString = o.channel_normal;
                    imageView.heighlightURLString = o.channel_highlight;
                    imageView.selectedURLString = o.channel_selected;
                    imageView.imageCheckType = [self getChannelCheckType:o.channelid];//
                    imageView.channelID = o.channelid;
                    imageView.tag = i;
                    //NSLog(@"o.channel_selected:%@",o.channel_selected);
                    [_scrollView addSubview:imageView];
                    
                    [imageView updataCheckImageView];
                    UILongPressGestureRecognizer *tapGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleGes:)];
                    tapGes.minimumPressDuration = 0.06;
                    [_scrollView addGestureRecognizer:tapGes];
                    [tapGes release];
                    [imageView release];
                    i++;
                    
                }
                _scrollView.contentSize = CGSizeMake(self.frame.size.width, 20+(imageSize+spacing)*line +imageSize);
            }
            
        }
    }
    
}


-(void)layoutLocalIcons{
    

    NSArray *channelList = [self.data valueForKey:@"channelList"];
    NSArray *normalImage = [self.data valueForKey:@"normalImage"];
    NSArray *selectedImage = [self.data valueForKey:@"selectedImage"];
    
    NSInteger i=0;
    NSInteger line = 0;
    NSInteger row = 0;
    CGFloat spacing = 9;
    CGFloat imageSize = self.frame.size.width/_IconsInOneLine - spacing*2;
    
    for (i=0; i<[channelList count]; i++) {
        line = i/_IconsInOneLine;
        row = i%_IconsInOneLine;
        
        FSAsyncCheckImageView *imageView = [[FSAsyncCheckImageView alloc] initWithFrame:CGRectMake(imageSize*row+spacing*(2*row+1), 10+(imageSize+spacing)*line, imageSize, imageSize)];
        //NSString *defaultDBPath = [getDocumentPath() stringByAppendingPathComponent:[o.channel_normal lastPathComponent]];
        imageView.normalURLString = [normalImage objectAtIndex:i];
        imageView.heighlightURLString = [selectedImage objectAtIndex:i];
        imageView.selectedURLString = [selectedImage objectAtIndex:i];
        imageView.imageCheckType = [self getChannelCheckType:[channelList objectAtIndex:i]];//
        imageView.channelID = [channelList objectAtIndex:i];
        imageView.tag = i;
        imageView.layoutLocalImage = self.layoutWithLocalData;
        [_scrollView addSubview:imageView];
        //NSLog(@"imageView.selectedURLString:%@",imageView.selectedURLString);
        [imageView updataCheckImageView];
        UILongPressGestureRecognizer *tapGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleGes:)];
        tapGes.minimumPressDuration = 0.08;
        [_scrollView addGestureRecognizer:tapGes];
        [tapGes release];
        [imageView release];
        
    }
    _scrollView.contentSize = CGSizeMake(self.frame.size.width, 20+(imageSize+spacing)*line +imageSize);
}


-(ImageCheckType)getChannelCheckType:(NSString *)channelid{
    
    if (self.isForOrdinnews) {
        
        if ([channelid isEqualToString:self.selectChannelid]) {
            return ImageCheckType_selected;
        }
        else{
            return ImageCheckType_normal;
        }
        
    }
    
    NSArray *visitArray = [[FSBaseDB sharedFSBaseDB] getObjectsByKeyWithName:@"FSChannelSelectedObject" key:@"channelid" value:channelid];
    if ([visitArray count]>0) {
        return ImageCheckType_selected;
    }
    else{
        return ImageCheckType_normal;
    }
}


- (void)handleGes:(UILongPressGestureRecognizer *)ges {
    CGPoint pt = [ges locationInView:_scrollView];
    UIView *hitView = [_scrollView hitTest:pt withEvent:nil];
    FSAsyncCheckImageView *asycImageView = nil;
    if ([hitView isKindOfClass:[FSAsyncCheckImageView class]]) {
        asycImageView = (FSAsyncCheckImageView *)hitView;
    }
    
    if (ges.state == UIGestureRecognizerStateEnded) {
        if (asycImageView != nil) {
            self.channelForNewsList = asycImageView.channelID;
            [self sendTouchEvent];
        }
        else{
           
        }
        
    }else{
        return;
    }
}



@end
