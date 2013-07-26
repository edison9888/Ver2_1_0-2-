//
//  FSNewsContainerWebView.h
//  PeopleNewsReaderPhone
//
//  Created by Xu dandan on 12-10-26.
//
//

#import <UIKit/UIKit.h>
#import "FSBaseContainerView.h"
//#import "FSNetworkData.h"
#import "FSNewsDitailToolBar.h"


@interface FSNewsContainerWebView : FSBaseContainerView<UIWebViewDelegate,UIScrollViewDelegate>{
@protected
    UIActivityIndicatorView *_indicator;
    UIWebView *_webContent;
    CGFloat _height;
    NSArray *_imageList;
    NSInteger _downloaodIndex;
    BOOL _isSizeChange;
    UIView *_imgContainer;
    TouchEvenKind _touchEvenKind;
    CGFloat _oldContentOfset;
    NSInteger _expendImageIndex;
    
    BOOL _hasebeenLoad;
    
    NSString *_adImageUrl;
    
    
}

@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) BOOL isSizeChange;
@property (nonatomic,assign) BOOL hasebeenLoad;
@property (nonatomic,assign) TouchEvenKind touchEvenKind;

-(void)loadWebPageWithContent:(NSString *)contentFile;

-(NSString *)processBodyImages:(NSString *)templateString;
-(NSString *)processBodyADImages:(NSString *)templateString;
-(NSString *)processCommentList:(NSString *)templateString;

-(NSString *)replayString:(NSString *)baseString oldString:(NSString *)oldString newString:(NSString *)newString;

-(void)heightChange;

-(BOOL)isDownloadPic;

-(void)downloadImages;
-(void)downloadADImage;
- (void)webImageManager:(UIImage *)image index:(NSInteger)index;
- (void)webADImageManager:(UIImage *)image index:(NSInteger)index;
-(NSString *) generateImageHTML:(UIImage *)image url:(NSString *)url;
-(NSString *) generateADImageHTML:(UIImage *)image url:(NSString *)url;

-(void)reSetCommentString:(NSString *)commentStr;


-(NSString *)returnFontSizeName:(NSInteger)n;

-(void)fontSizeChange;

- (void)expandImagefrom:(CGRect)startRect withImageUrl:(NSString *)urlStr;
- (void)shrinkImagetoRect:(CGRect)endRect;

-(CGRect)getStarRect:(NSString *)imageUrl;

@end
