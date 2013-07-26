//
//  FSAsyncImageView.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-13.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSAsyncImageView.h"
#import <dispatch/dispatch.h>
#import "FSNetworkDataManager.h"
#import "FSGraphicsEx.h"

//135.0f / 255.0f = 0.5294
#define FSASYNC_IMAGE_VIEW_DEFAULT__RED 0.5294f
#define FSASYNC_IMAGE_VIEW_DEFAULT__GREEN 0.5294f
#define FSASYNC_IMAGE_VIEW_DEFAULT__BLUE 0.5294f
#define FSASYNC_IMAGE_VIEW_DEFAULT__ALPHA 1.0f

@interface FSAsyncImageView(PrivateMethod)
- (UIImage *)inner_drawImageWithImage:(UIImage *)image withRect:(CGRect)rect;
- (CGRect)inner_computRectWithImage:(UIImage *)image withRect:(CGRect)rect;
@end


@implementation FSAsyncImageView
@synthesize imageView = _imageView;
@synthesize urlString = _urlString;
@synthesize localStoreFileName = _localStoreFileName;
@synthesize defaultFileName = _defaultFileName;
@synthesize imageID = _imageID;

@synthesize borderRadius = _borderRadius;
@synthesize borderColor = _borderColor;
@synthesize borderWidth = _borderWidth;

@synthesize imageSize = _imageSize;

@synthesize imageCuttingKind = _imageCuttingKind;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		
		self.borderRadius = 0.0f;
		
		self.borderColor = [UIColor colorWithRed:FSASYNC_IMAGE_VIEW_DEFAULT__RED 
										   green:FSASYNC_IMAGE_VIEW_DEFAULT__GREEN 
											blue:FSASYNC_IMAGE_VIEW_DEFAULT__BLUE 
										   alpha:FSASYNC_IMAGE_VIEW_DEFAULT__ALPHA];
		self.borderWidth = 1.0f;
		self.imageCuttingKind = ImageCuttingKind_None;
		
		_imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		[self addSubview:_imageView];
        self.defaultFileName = @"AsyncImage.png";
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginDownloading:) name:FSNETWORKDATA_MANAGER_BEGIN_DOWNLOADING_NOTIFICATION object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endDownloadingComplete:) name:FSNETWORKDATA_MANAGER_END_DOWNLOADING_COMPLETE_NOTIFICATION object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endDownloadingError:) name:FSNETWORKDATA_MANAGER_END_DOWNLOADING_ERROR_NOTIFICATION object:nil];
		
		[pool release];
    }
    return self;
}

- (void)dealloc {
//#ifdef MYDEBUG
//	NSLog(@"%@.dealloc", self);
//#endif
	[[NSNotificationCenter defaultCenter] removeObserver:self name:FSNETWORKDATA_MANAGER_END_DOWNLOADING_ERROR_NOTIFICATION object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:FSNETWORKDATA_MANAGER_END_DOWNLOADING_COMPLETE_NOTIFICATION object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:FSNETWORKDATA_MANAGER_BEGIN_DOWNLOADING_NOTIFICATION object:nil];
	
	[_urlString release];
	[_localStoreFileName release];
	[_defaultFileName release];
	[_imageID release];
	[_imageView release];
    [super dealloc];
}

- (void)updateAsyncImageView {
	dispatch_queue_t queue = dispatch_queue_create(NULL, NULL);
    NSString* localStoreFileName = _localStoreFileName;//by zhiliang  _localstorefilename 非线程安全
	dispatch_async(queue, ^(void) {
        
        NSData *data;
        
        if ([_urlString length]<5 || [_localStoreFileName length]<4) {
            data = nil;
        }
        else{
            data = [[FSNetworkDataManager shareNetworkDataManager] networkDataWithURLString:_urlString withLocalFilePath:localStoreFileName withDelegate:self];
        }
		if (data != nil) {
			dispatch_async(dispatch_get_main_queue(), ^(void) {
				UIImage *imageOri = [[UIImage alloc] initWithData:data];
				CGRect rect = [self inner_computRectWithImage:imageOri withRect:self.frame];
				UIImage *image = [self inner_drawImageWithImage:imageOri withRect:rect];
				_imageView.image = image;
                _imageSize = rect.size;
				_imageView.frame = rect;
				[imageOri release];
                self.backgroundColor = [UIColor clearColor];
                if ([_indicator isAnimating]) {
                    [_indicator stopAnimating];
                }
			});
			
		} else {
			dispatch_async(dispatch_get_main_queue(), ^(void) {
                NSLog(@"");
				UIImage *imageOri = [UIImage imageNamed:self.defaultFileName];
				CGRect rect;
                if (self.frame.size.width<imageOri.size.width || self.frame.size.height < imageOri.size.height) {
                    rect = CGRectMake(0,0, self.frame.size.width, self.frame.size.height);//[self inner_computRectWithImage:imageOri withRect:self.frame];
                }
                else{
                    rect = CGRectMake((self.frame.size.width - imageOri.size.width)/2, (self.frame.size.height - imageOri.size.height)/2, imageOri.size.width, imageOri.size.height);//[self inner_computRectWithImage:imageOri withRect:self.frame];
                }
                
				//UIImage *image = [self inner_drawImageWithImage:imageOri withRect:rect];
                
				_imageView.image = imageOri;
                _imageSize = rect.size;
				_imageView.frame = rect;
				
                if ([self.defaultFileName length]==0) {
                    self.backgroundColor = [UIColor clearColor];
                }
                else{
                    self.backgroundColor = [UIColor colorWithRed:178.0f green:178.0f blue:178.0f alpha:1.0f];
                }
                
                if (_indicator == nil) {
                    _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                    [self addSubview:_indicator];
                }
                [_indicator setCenter:CGPointMake(self.frame.size.width / 2.0f, self.frame.size.height / 2.0f)];
                //[_indicator startAnimating];
			});
			
		}

	});

	dispatch_release(queue);
}

#pragma mark -
#pragma mark PrivateMethod
- (UIImage *)inner_drawImageWithImage:(UIImage *)image withRect:(CGRect)rect {
	
	if (_imageCuttingKind == ImageCuttingKind_None) {
        rect.size.width = rect.size.width*2;
        rect.size.height = rect.size.height*2;
		return cuttingImageWithSourceImage(image, rect, self.borderRadius, self.borderColor.CGColor, self.borderWidth, FS_CUTTING_IMAGE_SCALE, CGPointZero);
	} else if (_imageCuttingKind == ImageCuttingKind_LeftTop) {
		return cuttingImageWithSourceImage(image, rect, self.borderRadius, self.borderColor.CGColor, self.borderWidth, FS_CUTTING_IMAGE_LEFT_TOP, CGPointZero);
	} else if (_imageCuttingKind == ImageCuttingKind_RightTop) {
		return cuttingImageWithSourceImage(image, rect, self.borderRadius, self.borderColor.CGColor, self.borderWidth, FS_CUTTING_IMAGE_RIGHT_TOP, CGPointZero);
	} else if (_imageCuttingKind == ImageCuttingKind_LeftBottom) {
		return cuttingImageWithSourceImage(image, rect, self.borderRadius, self.borderColor.CGColor, self.borderWidth, FS_CUTTING_IMAGE_LEFT_BOTTOM, CGPointZero);
	} else if (_imageCuttingKind == ImageCuttingKind_RightBottom) {
		return cuttingImageWithSourceImage(image, rect, self.borderRadius, self.borderColor.CGColor, self.borderWidth, FS_CUTTING_IMAGE_RIGHT_BOTTOM, CGPointZero);
	} else if (_imageCuttingKind == ImageCuttingKind_Center) {
		return cuttingImageWithSourceImage(image, rect, self.borderRadius, self.borderColor.CGColor, self.borderWidth, FS_CUTTING_IMAGE_CENTER, CGPointZero);
	} else if (_imageCuttingKind == ImageCuttingKind_fixrect) {
        rect.size.width = rect.size.width*2;
        rect.size.height = rect.size.height*2;
		return cuttingImageWithSourceImage(image, rect, self.borderRadius, self.borderColor.CGColor, self.borderWidth, FS_CUTTING_IMAGE_SCALE, CGPointZero);
	} else if (_imageCuttingKind == ImageCuttingKind_fixheight) {
		rect.size.width = rect.size.width*2;
        rect.size.height = rect.size.height*2;
        UIImage *image11 = cuttingImageWithSourceImage(image, rect, self.borderRadius, self.borderColor.CGColor, self.borderWidth, FS_CUTTING_IMAGE_FIXHEIGHT, CGPointZero);
        return image11;//cuttingImageWithSourceImage(image11, rect, self.borderRadius, self.borderColor.CGColor, self.borderWidth, FS_CUTTING_IMAGE_SCALE, CGPointZero);
	} else {
		return cuttingImageWithSourceImage(image, rect, self.borderRadius, self.borderColor.CGColor, self.borderWidth, FS_CUTTING_IMAGE_SCALE, CGPointZero);
	}
}

- (CGRect)inner_computRectWithImage:(UIImage *)image withRect:(CGRect)rect {
	CGRect result = CGRectZero;
	result.size = image.size;
	
    if (result.size.width ==0 || result.size.height == 0) {
        return rect;
    }
    
    
    if (_imageCuttingKind == ImageCuttingKind_fixrect) {
        result.size.width = rect.size.width;
        result.size.height = rect.size.height;
        return result;
    }
    
    if (_imageCuttingKind == ImageCuttingKind_fixheight) {
        
        result.size.width = rect.size.width;
        result.size.height = rect.size.width * image.size.height / image.size.width;
        return result;
    }
    
	if (image.size.width > rect.size.width && image.size.height > rect.size.height && _imageCuttingKind != ImageCuttingKind_None) {
		result.size  = rect.size;
	} else {
        result.size.width = rect.size.width;
        result.size.height = rect.size.width * image.size.height / image.size.width;
		
		if (result.size.height > rect.size.height) {
			result.size.height = rect.size.height;
			result.size.width = rect.size.height * image.size.width / image.size.height;
		}
		
		result.origin.x = (rect.size.width - result.size.width) / 2.0f;
		result.origin.y = (rect.size.height - result.size.height) / 2.0f;
	}
	
	return result;
}


#pragma mark -
#pragma mark Notification
- (void)beginDownloading:(NSNotification *)notification {

        //return; //避免在非主线程中处理UI ,  by zhiliang
  
	NSDictionary *userInfo = [notification userInfo];
	NSString *urlStr = [userInfo objectForKey:FSNETWORKDATA_MANAGER_URLSTRING_KEY];
	NSString *filePath = [userInfo objectForKey:FSNETWORKDATA_MANAGER_LOCALFILEPATH_KEY];
	if ([urlStr isEqualToString:self.urlString] && [filePath isEqualToString:self.localStoreFileName]) {
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue,^(){
                if (_indicator == nil) {
                    _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                    [self addSubview:_indicator];
                }
                [_indicator setCenter:CGPointMake(self.frame.size.width / 2.0f, self.frame.size.height / 2.0f)];
                if (![_indicator isAnimating]) {
                    [_indicator startAnimating];
                }
            });
	}
}

- (void)endDownloadingComplete:(NSNotification *)notification {
#ifdef MYDEBUG
    //NSLog(@"endDownloadingComplete");
#endif
	
	NSDictionary *userInfo = [notification userInfo];
	NSString *urlStr = [userInfo objectForKey:FSNETWORKDATA_MANAGER_URLSTRING_KEY];
	NSString *filePath = [userInfo objectForKey:FSNETWORKDATA_MANAGER_LOCALFILEPATH_KEY];
	if ([urlStr isEqualToString:self.urlString] && [filePath isEqualToString:self.localStoreFileName]) {
        BOOL isImage = NO;
		UIImage *imageOri = [[UIImage alloc] initWithContentsOfFile:self.localStoreFileName];
        
        if (imageOri != nil) {
            isImage = YES;
            CGRect rect = [self inner_computRectWithImage:imageOri withRect:self.frame];
            UIImage *image = [self inner_drawImageWithImage:imageOri withRect:rect];
            _imageView.image = image;
            _imageView.frame = rect;
            self.backgroundColor = [UIColor clearColor];
        }
        
		if ([_indicator isAnimating]) {
			[_indicator stopAnimating];
		}
		_imageView.alpha = 0.0f;
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
		[UIView setAnimationDuration:0.3];
		_imageView.alpha = 1.0f;
		[UIView commitAnimations];
		[imageOri release];
        
        if (!isImage) {
            NSError *error = nil;
            [[NSFileManager defaultManager] removeItemAtPath:self.localStoreFileName error:&error];
            FSLog(@"remove error image:%@", error);
        }
	}
}

- (void)endDownloadingError:(NSNotification *)notification {
	NSDictionary *userInfo = [notification userInfo];
	NSString *urlStr = [userInfo objectForKey:FSNETWORKDATA_MANAGER_URLSTRING_KEY];
	NSString *filePath = [userInfo objectForKey:FSNETWORKDATA_MANAGER_LOCALFILEPATH_KEY];
	if ([urlStr isEqualToString:self.urlString] && [filePath isEqualToString:self.localStoreFileName]) {
		if ([_indicator isAnimating]) {
			[_indicator stopAnimating];
		}
	}
}

@end
