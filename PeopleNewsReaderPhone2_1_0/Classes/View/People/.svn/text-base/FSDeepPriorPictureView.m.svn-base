//
//  FSDeepPriorPictureView.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-9.
//
//

#import "FSDeepPriorPictureView.h"
#import "FSHTTPWebExData.h"
#import "FSCommonFunction.h"

@implementation FSDeepPriorPictureView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _ivPicture = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
        [self addSubview:_ivPicture];
    }
    return self;
}

- (void)dealloc {
    [_ivPicture release];
    [super dealloc];
}

- (void)setPictureURLString:(NSString *)value {
    dispatch_queue_t queue = dispatch_queue_create(NULL, NULL);
    dispatch_async(queue, ^{
        NSString *picPath = getFileNameWithURLString(value, getCachesPath());
        if ([[NSFileManager defaultManager] fileExistsAtPath:picPath]) {
            UIImage *image = [[UIImage alloc] initWithContentsOfFile:picPath];
            CGSize sizePic = scalImageSizeInSize(image, self.frame.size);
            dispatch_async(dispatch_get_main_queue(), ^{
                [image retain];
                _ivPicture.image = image;
                _ivPicture.frame = CGRectMake((self.frame.size.width - sizePic.width) / 2.0f,
                                              (self.frame.size.height - sizePic.height) / 2.0f,
                                              sizePic.width,
                                              sizePic.height);
                [image release];
            });

            [image release];
        } else {
            [FSHTTPWebExData HTTPGetDataWithURLString:value
                                      blockCompletion:^(NSData *data, BOOL success) {
                                          if (success) {
                                              UIImage *image = [[UIImage alloc] initWithData:data];
                                              
                                              CGSize sizePic = scalImageSizeInSize(image, self.frame.size);
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  [image retain];
                                                  _ivPicture.image = image;
                                                  _ivPicture.frame = CGRectMake((self.frame.size.width - sizePic.width) / 2.0f,
                                                                                (self.frame.size.height - sizePic.height) / 2.0f,
                                                                                sizePic.width,
                                                                                sizePic.height);
                                                  [image release];
                                              });
                                              [image release];
                                              
                                              dispatch_queue_t savequeue = dispatch_queue_create(NULL, NULL);
                                              dispatch_async(savequeue, ^{
                                                  [data writeToFile:picPath atomically:YES];
                                              });
                                              dispatch_release(savequeue);
                                          }
                                      }];
        }
    });
    dispatch_release(queue);

}

@end
