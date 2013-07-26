//
//  FSChannelIconsContainerView.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-9-5.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSChannelIconsContainerView.h"
#import "FSChannelObject.h"
#import "FSBaseDB.h"
#import "FSCommonFunction.h"
#import "FSChannelSelectedObject.h"

@implementation FSChannelIconsContainerView


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

- (void)handleGes:(UILongPressGestureRecognizer *)ges {
    
    CGPoint pt = [ges locationInView:_scrollView];  
    UIView *hitView = [_scrollView hitTest:pt withEvent:nil];
    FSAsyncCheckImageView *asycImageView = nil;
    if ([hitView isKindOfClass:[FSAsyncCheckImageView class]]) {
        asycImageView = (FSAsyncCheckImageView *)hitView;
    }
   
    
    if (ges.state == UIGestureRecognizerStateBegan) {
        _oldType = asycImageView.imageCheckType;
        asycImageView.imageCheckType = ImageCheckType_selected;
        [asycImageView updataCheckImageView];
        _oldfsAsyncCheckImageView = asycImageView;
        return; 
    }
    
    if (ges.state == UIGestureRecognizerStateChanged) {
        if (_oldfsAsyncCheckImageView != asycImageView && asycImageView != nil) {
            _oldfsAsyncCheckImageView.imageCheckType = _oldType;
            [_oldfsAsyncCheckImageView updataCheckImageView];
            
            _oldType = asycImageView.imageCheckType;
            asycImageView.imageCheckType = ImageCheckType_selected;
            [asycImageView updataCheckImageView];
            _oldfsAsyncCheckImageView = asycImageView;
        }
        return;
    }
    
    if (ges.state == UIGestureRecognizerStateEnded) {
        if (asycImageView != nil) {
            if (_oldType == ImageCheckType_selected) {
                asycImageView.imageCheckType = ImageCheckType_normal;
            }
            else{
                asycImageView.imageCheckType = ImageCheckType_selected;
            }
            [asycImageView updataCheckImageView];
        }
        else{
            _oldfsAsyncCheckImageView.imageCheckType = _oldType;
            [_oldfsAsyncCheckImageView updataCheckImageView]; 
        }
        [[FSBaseDB sharedFSBaseDB] updata_oneday_selectChannel_message:asycImageView.channelID];
    }else{
        return;
    }
    NSLog(@"updata_oneday_selectChannel_message");
    
    /*
     NSArray *recordArr = [[FSBaseDB sharedFSBaseDB] getObjectsByKeyWithName:@"FSChannelSelectedObject" key:@"channelid" value:asycImageView.channelID];
    if ([recordArr count]>0) {
        FSChannelSelectedObject *o = (FSChannelSelectedObject *)[recordArr lastObject];
        if ([o.channelid isEqualToString:asycImageView.channelID] && asycImageView.imageCheckType == ImageCheckType_normal) {
            [[FSBaseDB sharedFSBaseDB] deleteObjectByKey:@"FSChannelSelectedObject" key:@"channelid" value:asycImageView.channelID];
        }
    }
    else{
        if (asycImageView.imageCheckType == ImageCheckType_selected) {
            FSChannelSelectedObject *o = (FSChannelSelectedObject *)[[FSBaseDB sharedFSBaseDB] insertObject:@"FSChannelSelectedObject"];
            [o setValue:asycImageView.channelID forKey:@"channelid"];
        }
    }
    [[FSBaseDB sharedFSBaseDB].managedObjectContext save:nil];
     */
}


-(void)sendTouchEvent{
    ;
}


@end
