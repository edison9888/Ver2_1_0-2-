//
//  FSMyFavoritesViewController.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-20.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSBaseDataViewController.h"
#import "FSMyFaverateContainView.h"


@interface FSMyFavoritesViewController : FSBaseDataViewController <FSTableContainerViewDelegate>{
@protected
    FSMyFaverateContainView *_fsMyFaverateContainView;
    NSArray *_array;
}

@end
