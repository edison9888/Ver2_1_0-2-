//
//  FSMoreTablePeopleAPPCell.h
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-28.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSTableViewCell.h"


@interface FSMoreTablePeopleAPPCell : FSTableViewCell{
@protected
   
    UIScrollView *_scrollView;
    NSInteger _currentIndex;
}

@property (nonatomic,assign) NSInteger currentIndex;

@end
