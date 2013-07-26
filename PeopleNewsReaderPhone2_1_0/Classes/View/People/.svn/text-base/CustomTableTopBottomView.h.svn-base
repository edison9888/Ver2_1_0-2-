//
//  CustomTableTopBottomView.h
//  PeopleNewsReader
//
//  Created by bo bo on 11-2-19.
//  Copyright 2011 www.people.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kReleaseToReloadStatus	0
#define kPullToReloadStatus		1
#define kLoadingStatus			2

typedef enum {
    HeaderViewStyleBlack,			//黑色风格
    HeaderViewStyleWhite
} HeaderViewStyle;

@interface CustomTableTopBottomView : UIView {
	
	UILabel *lastUpdatedLabel;
	UILabel *statusLabel;
	UIImageView *arrowImage;
	UIActivityIndicatorView *activityView;
	
	BOOL isFlipped;
	
	NSDate *lastUpdatedDate;
}
@property BOOL isFlipped;
@property (nonatomic, retain) NSDate *lastUpdatedDate;
- (id)initWithFrame:(CGRect)frame withStyle:(HeaderViewStyle)style;


- (void)flipImageAnimated:(BOOL)animated;
- (void)toggleActivityView:(BOOL)isON;
- (void)setStatus:(int)status;

@end



