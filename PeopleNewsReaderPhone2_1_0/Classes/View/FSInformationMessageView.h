//
//  FSInformationMessageView.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-8.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "FSGraphicsEx.h"
#import "FSCommonFunction.h"

#define VERTICAL_CENTER 
#define HORIZONTAL_CENTER (1 << 1)

typedef enum _PositionKind {
	PositionKind_Vertical_Horizontal_Center,
	PositionKind_Vertical_Center,
	PositionKind_Horizontal_Center
	
} PositionKind;

@protocol FSInformationMessageViewDelegate;

@interface FSInformationMessageView : UIView {
@private
	CALayer *_backgroundLayer;
	UILabel *_lblMessage;
	NSTimeInterval _delaySeconds;
	
	PositionKind _positionKind;
	CGFloat _offset;
	
	//NSObject<FSInformationMessageViewDelegate> *_parentDelegate;
    id _parentDelegate;
	UITapGestureRecognizer *_tapGesture;
	CGSize _clientSize;
	CGSize _messageSize;
}

//@property (nonatomic, retain) NSObject<FSInformationMessageViewDelegate> *parentDelegate;

@property (nonatomic, assign) id parentDelegate;

- (void)showInformationMessageViewInView:(UIView *)parentView withMessage:(NSString *)message withDelaySeconds:(NSTimeInterval)delaySeconds withPositionKind:(PositionKind)positionKind withOffset:(CGFloat)offset;

+ (FSInformationMessageView *)getInformationMessageViewInView:(UIView *)parentView;
+ (void)layoutInformationMessageViewInView:(UIView *)parentView;

@end

@protocol FSInformationMessageViewDelegate<NSObject>
@optional
- (void)informationMessageViewTouchClosed:(FSInformationMessageView *)sender;
@end

