//
//  NTESNBToast.h
//  NewsBoard
//
//  Created by 黄旭 on 1/14/11.
//  Copyright 2011 NetEase.com, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NTESNBToast : UIView {
	NSTimer *timer;
	UIImageView *backgroundImage;
	UILabel *infoLab;
	BOOL isWarning;
}
@property(nonatomic,assign) UIImageView *backgroundImage;
//@property(nonatomic,assign) UILabel *infoLab;
+ (NTESNBToast *)sharedToast;
- (void)showUpWithInfo:(NSString *)info;
- (void)showUpWithWarningInfo:(NSString *)info;
@end


@interface NTESNBToast()
-(void) drawRoundedRect:(CGRect) rect inContext:(CGContextRef)context withSize:(CGSize) size;
- (void)showUp:(NSString *)info;
- (void)hideInfo;
//- (void)removeSelf;
//- (void) startTimer;
//- (void) clearTimer;
@end