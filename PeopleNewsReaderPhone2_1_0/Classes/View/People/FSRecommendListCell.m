//
//  FSRecommendListCell.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-28.
//  Copyright (c) 2012年 people. All rights reserved.
//
 
#import "FSRecommendListCell.h"
#import "FSAsyncImageView.h"
#import "FSRecommentAPPObject.h"
#import "FSCommonFunction.h"
#import "FSRecommendListCell.h"

@implementation FSRecommendListCell
//@synthesize deleaget;
@synthesize btnDownload = _btn_download;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    return self;
}

-(void)doSomethingAtInit{
    
//    UIImageView *bgr = [[UIImageView alloc] init];
//    bgr.image = [UIImage imageNamed:@"moreCellBGR2.png"];
//    self.backgroundView = bgr;
//    [bgr release];
    
    self.backgroundColor = COLOR_NEWSLIST_TITLE_WHITE;
    
    _image_Onleft = [[FSAsyncImageView alloc] init];
    _image_Onleft.borderColor = COLOR_CLEAR;
    
    _lab_title = [[UILabel alloc] init];
    _lab_title.font = [UIFont systemFontOfSize:14];
    _lab_title.textColor = COLOR_NEWSLIST_TITLE;
    _lab_title.backgroundColor = COLOR_CLEAR;
    _lab_title.textAlignment = UITextAlignmentLeft;
    _lab_title.numberOfLines = 1;
    
    
    _lab_description = [[UILabel alloc] init];
    _lab_description.backgroundColor = COLOR_CLEAR;
    _lab_description.font = [UIFont systemFontOfSize:10];
    _lab_description.textColor = COLOR_NEWSLIST_DESCRIPTION;
    _lab_description.numberOfLines = 4;
    _lab_description.textAlignment = UITextAlignmentLeft;
  
    
    //add the download button
    _btn_download = [[UIButton alloc]init];
  
    
    [self.contentView addSubview:_lab_title];
    [self.contentView addSubview:_lab_description];
    [self.contentView addSubview:_image_Onleft];
    [self.contentView addSubview:_btn_download];
    
    self.btnDownload = _btn_download;
    
    
}

-(void)doSomethingAtDealloc{
    [_image_Onleft release];
    [_lab_description release];
    [_lab_title release];
    [_btn_download release];
}

-(void)doSomethingAtLayoutSubviews{
    
    FSRecommentAPPObject *o = (FSRecommentAPPObject *)self.data;
    
    _lab_title.text = o.appName;
    _lab_description.text = o.appDesc;
     
    
    //NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"F201208071344314243442215.jpg"];
    //_image_Onleft.defaultFileName = defaultDBPath;
    _image_Onleft.urlString = o.appLogo;
    _image_Onleft.localStoreFileName = getFileNameWithURLString(o.appLogo, getCachesPath());
    _image_Onleft.imageCuttingKind = ImageCuttingKind_fixrect;
    [_image_Onleft updateAsyncImageView];
    
    _image_Onleft.frame = CGRectMake(MORE_LIST_RECOMMEND_CELL_INDENT, MORE_LIST_RECOMMEND_CELL_INDENT, MORE_LIST_RECOMMEND_ICON_HEIGHT, MORE_LIST_RECOMMEND_ICON_HEIGHT);
    
    _lab_title.frame = CGRectMake(MORE_LIST_RECOMMEND_CELL_INDENT*2+MORE_LIST_RECOMMEND_ICON_HEIGHT - 10, MORE_LIST_RECOMMEND_CELL_INDENT - 5, self.frame.size.width - 135, 20);
    
    _lab_description.frame = CGRectMake(MORE_LIST_RECOMMEND_CELL_INDENT*2+MORE_LIST_RECOMMEND_ICON_HEIGHT - 10, MORE_LIST_RECOMMEND_CELL_INDENT+22, self.frame.size.width - 148, self.frame.size.height - MORE_LIST_RECOMMEND_CELL_INDENT-30);
    
    CGRect btnFrame = CGRectMake(self.frame.size.width - 20 - 35, 37.5, 40, 40);
    _btn_download.frame = btnFrame;
    [_btn_download setImage:[UIImage imageNamed:@"more_DownIcon.png"] forState:UIControlStateNormal];
//    //add action method
//    [_btn_download addTarget:self action:@selector(downlaodButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/*
// the download button clicked  create by Qin,Zhuoran
- (void)downlaodButtonClicked:(UIButton *)button
{
    NSLog(@"downlaod button clicked!!!!");
    [deleaget TappedInAppRemmendListCell:self downloadButton:button];
    
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0,screenRect.size.width , screenRect.size.height)];
//    
//    [_webView setUserInteractionEnabled:YES];
//    [_webView setDelegate:self];
//    [_webView setOpaque:NO];
    
}
*/

@end
