    //
//  FSPictureShowViewController.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-28.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSPictureShowViewController.h"

@interface FSPictureShowViewController(PrivateMethod)
- (void)initializePictureWithImage:(UIImage *)image;
@end


@implementation FSPictureShowViewController
@synthesize pictureURL = _pictureURL;
@synthesize pictureLocalFilePath = _pictureLocalFilePath;
@synthesize defaultPictureFilePath = _defaultPictureFilePath;

- (void)dealloc {
	[_pictureURL release];
	[_pictureLocalFilePath release];
	[_defaultPictureFilePath release];
	
	[_svContainer release];
	[_ivPicture release];
    [super dealloc];
}

- (void)loadChildView {
	_svContainer = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)];
	_svContainer.delegate = self;
	[self.view addSubview:_svContainer];
	
	_ivPicture = [[UIImageView alloc] initWithFrame:CGRectZero];
	[_svContainer addSubview:_ivPicture];
	
	NSData *data = [FSNetworkData networkDataWithURLString:self.pictureURL withLocalStoreFileName:self.pictureLocalFilePath withDelegate:self];
	if (data) {
		UIImage *image = [[UIImage alloc] initWithData:data];
		[self initializePictureWithImage:image];
		[image release];
	}
}

- (void)layoutChildControllerViewWithRect:(CGRect)rect {
}

#pragma mark -
#pragma mark UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return _ivPicture;
}

#pragma mark -
#pragma mark FSNetworkDataDelegate
- (void)networkDataDownloadDataComplete:(FSNetworkData *)sender isError:(BOOL)isError data:(NSData *)data {
	if (isError) {
		//显示下载图片失败
	} else {
		UIImage *image = [[UIImage alloc] initWithData:data];
		[self initializePictureWithImage:image];
		[image release];
	}
}

- (void)networkDataDownloading:(FSNetworkData *)sender maxLength:(long long)maxLength {
}

- (void)networkDataDownloadingProgressing:(FSNetworkData *)sender totalLength:(long long)totalLength {
}

#pragma mark -
#pragma mark PrivateMethod
- (void)initializePictureWithImage:(UIImage *)image {
	
}

@end
