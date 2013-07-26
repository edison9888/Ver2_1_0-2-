//
//  FSAsyncImageView.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-13.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "FSNetworkData.h"

typedef enum _ImageCuttingKind {
	ImageCuttingKind_None,
    ImageCuttingKind_fixrect,
    ImageCuttingKind_fixheight,
	ImageCuttingKind_Center,
	ImageCuttingKind_LeftTop,
	ImageCuttingKind_RightTop,
	ImageCuttingKind_LeftBottom,
	ImageCuttingKind_RightBottom
} ImageCuttingKind;

@interface FSAsyncImageView : UIView{
@private
	UIActivityIndicatorView *_indicator;
	UIImageView *_imageView;
	
	NSString *_urlString;
	NSString *_localStoreFileName;
	NSString *_defaultFileName;
    
    NSString *_imageID;
	
	CGFloat _borderRadius;
	UIColor *_borderColor;
	CGFloat _borderWidth;
    
    CGSize _imageSize;
	
	ImageCuttingKind _imageCuttingKind;
}

@property (nonatomic, retain) NSString *urlString;
@property (nonatomic, retain) NSString *localStoreFileName;
@property (nonatomic, retain) NSString *defaultFileName;
@property (nonatomic, retain, readonly) UIImageView *imageView;
@property (nonatomic, retain) NSString *imageID;
@property (nonatomic) ImageCuttingKind imageCuttingKind;

@property (nonatomic) CGFloat borderRadius;
@property (nonatomic, retain) UIColor *borderColor;
@property (nonatomic) CGFloat borderWidth;

@property (nonatomic,assign) CGSize imageSize;


- (void)updateAsyncImageView;

@end
