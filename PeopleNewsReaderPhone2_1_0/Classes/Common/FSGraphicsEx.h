/*
 *  FSGraphicsEx.h
 *  ipad
 *
 *  Created by people.com.cn on 11-7-1.
 *  Copyright 2011 www.people.com.cn. All rights reserved.
 *
 */
//////////////////////////////////////////////////////////////////
//	版本			时间				说明
//////////////////////////////////////////////////////////////////
//	1.0			2011-06-15		初版做成，基本绘制图形函数
//****************************************************************
#include <CoreGraphics/CoreGraphics.h>

//绘制方式常量
//一个矩形区域
#define FS_DRAW_REGION_RECT (1 << 31)
//左上角圆角
#define FS_DRAW_REGION_LEFT_TOP_RADIUS (1)
//右上角圆角
#define FS_DRAW_REGION_RIGHT_TOP_RADIUS (1 << 1)
//右下角圆角
#define FS_DRAW_REGION_RIGHT_BOTTOM_RADIUS (1 << 2)
//左下角圆角
#define FS_DRAW_REGION_LEFT_BOTTOM_RADIUS (1 << 3)
//四周圆角
#define FS_DRAW_REGION_ROUND_RECT (FS_DRAW_REGION_LEFT_TOP_RADIUS | FS_DRAW_REGION_RIGHT_TOP_RADIUS | FS_DRAW_REGION_RIGHT_BOTTOM_RADIUS | FS_DRAW_REGION_LEFT_BOTTOM_RADIUS)

//从上往下
#define FS_LIGHT_FROM_TOP_TO_BOTTOM (1 << 8)
//从左往右
#define FS_LIGHT_FROM_LEFT_TO_RIGHT (1 << 9)
//从下往上
#define FS_LIGHT_FROM_BOTTOM_TO_TOP (1 << 10)
//从右往左
#define FS_LIGHT_FROM_RIGHT_TO_LEFT (1 << 11)
//从里往外
#define FS_LIGHT_FROM_INNER_TO_OUTER (1 << 12)
//往外往里
#define FS_LIGHT_FROM_OUTER_TO_INNER (1 << 13)

#define FS_ARROW_UP (1)
#define FS_ARROW_DOWN (1 << 1)
#define FS_ARROW_LEFT (1 << 2)
#define FS_ARROW_RIGHT (1 << 3)

//裁剪图片
#define FS_CUTTING_IMAGE_SCALE (1)
#define FS_CUTTING_IMAGE_STRENTCH (2)
#define FS_CUTTING_IMAGE_CENTER (3)
#define FS_CUTTING_IMAGE_LEFT_TOP (4)
#define FS_CUTTING_IMAGE_RIGHT_TOP (5)
#define FS_CUTTING_IMAGE_LEFT_BOTTOM (6)
#define FS_CUTTING_IMAGE_RIGHT_BOTTOM (7)
#define FS_CUTTING_IMAGE_OFFSET (8)
#define FS_CUTTING_IMAGE_FIXRECT (9)
#define FS_CUTTING_IMAGE_FIXHEIGHT (10)

//////////////////////////////////////////////////////////////////
//	函数说明：FOUNDATION_EXTERN
//////////////////////////////////////////////////////////////////

FOUNDATION_EXTERN void buildPathForRect(CGContextRef context, CGRect rect, CGFloat radius, NSUInteger radiusflag);

FOUNDATION_EXTERN void drawLightForPath(CGContextRef context, CGRect rect, NSUInteger lightFlag, CGGradientRef gradient, CGFloat startRadius, CGFloat endRadius);

FOUNDATION_EXTERN void drawCrystalRect(CGContextRef context, CGRect rect, CGFloat radius, const CGFloat *components, NSUInteger componentCount);

FOUNDATION_EXTERN UIImage *createImageWithRect(CGRect rect, CGFloat radius, const CGFloat *components, NSUInteger componentCount);

FOUNDATION_EXTERN void drawNavigatorArrow(CGContextRef context, CGRect rect, NSUInteger arrowDirection, const CGFloat *components, NSUInteger componentCount);

FOUNDATION_EXTERN UIImage *createNavigatorArrowWithRect(CGRect rect, NSUInteger arrowDirection, CGFloat boundSpace, const CGFloat *components, NSUInteger componentCount);

FOUNDATION_EXTERN void drawImageWithRect(CGContextRef context, CGRect rect, UIImage *image);

FOUNDATION_EXTERN UIImage *scaleImage(UIImage *source, CGSize destSize);
//构建一个左卷曲的图像
FOUNDATION_EXTERN UIImage *curlImage(CGColorRef color, CGRect rect, CGFloat radius, CGSize offset, NSUInteger flag);
//构建一个镜框
FOUNDATION_EXTERN UIImage *rectangleFrameImage(CGColorRef color, CGRect rect, CGFloat edge, CGFloat shadowOffset, NSUInteger flag);

FOUNDATION_EXTERN void drawVerticalGrid(CGContextRef context, CGRect rect, CGFloat lineWidth, const CGFloat *oddComponents, NSInteger oddComponentCount, const CGFloat *evenComponents, NSInteger evenComponentCount);

FOUNDATION_EXTERN UIImage *drawBackgroundImageWithRoundRect(CGRect rect, CGFloat edgeWidth, CGFloat radius, CGColorRef fillColor, CGColorRef borderColor);

FOUNDATION_EXTERN UIImage *cuttingImageWithSourceImage(UIImage *image, CGRect destRect, CGFloat radius, CGColorRef borderColor, CGFloat borderWidth, NSUInteger flag, CGPoint offset);

FOUNDATION_EXPORT UIImage *clipImageToRoundRect(UIImage *image, CGFloat radius);

