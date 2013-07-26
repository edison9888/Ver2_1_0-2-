//
//  FSRecommendSectView.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-3-20.
//
//

#import "FSRecommendSectView.h"

#import "FSAsyncCheckImageView.h"
#import "FS_GZF_PageControllView.h"

#import "FSRecommentAPPObject.h"

#define topbarHeight 44.0f

@implementation FSRecommendSectView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)doSomethingAtDealloc{
    [_scrollView release];
    [_lab_sectionTitle release];
    [_sectionBGR release];
    [_lab_more release];
    [_MoreButton release];
    [_fs_GZF_PageControllView release];
}


-(void)doSomethingAtInit{
    
    _lab_sectionTitle = [[UILabel alloc] init];
    _lab_sectionTitle.textAlignment = UITextAlignmentLeft;
    _lab_sectionTitle.backgroundColor = COLOR_CLEAR;
    
    
    _lab_more = [[UILabel alloc] init];
    _lab_more.textAlignment = UITextAlignmentRight;
    _lab_more.backgroundColor = COLOR_CLEAR;
    
    
    _sectionBGR = [[UIImageView alloc] init];
    _sectionBGR.image = [UIImage imageNamed:@"more_section.png"];
    
    [self addSubview:_sectionBGR];
    [self addSubview:_lab_sectionTitle];
    //[self addSubview:_lab_more];
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
    
    
    _MoreButton = [[UIButton alloc] init];
    _MoreButton.alpha = 0.05;
    [_MoreButton addTarget:self action:@selector(MoerButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    //[self addSubview:_MoreButton];
    
    
    _fs_GZF_PageControllView = [[FS_GZF_PageControllView alloc] init];
    _fs_GZF_PageControllView.backgroundColor = COLOR_CLEAR;
    _fs_GZF_PageControllView.FocusColor = COLOR_RED;
    _fs_GZF_PageControllView.NonFocusColor = COLOR_NEWSLIST_DESCRIPTION;
    _fs_GZF_PageControllView.position_kind = Position_kind_middle;
    [self addSubview:_fs_GZF_PageControllView];
    
    
}

-(void)doSomethingAtLayoutSubviews{
    
    
    _lab_sectionTitle.text = @"应用推荐";
    _lab_sectionTitle.textColor = COLOR_NEWSLIST_TITLE;
    
    _sectionBGR.frame = CGRectMake(0, 0, self.frame.size.width, topbarHeight);
    _lab_sectionTitle.frame = CGRectMake(20, 0, self.frame.size.width, topbarHeight-4);
    
    _lab_more.text = @"更多";
    _lab_more.textColor = COLOR_RED;
    _lab_more.frame = CGRectMake(100, 0, self.frame.size.width-120, topbarHeight-4);
    
    _MoreButton.frame = CGRectMake(self.frame.size.width-100, 0, 90, topbarHeight-4);
    
    
    _scrollView.frame = CGRectMake(0, topbarHeight, self.frame.size.width, self.frame.size.height-topbarHeight);
    //_scrollView.backgroundColor = [UIColor yellowColor];
    _scrollView.backgroundColor = COLOR_CLEAR;
    NSArray *v = [_scrollView subviews];
    for (UIView *o in v) {
        [o removeFromSuperview];
    }
    
    CGFloat space = 85;
    CGFloat left_right = 19.0f;
    CGFloat Mspace = 13.0f;
    NSInteger i = 0;
    
    
    
    NSMutableArray *array = (NSMutableArray *)self.data;
    
    //NSLog(@"array:%d",[array count]);
    
    for (FSRecommentAPPObject *o in array) {
        
        //set the image
        
        UIImageView *imageBackGR = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"more_PeopleApp.png"]];
        imageBackGR.frame = CGRectMake( left_right + (space+Mspace) * i, 16, space, space+4);
        [_scrollView addSubview:imageBackGR];
        [imageBackGR release];
        
        
        FSAsyncCheckImageView *imageView = [[FSAsyncCheckImageView alloc] initWithFrame:CGRectMake( 36 + (MORE_LIST_PEOPLEAPP_ICON_HEIGHT+48) * i, 26, MORE_LIST_PEOPLEAPP_ICON_HEIGHT, MORE_LIST_PEOPLEAPP_ICON_HEIGHT)];
        // NSString *defaultDBPath = [getDocumentPath() stringByAppendingPathComponent:[o.channel_normal lastPathComponent]];
        imageView.normalURLString = o.appLogo;
        imageView.heighlightURLString = o.appLogo;
        imageView.selectedURLString = o.appLogo;
        imageView.imageCheckType = ImageCheckType_normal;//
        imageView.tag = i;
        [_scrollView addSubview:imageView];
        [imageView updataCheckImageView];
        
        
        
        //set the label
        UILabel *lab_title = [[UILabel alloc] init];
        lab_title.backgroundColor = COLOR_CLEAR;
        lab_title.font = [UIFont systemFontOfSize:14];
        lab_title.textColor = COLOR_NEWSLIST_TITLE;
        lab_title.textAlignment = UITextAlignmentCenter;
        lab_title.text = o.appName;
        //lab_title.frame = CGRectMake(space+(MORE_LIST_PEOPLEAPP_ICON_HEIGHT+space)*i+3, MORE_LIST_PEOPLEAPP_ICON_HEIGHT+5, MORE_LIST_PEOPLEAPP_ICON_HEIGHT, 20);
        lab_title.frame = CGRectMake( left_right + (space+Mspace) * i, 28+MORE_LIST_PEOPLEAPP_ICON_HEIGHT, space, 18);
        [_scrollView addSubview:lab_title];
        [lab_title release];
        
        //set the button under the image
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake( left_right + (space+Mspace) * i, 16, space, space+4);
        button.alpha = 0.05;
        button.tag = i;
        [button addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:button];
        [button release];
        i++;
        [imageView release];
    }
    
    NSInteger pages = i/3;
    if (pages*3==i) {
        _fs_GZF_PageControllView.PageNumber = pages;
    }
    else{
        _fs_GZF_PageControllView.PageNumber = pages+1;
    }
    _fs_GZF_PageControllView.frame = CGRectMake(0, self.frame.size.height-TODAYNEWSLIST_TOP_BOTTOM_HEIGHT, self.frame.size.width-5, TODAYNEWSLIST_TOP_BOTTOM_HEIGHT);
    
    _fs_GZF_PageControllView.Radius = 3;
    _fs_GZF_PageControllView.Spacing = 12;
    _fs_GZF_PageControllView.CurrentPage = 0;
    _currentPage = 0;
    [_scrollView setContentSize:CGSizeMake(left_right + (space+Mspace) * i+6, self.frame.size.height-topbarHeight)];
    if (_fs_GZF_PageControllView.PageNumber==1) {
        _fs_GZF_PageControllView.alpha = 0.0f;
    }
    else{
        _fs_GZF_PageControllView.alpha = 1.0f;
    }
    
}




-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidScroll:%f",scrollView.contentOffset.x);
    //计算当前页码
    int page = floor((scrollView.contentOffset.x - self.frame.size.width / 2) / self.frame.size.width) + 1;
    if (page==_currentPage || page<0 || scrollView.contentOffset.x>scrollView.contentSize.width - self.frame.size.width) {
        return;
    }
    _currentPage = page;
    _fs_GZF_PageControllView.CurrentPage = _currentPage;
}


-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidEndScrollingAnimation");
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"scrollViewDidEndDragging");
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidEndDecelerating");
    
    
    if (scrollView.contentOffset.x > _currentPage*self.frame.size.width) {
        _currentPage = _currentPage+1;
    }
    _fs_GZF_PageControllView.CurrentPage = _currentPage;
}


-(void)buttonSelected:(id)sender{
    UIButton *o = (UIButton *)sender;
    self.currentIndex = o.tag;
    [self sendTouchEvent];
}

-(void)MoerButtonSelected:(id)sender{
    self.currentIndex = -1;
    [self sendTouchEvent];
}

@end
