//
//  FSTitleView.h
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-13.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FSTitleView : UIView{
@protected
    id _parentDelegate;
     NSObject *_data;
    UIImageView *_image_ListIcon;
    UIImageView *_image_Refresh;
    UILabel *_lab_CityName;
    
    UIButton *_clear_backBT1;
    UIButton *_clear_backBT2;
    BOOL _hidRefreshBt;
    BOOL _toBottom;
    
    
}

@property (nonatomic,assign) id parentDelegate;
@property (nonatomic,assign) BOOL hidRefreshBt;
@property (nonatomic,assign) BOOL toBottom;

@property (nonatomic, retain, setter = setData:) NSObject *data;


-(void)doSomethingAtInit;
-(void)doSomethingAtDealloc;

-(void)initVariable;
-(void)setContent;
-(void)reSetFrame;

-(CGFloat)getTitleTextWidth:(NSString *)text;


@end


@protocol FSTitleViewDelegate

-(void)FSTitleViewTouchEvent:(FSTitleView *)titleView;

@end