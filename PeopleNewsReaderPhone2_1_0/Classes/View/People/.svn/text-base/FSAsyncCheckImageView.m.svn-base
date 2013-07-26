//
//  FSAsyncCheckImageView.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-9-5.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSAsyncCheckImageView.h"
#import "FSNetworkDataManager.h"
#import "FSCommonFunction.h"

@implementation FSAsyncCheckImageView

@synthesize normalURLString = _normalURLString;
@synthesize heighlightURLString = _heighlightURLString;
@synthesize selectedURLString = _selectedURLString;
@synthesize channelID = _channelID;
//@synthesize imageCuttingkind = _imageCuttingKind;
@synthesize imageCheckType = _imageCheckType;

@synthesize layoutLocalImage = _layoutLocalImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		[self addSubview:_imageView];
        _layoutLocalImage = NO;
        _defaultFileName = @"AsyncImage.png";
        _firstImageCompelet = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginDownloading:) name:FSNETWORKDATA_MANAGER_BEGIN_DOWNLOADING_NOTIFICATION object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endDownloadingComplete:) name:FSNETWORKDATA_MANAGER_END_DOWNLOADING_COMPLETE_NOTIFICATION object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endDownloadingError:) name:FSNETWORKDATA_MANAGER_END_DOWNLOADING_ERROR_NOTIFICATION object:nil];

        
        [pool release];
    }
    return self;
}

-(void)dealloc{
    [_imageView release];
    [_normalURLString release];
    [_heighlightURLString release];
    [_selectedURLString release];
    [_channelID release];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:FSNETWORKDATA_MANAGER_END_DOWNLOADING_ERROR_NOTIFICATION object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:FSNETWORKDATA_MANAGER_END_DOWNLOADING_COMPLETE_NOTIFICATION object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:FSNETWORKDATA_MANAGER_BEGIN_DOWNLOADING_NOTIFICATION object:nil];

    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)updataCheckImageView{
    
    [self setFirstShowImageUrl];
    if (self.layoutLocalImage) {
        _imageView.image = [UIImage imageNamed:_urlString];
        _imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        return;
    }
    
    
    NSString *loaclFile = getFileNameWithURLString(_urlString, getCachesPath());
    if (![[NSFileManager defaultManager] fileExistsAtPath:loaclFile]) {
        
        UIImage *imageOri = [UIImage imageNamed:_defaultFileName];
        CGRect rect = CGRectMake((self.frame.size.width - imageOri.size.width)/2, (self.frame.size.height - imageOri.size.height)/2, imageOri.size.width, imageOri.size.height);//[self inner_computRectWithImage:imageOri withRect:self.frame];
        //UIImage *image = [self inner_drawImageWithImage:imageOri withRect:rect];
        if (rect.size.width > self.frame.size.width || rect.size.height > self.frame.size.height) {
           rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        }
        _imageView.image = imageOri;
        _imageView.frame = rect;
        
        if ([_urlString length]<4) {
            return;
        }
        
        _firstImageCompelet = NO;
       
        [[FSNetworkDataManager shareNetworkDataManager] networkDataWithURLString:_urlString withLocalFilePath:loaclFile withDelegate:self];
        
        if (_indicator == nil) {
            _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [self addSubview:_indicator];
        }
        [_indicator setCenter:CGPointMake(self.frame.size.width / 2.0f, self.frame.size.height / 2.0f)];
        if (![_indicator isAnimating]) {
            [_indicator startAnimating];
        }
    }
    else{
        _imageView.image = [UIImage imageWithContentsOfFile:loaclFile];
        _imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self downLoadAllImages];
    }
    
}

-(void)updataCheckImageViewWithLocal{
    [self setFirstShowImageUrl];
    _imageView.image = [UIImage imageNamed:_urlString];
    _imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

-(void)setFirstShowImageUrl{
    switch (_imageCheckType) {
        case ImageCheckType_normal:
            _urlString = _normalURLString;
            break;
            
        case ImageCheckType_highlight:
            _urlString = _heighlightURLString;
            break;
            
        case ImageCheckType_selected:
            _urlString = _selectedURLString;
            break;
            
        default:
            break;
    }
}



#pragma mark -
#pragma mark Notification
- (void)beginDownloading:(NSNotification *)notification {
    if (_firstImageCompelet) {
        return;
    }
    
    NSString *loaclFile = getFileNameWithURLString(_urlString, getCachesPath());
    
	NSDictionary *userInfo = [notification userInfo];
	NSString *urlStr = [userInfo objectForKey:FSNETWORKDATA_MANAGER_URLSTRING_KEY];
	NSString *filePath = [userInfo objectForKey:FSNETWORKDATA_MANAGER_LOCALFILEPATH_KEY];
    //NSLog(@"filePath:%@  urlStr:%@",filePath,urlStr);
    //NSLog(@"loaclFile:%@  _urlString:%@",loaclFile,_urlString);
	if ([urlStr isEqualToString:_urlString] && [filePath isEqualToString:loaclFile]) {
		if (_indicator == nil) {
			_indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
			[self addSubview:_indicator];
		}
		[_indicator setCenter:CGPointMake(self.frame.size.width / 2.0f, self.frame.size.height / 2.0f)];
		if (![_indicator isAnimating]) {
			[_indicator startAnimating];
		}
	}
}

- (void)endDownloadingComplete:(NSNotification *)notification {
#ifdef MYDEBUG
    //NSLog(@"endDownloadingComplete");
#endif
    
    if (_firstImageCompelet) {
        return;
    }
    
    NSString *loaclFile = getFileNameWithURLString(_urlString, getCachesPath());
    
	NSDictionary *userInfo = [notification userInfo];
	NSString *urlStr = [userInfo objectForKey:FSNETWORKDATA_MANAGER_URLSTRING_KEY];
	NSString *filePath = [userInfo objectForKey:FSNETWORKDATA_MANAGER_LOCALFILEPATH_KEY];
	if ([urlStr isEqualToString:_urlString] && [filePath isEqualToString:loaclFile]) {
        BOOL isImage = NO;
        
        //NSLog(@"endDownloadingComplete:%@",filePath);
        
		UIImage *imageOri = [[UIImage alloc] initWithContentsOfFile:loaclFile];
        
        if (imageOri != nil) {
            _imageView.image = imageOri;
            _imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
            [imageOri release];
            isImage = YES;
            _firstImageCompelet = YES;
        }
        if ([_indicator isAnimating]) {
            [_indicator stopAnimating];
        }
        if (!isImage) {
            NSError *error = nil;
            [[NSFileManager defaultManager] removeItemAtPath:loaclFile error:&error];
            FSLog(@"remove error image:%@", error);
        }
	}
}

- (void)endDownloadingError:(NSNotification *)notification {
    NSString *loaclFile = getFileNameWithURLString(_urlString, getCachesPath());
	NSDictionary *userInfo = [notification userInfo];
	NSString *urlStr = [userInfo objectForKey:FSNETWORKDATA_MANAGER_URLSTRING_KEY];
	NSString *filePath = [userInfo objectForKey:FSNETWORKDATA_MANAGER_LOCALFILEPATH_KEY];
	if ([urlStr isEqualToString:_urlString] && [filePath isEqualToString:loaclFile]) {
		if ([_indicator isAnimating]) {
			[_indicator stopAnimating];
		}
	}
}


//-(void)networkDataDownloadDataComplete:(FSNetworkData *)sender isError:(BOOL)isError data:(NSData *)data{
//   
//    if (data!=nil) {
//        [_indicator stopAnimating];
//        UIImage *imageOri = [[UIImage alloc] initWithData:data];
//        _imageView.image = imageOri;
//        _imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//        [imageOri release];
//    }
//    else{
//        [_indicator stopAnimating];
//        
//    }
//    return;
//	dispatch_queue_t queue = dispatch_queue_create(NULL, NULL);
//
//    dispatch_async(queue, ^(void) {
//        [self downLoadAllImages];
//	});
//	dispatch_release(queue);
//    
//}
//
-(void)downLoadAllImages{
    NSString *loaclFile = getFileNameWithURLString(_normalURLString, getCachesPath());
    if (![[NSFileManager defaultManager] fileExistsAtPath:loaclFile]&&[_normalURLString length]>5) {
        [[FSNetworkDataManager shareNetworkDataManager] networkDataWithURLString:_normalURLString withLocalFilePath:loaclFile withDelegate:nil];
    }
    
    loaclFile = getFileNameWithURLString(_heighlightURLString, getCachesPath());
    if (![[NSFileManager defaultManager] fileExistsAtPath:loaclFile]&&[_heighlightURLString length]>5) {
        
        [[FSNetworkDataManager shareNetworkDataManager] networkDataWithURLString:_heighlightURLString withLocalFilePath:loaclFile withDelegate:nil];

    }
    
    loaclFile = getFileNameWithURLString(_selectedURLString, getCachesPath());
    if (![[NSFileManager defaultManager] fileExistsAtPath:loaclFile]&&[_selectedURLString length]>5) {
        
        [[FSNetworkDataManager shareNetworkDataManager] networkDataWithURLString:_selectedURLString withLocalFilePath:loaclFile withDelegate:nil];

    }
}


@end
