//
//  FSDeepEndView.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-8.
//
//

#import "FSDeepEndView.h"
#import "FSCommonFunction.h"
#import "FSGraphicsEx.h"
#import "FSHTTPWebExData.h"

#define FSDEEP_END_LEFT_RIGHT_SPACE 12.0f
#define FSDEEP_END_TOP_BOTTOM_SPACE 24.0f
#define FSDEEP_END_ROW_SPACE 24.0f

#define FSDEEP_END_PERSION_IMAGE_WIDTH 64.0f
#define FSDEEP_END_PERSION_IMAGE_HEIGHT 40.0f

@interface FSDeepEndView()
- (void)inner_Layout;
@end

@implementation FSDeepEndView
@synthesize deepEndObject = _deepEndObject;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        _backBGRTOP = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"deep_endTOP.png"]];
        _backBGRM = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"deep_endM.png"]];
        _backBGRB = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"deep_endBOTTOM.png"]];
        
        
        _backBGRTOP.frame = CGRectMake(0, 0, 0, 0);
        _backBGRM.frame = CGRectMake(0, 0, 0, 0);
        _backBGRB.frame = CGRectMake(0, 0, 0, 0);
        
        
//        [self addSubview:_backBGRM];
//        [self addSubview:_backBGRTOP];
//        [self addSubview:_backBGRB];
        
    
        
        
        _titleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Deep_EndTitle.png"]];
        _textBeginImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"open_mark.png"]];
        _textEndImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"end_mark.png"]];
        
        
        _titleImage.frame = CGRectMake(0, 0, 0, 0);
        _textBeginImage.frame = CGRectMake(0, 0, 0, 0);
        _textEndImage.frame = CGRectMake(0, 0, 0, 0);
        [self addSubview:_titleImage];
        [self addSubview:_textBeginImage];
        [self addSubview:_textEndImage];
        
        
        _endContentLayer = [[CALayer alloc] init];
        _endContentLayer.shadowColor = [UIColor grayColor].CGColor;
        _endContentLayer.shadowOffset = CGSizeZero;
        _endContentLayer.shadowOpacity = 0.85;
        _endContentLayer.backgroundColor = [UIColor grayColor].CGColor;
        _endContentLayer.borderColor = [UIColor darkGrayColor].CGColor;
        _endContentLayer.cornerRadius = 6.0f;
        _endContentLayer.borderWidth = 2.0f;
        CGFloat borderSpace = FSDEEP_END_LEFT_RIGHT_SPACE / 2.0f;
        _endContentLayer.frame = CGRectMake(FSDEEP_END_LEFT_RIGHT_SPACE - borderSpace,
                                            FSDEEP_END_TOP_BOTTOM_SPACE + FSDEEP_END_PERSION_IMAGE_HEIGHT / 2.0f,
                                            self.frame.size.width - FSDEEP_END_LEFT_RIGHT_SPACE,
                                            self.frame.size.height - FSDEEP_END_TOP_BOTTOM_SPACE * 2.0f - FSDEEP_END_PERSION_IMAGE_HEIGHT / 2.0f);
        //[self.layer addSublayer:_endContentLayer];
        
//        _persionLayer = [[CALayer alloc] init];
//        _persionLayer.shadowColor = [UIColor grayColor].CGColor;
//        _persionLayer.shadowOffset = CGSizeZero;
//        _persionLayer.shadowOpacity = 0.85;
//        _persionLayer.backgroundColor = [UIColor grayColor].CGColor;
//        _persionLayer.borderColor = [UIColor darkGrayColor].CGColor;
//        _persionLayer.cornerRadius = FSDEEP_END_PERSION_IMAGE_HEIGHT / 2.0f;
//        _persionLayer.borderWidth = 2.0f;
//        _persionLayer.frame = CGRectMake((self.frame.size.width - FSDEEP_END_PERSION_IMAGE_WIDTH) / 2.0f,
//                                         FSDEEP_END_TOP_BOTTOM_SPACE,
//                                         FSDEEP_END_PERSION_IMAGE_WIDTH,
//                                         FSDEEP_END_PERSION_IMAGE_HEIGHT);
//        [self.layer addSublayer:_persionLayer];
        
        
        
        _ivPersion = [[UIImageView alloc] initWithFrame:CGRectZero];
        //[self addSubview:_ivPersion];
        
        _textBGR = [[UIImageView alloc] initWithFrame:CGRectZero];
        _textBGR.image = [UIImage imageNamed:@"deep_end_textBGR.png"];
        //[self addSubview:_textBGR];
        
        _lblEndContent = [[UILabel alloc] initWithFrame:CGRectZero];
        [_lblEndContent setBackgroundColor:[UIColor clearColor]];
        [_lblEndContent setFont:[UIFont boldSystemFontOfSize:16.0f]];
        [_lblEndContent setNumberOfLines:99];
        
        _lblEndTitle = [[UILabel alloc] initWithFrame:CGRectZero];
        [_lblEndTitle setBackgroundColor:[UIColor clearColor]];
        [_lblEndTitle setFont:[UIFont boldSystemFontOfSize:20.0f]];
        _lblEndTitle.textAlignment = UITextAlignmentCenter;
        _lblEndTitle.textColor = [UIColor whiteColor];
        
        
        [self addSubview:_lblEndContent];
        
        [self addSubview:_lblEndTitle];
        
    }
    return self;
}

- (void)dealloc {
//    [_persionLayer release];
    [_lblEndContent release];
    [_ivPersion release];
    [_endContentLayer release];
    [_deepEndObject release];
    [_backBGRTOP release];
    [_backBGRM release];
    [_backBGRB release];
    [super dealloc];
}

- (void)setFrame:(CGRect)value {
    BOOL needLayout = CGSizeEqualToSize(self.frame.size, value.size);
    [super setFrame:value];
    if (needLayout) {
        
        [self inner_Layout];
    }
}

- (void)setDeepEndObject:(FSDeepEndObject *)value {
    if (value != _deepEndObject) {
        [_deepEndObject release];
        _deepEndObject = [value retain];
        
        NSString *picPath = getFileNameWithURLString(_deepEndObject.picture, getCachesPath());
        if ([[NSFileManager defaultManager] fileExistsAtPath:picPath]) {
            UIImage *image = [[UIImage alloc] initWithContentsOfFile:picPath];
            //_ivPersion.image = clipImageToRoundRect(image, MIN(image.size.width / 2.0f, image.size.height / 2.0f));
            _ivPersion.image = image;
            [image release];
            
        } else {
            [FSHTTPWebExData HTTPGetDataWithURLString:_deepEndObject.picture
                                      blockCompletion:^(NSData *data, BOOL success) {
                                          if (success) {
                                              UIImage *image = [[UIImage alloc] initWithData:data];
                                              //UIImage *fileImage = clipImageToRoundRect(image, MIN(image.size.width / 2.0f, image.size.height / 2.0f));
                                              _ivPersion.image = image;
                                              [image release];
                                              [self inner_Layout];
                                              FSLog(@"picPath:%@", picPath);
                                              dispatch_queue_t queue = dispatch_queue_create(NULL, NULL);
                                              dispatch_async(queue, ^{
                                                  //NSData *fileData = UIImagePNGRepresentation(fileImage);
                                                  NSData *fileData = UIImagePNGRepresentation(image);
                                                  [fileData writeToFile:picPath atomically:YES];
                                              });
                                              dispatch_release(queue);
                                              
                                              
                                          }
                                      }];
        }
        [self inner_Layout];
    }
}

- (void)inner_Layout {
    //STEP 3.
    CGFloat borderSpace = FSDEEP_END_LEFT_RIGHT_SPACE / 2.0f;
    _endContentLayer.frame = CGRectMake(FSDEEP_END_LEFT_RIGHT_SPACE - borderSpace,
                                        FSDEEP_END_TOP_BOTTOM_SPACE + FSDEEP_END_PERSION_IMAGE_HEIGHT / 2.0f,
                                        self.frame.size.width - FSDEEP_END_LEFT_RIGHT_SPACE,
                                        self.frame.size.height - FSDEEP_END_TOP_BOTTOM_SPACE * 2.0f - FSDEEP_END_PERSION_IMAGE_HEIGHT / 2.0f);
    
    if (!_deepEndObject) {
        return;
    }
    
    _lblEndContent.text = _deepEndObject.endContent;
    _lblEndTitle.text = @"结束语";
    
    CGFloat top = FSDEEP_END_TOP_BOTTOM_SPACE;
    CGFloat clientWidth = self.frame.size.width - FSDEEP_END_LEFT_RIGHT_SPACE * 2.0f;
    //CGSize sizeTmp = CGSizeZero;
    //STEP 1.
    if (_ivPersion.image) {
        //sizeTmp = scalImageSizeInSize(_ivPersion.image, CGSizeMake(FSDEEP_END_PERSION_IMAGE_WIDTH, FSDEEP_END_PERSION_IMAGE_HEIGHT));
        _ivPersion.frame = CGRectMake(56.0f,
                                      30.0f,
                                      FSDEEP_END_PERSION_IMAGE_WIDTH,
                                      FSDEEP_END_PERSION_IMAGE_HEIGHT);
        [_ivPersion setNeedsDisplay];
        [_ivPersion layer].transform = CATransform3DMakeRotation(-0.25, 0.0f, 0.0f, 1.0f);
    } else {
        _ivPersion.frame = CGRectMake(56.0f,
                                      30.0f,
                                      FSDEEP_END_PERSION_IMAGE_WIDTH,
                                      FSDEEP_END_PERSION_IMAGE_HEIGHT);
        [_ivPersion setNeedsDisplay];
        [_ivPersion layer].transform = CATransform3DMakeRotation(-0.25, 0.0f, 0.0f, 1.0f);
    }
    
//    _persionLayer.frame = CGRectMake((self.frame.size.width - FSDEEP_END_PERSION_IMAGE_WIDTH) / 2.0f,
//                                     top,
//                                     FSDEEP_END_PERSION_IMAGE_WIDTH,
//                                     FSDEEP_END_PERSION_IMAGE_HEIGHT);
    
    top += (FSDEEP_END_PERSION_IMAGE_HEIGHT + FSDEEP_END_ROW_SPACE);
    
    //STEP 2.
//    CGSize sizeContent = [_lblEndContent.text sizeWithFont:_lblEndContent.font
//                                         constrainedToSize:CGSizeMake(clientWidth, 8192)
//                                             lineBreakMode:_lblEndContent.lineBreakMode];
   
    _textBGR.frame = CGRectMake(36,
                                76,
                                self.frame.size.width-68,
                                self.frame.size.height-164);
    
    _backBGRM.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
    _backBGRTOP.frame = CGRectMake(0.0f, -35.0f, _backBGRTOP.image.size.width, _backBGRTOP.image.size.height);
    _backBGRB.frame = CGRectMake(0.0f, self.frame.size.height- _backBGRTOP.image.size.height+35, _backBGRTOP.image.size.width, _backBGRTOP.image.size.height);
    
  /////////////////////////////////////////////////////
    top = 4.0f;
    _titleImage.frame = CGRectMake(0.0f, top, _titleImage.image.size.width, _titleImage.image.size.height);
    _lblEndTitle.frame = CGRectMake(4.0f, top-2, 80, _textBeginImage.image.size.height);
    top = top + _titleImage.image.size.height+4.0f;
    _textBeginImage.frame = CGRectMake(4.0f, top, _textBeginImage.image.size.width, _textBeginImage.image.size.height);
    
    top = top + _textBeginImage.image.size.height;
    
    
    clientWidth = self.frame.size.width - 20 * 2.0f;
    
    CGSize sizeContent = [_lblEndContent.text sizeWithFont:_lblEndContent.font
                                         constrainedToSize:CGSizeMake(clientWidth, 8192)
                                             lineBreakMode:_lblEndContent.lineBreakMode];
    
    _lblEndContent.frame = CGRectMake(20,
                                      top,
                                      clientWidth,
                                      sizeContent.height);
    
    top = top + sizeContent.height;
    
    _textEndImage.frame = CGRectMake(self.frame.size.width - _textEndImage.image.size.width-4, top, _textEndImage.image.size.width, _textEndImage.image.size.height);
    
}

@end
