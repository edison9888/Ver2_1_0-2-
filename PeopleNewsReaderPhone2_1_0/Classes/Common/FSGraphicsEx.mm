/*
 *  FSGraphicsEx.c
 *  ipad
 *
 *  Created by people.com.cn on 11-7-1.
 *  Copyright 2011 www.people.com.cn. All rights reserved.
 *
 */

#include "FSGraphicsEx.h"

#define RGB_ADDTION (30.0f / 255.0f)

void buildPathForRect(CGContextRef context, CGRect rect, CGFloat radius, NSUInteger radiusflag) {
	if ((radiusflag & FS_DRAW_REGION_RECT) == FS_DRAW_REGION_RECT || radius == 0) {

		CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
		CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect));
		CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
		CGContextAddLineToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));
		CGContextClosePath(context);
	} else {
		//左上
		CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMidY(rect));
		if ((radiusflag & FS_DRAW_REGION_LEFT_TOP_RADIUS) == FS_DRAW_REGION_LEFT_TOP_RADIUS) {
			CGContextAddArcToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetMidX(rect), CGRectGetMinY(rect), radius);
		} else {
			CGContextAddLineToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
		}
		CGContextAddLineToPoint(context, CGRectGetMidX(rect), CGRectGetMinY(rect));
		
		//右上
		if ((radiusflag & FS_DRAW_REGION_RIGHT_TOP_RADIUS) == FS_DRAW_REGION_RIGHT_TOP_RADIUS) {
			CGContextAddArcToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMidY(rect), radius);
		} else {
			CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect));
		}
		CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMidY(rect));

		//右下
		if ((radiusflag & FS_DRAW_REGION_RIGHT_BOTTOM_RADIUS) == FS_DRAW_REGION_RIGHT_BOTTOM_RADIUS) {		
			CGContextAddArcToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect), CGRectGetMidX(rect), CGRectGetMaxY(rect), radius);
		} else {
			CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
		}
		CGContextAddLineToPoint(context, CGRectGetMidX(rect), CGRectGetMaxY(rect));
		
		//左下
		if ((radiusflag & FS_DRAW_REGION_LEFT_BOTTOM_RADIUS) == FS_DRAW_REGION_LEFT_BOTTOM_RADIUS) {
			CGContextAddArcToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMidY(rect), radius);
		} else {
			CGContextAddLineToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));
		}
		CGContextAddLineToPoint(context, CGRectGetMinX(rect), CGRectGetMidY(rect));
		
//		if (radiusflag == FS_DRAW_REGION_ROUND_RECT) {
//			CGContextClosePath(context);
//		}
	}
}

void drawLightForPath(CGContextRef context, CGRect rect, NSUInteger lightFlag, CGGradientRef gradient, CGFloat startRadius, CGFloat endRadius) {
	CGPoint startPoint = CGPointZero;
	CGPoint endPoint = CGPointZero;
	if (lightFlag == FS_LIGHT_FROM_INNER_TO_OUTER ||
		lightFlag == FS_LIGHT_FROM_OUTER_TO_INNER) {
		CGFloat radius1 = 0;
		CGFloat radius2 = 0;
		startPoint = CGPointMake(CGRectGetMinX(rect) + rect.size.width / 2.0f, CGRectGetMinY(rect) + rect.size.height / 2.0f);
		endPoint = startPoint;
		if (lightFlag == FS_LIGHT_FROM_INNER_TO_OUTER) {
			radius1 = MIN(startRadius, endRadius);
			radius2 = MAX(startRadius, endRadius);
		} else {
			radius1 = MAX(startRadius, endRadius);
			radius2 = MIN(startRadius, endRadius);
		}
		CGContextDrawRadialGradient(context, gradient, startPoint, radius1, endPoint, radius2, 0);
	} else {

		if (lightFlag == FS_LIGHT_FROM_TOP_TO_BOTTOM) {
			startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
			endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
		} else if (lightFlag == FS_LIGHT_FROM_LEFT_TO_RIGHT) {
			startPoint = CGPointMake(CGRectGetMinX(rect), CGRectGetMidY(rect));
			endPoint = CGPointMake(CGRectGetMaxX(rect), CGRectGetMidY(rect));
		} else if (lightFlag == FS_DRAW_REGION_LEFT_BOTTOM_RADIUS) {
			startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
			endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
		} else if (lightFlag == FS_LIGHT_FROM_RIGHT_TO_LEFT) {
			startPoint = CGPointMake(CGRectGetMaxX(rect), CGRectGetMidY(rect));
			endPoint = CGPointMake(CGRectGetMinX(rect), CGRectGetMidY(rect));
		} 
		CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
	}
}

void drawCrystalRect(CGContextRef context, CGRect rect, CGFloat radius, const CGFloat *components, NSUInteger componentCount) {
	//STEP 1.
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	
	//STEP 2.
	CGFloat colors[4] = {0};
	if (componentCount >= 4) {
		colors[0] = components[0];
		colors[1] = components[1];
		colors[2] = components[2];
		colors[3] = components[3];
	} else if (componentCount == 2) {
		colors[0] = components[0];
		colors[1] = components[0];
		colors[2] = components[0];
		colors[3] = components[1];
	}
#ifdef G_MYDEBUG
	NSLog(@"componentCount=%d;r=%f;g=%f;b=%f;a=%f", componentCount, colors[0], colors[1], colors[2], colors[3]);
#endif
	CGRect rClient = rect;
	rClient.origin.x += 0.5;
	rClient.origin.y += 0.5;
	rClient.size.width -= 1;
	rClient.size.height -= 2;
	CGContextSaveGState(context);
	buildPathForRect(context, rClient, radius, (FS_DRAW_REGION_LEFT_TOP_RADIUS | FS_DRAW_REGION_RIGHT_TOP_RADIUS | FS_DRAW_REGION_RIGHT_BOTTOM_RADIUS | FS_DRAW_REGION_LEFT_BOTTOM_RADIUS));
	CGContextSetRGBFillColor(context, colors[0], colors[1], colors[2], colors[3]);
	CGContextSetRGBStrokeColor(context, colors[0], colors[1], colors[2], colors[3]);
	CGContextSetLineWidth(context, 1.0f);
	CGContextDrawPath(context, kCGPathFillStroke);
	CGContextRestoreGState(context);
	
	//STEP 3.
	CGContextSaveGState(context);
	CGContextSetLineWidth(context, 1.0f);
	CGFloat topGradientColors[] = 
	{
		1.0f, 1.0f, 1.0f, 0.8,
		1.0f, 1.0f, 1.0f, 0.6,
		1.0f, 1.0f, 1.0f, 0.4,
		1.0f, 1.0f, 1.0f, 0.2,
		1.0f, 1.0f, 1.0f, 0.0
		
	};
	CGRect topRect = CGRectMake(CGRectGetMinX(rClient), CGRectGetMinY(rClient), rClient.size.width, rClient.size.height / 2.0f);
	CGGradientRef topGradient = CGGradientCreateWithColorComponents(colorSpace, topGradientColors, NULL, sizeof(topGradientColors) / (4 * sizeof(CGFloat)));
	buildPathForRect(context, topRect, radius, (FS_DRAW_REGION_LEFT_TOP_RADIUS | FS_DRAW_REGION_RIGHT_TOP_RADIUS));
	CGContextClip(context);
	drawLightForPath(context, topRect, FS_LIGHT_FROM_TOP_TO_BOTTOM, topGradient, 0.0f, 0.0f);
	CGGradientRelease(topGradient);
	CGContextRestoreGState(context);
	
	//STEP 4.
	CGContextSaveGState(context);
	CGContextSetLineWidth(context, 1.0f);
	CGFloat bottomGradientColors[] = 
	{
		0.0f, 0.0f, 0.0f, 0.0f,
		0.0f, 0.0f, 0.0f, 0.05f,
		0.0f, 0.0f, 0.0f, 0.10,
		0.0f, 0.0f, 0.0f, 0.15
	};
	CGRect bottomRect = CGRectMake(CGRectGetMinX(rClient), CGRectGetMidY(rClient), rClient.size.width, rClient.size.height / 2.0f);
	CGGradientRef bottomGradient = CGGradientCreateWithColorComponents(colorSpace, bottomGradientColors, NULL, sizeof(bottomGradientColors) / (4 * sizeof(CGFloat)));
	buildPathForRect(context, bottomRect, radius, FS_DRAW_REGION_RIGHT_BOTTOM_RADIUS | FS_DRAW_REGION_LEFT_BOTTOM_RADIUS);
	CGContextClip(context);
	drawLightForPath(context, bottomRect, FS_LIGHT_FROM_TOP_TO_BOTTOM, bottomGradient, 0.0f, 0.0f);
	CGGradientRelease(bottomGradient);
	CGContextRestoreGState(context);
	
	//STEP 5.
	rect.origin.x += 0.5;
	rect.origin.y += 0.5;
	rect.size.width -= 1;
	rect.size.height -= 1;
	CGContextSaveGState(context);
	buildPathForRect(context, rect, radius, (FS_DRAW_REGION_LEFT_TOP_RADIUS | FS_DRAW_REGION_RIGHT_TOP_RADIUS | FS_DRAW_REGION_RIGHT_BOTTOM_RADIUS | FS_DRAW_REGION_LEFT_BOTTOM_RADIUS));
	colors[0] += RGB_ADDTION * 1.2;
	colors[1] += RGB_ADDTION * 1.2;
	colors[2] += RGB_ADDTION * 1.2;
	if (colors[0] > 1) {
		colors[0] = 1.0f;
	}
	if (colors[1] > 1) {
		colors[1] = 1.0f;
	}
	if (colors[2] > 1) {
		colors[2] = 1.0f;
	}
	
	//CGContextSetRGBStrokeColor(context, 125.0f / 255.0f, 125.0f / 255.0f, 125.0f / 255.0f, 1.0f);
	CGContextSetRGBStrokeColor(context, colors[0], colors[1], colors[2], 1.0f);
	CGContextSetLineWidth(context, 1);
	CGContextDrawPath(context, kCGPathStroke);
	CGContextRestoreGState(context);
	
	//STEP 6.
	CGContextSaveGState(context);
//	rect.origin.x += 1;
//	rect.origin.y += 1;
//	rect.size.width -= 2;
//	rect.size.height -= 2;
//	radius--;
	colors[0] -= RGB_ADDTION * 1.5f;
	colors[1] -= RGB_ADDTION * 1.5f;
	colors[2] -= RGB_ADDTION * 1.5f;
	if (colors[0] < 0) {
		colors[0] = 0.0f;
	}
	if (colors[1] < 0) {
		colors[1] = 0.0f;
	}
	if (colors[2] < 0) {
		colors[2] = 0.0f;
	}
	buildPathForRect(context, rClient, radius, (FS_DRAW_REGION_LEFT_TOP_RADIUS | FS_DRAW_REGION_RIGHT_TOP_RADIUS | FS_DRAW_REGION_RIGHT_BOTTOM_RADIUS | FS_DRAW_REGION_LEFT_BOTTOM_RADIUS));
	//CGContextSetRGBStrokeColor(context, 229.0f / 255.0f, 229.0f / 255.0f, 229.0f / 255.0f, 1.0f);
	CGContextSetRGBStrokeColor(context, colors[0], colors[1], colors[2], 1.0f);
	CGContextSetLineWidth(context, 1.0);
	CGContextDrawPath(context, kCGPathStroke);
	CGContextRestoreGState(context);
	
	//STEP 7.
	CGColorSpaceRelease(colorSpace);
	
}

UIImage *createImageWithRect(CGRect rect, CGFloat radius, const CGFloat *components, NSUInteger componentCount) {
	UIImage *result = nil;
	//STEP 1.
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(NULL, rect.size.width, rect.size.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Little);
	CGContextTranslateCTM (context, 0, rect.size.height);
	CGContextScaleCTM(context, 1.0, -1.0);
	
	//STEP 2.
	drawCrystalRect(context, CGRectMake(0.0f, 0.0f, rect.size.width, rect.size.height), radius, components, componentCount);
	
	//STEP 3.
	CGImageRef image = CGBitmapContextCreateImage(context);
	result = [UIImage imageWithCGImage:image];
	CGImageRelease(image);
	
	CGContextRelease(context);
	CGColorSpaceRelease(colorSpace);
	
	//STEP 4.
	return result;
}

/////////////////////////////////////////
//	绘制导航箭头
////////////////////////////////////////
void drawNavigatorArrow(CGContextRef context, CGRect rect, NSUInteger arrowDirection, const CGFloat *components, NSUInteger componentCount) {
	CGFloat colors[4] = {0};
	if (componentCount >= 4) {
		colors[0] = components[0];
		colors[1] = components[1];
		colors[2] = components[2];
		colors[3] = components[3];
	} else if (componentCount == 2) {
		colors[0] = components[0];
		colors[1] = components[0];
		colors[2] = components[0];
		colors[3] = components[1];
	} else {
		colors[0] = 239.0f / 255.0f;
		colors[1] = 239.0f / 255.0f;
		colors[2] = 239.0f / 255.0f;
		colors[3] = 1.0f;
	}

	
	//STEP 1.
	CGContextSaveGState(context);
	CGContextSetRGBStrokeColor(context, 1.0f, 1.0f, 1.0f, 0.0f);
	CGContextSetRGBFillColor(context, 1.0f, 1.0f, 1.0f, 0.0f);
	CGContextSetLineWidth(context, 0.0f);
	buildPathForRect(context, rect, 0.0f, FS_DRAW_REGION_RECT);
	CGContextDrawPath(context, kCGPathFillStroke);
	CGContextRestoreGState(context);
	
	//STEP 2.
	CGContextSaveGState(context);
	if (arrowDirection == FS_ARROW_UP) {
		CGContextMoveToPoint(context, CGRectGetMidX(rect), CGRectGetMinY(rect));
		CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMidY(rect));
		CGContextAddLineToPoint(context, rect.size.width * 2 / 3.0f + CGRectGetMinX(rect), CGRectGetMidY(rect));
		CGContextAddLineToPoint(context, rect.size.width * 2 / 3.0f + CGRectGetMinX(rect), CGRectGetMaxY(rect));
		CGContextAddLineToPoint(context, rect.size.width / 3.0f + CGRectGetMinX(rect), CGRectGetMaxY(rect));
		CGContextAddLineToPoint(context, rect.size.width / 3.0f + CGRectGetMinX(rect), CGRectGetMidY(rect));
		CGContextAddLineToPoint(context, CGRectGetMinX(rect), CGRectGetMidY(rect));
		CGContextClosePath(context);
	} else if (arrowDirection == FS_ARROW_DOWN) {
		CGContextMoveToPoint(context, CGRectGetMidX(rect), CGRectGetMaxY(rect));
		CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMidY(rect));
		CGContextAddLineToPoint(context, rect.size.width * 2 / 3.0f + CGRectGetMinX(rect), CGRectGetMidY(rect));
		CGContextAddLineToPoint(context, rect.size.width * 2 / 3.0f + CGRectGetMinX(rect), CGRectGetMinY(rect));
		CGContextAddLineToPoint(context, rect.size.width / 3.0f + CGRectGetMinX(rect), CGRectGetMinY(rect));
		CGContextAddLineToPoint(context, rect.size.width / 3.0f + CGRectGetMinX(rect), CGRectGetMidY(rect));
		CGContextAddLineToPoint(context, CGRectGetMinX(rect), CGRectGetMidY(rect));
		CGContextClosePath(context);
	} else if (arrowDirection == FS_ARROW_LEFT) {
		CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMidY(rect));
		CGContextAddLineToPoint(context, CGRectGetMidX(rect), CGRectGetMinY(rect));
		CGContextAddLineToPoint(context, CGRectGetMidX(rect), rect.size.height / 3.0f + CGRectGetMinY(rect));
		CGContextAddLineToPoint(context, CGRectGetMaxX(rect), rect.size.height / 3.0f + CGRectGetMinY(rect));
		CGContextAddLineToPoint(context, CGRectGetMaxX(rect), rect.size.height * 2.0 / 3.0f + CGRectGetMinY(rect));
		CGContextAddLineToPoint(context, CGRectGetMidX(rect), rect.size.height * 2.0 / 3.0f + CGRectGetMinY(rect));
		CGContextAddLineToPoint(context, CGRectGetMidX(rect), CGRectGetMaxY(rect));
		CGContextClosePath(context);
	} else if (arrowDirection == FS_ARROW_RIGHT) {
		CGContextMoveToPoint(context, CGRectGetMaxX(rect), CGRectGetMidY(rect));
		CGContextAddLineToPoint(context, CGRectGetMidX(rect), CGRectGetMaxY(rect));
		CGContextAddLineToPoint(context, CGRectGetMidX(rect), rect.size.height * 2.0 / 3.0f + CGRectGetMinY(rect));
		CGContextAddLineToPoint(context, CGRectGetMinX(rect), rect.size.height * 2.0 / 3.0f + CGRectGetMinY(rect));
		CGContextAddLineToPoint(context, CGRectGetMinX(rect), rect.size.height / 3.0f + CGRectGetMinY(rect));
		CGContextAddLineToPoint(context, CGRectGetMidX(rect), rect.size.height / 3.0f + CGRectGetMinY(rect));
		CGContextAddLineToPoint(context, CGRectGetMidX(rect), CGRectGetMinY(rect));
		CGContextClosePath(context);
	} else {
		CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMidY(rect));
		CGContextAddLineToPoint(context, CGRectGetMidX(rect), CGRectGetMinY(rect));
		CGContextAddLineToPoint(context, CGRectGetMidX(rect), rect.size.height / 3.0f + CGRectGetMinY(rect));
		CGContextAddLineToPoint(context, CGRectGetMaxX(rect), rect.size.height / 3.0f + CGRectGetMinY(rect));
		CGContextAddLineToPoint(context, CGRectGetMaxX(rect), rect.size.height * 2.0 / 3.0f + CGRectGetMinY(rect));
		CGContextAddLineToPoint(context, CGRectGetMidX(rect), rect.size.height * 2.0 / 3.0f + CGRectGetMinY(rect));
		CGContextAddLineToPoint(context, CGRectGetMidX(rect), CGRectGetMaxY(rect));
		CGContextClosePath(context);
	}
	CGContextSetRGBFillColor(context, colors[0], colors[1], colors[2], colors[3]);
	CGContextSetRGBStrokeColor(context, colors[0], colors[1], colors[2], colors[3]);
	CGContextSetLineWidth(context, 1.0f);
	CGContextDrawPath(context, kCGPathFillStroke);
	CGContextRestoreGState(context);
}

UIImage *createNavigatorArrowWithRect(CGRect rect, NSUInteger arrowDirection, CGFloat boundSpace, const CGFloat *components, NSUInteger componentCount) {
	UIImage *result = nil;
	//STEP 1.
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(NULL, rect.size.width, rect.size.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Little);
	CGContextTranslateCTM (context, 0, rect.size.height);
	CGContextScaleCTM(context, 1.0, -1.0);
	
	//STEP 2.
	CGRect rArrow = CGRectMake(boundSpace + CGRectGetMinX(rect), boundSpace + CGRectGetMinY(rect), rect.size.width - boundSpace * 2.0f, rect.size.height - boundSpace * 2.0f);
	drawNavigatorArrow(context, rArrow, arrowDirection, components, componentCount);
	
	//STEP 3.
	CGImageRef image = CGBitmapContextCreateImage(context);
	result = [UIImage imageWithCGImage:image];
	CGImageRelease(image);
	
	CGContextRelease(context);
	CGColorSpaceRelease(colorSpace);
	
	//STEP 4.
	return result;
}

UIImage *scaleImage(UIImage *source, CGSize destSize) {
	CGFloat destW = destSize.width;
	CGFloat destH = destSize.height;
	
	CGImageRef imageRef = source.CGImage;
	
	CGBitmapInfo bitmapInfo = kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast;//CGImageGetBitmapInfo(imageRef);
	CGColorSpaceRef colorSpaceInfo = CGImageGetColorSpace(imageRef);
	
	CGContextRef bitmap = NULL;
	
	size_t bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
	size_t bytesPerRow = 0;// CGImageGetBytesPerRow(imageRef);
#ifdef G_MYDEBUG
	NSLog(@"bitsPerComponent=%d;bytesPerRow=%d", bitsPerComponent, bytesPerRow);
#endif
	
	if (source.imageOrientation == UIImageOrientationUp || source.imageOrientation == UIImageOrientationDown) {
		bitmap = CGBitmapContextCreate(NULL, destW, destH, bitsPerComponent, bytesPerRow, colorSpaceInfo, bitmapInfo);
	} else {
		bitmap = CGBitmapContextCreate(NULL, destH, destW, bitsPerComponent, bytesPerRow, colorSpaceInfo, bitmapInfo);
	}
	
	if (source.imageOrientation == UIImageOrientationLeft) {
		CGContextRotateCTM (bitmap, M_PI / 2.0f);
		CGContextTranslateCTM (bitmap, 0, - destW);
	} else if (source.imageOrientation == UIImageOrientationRight) {
		CGContextRotateCTM (bitmap, - M_PI / 2.0f);
		CGContextTranslateCTM (bitmap, - destW, 0);
	} else if (source.imageOrientation == UIImageOrientationUp) {
		// NOTHING
	} else if (source.imageOrientation == UIImageOrientationDown) {
		CGContextTranslateCTM (bitmap, destW, destH);
		CGContextRotateCTM (bitmap, - M_PI);
	}
	
	//CGContextScaleCTM(bitmap, destW / source.size.width, destH / source.size.height);
	CGContextDrawImage(bitmap, CGRectMake(0, 0, destW, destH), imageRef);
	
	CGImageRef ref = CGBitmapContextCreateImage(bitmap);
	UIImage *result = [UIImage imageWithCGImage:ref];
	CGContextRelease(bitmap);
	CGImageRelease(ref);
	
	return result;
}

void drawImageWithRect(CGContextRef context, CGRect rect, UIImage *image) {
	NSInteger colCount = rect.size.width / image.size.width + 1;
	NSInteger rowCount = rect.size.height / image.size.height + 1;
	
	CGFloat left = CGRectGetMinX(rect);
	CGFloat top = CGRectGetMinY(rect);
	for (int i = 0; i < rowCount; i++) {
		for (int j = 0; j < colCount; j++) {
			CGRect rImage = CGRectMake(left, top, image.size.width, image.size.height);
			CGContextDrawImage(context, rImage, image.CGImage);
			left += rImage.size.width;
		}
		top += image.size.height;
		left = CGRectGetMinX(rect);
		//top += 100;
	}
}

/////////////////////////////////////////////////////////////////////
//	卷曲的图像
//	color:颜色值
//	rect:矩形
//	radius:蜷曲半径
//	offset:横轴偏移、纵轴偏移
//	flag:暂时未用，默认左侧
/////////////////////////////////////////////////////////////////////
UIImage *curlImage(CGColorRef color, CGRect rect, CGFloat radius, CGSize offset, NSUInteger flag) {
	UIImage *image = nil;
	CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
	
	CGContextRef context = CGBitmapContextCreate(NULL, 
												 rect.size.width, 
												 rect.size.height, 
												 8,
												 0,
												 rgb, 
												 (kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Little));
	
	//STEP 1.
	CGRect rClient = rect;
	rClient.origin.x += 1.0f;
	rClient.origin.y += offset.height; //PEOPLEDAILY_EDITION_DESC_TOP_BOTTOM_SPACE;
	rClient.size.width -= (offset.width + 1.0f);
	rClient.size.height -= offset.height * 3.0f;
	
	CGFloat fillColors[4] = {198.0f / 255.0f, 30.0f / 255.0f, 29.0f / 255.0f, 0.95f};
	CGFloat strokeColors[4] = {231.0f / 255.0f, 63.0f / 255.0f, 63.0f / 255.0f, 1.0f};
	
	if (CGColorGetNumberOfComponents(color) == 4) {
		const CGFloat *components = CGColorGetComponents(color);
		fillColors[0] = components[0];
		fillColors[1] = components[1];
		fillColors[2] = components[2];
		fillColors[3] = components[3];
		
	} else if (CGColorGetNumberOfComponents(color) == 2) {
		const CGFloat *components = CGColorGetComponents(color);
		fillColors[0] = components[0];
		fillColors[1] = components[0];
		fillColors[2] = components[0];
		fillColors[3] = components[1];
	}
	
	strokeColors[0] = MIN(fillColors[0] + 33.0f / 255.0f, 1.0f);
	strokeColors[1] = MIN(fillColors[1] + 33.0f / 255.0f, 1.0f);
	strokeColors[2] = MIN(fillColors[2] + 33.0f / 255.0f, 1.0f);
	strokeColors[3] = 1.0f;
	
	
	CGContextSaveGState(context);
	CGContextMoveToPoint(context, CGRectGetMaxX(rClient), CGRectGetMaxY(rClient));
	CGContextAddLineToPoint(context, CGRectGetMidX(rClient), CGRectGetMaxY(rClient));
	CGContextAddArcToPoint(context, CGRectGetMinX(rClient), CGRectGetMaxY(rClient), CGRectGetMinX(rClient), CGRectGetMaxY(rClient) + offset.height, offset.height);
	CGContextAddLineToPoint(context, CGRectGetMinX(rClient), CGRectGetMidY(rClient));
	CGContextAddArcToPoint(context, CGRectGetMinX(rClient), CGRectGetMinY(rClient), CGRectGetMidX(rClient), CGRectGetMinY(rClient), offset.height);
	CGContextAddLineToPoint(context, CGRectGetMaxX(rClient), CGRectGetMinY(rClient));
	CGContextClosePath(context);
	CGContextSetRGBFillColor(context, fillColors[0], fillColors[1], fillColors[2], fillColors[3]);
	CGContextSetRGBStrokeColor(context, strokeColors[0], strokeColors[1], strokeColors[2], strokeColors[3]);
	CGContextSetLineWidth(context, 0.5);
	CGContextSetShadowWithColor(context, CGSizeMake(0.0f, -0.1f), 18.0f, [UIColor colorWithRed:10.0f / 255.0f green:10.0f / 255.0f blue:10.0f / 255.0f alpha:0.55].CGColor);
	CGContextDrawPath(context, kCGPathFillStroke);
	CGContextRestoreGState(context);
	
	//STEP 2.底部
	CGContextSaveGState(context);
	CGContextMoveToPoint(context, CGRectGetMinX(rClient), CGRectGetMinY(rClient));
	CGContextAddLineToPoint(context, CGRectGetMinX(rClient), CGRectGetMaxY(rClient));
	CGContextAddLineToPoint(context, CGRectGetMaxX(rClient), CGRectGetMaxY(rClient));
	CGContextAddLineToPoint(context, CGRectGetMaxX(rClient), CGRectGetMinY(rClient));
	CGContextClosePath(context);
	CGContextClip(context);
	
	CGFloat bottomColors[] =
	{
		//0.0f, 0.0f, 0.0f, 0.8f,
		//0.0f, 0.0f, 0.0f, 0.6f,
		0.0f, 0.0f, 0.0f, 0.1f,
		0.0f, 0.0f, 0.0f, 0.0f,
		1.0f, 1.0f, 1.0f, 0.05f,
		0.0f, 0.0f, 0.0f, 0.0f,
		0.0f, 0.0f, 0.0f, 0.1f
	};
	CGGradientRef bottomGradient = CGGradientCreateWithColorComponents(rgb, bottomColors, NULL, sizeof(bottomColors) / (4 * sizeof(CGFloat)));
	CGContextDrawLinearGradient(context, 
								bottomGradient, 
								CGPointMake(CGRectGetMidX(rClient), CGRectGetMinY(rClient)), 
								CGPointMake(CGRectGetMidX(rClient), CGRectGetMaxY(rClient)), 
								0);
	CGGradientRelease(bottomGradient);
	CGContextRestoreGState(context);
	
	//STEP 4.右部
	CGContextSaveGState(context);
	CGContextMoveToPoint(context, CGRectGetMaxX(rClient), CGRectGetMaxY(rClient));
	CGContextAddLineToPoint(context, CGRectGetMaxX(rClient), CGRectGetMinY(rClient));
	CGContextAddLineToPoint(context, CGRectGetMaxX(rClient) - 45.0f, CGRectGetMinY(rClient));
	CGContextAddLineToPoint(context, CGRectGetMaxX(rClient) - 45.0f, CGRectGetMaxY(rClient));
	CGContextClosePath(context);
	CGContextClip(context);
	
	CGFloat rightColors[] =
	{
		0.0f, 0.0f, 0.0f, 0.2f,
		0.0f, 0.0f, 0.0f, 0.1f,
		0.0f, 0.0f, 0.0f, 0.0f
	};
	CGGradientRef rightGradient = CGGradientCreateWithColorComponents(rgb, rightColors, NULL, sizeof(rightColors) / (4 * sizeof(CGFloat)));
	CGContextDrawLinearGradient(context, 
								rightGradient, 
								CGPointMake(CGRectGetMaxX(rClient), CGRectGetMidY(rClient)), 
								CGPointMake(CGRectGetMaxX(rClient) - 45.0f, CGRectGetMidY(rClient)), 
								0);
	CGGradientRelease(rightGradient);
	CGContextRestoreGState(context);
	
	//STEP 5.左部
	CGContextSaveGState(context);
	CGContextMoveToPoint(context, CGRectGetMaxX(rClient), CGRectGetMaxY(rClient));
	CGContextAddLineToPoint(context, CGRectGetMidX(rClient), CGRectGetMaxY(rClient));
	CGContextAddArcToPoint(context, CGRectGetMinX(rClient), CGRectGetMaxY(rClient), CGRectGetMinX(rClient), CGRectGetMaxY(rect), offset.height);
	CGContextAddLineToPoint(context, CGRectGetMinX(rClient), CGRectGetMidY(rClient));
	CGContextAddArcToPoint(context, CGRectGetMinX(rClient), CGRectGetMinY(rClient), CGRectGetMidX(rClient), CGRectGetMinY(rClient), offset.height);
	CGContextAddLineToPoint(context, CGRectGetMaxX(rClient), CGRectGetMinY(rClient));
	CGContextClosePath(context);
	CGContextClip(context);
	
	CGFloat leftColors[] =
	{
		0.0f, 0.0f, 0.0f, 0.4f,
		0.0f, 0.0f, 0.0f, 0.2f,
		0.0f, 0.0f, 0.0f, 0.0f,
		1.0f, 1.0f, 1.0f, 0.05f,
	};
	CGGradientRef leftGradient = CGGradientCreateWithColorComponents(rgb, leftColors, NULL, sizeof(leftColors) / (4 * sizeof(CGFloat)));
	CGContextDrawLinearGradient(context, 
								leftGradient, 
								CGPointMake(CGRectGetMinX(rClient), CGRectGetMidY(rect)), 
								CGPointMake(CGRectGetMinX(rClient) + offset.height * 1.2, CGRectGetMidY(rect)), 
								0);
	CGGradientRelease(leftGradient);
	CGContextRestoreGState(context);
	
	//STEP 6.
	CGFloat spaceEdge = 1.5f;
	CGContextSaveGState(context);
	CGContextMoveToPoint(context, CGRectGetMinX(rClient) + offset.height - spaceEdge, CGRectGetMaxY(rClient));
	CGContextAddArcToPoint(context, CGRectGetMinX(rClient), CGRectGetMaxY(rClient), CGRectGetMinX(rClient), CGRectGetMaxY(rClient) + offset.height, offset.height);
	CGContextAddLineToPoint(context, CGRectGetMinX(rClient), CGRectGetMaxY(rClient) + offset.height);
	CGContextAddArcToPoint(context, 
						   CGRectGetMinX(rClient), 
						   CGRectGetMaxY(rClient) + offset.height * 2.0f, 
						   CGRectGetMinX(rClient) + offset.height - spaceEdge,  
						   CGRectGetMaxY(rClient) + offset.height * 2.0f, 
						   offset.height);
	CGContextAddLineToPoint(context, CGRectGetMinX(rClient) + offset.height - spaceEdge, CGRectGetMaxY(rClient) + offset.height * 2.0f);
	CGContextClosePath(context);
	CGContextSetRGBFillColor(context, fillColors[0], fillColors[1], fillColors[2], fillColors[3]);
	CGContextSetRGBStrokeColor(context, strokeColors[0], strokeColors[1], strokeColors[2], strokeColors[3]);
	CGContextSetLineWidth(context, 0.0f);
	CGContextDrawPath(context, kCGPathFillStroke);
	CGContextRestoreGState(context);
	
	//STEP 7.
	CGContextSaveGState(context);
	CGContextMoveToPoint(context, CGRectGetMinX(rClient) + offset.height - spaceEdge, CGRectGetMaxY(rClient));
	CGContextAddArcToPoint(context, CGRectGetMinX(rClient), CGRectGetMaxY(rClient), CGRectGetMinX(rClient), CGRectGetMaxY(rClient) + offset.height, offset.height);
	CGContextAddLineToPoint(context, CGRectGetMinX(rClient), CGRectGetMaxY(rClient) + offset.height);
	CGContextAddArcToPoint(context, 
						   CGRectGetMinX(rClient), 
						   CGRectGetMaxY(rClient) + offset.height * 2.0f, 
						   CGRectGetMinX(rClient) + offset.height - spaceEdge,  
						   CGRectGetMaxY(rClient) + offset.height * 2.0f, 
						   offset.height);
	CGContextAddLineToPoint(context, CGRectGetMinX(rClient) + offset.height - spaceEdge, CGRectGetMaxY(rClient) + offset.height * 2.0f);
	CGContextClosePath(context);
	CGContextClip(context);
	CGFloat topArcColors[] =
	{
		0.0f, 0.0f, 0.0f, 0.8f,
		0.0f, 0.0f, 0.0f, 0.5f,
		0.0f, 0.0f, 0.0f, 0.2f,
	};
	CGGradientRef topArcGradient = CGGradientCreateWithColorComponents(rgb, topArcColors, NULL, sizeof(topArcColors) / (4 * sizeof(CGFloat)));
	CGContextDrawLinearGradient(context, 
								topArcGradient, 
								CGPointMake(CGRectGetMinX(rClient), CGRectGetMidY(rect)), 
								CGPointMake(CGRectGetMinX(rClient) + offset.height, CGRectGetMidY(rect)), 
								0);
	CGGradientRelease(topArcGradient);
	
	CGContextRestoreGState(context);
	
	//STEP 8.构建图像
	
	CGImageRef imageRef = CGBitmapContextCreateImage(context);
	image = [UIImage imageWithCGImage:imageRef];
	CGImageRelease(imageRef);
	
	CGContextRelease(context);
	CGColorSpaceRelease(rgb);
	
	return image;
}

UIImage *rectangleFrameImage(CGColorRef color, CGRect rect, CGFloat edge, CGFloat shadowOffset, NSUInteger flag) {
	UIImage *image = nil;
	
	CGFloat fillColors[4] = {229.0f / 255.0f, 229.0f / 255.0f, 229.0f / 255.0f, 1.0f};
	CGFloat strokeColors[4] = {229.0f / 255.0f, 229.0f / 255.0f, 229.0f / 255.0f, 1.0f};
	
	if (CGColorGetNumberOfComponents(color) == 4) {
		const CGFloat *components = CGColorGetComponents(color);
		fillColors[0] = components[0];
		fillColors[1] = components[1];
		fillColors[2] = components[2];
		fillColors[3] = components[3];
		
	} else if (CGColorGetNumberOfComponents(color) == 2) {
		const CGFloat *components = CGColorGetComponents(color);
		fillColors[0] = components[0];
		fillColors[1] = components[0];
		fillColors[2] = components[0];
		fillColors[3] = components[1];
	}
	strokeColors[0] = fillColors[0];
	strokeColors[1] = fillColors[1];
	strokeColors[2] = fillColors[2];
	strokeColors[3] = fillColors[3];
	
	CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(NULL, 
												 rect.size.width, 
												 rect.size.height, 
												 8,
												 0,
												 rgb, 
												 (kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Little));
	
	//STEP 1.填充背景色
	CGContextSaveGState(context);
	buildPathForRect(context, rect, 0.0f, FS_DRAW_REGION_RECT);
	CGContextClosePath(context);
	CGContextSetRGBFillColor(context, fillColors[0], fillColors[1], fillColors[2], fillColors[3]);
	CGContextSetRGBStrokeColor(context, strokeColors[0], strokeColors[1], strokeColors[2], strokeColors[3]);
	CGContextDrawPath(context, kCGPathFillStroke);
	CGContextRestoreGState(context);
	
	//STEP 1.1设置矩形
	rect.origin.x += edge;
	rect.origin.y += edge;
	rect.size.width -= edge * 2.0f;
	rect.size.height -= edge * 2.0f;
	
	//STEP 2.顶部
	CGContextSaveGState(context);
	CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));
	CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
	CGContextAddLineToPoint(context, CGRectGetMaxX(rect) - shadowOffset, CGRectGetMaxY(rect) - shadowOffset);
	CGContextAddLineToPoint(context, CGRectGetMinX(rect) + shadowOffset, CGRectGetMaxY(rect) - shadowOffset);
	CGContextClosePath(context);
	CGContextClip(context);
	CGFloat topColors[] = 
	{
		75.0f / 255.0f, 75.0f / 255.0f, 75.0f / 255.0f, 0.0f,
		//75.0f / 255.0f, 75.0f / 255.0f, 75.0f / 255.0f, 0.2f,
		75.0f / 255.0f, 75.0f / 255.0f, 75.0f / 255.0f, 0.6f,
		75.0f / 255.0f, 75.0f / 255.0f, 75.0f / 255.0f, 0.8f,
	};
	CGGradientRef topGradient = CGGradientCreateWithColorComponents(rgb, topColors, NULL, sizeof(topColors) / (4 * sizeof(CGFloat)));
	CGContextDrawLinearGradient(context, 
								topGradient, 
								CGPointMake(CGRectGetMidX(rect), 
											CGRectGetMaxY(rect)), 
								CGPointMake(CGRectGetMidX(rect), 
											CGRectGetMaxY(rect) - shadowOffset * 2.0f), 
								0);
	CGGradientRelease(topGradient);
	CGContextRestoreGState(context);
	
	
	//STEP 3.右部
	CGContextSaveGState(context);
	CGContextMoveToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
	CGContextAddLineToPoint(context, CGRectGetMaxX(rect) - shadowOffset, CGRectGetMaxY(rect) - shadowOffset);
	CGContextAddLineToPoint(context, CGRectGetMaxX(rect) - shadowOffset, CGRectGetMinY(rect) + shadowOffset);
	CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect));
	CGContextClosePath(context);
	CGContextClip(context);
	CGFloat rightColors[] = 
	{
		45.0f / 255.0f, 45.0f / 255.0f, 45.0f / 255.0f, 0.0f,
		//45.0f / 255.0f, 45.0f / 255.0f, 45.0f / 255.0f, 0.2f,
		45.0f / 255.0f, 45.0f / 255.0f, 45.0f / 255.0f, 0.6f,
		45.0f / 255.0f, 45.0f / 255.0f, 45.0f / 255.0f, 0.8f,
	};
	CGGradientRef rightGradient = CGGradientCreateWithColorComponents(rgb, rightColors, NULL, sizeof(rightColors) / (4 * sizeof(CGFloat)));
	CGContextDrawLinearGradient(context, 
								rightGradient, 
								CGPointMake(CGRectGetMaxX(rect), 
											CGRectGetMidY(rect)), 
								CGPointMake(CGRectGetMaxX(rect) - shadowOffset * 2.0f, 
											CGRectGetMidY(rect)), 
								0);
	CGGradientRelease(rightGradient);
	CGContextRestoreGState(context);
	
	//STEP 4.底部
	CGContextSaveGState(context);
	CGContextMoveToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect));
	CGContextAddLineToPoint(context, CGRectGetMaxX(rect) - shadowOffset, CGRectGetMinY(rect) + shadowOffset);
	CGContextAddLineToPoint(context, CGRectGetMinX(rect) + shadowOffset, CGRectGetMinY(rect) + shadowOffset);
	CGContextAddLineToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
	CGContextClosePath(context);
	CGContextClip(context);
	CGFloat bottomColors[] = 
	{
		135.0f / 255.0f, 135.0f / 255.0f, 135.0f / 255.0f, 0.0f,
		//135.0f / 255.0f, 135.0f / 255.0f, 135.0f / 255.0f, 0.2f,
		135.0f / 255.0f, 135.0f / 255.0f, 135.0f / 255.0f, 0.6f,
		175.0f / 255.0f, 135.0f / 255.0f, 135.0f / 255.0f, 0.8f,
	};
	CGGradientRef bottomGradient = CGGradientCreateWithColorComponents(rgb, bottomColors, NULL, sizeof(bottomColors) / (4 * sizeof(CGFloat)));
	CGContextDrawLinearGradient(context, 
								bottomGradient, 
								CGPointMake(CGRectGetMidX(rect), 
											CGRectGetMinY(rect)), 
								CGPointMake(CGRectGetMidX(rect), 
											CGRectGetMinY(rect) + shadowOffset), 
								0);
	CGGradientRelease(bottomGradient);
	CGContextRestoreGState(context);
	
	
	//STEP 5.左边
	CGContextSaveGState(context);
	CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
	CGContextAddLineToPoint(context, CGRectGetMinX(rect) + shadowOffset, CGRectGetMinY(rect) + shadowOffset);
	CGContextAddLineToPoint(context, CGRectGetMinX(rect) + shadowOffset, CGRectGetMaxY(rect) - shadowOffset);
	CGContextAddLineToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));
	CGContextClosePath(context);
	CGContextClip(context);
	CGFloat leftColors[] = 
	{
		195.0f / 255.0f, 195.0f / 255.0f, 195.0f / 255.0f, 0.0f,
		195.0f / 255.0f, 195.0f / 255.0f, 195.0f / 255.0f, 0.2f,
		195.0f / 255.0f, 195.0f / 255.0f, 195.0f / 255.0f, 0.4f,
		195.0f / 255.0f, 195.0f / 255.0f, 195.0f / 255.0f, 0.8f,
	};
	CGGradientRef leftGradient = CGGradientCreateWithColorComponents(rgb, leftColors, NULL, sizeof(leftColors) / (4 * sizeof(CGFloat)));
	CGContextDrawLinearGradient(context, 
								leftGradient, 
								CGPointMake(CGRectGetMinX(rect), 
											CGRectGetMidY(rect)), 
								CGPointMake(CGRectGetMinX(rect) + shadowOffset, 
											CGRectGetMidY(rect)), 
								0);
	CGGradientRelease(leftGradient);
	CGContextRestoreGState(context);
	
	//STEP 6.构建图像
	
	CGImageRef imageRef = CGBitmapContextCreateImage(context);
	image = [UIImage imageWithCGImage:imageRef];
	CGImageRelease(imageRef);
	
	CGContextRelease(context);
	CGColorSpaceRelease(rgb);
	
	return image;
}

void drawVerticalGrid(CGContextRef context, CGRect rect, CGFloat lineWidth, const CGFloat *oddComponents, NSInteger oddComponentCount, const CGFloat *evenComponents, NSInteger evenComponentCount) {
	
	CGFloat oddColors[4] = {1.0f, 1.0f, 1.0f, 1.0f};
	CGFloat evenColors[4] = {0.0f, 0.0f, 0.0f, 1.0f};
	if (oddComponentCount == 4) {
		oddColors[0] = oddComponents[0];
		oddColors[1] = oddComponents[1];
		oddColors[2] = oddComponents[2];
		oddColors[3] = oddComponents[3];
	} else if (oddComponentCount == 2) {
		oddColors[0] = oddComponents[0];
		oddColors[1] = oddComponents[0];
		oddColors[2] = oddComponents[0];
		oddColors[3] = oddComponents[1];
	}
	
	if (evenComponentCount == 4) {
		evenColors[0] = evenComponents[0];
		evenColors[1] = evenComponents[1];
		evenColors[2] = evenComponents[2];
		evenColors[3] = evenComponents[3];
	} else if (evenComponentCount == 2) {
		evenColors[0] = evenComponents[0];
		evenColors[1] = evenComponents[0];
		evenColors[2] = evenComponents[0];
		evenColors[3] = evenComponents[1];
	}
	
	if (lineWidth <= 0.0f) {
		lineWidth = 1.0f;
	}
	
	NSInteger maxWith = (int)rect.size.width + 1;
	NSInteger startX = (int)CGRectGetMinX(rect);
	
	for (int i = startX; i < maxWith / lineWidth; i++) {
		CGContextSaveGState(context);
		
		CGContextMoveToPoint(context, i * lineWidth, CGRectGetMinY(rect));
		CGContextAddLineToPoint(context, i * lineWidth, CGRectGetMaxY(rect));
		if (i % 2 == 0) {
			CGContextSetRGBStrokeColor(context, evenColors[0], evenColors[1], evenColors[2], evenColors[3]);
		} else {
			CGContextSetRGBStrokeColor(context, oddColors[0], oddColors[1], oddColors[2], oddColors[3]);
		}
		CGContextSetLineWidth(context, lineWidth);
		CGContextDrawPath(context, kCGPathStroke);
		
		CGContextRestoreGState(context);
	}
}

UIImage *drawBackgroundImageWithRoundRect(CGRect rect, CGFloat edgeWidth, CGFloat radius, CGColorRef fillColor, CGColorRef borderColor) {
	UIImage *image = nil;
	
	CGFloat fillComponents[4] = {45.0f / 255.0f, 45.0f / 255.0f, 45.0f / 255.0f, 0.75};
	CGFloat borderComponents[4] = {45.0f / 255.0f, 45.0f / 255.0f, 45.0f / 255.0f, 0.75};
	
	const CGFloat *fill_Components = CGColorGetComponents(fillColor);
	int fillNumberOfComponents = CGColorGetNumberOfComponents(fillColor);
	if (fillNumberOfComponents == 4) {
		fillComponents[0] = fill_Components[0];
		fillComponents[1] = fill_Components[1];
		fillComponents[2] = fill_Components[2];
		fillComponents[3] = fill_Components[3];
	} else if (fillNumberOfComponents == 2) {
		fillComponents[0] = fill_Components[0];
		fillComponents[1] = fill_Components[0];
		fillComponents[2] = fill_Components[0];
		fillComponents[3] = fill_Components[1];
	}
	
	const CGFloat *border_Components = CGColorGetComponents(borderColor);
	int borderNumberOfComponents = CGColorGetNumberOfComponents(borderColor);
	if (borderNumberOfComponents == 4) {
		borderComponents[0] = border_Components[0];
		borderComponents[1] = border_Components[1];
		borderComponents[2] = border_Components[2];
		borderComponents[3] = border_Components[3];
	} else if (borderNumberOfComponents == 2) {
		borderComponents[0] = border_Components[0];
		borderComponents[1] = border_Components[0];
		borderComponents[2] = border_Components[0];
		borderComponents[3] = border_Components[1];
	}
	
	rect.origin.x = 0;
	rect.origin.y = 0;
	CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(NULL, 
												 rect.size.width, 
												 rect.size.height, 
												 8,
												 0,
												 rgb, 
												 (kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Little));
	
	CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));
	CGContextScaleCTM(context, 1.0f, -1.0f);
	
	CGRect rClient = rect;
	rClient.origin.x += edgeWidth;
	rClient.origin.y += edgeWidth;
	rClient.size.width -= (edgeWidth * 2.0f);
	rClient.size.height -= (edgeWidth * 2.0f);
	CGContextSaveGState(context);
	CGContextSetRGBFillColor(context, fillComponents[0], fillComponents[1], fillComponents[2], fillComponents[3]);
	CGContextSetRGBStrokeColor(context, borderComponents[0], borderComponents[1], borderComponents[2], borderComponents[3]);
	buildPathForRect(context, rClient, radius, FS_DRAW_REGION_ROUND_RECT);
	CGContextClosePath(context);
	CGContextSetShadowWithColor(context, CGSizeZero, 8, [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4].CGColor);
	CGContextDrawPath(context, kCGPathFillStroke);
	CGContextRestoreGState(context);
	
	CGContextSaveGState(context);
	CGContextSetRGBFillColor(context, fillComponents[0], fillComponents[1], fillComponents[2], fillComponents[3]);
	CGContextSetRGBStrokeColor(context, borderComponents[0], borderComponents[1], borderComponents[2], borderComponents[3]);
	buildPathForRect(context, rClient, radius, FS_DRAW_REGION_ROUND_RECT);
	CGContextClosePath(context);
	CGContextDrawPath(context, kCGPathFillStroke);
	CGContextRestoreGState(context);
	
	CGImageRef imageRef = CGBitmapContextCreateImage(context);
	image = [UIImage imageWithCGImage:imageRef];
	CGImageRelease(imageRef);
	
	CGContextRelease(context);
	CGColorSpaceRelease(rgb);
	
	return image;
}

UIImage *cuttingImageWithSourceImage(UIImage *image, CGRect destRect, CGFloat radius, CGColorRef borderColor, CGFloat borderWidth, NSUInteger flag, CGPoint offset) {
	UIImage *result = nil;
	if (image == nil || image.size.width <= 0.0f || image.size.height <= 0.0f) {
		return result;
	}
	
	const CGFloat *components = CGColorGetComponents(borderColor);
	int numberOfComponents = CGColorGetNumberOfComponents(borderColor);
	
	CGFloat colors[4] = {0.5294f, 0.5294f, 0.5294f, 1.0f};
	if (numberOfComponents == 4) {
		colors[0] = components[0];
		colors[1] = components[1];
		colors[2] = components[2];
		colors[3] = components[3];
	} else if (numberOfComponents == 2) {
		colors[0] = components[0];
		colors[1] = components[0];
		colors[2] = components[0];
		colors[3] = components[1];
	}
	
	CGRect rImage = CGRectMake(0.0f, 0.0f, image.size.width, image.size.height);
	if (flag == FS_CUTTING_IMAGE_SCALE) {
        
			rImage.size.width = destRect.size.width;
			rImage.size.height = destRect.size.width * image.size.height / image.size.width;
		
		if (rImage.size.height > destRect.size.height) {
			rImage.size.height = destRect.size.height;
			rImage.size.width = destRect.size.height * image.size.width / image.size.height;
		}
		
		destRect = rImage;
	} else if (flag == FS_CUTTING_IMAGE_STRENTCH) {
		rImage = CGRectMake(0.0f, 0.0f, destRect.size.width, destRect.size.height);
	} else if (flag == FS_CUTTING_IMAGE_CENTER) {
		rImage = CGRectMake((destRect.size.width - image.size.width) / 2.0f, 
							(destRect.size.height - image.size.height) / 2.0f, 
							image.size.width, 
							image.size.height);
	} else if (flag == FS_CUTTING_IMAGE_LEFT_TOP) {
		rImage = CGRectMake(0.0f, 
							destRect.size.height - image.size.height, 
							image.size.width, 
							image.size.height);
	} else if (flag == FS_CUTTING_IMAGE_RIGHT_TOP) {
		rImage = CGRectMake(destRect.size.width - image.size.width, 
							destRect.size.height - image.size.height, 
							image.size.width, 
							image.size.height);
	} else if (flag == FS_CUTTING_IMAGE_LEFT_BOTTOM) {
		rImage = CGRectMake(0.0f, 
							0.0f, 
							image.size.width, 
							image.size.height);
	} else if (flag == FS_CUTTING_IMAGE_RIGHT_BOTTOM) {
		rImage = CGRectMake(destRect.size.width - image.size.width, 
							0.0f, 
							image.size.width, 
							image.size.height);
	} else if (flag == FS_CUTTING_IMAGE_OFFSET) {
		rImage = CGRectMake(offset.x, 
							offset.y, 
							image.size.width, 
							image.size.height);
	} else if (flag == FS_CUTTING_IMAGE_FIXRECT) {
		rImage = CGRectMake(0.0f,
							0.0f,
							destRect.size.width,
							destRect.size.height);
	} else if (flag == FS_CUTTING_IMAGE_FIXHEIGHT) {
        
        
        
		rImage = CGRectMake(0.0f,
							image.size.width*destRect.size.height/destRect.size.width - image.size.height,
							image.size.width,
							image.size.height);
	}
	
	destRect.origin.x = 0;
	destRect.origin.y = 0;
	CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(NULL, 
												 destRect.size.width, 
												 destRect.size.height, 
												 8,
												 0,
												 rgb, 
												 (kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Little));
	
	
	CGContextSaveGState(context);
	buildPathForRect(context, destRect, radius, FS_DRAW_REGION_ROUND_RECT);
	CGContextClosePath(context);
	CGContextClip(context);
	CGContextDrawImage(context, rImage, image.CGImage);
	CGContextRestoreGState(context);
	
	CGContextSaveGState(context);
	CGRect rClient = destRect;
	rClient.origin.x += (borderWidth / 2.0f);
	rClient.origin.y += (borderWidth / 2.0f);
	rClient.size.width -= borderWidth;
	rClient.size.height -= borderWidth;
	buildPathForRect(context, rClient, radius - borderWidth / 2.0f, FS_DRAW_REGION_ROUND_RECT);
	CGContextClosePath(context);
	CGContextSetLineWidth(context, borderWidth);
	CGContextSetRGBStrokeColor(context, colors[0], colors[1], colors[2], colors[3]);
	CGContextDrawPath(context, kCGPathStroke);
	CGContextRestoreGState(context);
	
	CGImageRef imageRef = CGBitmapContextCreateImage(context);
	result = [UIImage imageWithCGImage:imageRef];
	CGImageRelease(imageRef);
	
	CGContextRelease(context);
	CGColorSpaceRelease(rgb);
	
	return result;
}

UIImage *clipImageToRoundRect(UIImage *image, CGFloat radius) {
    UIImage *result = image;
    
    CGRect rect = CGRectMake(0.0f, 0.0f, image.size.width, image.size.height);
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(NULL,
												 rect.size.width,
												 rect.size.height,
												 8,
												 0,
												 rgb,
												 (kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Little));
    
    CGContextSaveGState(context);
    buildPathForRect(context, rect, radius, FS_DRAW_REGION_ROUND_RECT);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, rect, image.CGImage);
    CGContextRestoreGState(context);
    
    
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
	result = [UIImage imageWithCGImage:imageRef];
	CGImageRelease(imageRef);
    
    CGColorSpaceRelease(rgb);
    CGContextRelease(context);
    
    return result;
}
