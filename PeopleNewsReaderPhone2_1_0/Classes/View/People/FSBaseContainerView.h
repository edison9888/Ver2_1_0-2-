//
//  FSBaseContainerView.h
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-29.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSConst.h"
#import "GlobalConfig.h"

@interface FSBaseContainerView : UIView{
@protected
    NSObject *_data;
    NSArray *_objectList;
    CGSize _clientSize;
    id _parentDelegate;
}

@property (nonatomic, retain, setter = setData:) NSObject *data;
@property (nonatomic, retain, setter = setArray:) NSArray *objectList;
@property (nonatomic, assign) id parentDelegate;

//初始化
-(void)doSomethingAtInit;
//销毁对象
-(void)doSomethingAtDealloc;
//布局
-(void)doSomethingAtLayoutSubviews;

-(void)sendTouchEvent;

@end

@protocol FSBaseContainerViewDelegate
@optional
-(void)fsBaseContainerViewTouchEvent:(FSBaseContainerView *)sender;

@end
