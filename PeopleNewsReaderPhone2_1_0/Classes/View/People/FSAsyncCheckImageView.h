//
//  FSAsyncCheckImageView.h
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-9-5.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSNetworkData.h"
typedef enum _ImageCheckType{
    ImageCheckType_normal,
    ImageCheckType_highlight,
    ImageCheckType_selected,
} ImageCheckType;

@interface FSAsyncCheckImageView : UIView <FSNetworkDataDelegate>{
@protected
    UIActivityIndicatorView *_indicator;
	UIImageView *_imageView;
    
    NSString *_urlString;
    NSString *_normalURLString;
    NSString *_heighlightURLString;
    NSString *_selectedURLString;
    NSString *_channelID;
    NSString *_defaultFileName;
   // ImageCuttingKind _imageCuttingKind;
    ImageCheckType _imageCheckType;
    BOOL _layoutLocalImage;
    
    BOOL _firstImageCompelet;
}

@property (nonatomic,retain) NSString *normalURLString;
@property (nonatomic,retain) NSString *heighlightURLString;
@property (nonatomic,retain) NSString *selectedURLString;
@property (nonatomic,retain) NSString *channelID;
//@property (nonatomic,assign) ImageCuttingKind imageCuttingkind;
@property (nonatomic,assign) ImageCheckType imageCheckType;

@property (nonatomic,assign) BOOL layoutLocalImage;


-(void)updataCheckImageView;

-(void)updataCheckImageViewWithLocal;

-(void)setFirstShowImageUrl;
-(void)downLoadAllImages;

@end
