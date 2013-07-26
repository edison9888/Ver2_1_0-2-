//
//  FSLocalNewsListContentView.h
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-10.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSTableContainerView.h"
#import "FSTableViewCell.h"



@interface FSLocalNewsListContentView : FSTableContainerView<UIScrollViewDelegate,FSTableViewCellDelegate>{
@protected
    
    CGFloat _controllerViewOffset;
}

@end
