//
//  FSMoreContainerView.h
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-24.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSTableContainerView.h"
#import "FSTableViewCell.h"

#import "FSRecommendSectView.h"

@interface FSMoreContainerView : FSTableContainerView<FSTableViewCellDelegate,FSBaseContainerViewDelegate>{
@protected
    NSInteger _flag;
    NSIndexPath *oldIndexPath;
    
    NSObject *_data;
    
    NSInteger _currentIndex;
}
@property (nonatomic,assign) NSInteger flag;
@property (nonatomic, retain) NSObject *data;

@property (nonatomic, assign) NSInteger currentIndex;

-(void)tableCellselect:(NSIndexPath *)indexPath;

@end
