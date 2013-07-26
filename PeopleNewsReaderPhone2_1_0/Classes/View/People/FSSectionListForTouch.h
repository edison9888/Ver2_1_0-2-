//
//  FSSectionListForTouch.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-12-18.
//
//

#import <UIKit/UIKit.h>
#import "FSBaseContainerView.h"


@interface FSSectionListForTouch : FSBaseContainerView{
@protected
    UIImageView *_background;
    
    NSInteger _currentIndex;
    CGFloat lindheight;
}

@property (nonatomic,assign) NSInteger currentIdex;

@end
