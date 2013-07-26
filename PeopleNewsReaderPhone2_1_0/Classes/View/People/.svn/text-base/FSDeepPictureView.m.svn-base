//
//  FSDeepPictureView.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-7.
//
//

#import "FSDeepPictureView.h"
#import "FSHTTPWebExData.h"
#import "FSCommonFunction.h"
#import "FSConst.h"

#define FSDEEP_PICTURE_LEFT_RIGHT_SPACE 12.0f
#define FSDEEP_PICTURE_ROW_SPACE 6.0f
#define FSDEEP_PICTURE_TOP_BOTTOM_SAPCE 12.0f

#define DEEPPICTURE_IMAGESIZE @"320/295"
#define DEEPPICTURE_IMAGESIZE_OLD @"640/320"


@interface FSDeepPictureView()
- (void)inner_Layout;
@end

@implementation FSDeepPictureView
@synthesize deepPictureObject = _deepPictureObject;
@synthesize bottomControlHeight = _bottomControlHeight;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        
//        UIImageView *backBGR = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"deep_baground.png"]];
//        backBGR.frame = CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height);//CGRectMake(0, 0, backBGR.image.size.width, backBGR.image.size.height);
//        [self addSubview:backBGR];
//        [backBGR release];
        
        
        _svContainer = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, 295)];
        [_svContainer setShowsHorizontalScrollIndicator:NO];
        [_svContainer setShowsVerticalScrollIndicator:NO];
        [self addSubview:_svContainer];
        
        
        _ivPictureCover = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Deep_picBottom.png"]];
        
        //_ivPictureCover.backgroundColor = [UIColor redColor];
        
        
        _ivPicture = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, 295)];
        [_svContainer addSubview:_ivPicture];
        //[self addSubview:_ivPictureCover];
        
        
//        _ivPicture.layer.shadowColor = [UIColor darkGrayColor].CGColor;
//        _ivPicture.layer.shadowOffset = CGSizeMake(0, 3);
//        _ivPicture.layer.shadowOpacity = 0.6;
        
        _lblPicture = [[UILabel alloc] initWithFrame:CGRectZero];
        [_lblPicture setBackgroundColor:[UIColor clearColor]];
        [_lblPicture setTextColor:COLOR_DEEP_TEXT];
        [_lblPicture setFont:[UIFont systemFontOfSize:16.0f]];
        [_lblPicture setNumberOfLines:99];
        _lblPicture.textAlignment = UITextAlignmentLeft;
        [_svContainer addSubview:_lblPicture];
    }
    return self;
}

- (void)dealloc {
    [_svContainer release];
    [_ivPicture release];
    [_lblPicture release];
    [_deepPictureObject release];
    [_ivPictureCover release];
    [super dealloc];
}

- (void)setFrame:(CGRect)value {
    BOOL needLayout = CGSizeEqualToSize(self.frame.size, value.size);
    [super setFrame:value];
    if (needLayout) {
        [self inner_Layout];
    }
}

- (void)setDeepPictureObject:(FSDeepPictureObject *)value {
    if (value != _deepPictureObject) {
        [_deepPictureObject release];
        _deepPictureObject = [value retain];
        
        NSString *picURL = [_deepPictureObject.picture stringByReplacingOccurrencesOfString:DEEPPICTURE_IMAGESIZE_OLD withString:DEEPPICTURE_IMAGESIZE];
        //NSLog(@"picURL:%@",picURL);
        //NSLog(@"_deepPictureObject.picture:%@",_deepPictureObject.picture);
        
        NSString *picFile = getFileNameWithURLString(picURL, getCachesPath());
        if ([[NSFileManager defaultManager] fileExistsAtPath:picFile]) {
            UIImage *image = [[UIImage alloc] initWithContentsOfFile:picFile];
            _ivPicture.image = image;
            [image release];
        } else {
            [FSHTTPWebExData HTTPGetDataWithURLString:picURL blockCompletion:^(NSData *data, BOOL success) {
                if (success) {
                    BOOL isImage = NO;
                   
                    UIImage *image = [[UIImage alloc] initWithData:data];
                    _ivPicture.image = image;
                    isImage = (image != nil);
                    [image release];
                    [self inner_Layout];
                    
                    if (isImage) {
                        dispatch_queue_t queue = dispatch_queue_create(NULL, NULL);
                        dispatch_async(queue, ^{
                            [data writeToFile:picFile atomically:YES];
                        });
                        dispatch_release(queue);
                    }
                    
                }
            }];
        }
        
        [self inner_Layout];
    }
}

- (void)inner_Layout {
    _svContainer.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height-25);//CGRectMake(0.0f, 0.0f, self.frame.size.width, 295.0f);
    _svContainer.contentSize = CGSizeZero;
    
    _lblPicture.text = _deepPictureObject.pictureText;
    CGSize sizeTmp = CGSizeZero;
    CGSize sizePic = CGSizeZero;
    CGFloat clientWith = self.frame.size.width - FSDEEP_PICTURE_LEFT_RIGHT_SPACE * 2.0f;
    //STEP 1.
    sizeTmp = [_lblPicture.text sizeWithFont:_lblPicture.font
                           constrainedToSize:CGSizeMake(clientWith, 4096)
                               lineBreakMode:_lblPicture.lineBreakMode];
    

    _lblPicture.frame = CGRectMake(FSDEEP_PICTURE_LEFT_RIGHT_SPACE, 300, self.frame.size.width - FSDEEP_PICTURE_LEFT_RIGHT_SPACE * 2.0f, sizeTmp.height);

    //STEP 2.
    if (_ivPicture.image != nil) {
        sizePic = _ivPicture.image.size;
        if (_ivPicture.image.size.width > _svContainer.frame.size.width) {
            sizePic.width = _svContainer.frame.size.width;
            sizePic.height = sizeTmp.width * _ivPicture.image.size.height / _ivPicture.image.size.width;
        }
        
        if (sizePic.height > 300) {
            sizePic.height = 300;
            sizePic.width = sizeTmp.height * _ivPicture.image.size.width / _ivPicture.image.size.height;
        }


        _ivPicture.frame = CGRectMake((_svContainer.frame.size.width - sizePic.width) / 2.0f,
                                      0.0f,
                                      sizePic.width,
                                      sizePic.height);
        
        _ivPictureCover.frame = CGRectMake(_ivPicture.frame.origin.x, _ivPicture.frame.origin.y+_ivPicture.frame.size.height, _ivPicture.frame.size.width, _ivPictureCover.image.size.height);
        
    }
    
    _lblPicture.frame = CGRectMake(FSDEEP_PICTURE_LEFT_RIGHT_SPACE, sizePic.height+4, self.frame.size.width - FSDEEP_PICTURE_LEFT_RIGHT_SPACE * 2.0f, sizeTmp.height);
    _svContainer.contentSize = CGSizeMake(_svContainer.frame.size.width, sizePic.height+sizeTmp.height+10);
    
    
}

@end
