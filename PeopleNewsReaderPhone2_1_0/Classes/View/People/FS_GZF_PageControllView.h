//
//  FS_GZF_PageControllView.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-11-29.
//
//

#import <UIKit/UIKit.h>
#import "FSBaseContainerView.h"

typedef enum _Position_kind{
    Position_kind_left,
    Position_kind_middle,
    Position_kind_right
}Position_kind;


@interface FS_GZF_PageControllView : FSBaseContainerView{
@protected
    NSInteger _CurrentPage;
    NSInteger _PageNumber;
    UIColor *_FocusColor;
    UIColor *_NonFocusColor;
    CGFloat _Radius;
    CGFloat _Spacing;
    
    Position_kind _position_kind;
    
}

@property (nonatomic,assign) CGFloat Radius;
@property (nonatomic,assign) CGFloat Spacing;

@property (nonatomic,assign) Position_kind position_kind;

@property (nonatomic,retain) UIColor *FocusColor;
@property (nonatomic,retain) UIColor *NonFocusColor;

@property (nonatomic,assign,setter = setCurrentPage:) NSInteger CurrentPage;
@property (nonatomic,assign,setter = setPageNumber:) NSInteger PageNumber;

@end
