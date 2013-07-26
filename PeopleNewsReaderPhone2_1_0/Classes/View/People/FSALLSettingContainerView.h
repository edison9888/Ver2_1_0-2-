//
//  FSALLSettingContainerView.h
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-31.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSTableContainerView.h"
#import "FSTableViewCell.h"

@interface FSALLSettingContainerView : FSTableContainerView<FSTableViewCellDelegate>{
@protected
    NSInteger _flag;
    NSIndexPath *oldIndexPath;
}

@property (nonatomic,assign) NSInteger flag;

-(void)tableCellselect:(NSIndexPath *)indexPath;

@end
