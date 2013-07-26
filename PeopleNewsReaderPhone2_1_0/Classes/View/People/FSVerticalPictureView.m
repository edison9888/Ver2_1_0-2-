//
//  FSVerticalPictureView.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-7.
//
//

#import "FSVerticalPictureView.h"
#import "FSCommonFunction.h"
#import "FSHTTPWebExData.h"

@implementation FSVerticalPictureView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _ivPicture = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_ivPicture];
    }
    return self;
}

- (void)dealloc {
    [_ivPicture release];
    [super dealloc];
}

- (void)doSomethingWithContent:(NSString *)content {
    if (!content) {
        return;
    }
    
    NSString *picPath = getFileNameWithURLString(content, getCachesPath());
    if ([[NSFileManager defaultManager] fileExistsAtPath:picPath]) {
        UIImage *localImage = [[UIImage alloc] initWithContentsOfFile:picPath];
        _ivPicture.image = localImage;
        CGSize localSize = scalImageSizeFixWidth(localImage, self.fixWidth);
        _ivPicture.frame = CGRectMake((self.fixWidth - localSize.width) / 2.0f,
                                      0.0f,
                                      localSize.width,
                                      localSize.height);
        
        self.layoutSize = CGSizeMake(self.fixWidth, localSize.height);
        [localImage release];
    } else {
        [FSHTTPWebExData HTTPGetDataWithURLString:content
                                  blockCompletion:^(NSData *data, BOOL success) {
                                      if (success) {
                                          UIImage *netImage = [[UIImage alloc] initWithData:data];
                                          _ivPicture.image = netImage;
                                          CGSize netSize = scalImageSizeFixWidth(netImage, self.fixWidth);
                                          _ivPicture.frame = CGRectMake((self.fixWidth - netSize.width) / 2.0f,
                                                                        0.0f,
                                                                        netSize.width,
                                                                        netSize.height);
                                          self.layoutSize = CGSizeMake(self.fixWidth, netSize.height);
                                          [netImage release];
                                          [data writeToFile:picPath atomically:YES];
                                      }
                                  }];
    }
}

- (CGFloat)adjustmentHeightWithDistanceToBottom:(CGFloat)distance {
    CGRect rPic = _ivPicture.frame;
    rPic.size.height = 0.0f;
    _ivPicture.frame = rPic;
    return 0.0f;
}

@end
