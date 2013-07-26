//
//  FSControllerLayout.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-29.
//
//

#import <Foundation/Foundation.h>

typedef enum _FSControllerAdjustLayout {
    FSControllerAdjustLayout_Auto,
    FSControllerAdjustLayout_Self_Manual,
    FSControllerAdjustLayout_Other_Manual
} FSControllerAdjustLayout;

@protocol FSControllerLayout <NSObject>
@required
- (FSControllerAdjustLayout)isManualLayout;
- (void)layoutControllerViewWithInterfaceOrientation:(UIInterfaceOrientation)willToOrientation;
- (void)layoutControllerViewWithRect:(CGRect)rect;
@optional
- (CGRect)manualLayoutView;
@end
