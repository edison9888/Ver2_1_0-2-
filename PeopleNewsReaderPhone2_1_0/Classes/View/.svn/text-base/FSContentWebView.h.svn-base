//
//  FSContentWebView.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-20.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalConfig.h"

typedef enum _FSContentPictureScaleStyle {
	FSContentPictureScaleStyle_Scaling,
	FSContentPictureScaleStyle_FixedRect
	
} FSContentPictureScaleStyle;

@interface FSContentWebView : UIWebView <UIWebViewDelegate, UIGestureRecognizerDelegate>  {
@private
	/*
	 字体确省索引、是否加载图片（2G_3G网络下不加载图片）
	 */
	GlobalConfig *_config;
	NSMutableArray *_pictureList;
	FSContentPictureScaleStyle _contentPictureScaleStyle;
//	NSInteger _fontDefaultIndex;
}


@property (nonatomic) FSContentPictureScaleStyle contentPictureScaleStyle;

- (void)loadContentData;
- (void)loadCommentData;

@end

@protocol FSContentWebViewDelegate
@optional
//- (void)contentWebViewNavigation:(FSContentWebView *)sender navigation:(ContentNavigation)navigation;
//- (void)contentWebViewTap:(FSContentWebView *)sender tapCount:(NSUInteger)tapCount;
//- (void)contentWebViewPictureLink:(FSContentWebView *)sender withPictureURL:(NSString *)pictureURL;
//- (void)contentWebViewLoadComplete:(FSContentWebView *)sender;
//- (void)contentWebViewFontSizeState:(FSContentWebView *)sender fontSizeState:(ContentWebViewFontSizeState)fontSizeState;
@required
//显示正文用
- (NSString *)contentWebViewTitle:(FSContentWebView *)sender;
- (NSString *)contentWebViewSubTitle:(FSContentWebView *)sender;
- (NSString *)contentWebViewAuthor:(FSContentWebView *)sender;
- (NSString *)contentWebViewText:(FSContentWebView *)sender;
- (NSInteger)contentWebViewPictureCount:(FSContentWebView *)sender;
- (void)contentWebView:(FSContentWebView *)sender pictureURL:(NSString **)pictureURL pictureText:(NSString **)pictureText withPictureIndex:(NSInteger)pictureIndex;
//评论用
@optional
- (NSInteger)contentWebViewCommentCount:(FSContentWebView *)sender;
- (NSString *)contentWebViewCommentNickName:(FSContentWebView *)sender withCommentIndex:(NSInteger)commentIndex;
- (NSString *)contentWebViewCommentDateTime:(FSContentWebView *)sender withCommentIndex:(NSInteger)commentIndex;
- (NSString *)contentWebViewCommentBody:(FSContentWebView *)sender withCommentIndex:(NSInteger)commentIndex;
- (NSString *)contentWebViewCommentComeFrom:(FSContentWebView *)sender withCommentIndex:(NSInteger)commentIndex;
- (void)contentWebViewAllCommentList:(FSContentWebView *)sender;
@end
