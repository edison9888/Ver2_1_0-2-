//
//  BlogActivityView.h
//  BlogPress
//
//  Created by Feng Huajun on 08-6-18.
//  Copyright 2008 Coollittlethings. All rights reserved.
//

#import <UIKit/UIKit.h>
#define BUTTON_TITLE_KEY @"btninfo"
#define LABEL_TEXT_KEY @"labelinfo"
#define BTN_EFFECT @"btneffected"

@interface NTESNBActivityView : UIView {

	UIActivityIndicatorView*  activityIndicator;
	UILabel *label;
	UIButton *button;
	
	id activeDelegate;
	
	UIView *backView;
	
}
@property(nonatomic,assign) id activeDelegate;
@property(nonatomic,assign) NSString* text;
+ (NTESNBActivityView *)sharedActivityView;
//为了简化layout，目前暂时只支持一个按钮
- (void)startSpinWithInfo:(NSString *)info withButtonTitle:(NSString *)button;
- (void)stopSpinWithInfo:(NSString *)info withButtonTitle:(NSString *)button;
@end

@protocol ActiveViewDelegate
@optional
- (void)buttonSelected:(NSString *)btnTitle;
@end


@interface NTESNBActivityView()
//- (void)refreshImmediately;
//- (void)layoutButton:(NSArray *)arr InRect:(CGRect)rect;
- (void)drawRoundedRect:(CGRect) rect inContext:(CGContextRef)context withSize:(CGSize) size;
- (void)showUp;
- (void)fadeOut:(id)sender;
@end