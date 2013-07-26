//
//  FSDeepView.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-23.
//
//

#import "FSDeepView.h"
#import "FSCommonFunction.h"
#import "FSDeepFloatingTitleView.h"

#define TOPIC_LIST_IMAGESIZE @"630/420"
#define TOPIC_LIST_IMAGESIZE_OLD @"640/420"

@implementation FSDeepView
@synthesize indexPath = _indexPath;

@synthesize deep_Title = _deep_Title;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _deepImageView = [[FSAsyncImageView alloc] initWithFrame:CGRectMake(4.0f, 3.0f, frame.size.width-8.0f, frame.size.height-6.0f)];
        _deepImageView.imageCuttingKind = ImageCuttingKind_fixrect;
        _deepImageView.userInteractionEnabled = NO;
        
        _deepLogoImageView = [[FSAsyncImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
        _deepLogoImageView.imageCuttingKind = ImageCuttingKind_None;
        _deepLogoImageView.userInteractionEnabled = NO;
        
        _backGroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Deep_listbook.png"]];
        
        [self addSubview:_backGroundImage];
        
        
        [self addSubview:_deepImageView];
        [self addSubview:_deepLogoImageView];
        
        _deepFloattingTitleView = [[FSDeepFloatingTitleView alloc] initWithFrame:CGRectZero];
        //_deepFloattingTitleView.backgroundColor = [UIColor whiteColor];
        
        _floatingViewBimage = [[UIImageView alloc] initWithFrame:CGRectZero];
        _floatingViewBimage.image = [UIImage imageNamed:@"titleforip4.png"];
        
        if ([UIScreen mainScreen].applicationFrame.size.height<490.0f) {
            [self addSubview:_floatingViewBimage];
            [self addSubview:_deepFloattingTitleView];
        }
    }
    return self;
}

- (void)dealloc {
    [_deepImageView release];
    [_indexPath release];
    [_deepLogoImageView release];
    [_backGroundImage release];
    [_deepFloattingTitleView release];
    [_floatingViewBimage release];
    [super dealloc];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    _deepImageView.frame = CGRectMake(4.0f, 3.0f, frame.size.width-8.0f, frame.size.height-6.0f);
    
    _backGroundImage.frame = CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height+4);
    
    _deepLogoImageView.frame = CGRectMake(0, 10, 100, 40);
    
    _floatingViewBimage.frame = CGRectMake(0, frame.size.height- _floatingViewBimage.image.size.height - 16, self.frame.size.width, _floatingViewBimage.image.size.height);
    _deepFloattingTitleView.frame = _floatingViewBimage.frame;

}

- (void)setPictureURL:(NSString *)value {
    //NSLog(@"value:%@",value);
    NSString *resultSTR = [value stringByReplacingOccurrencesOfString:TOPIC_LIST_IMAGESIZE_OLD withString:TOPIC_LIST_IMAGESIZE];
    _deepImageView.urlString = resultSTR;
    _deepImageView.localStoreFileName = getFileNameWithURLString(resultSTR, getCachesPath());
    //缺省图
    [_deepFloattingTitleView setTitle:self.deep_Title withDateTime:nil];
    [_deepImageView updateAsyncImageView];
}

-(void)setLogoPictureURL:(NSString *)value{
    NSString *resultSTR = [value stringByReplacingOccurrencesOfString:TOPIC_LIST_IMAGESIZE_OLD withString:TOPIC_LIST_IMAGESIZE];
    _deepLogoImageView.urlString = resultSTR;
    _deepLogoImageView.localStoreFileName = getFileNameWithURLString(resultSTR, getCachesPath());

    //缺省图
    [_deepLogoImageView updateAsyncImageView];
}

@end
