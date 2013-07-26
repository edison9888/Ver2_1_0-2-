//
//  FSDeepLeadView.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-30.
//
//

#import "FSDeepLeadView.h"
#import "FSHTTPWebExData.h"
#import "FSCommonFunction.h"
#import "FSConst.h"

#define FSDEEPLEAD_PIC_WIDTH 320.0f

#define FSDEEPLEAD_PIC_HEIGHT 240.0f

#define FSDEEPLEAD_LEFT_RIGHT_SPACE 16.0f

#define FSDEEPLEAD_ROW_SPACE 6.0f

#define FSDEEPLEAD_SHADOW_HEIGHT 76.0f

#define FSDEEPLEAD_LINE_HEIGHT 100.0f

#define DEEPLEAD_IMAGESIZE @"320/350"
#define DEEPLEAD_IMAGESIZE_OLD @"640/320"

@interface FSDeepLeadView()
- (void)inner_reLayout;
@end

@implementation FSDeepLeadView
@synthesize deepLeadObject = _deepLeadObject;
@synthesize defaultPicture = _defaultPicture;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = COLOR_NEWSLIST_TITLE_WHITE;
        _ivLeadPic = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
        [self addSubview:_ivLeadPic];
        
        _gradentView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
        _gradentView.image = [UIImage imageNamed:@"Deep_Leadmask.png"];
        _gradentView.backgroundColor = [UIColor clearColor];
        [self addSubview:_gradentView];
        
        
        
//        _deepTitleLayer = [[CAGradientLayer alloc] init];
//        _deepTitleLayer.frame = CGRectMake(0.0f, FSDEEPLEAD_PIC_HEIGHT - FSDEEPLEAD_SHADOW_HEIGHT, frame.size.width, FSDEEPLEAD_SHADOW_HEIGHT);
//        CGColorRef startColor = [UIColor colorWithRed:75.0f / 255.0f green:75.0f / 255.0f blue:75.0f / 255.0f alpha:1.0f].CGColor;
//        CGColorRef middleColor = [UIColor colorWithRed:75.0f / 255.0f green:75.0f / 255.0f blue:75.0f / 255.0f alpha:0.8f].CGColor;
//        CGColorRef endColor = [UIColor colorWithRed:75.0f / 255.0f green:75.0f / 255.0f blue:75.0f / 255.0f alpha:0.0f].CGColor;
//        NSArray *colors = [[NSArray alloc] initWithObjects:(id)startColor, (id)middleColor, (id)endColor, nil];
//        _deepTitleLayer.colors = colors;
//        [colors release];
//        [self.layer addSublayer:_deepTitleLayer];
        
        _lblDeepTitle = [[UILabel alloc] initWithFrame:CGRectZero];
        [_lblDeepTitle setBackgroundColor:[UIColor whiteColor]];
        [_lblDeepTitle setFont:[UIFont boldSystemFontOfSize:18.0f]];
        [_lblDeepTitle setTextColor:[UIColor whiteColor]];
        [_lblDeepTitle setNumberOfLines:3];
        [self addSubview:_lblDeepTitle];
        
        _lblTitle = [[UILabel alloc] initWithFrame:CGRectZero];
        [_lblTitle setBackgroundColor:[UIColor clearColor]];
        [_lblTitle setTextColor:COLOR_NEWSLIST_TITLE];
        [_lblTitle setFont:[UIFont boldSystemFontOfSize:16.0f]];
        [_lblTitle setNumberOfLines:3];
        [self addSubview:_lblTitle];
        
        _lblLeadContent = [[UILabel alloc] initWithFrame:CGRectZero];
        [_lblLeadContent setBackgroundColor:[UIColor clearColor]];
        [_lblLeadContent setTextColor:COLOR_DEEP_TEXT];
        [_lblLeadContent setFont:[UIFont systemFontOfSize:16.0f]];
        [_lblLeadContent setNumberOfLines:99];
        [self addSubview:_lblLeadContent];
        

    }
    return self;
}

- (void)dealloc {
    [_gradentView release];
    [_deepLeadObject release];
    [_lblDeepTitle release];
    [_ivLeadPic release];
    [_lblLeadContent release];
    [_lblTitle release];
    [_defaultPicture release];
    //[_deepTitleLayer release];
    [super dealloc];
}

- (void)setDeepLeadObject:(FSDeepLeadObject *)value {
    if (value != nil) {
        if (_deepLeadObject!=nil) {
            [_deepLeadObject release];
        }
        _deepLeadObject = [value retain];
        //NSLog(@"_deepLeadObject.picture:%@",_deepLeadObject.picture);
        NSString *picURL = [_deepLeadObject.picture stringByReplacingOccurrencesOfString:DEEPLEAD_IMAGESIZE_OLD withString:DEEPLEAD_IMAGESIZE];
        
        NSString *picFile = getFileNameWithURLString(picURL, getCachesPath());
        if ([[NSFileManager defaultManager] fileExistsAtPath:picFile]) {
            UIImage *image = [[UIImage alloc] initWithContentsOfFile:picFile];
            _ivLeadPic.image = image;
            [image release];
        } else {
            [FSHTTPWebExData HTTPGetDataWithURLString:picURL blockCompletion:^(NSData *data, BOOL success) {
                if (success) {
                    [data writeToFile:picFile atomically:YES];
                    UIImage *image = [[UIImage alloc] initWithData:data];
                    _ivLeadPic.image = image;
                    [image release];
                    [self inner_reLayout];
                }
            }];
        }
        
        [self inner_reLayout];
    }
}

- (void)setFrame:(CGRect)value {
    BOOL needLayout = !CGSizeEqualToSize(value.size, self.frame.size);
    [super setFrame:value];
    if (needLayout) {
        [self inner_reLayout];
    }
}

- (void)inner_reLayout {
    _lblDeepTitle.text = _deepLeadObject.deepTitle;
    _lblTitle.text = _deepLeadObject.title;
    _lblLeadContent.text = _deepLeadObject.leadContent;
    
    CGSize sizeTmp = CGSizeZero;
    
    CGFloat clientWidth = self.frame.size.width - FSDEEPLEAD_LEFT_RIGHT_SPACE * 2.0f;
    CGFloat picMaxHeight = FSDEEPLEAD_PIC_HEIGHT;
    CGFloat left = FSDEEPLEAD_LEFT_RIGHT_SPACE;
    //STEP 1.
    sizeTmp = [_lblDeepTitle.text sizeWithFont:_lblDeepTitle.font
                             constrainedToSize:CGSizeMake(clientWidth, 1024)
                                 lineBreakMode:_lblDeepTitle.lineBreakMode];
    
    _lblDeepTitle.frame = CGRectMake(left, picMaxHeight - sizeTmp.height - FSDEEPLEAD_ROW_SPACE, sizeTmp.width, sizeTmp.height);
    
    _deepTitleLayer.frame = CGRectMake(0.0f, FSDEEPLEAD_PIC_HEIGHT - FSDEEPLEAD_SHADOW_HEIGHT, self.frame.size.width, FSDEEPLEAD_SHADOW_HEIGHT);
    _deepTitleLayer.startPoint = CGPointMake(0.5, 1.0);
    _deepTitleLayer.endPoint = CGPointMake(0.5, 0.0f);
    //STEP 2.
    
    //STEP 4.
    if (_ivLeadPic.image != nil) {
//        sizeTmp = _ivLeadPic.image.size;
//        if (_ivLeadPic.image.size.width > self.frame.size.width) {
//            sizeTmp.width = self.frame.size.height;
//            sizeTmp.height = sizeTmp.width * _ivLeadPic.image.size.height / _ivLeadPic.image.size.width;
//        }
        
        sizeTmp = scalImageSizeFixWidth(_ivLeadPic.image, self.frame.size.width);
        
        _ivLeadPic.frame = CGRectMake((self.frame.size.width - sizeTmp.width) / 2.0f, 0.0f, sizeTmp.width, sizeTmp.height);
        
    }
    else{
        _ivLeadPic.frame = CGRectZero;
        sizeTmp.height = FSDEEPLEAD_SHADOW_HEIGHT;
    }
    
    //STEP 11.
    CGSize sizeTmpContent = [_lblLeadContent.text sizeWithFont:_lblLeadContent.font
                                             constrainedToSize:CGSizeMake(clientWidth, 4096)
                                                 lineBreakMode:_lblLeadContent.lineBreakMode];
    
    CGSize sizeTmpTitle = [_lblTitle.text sizeWithFont:_lblTitle.font
                                     constrainedToSize:CGSizeMake(clientWidth, 1024)
                                         lineBreakMode:_lblTitle.lineBreakMode];
    
    
    
    
    
    _gradentView.frame = CGRectMake(0.0f, sizeTmp.height-_gradentView.image.size.height, self.frame.size.width, _gradentView.image.size.height);
    
    
    if (_gradentView.frame.origin.y+_gradentView.image.size.height + FSDEEPLEAD_ROW_SPACE + sizeTmpContent.height>self.frame.size.height) {
        
        _gradentView.frame = CGRectMake(0.0f, self.frame.size.height - sizeTmpContent.height - _gradentView.image.size.height-30, self.frame.size.width, _gradentView.image.size.height);
        
        _lblTitle.frame = CGRectMake(left, _gradentView.frame.origin.y+_gradentView.image.size.height - sizeTmpTitle.height - 8, sizeTmpTitle.width, sizeTmpTitle.height);
        _lblLeadContent.frame = CGRectMake(left,
                                           _gradentView.frame.origin.y+_gradentView.image.size.height,
                                           sizeTmpContent.width,
                                           sizeTmpContent.height);
        _lblDeepTitle.frame = CGRectMake(0, _gradentView.frame.origin.y+_gradentView.image.size.height-4, self.frame.size.width, self.frame.size.height);
        
        
    }
    else{
        
        _lblTitle.frame = CGRectMake(left, _gradentView.frame.origin.y+_gradentView.image.size.height - sizeTmpTitle.height - 8, sizeTmpTitle.width, sizeTmpTitle.height);
        
        _lblLeadContent.frame = CGRectMake(left,
                                           _gradentView.frame.origin.y+_gradentView.image.size.height,
                                           sizeTmpContent.width,
                                           sizeTmpContent.height);
        
        _lblDeepTitle.frame = CGRectMake(0, _gradentView.frame.origin.y+_gradentView.image.size.height-4, self.frame.size.width, self.frame.size.height);
    }
    
    
    
    
}

@end
