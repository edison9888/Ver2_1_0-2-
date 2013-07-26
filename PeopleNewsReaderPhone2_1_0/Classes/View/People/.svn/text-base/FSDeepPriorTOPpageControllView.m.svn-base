//
//  FSDeepPriorTOPpageControllView.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-1-11.
//
//

#import "FSDeepPriorTOPpageControllView.h"
#import "FS_GZF_PageControllView.h"

#define PAGECONTROLLER_BEGIN 200.0f
#define LEFT_RIGHT_IMAGE_WIDTH 18.0f

@implementation FSDeepPriorTOPpageControllView

@synthesize CurrentPage = _CurrentPage;

@synthesize pageNumber = _pageNumber;


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
    [_fs_GZF_PageControllView release];
}

-(void)doSomethingAtInit{
    _fs_GZF_PageControllView = [[FS_GZF_PageControllView alloc] init];
    
    _fs_GZF_PageControllView.backgroundColor = COLOR_CLEAR;
    _fs_GZF_PageControllView.FocusColor = COLOR_WHITE_8;
    _fs_GZF_PageControllView.NonFocusColor = COLOR_BLACK_8;
    _fs_GZF_PageControllView.Radius = 4;
    _fs_GZF_PageControllView.Spacing = 16;
    
    _lab_title = [[UILabel alloc] init];
    _lab_title.backgroundColor = COLOR_CLEAR;
    _lab_title.textColor = COLOR_NEWSLIST_TITLE_WHITE;
    _lab_title.font = [UIFont systemFontOfSize:14.0f];
    _lab_title.textAlignment = UITextAlignmentLeft;
    _backgroundImage = [[UIImageView alloc] init];
    _backgroundImage.image = [UIImage imageNamed:@"deep_priorpagecontroll.png"];
    
    _leftImage = [[UIImageView alloc] init];
    _leftImage.image = [UIImage imageNamed:@"page_left.png"];
    
    _rightimage = [[UIImageView alloc] init];
    _rightimage.image = [UIImage imageNamed:@"page_right.png"];
    
    [self addSubview:_backgroundImage];
    [self addSubview:_fs_GZF_PageControllView];
    [self addSubview:_leftImage];
    [self addSubview:_rightimage];
    [self addSubview:_lab_title];
    
}

-(void)doSomethingAtLayoutSubviews{
    _fs_GZF_PageControllView.PageNumber = self.pageNumber;
    _fs_GZF_PageControllView.CurrentPage = self.CurrentPage;
    
    _lab_title.text = (NSString *)self.data;
    
    
    _backgroundImage.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
    _lab_title.frame = CGRectMake(6.0f, 0.0f, self.frame.size.width, self.frame.size.height);
    CGFloat pageControllWidth = _fs_GZF_PageControllView.Spacing * (self.pageNumber*2);
    _fs_GZF_PageControllView.frame = CGRectMake(self.frame.size.width-pageControllWidth-LEFT_RIGHT_IMAGE_WIDTH-6.0f, 0.0f, pageControllWidth, self.frame.size.height);
    
    _rightimage.frame = CGRectMake(self.frame.size.width-LEFT_RIGHT_IMAGE_WIDTH-6.0f, (self.frame.size.height-LEFT_RIGHT_IMAGE_WIDTH)/2, LEFT_RIGHT_IMAGE_WIDTH, LEFT_RIGHT_IMAGE_WIDTH);
    
    _leftImage.frame = CGRectMake(self.frame.size.width-pageControllWidth-LEFT_RIGHT_IMAGE_WIDTH*2-6.0f, (self.frame.size.height-LEFT_RIGHT_IMAGE_WIDTH)/2, LEFT_RIGHT_IMAGE_WIDTH, LEFT_RIGHT_IMAGE_WIDTH);
    
    
}


@end
