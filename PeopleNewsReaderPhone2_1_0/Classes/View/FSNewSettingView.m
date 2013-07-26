//
//  FSNewSettingView.m
//  PeopleNewsReaderPhone
//
//  Created by Qin,Zhuoran on 12-11-28.
//
//

#import "FSNewSettingView.h"
#import "FSConst.h"
#import "FSBaseDB.h"
#import "FSWeatherObject.h"
@implementation FSNewSettingView

//@synthesize btnClearMemory,btnDownLoad,btnMyCollection,btnNigthMode,btnUpdate;

@synthesize delegate;
-(void)addWeatherView
{
    _fsWeatherView = [[FSWeatherView alloc] init];
    _fsWeatherView.frame = CGRectMake(50, 0, 320, 100);
    _fsWeatherView.userInteractionEnabled = NO;
    _fsWeatherView.multipleTouchEnabled = NO;
    UIButton *weatcherBt = [[UIButton alloc] init];
    weatcherBt.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1];
    //weatcherBt.backgroundColor = [UIColor greenColor];
    weatcherBt.frame = CGRectMake(0, 0, 320, 100);
    [weatcherBt addSubview:_fsWeatherView];
    [weatcherBt addTarget:self action:@selector(weatherNewsAction:) forControlEvents:UIControlEventTouchUpInside];
    [weatcherBt addTarget:self action:@selector(weatherNewsActionLock:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:weatcherBt];
    
}
-(void)updataWeatherStatus{
    NSArray *array = [[FSBaseDB sharedFSBaseDB] getObjectsByKeyWithName:@"FSWeatherObject" key:@"group" value:@""];
    
    for (FSWeatherObject *obj in array) {
        if ([obj.day isEqualToString:@"0"]) {
            _fsWeatherView.data = obj;
            [_fsWeatherView doSomethingAtLayoutSubviews];
        }
    }
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialize the background image
        
        
        CGFloat top = 30;
        CGFloat left = 0;
        CGFloat space = 4.0f;
        
        
        [self addWeatherView];
        [self updataWeatherStatus];
        
        
        //the Scroll View
        CGRect scrollFrame = CGRectMake(0, 0, self.frame.size.width, frame.size.height);
        scrollView = [[UIScrollView alloc] initWithFrame:scrollFrame];
        scrollView.delegate = self;
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        
        UIImageView *buttonImage1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"设置.png"]];
        
        left = (self.frame.size.width-40 - buttonImage1.image.size.width)/2;
        top = frame.size.height - 40-buttonImage1.image.size.height;
        
        buttonImage1.frame = CGRectMake(left, top, buttonImage1.image.size.width,buttonImage1.image.size.height);
        [self addSubview:buttonImage1];
        btnNigthMode = [UIButton buttonWithType:UIButtonTypeCustom];
        btnNigthMode.frame = buttonImage1.frame;
        btnNigthMode.alpha = 0.02;
        [btnNigthMode addTarget:self action: @selector(nigthModeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnNigthMode];
        [buttonImage1 release];
        
        UIImageView *backGroundImage1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tools_line.png"]];
        backGroundImage1.frame = CGRectMake(left, top+btnNigthMode.frame.size.height, backGroundImage1.image.size.width,backGroundImage1.image.size.height);
        [self addSubview:backGroundImage1];
        [backGroundImage1 release];
        
        
        
        UIImageView *buttonImage2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"检查更新.png"]];
        
        left = (self.frame.size.width-40 - buttonImage2.image.size.width)/2;
        top = top - space -buttonImage2.image.size.height;
        
        buttonImage2.frame = CGRectMake(left, top, buttonImage2.image.size.width,buttonImage2.image.size.height);
        [self addSubview:buttonImage2];
        btnUpdate = [UIButton buttonWithType:UIButtonTypeCustom];
        btnUpdate.frame = buttonImage2.frame;
        btnUpdate.alpha = 0.02;
        [btnUpdate addTarget:self action: @selector(updateButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnUpdate];
        [buttonImage2 release];
        
        UIImageView *backGroundImage2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tools_line.png"]];
        backGroundImage2.frame = CGRectMake(left, top+btnUpdate.frame.size.height, backGroundImage2.image.size.width,backGroundImage2.image.size.height);
        [self addSubview:backGroundImage2];
        [backGroundImage2 release];
        
        
        UIImageView *buttonImage3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"清理缓存.png"]];
        
        left = (self.frame.size.width-40 - buttonImage3.image.size.width)/2;
        top = top - space -buttonImage3.image.size.height;
        
        buttonImage3.frame = CGRectMake(left, top, buttonImage3.image.size.width,buttonImage3.image.size.height);
        [self addSubview:buttonImage3];
        btnClearMemory = [UIButton buttonWithType:UIButtonTypeCustom];
        btnClearMemory.frame = buttonImage3.frame;
        btnClearMemory.alpha = 0.02;
        [btnClearMemory addTarget:self action: @selector(clearMemoryButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnClearMemory];
        [buttonImage3 release];
        
        
        UIImageView *backGroundImage3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tools_line.png"]];
        backGroundImage3.frame = CGRectMake(left, top+btnClearMemory.frame.size.height, backGroundImage3.image.size.width,backGroundImage3.image.size.height);
        [self addSubview:backGroundImage3];
        [backGroundImage3 release];
        
        
        UIImageView *buttonImage4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"我的收藏.png"]];
        
        left = (self.frame.size.width-40 - buttonImage4.image.size.width)/2;
        top = top - space -buttonImage4.image.size.height;
        
        buttonImage4.frame = CGRectMake(left, top, buttonImage4.image.size.width,buttonImage4.image.size.height);
        [self addSubview:buttonImage4];
        btnMyCollection = [UIButton buttonWithType:UIButtonTypeCustom];
        btnMyCollection.frame = buttonImage4.frame;
        btnMyCollection.alpha = 0.02;
        [btnMyCollection addTarget:self action: @selector(myCollectionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnMyCollection];
        [buttonImage4 release];
        
        UIImageView *backGroundImage4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tools_line.png"]];
        backGroundImage4.frame = CGRectMake(left, top+btnMyCollection.frame.size.height, backGroundImage4.image.size.width,backGroundImage4.image.size.height);
        [self addSubview:backGroundImage4];
        [backGroundImage4 release];
        
        
        UIImageView *buttonImage5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"订阅中心.png"]];
        
        left = (self.frame.size.width-40 - buttonImage5.image.size.width)/2;
        top = top - space -buttonImage5.image.size.height;
        
        buttonImage5.frame = CGRectMake(left, top, buttonImage5.image.size.width,buttonImage5.image.size.height);
        [self addSubview:buttonImage5];
        btnDownLoad = [UIButton buttonWithType:UIButtonTypeCustom];
        btnDownLoad.frame = buttonImage5.frame;
        btnDownLoad.alpha = 0.02;
        [btnDownLoad addTarget:self action: @selector(downloadButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnDownLoad];
        [buttonImage5 release];
        
        UIImageView *backGroundImage5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tools_line.png"]];
        backGroundImage5.frame = CGRectMake(left, top+btnDownLoad.frame.size.height, backGroundImage5.image.size.width,backGroundImage5.image.size.height);
        [self addSubview:backGroundImage5];
        [backGroundImage5 release];
        
        
       
        //1  download button

//        btnDownLoad = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        btnDownLoad.frame = btnFrame;
//        btnDownLoad.backgroundColor = [UIColor clearColor];
//        [btnDownLoad setImage:[UIImage imageNamed:@"_Download.png"] forState:UIControlStateNormal];
//        //[btnDownLoad setImage:[UIImage imageNamed:@"newsettingview.png"] forState:UIControlStateHighlighted];
//        [btnDownLoad addTarget:self action: @selector(downloadButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //2  night mode  button
//        btnFrame = CGRectMake(20, BUTTON_WIDTH + BUTTON_SPACE, BUTTON_LENGTH, BUTTON_WIDTH);
//        btnNigthMode = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        btnNigthMode.frame = btnFrame;
//        btnNigthMode.backgroundColor = [UIColor clearColor];
//        [btnNigthMode setImage:[UIImage imageNamed:@"_NightMode.png"] forState:UIControlStateNormal];
//        //[btnNigthMode setImage:[UIImage imageNamed:@"newsettingview.png"] forState:UIControlStateHighlighted];
//        [btnNigthMode addTarget:self action: @selector(nigthModeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
//        UIImage *image1 = [UIImage imageNamed:@"_MyCollection.png"];
//        left = (self.frame.size.width-40 - image1.size.width)/2;
//        
//        btnMyCollection = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        btnMyCollection.frame = CGRectMake(left, top, image1.size.width, image1.size.height);
//        btnMyCollection.backgroundColor = [UIColor clearColor];
//        [btnMyCollection setImage:image1 forState:UIControlStateNormal];
//        //[btnMyCollection setImage:[UIImage imageNamed:@"newsettingview.png"] forState:UIControlStateHighlighted];
//        [btnMyCollection addTarget:self action: @selector(myCollectionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//        
//        
//        top = top + image1.size.height+space;
//        //4  clear memory   button
//        UIImage *image2 = [UIImage imageNamed:@"_ClearMemory.png"];
//        btnClearMemory = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        btnClearMemory.frame = CGRectMake(left, top, image2.size.width, image2.size.height);
//        btnClearMemory.backgroundColor = [UIColor clearColor];
//        [btnClearMemory setImage:image2 forState:UIControlStateNormal];
//        //[btnClearMemory setImage:[UIImage imageNamed:@"newsettingview.png"] forState:UIControlStateHighlighted];
//        [btnClearMemory addTarget:self action: @selector(clearMemoryButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//        
//        
//        top = top + image2.size.height+space;
//        //5  update   button
//        UIImage *image3 = [UIImage imageNamed:@"_UpdateButton.png"];
//        
//        
//        btnUpdate = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        btnUpdate.frame = CGRectMake(left, top, image3.size.width, image3.size.height);
//        btnUpdate.backgroundColor = [UIColor clearColor];
//        [btnUpdate setImage:image3 forState:UIControlStateNormal];
//        //[btnUpdate setImage:[UIImage imageNamed:@"newsettingview.png"] forState:UIControlStateHighlighted];
//        [btnUpdate addTarget:self action: @selector(updateButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//        
//        
//        top = top + image3.size.height+space;
//        //6 订阅中心
//        UIImage *image4 = [UIImage imageNamed:@"_Subspription.png"];
//        
//        
//        btnDownLoad = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        btnDownLoad.frame = CGRectMake(left, top, image4.size.width, image4.size.height);
//        btnDownLoad.backgroundColor = [UIColor clearColor];
//        [btnDownLoad setImage:image4 forState:UIControlStateNormal];
//        [btnDownLoad addTarget:self action: @selector(downloadButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//        
//        
//        top = top + image4.size.height+space;
//        //7 设置
//        UIImage *image5 = [UIImage imageNamed:@"_Setting.png"];
//        
//        
//        btnNigthMode = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        btnNigthMode.frame = CGRectMake(left, top, image5.size.width, image5.size.height);
//        btnNigthMode.backgroundColor = [UIColor clearColor];
//        [btnNigthMode setImage:image5 forState:UIControlStateNormal];
//        [btnNigthMode addTarget:self action: @selector(nigthModeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//        
//        
//        [scrollView addSubview:btnDownLoad];
//        [scrollView addSubview:btnNigthMode];
//        
//        [scrollView addSubview:btnUpdate];
//        [scrollView addSubview:btnMyCollection];
//        [scrollView addSubview:btnClearMemory];
        
        //[self addSubview:scrollView];
        
       scrollView.contentSize = CGSizeMake(self.frame.size.width, frame.size.height);
    }
    return self;
}


#pragma mark costum method
//by Qin,Zhuoran

//btnDownLoad---字体设置
- (void)downloadButtonClicked:(UIButton *)button
{
    [delegate tappedInSettingView:self downloadButton:button];
}

//btnNigthMode---订阅中心
- (void)nigthModeButtonClicked:(UIButton *)button
{
    [delegate tappedInSettingView:self nightModeButton:button];
}

//btnMyCollection
- (void)myCollectionButtonClicked:(UIButton *)button
{
    [delegate tappedInSettingView:self myCollectionButton:button];
}

//btnClearMemory
- (void)clearMemoryButtonClicked:(UIButton *)button
{
    [delegate tappedInSettingView:self clearMemoryButton:button];
}

//btnUpdate
- (void)updateButtonClicked:(UIButton *)button
{
    [delegate tappedInSettingView:self updateButton:button];
}


#pragma mark - UIScrollView Delegate

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    return NO;
}

//滚动时出发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    //    NSLog(@" scrollViewDidScroll");
   // NSLog(@"ContentOffset  x is  %f,yis %f",scrollView.contentOffset.x,scrollView.contentOffset.y);
}

@end
