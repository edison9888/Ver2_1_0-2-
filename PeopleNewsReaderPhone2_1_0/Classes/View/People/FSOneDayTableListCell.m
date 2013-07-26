//
//  FSOneDayTableListCell.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-9-4.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSOneDayTableListCell.h"
#import <CoreData/CoreData.h>
#import "FSCommonFunction.h"
#import "GlobalConfig.h"
#import "FSOneDayNewsObject.h"
#import "FSBaseDB.h"
#import "FSChannelObject.h"


#define move_down_space 5.0f


@implementation FSOneDayTableListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)doSomethingAtDealloc{
    //[_lab_newsType release];
//    [_labContainbackground release];
    [_lab_title release];
    [_lab_description release];
    [_image_Icon release];
    [_image_channelIcon release];
    [_image_newsimage release];
//    [_cellbackground release];
//    [_cellBOXtop release];
//    [_cellBOXmidle release];
//    [_cellBOXbottom release];
    [_contenBGRView release];
    [_lineView release];
    [_cellLeftLine release];
    [_oneday_eastImage release];
   // [_image_VisitIcon release];
    //[_lab_VisitVolume release];
}

-(void)doSomethingAtInit{
    self.contentView.backgroundColor = COLOR_NEWSLIST_TITLE_WHITE;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _cellLeftLine = [[UIView alloc] init];
    _cellLeftLine.backgroundColor = [UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:0.9];
    [self.contentView addSubview:_cellLeftLine];
    
//    _cellbackground = [[UIImageView alloc] init];
//    _cellbackground.image = [UIImage imageNamed:@"oneday_timeline.png"];
//    [self.contentView addSubview:_cellbackground];
    
//    _cellBOXtop = [[UIImageView alloc] init];
//    _cellBOXtop.image = [UIImage imageNamed:@"newscard_01.png"];
//    [self.contentView addSubview:_cellBOXtop];
//    
//    _cellBOXmidle = [[UIImageView alloc] init];
//    _cellBOXmidle.image = [UIImage imageNamed:@"newscard_02.png"];
//    [self.contentView addSubview:_cellBOXmidle];
//    
//    _cellBOXbottom = [[UIImageView alloc] init];
//    _cellBOXbottom.image = [UIImage imageNamed:@"newscard_03.png"];
//    [self.contentView addSubview:_cellBOXbottom];
    
    _contenBGRView = [[UIView alloc] init];
    _contenBGRView.layer.borderWidth = 1;
    _contenBGRView.backgroundColor = [UIColor whiteColor];
    _contenBGRView.layer.borderColor = [UIColor colorWithRed:221.0f/255.0f green:152.0f/255.0f blue:152.0f/255.0f alpha:1.0].CGColor;
    _contenBGRView.layer.cornerRadius = 4.0f;
//    _contenBGRView.layer.shadowColor = [UIColor darkGrayColor].CGColor;
//    _contenBGRView.layer.shadowOffset = CGSizeMake(1, 1);
//    _contenBGRView.layer.shadowOpacity = 0.85f;
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = [UIColor colorWithRed:199.0f/255.0f green:199.0f/255.0f blue:199.0f/255.0f alpha:1.0];
    
    _oneday_eastImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"oneday_east.png"]];
    
    
    [self.contentView addSubview:_contenBGRView];
    [self.contentView addSubview:_lineView];
    [self.contentView addSubview:_oneday_eastImage];
    
//    _labContainbackground = [[UIImageView alloc] init];
//    _labContainbackground.alpha = 0.88;
//    [self.contentView addSubview:_labContainbackground];
    

//    _lab_newsType = [[UILabel alloc] init];
//    _lab_newsType.backgroundColor = COLOR_CLEAR;
//    _lab_newsType.textColor = COLOR_NEWSLIST_DESCRIPTION;
//    _lab_newsType.textAlignment = UITextAlignmentLeft;
//    _lab_newsType.font = [UIFont systemFontOfSize:10];

    
    _image_channelIcon = [[FSAsyncImageView alloc] init];
    _image_channelIcon.borderColor = COLOR_CLEAR;
    [self.contentView addSubview:_image_channelIcon];

    _image_newsimage = [[FSAsyncImageView alloc] init];
    [self.contentView addSubview:_image_newsimage];
    
    
    _image_Icon = [[UIImageView alloc] init];
    _image_Icon.tag = arc4random();
     _image_Icon.backgroundColor = [UIColor whiteColor];
    //[self.contentView addSubview:_image_Icon];
    
    _lab_title = [[UILabel alloc] init];
    _lab_title.backgroundColor = COLOR_CLEAR;
    _lab_title.textColor = COLOR_NEWSLIST_TITLE;
    _lab_title.font = [UIFont systemFontOfSize:TODAYNEWSLIST_TITLE_FONT];
    _lab_title.textAlignment = UITextAlignmentLeft;
    _lab_title.userInteractionEnabled = NO;
    [self.contentView addSubview:_lab_title];
    
    
    _lab_description = [[UILabel alloc] init];
    _lab_description.backgroundColor = COLOR_CLEAR;
    _lab_description.textColor = COLOR_NEWSLIST_DESCRIPTION;
    _lab_description.font = [UIFont systemFontOfSize:TODAYNEWSLIST_DESCRIPTION_FONT];
    _lab_description.userInteractionEnabled = NO;
    _lab_description.numberOfLines = 4;
    _lab_description.textAlignment = UITextAlignmentLeft;
    [self.contentView addSubview:_lab_description];
    
    
//    _image_VisitIcon = [[UIImageView alloc] init];
//    _image_VisitIcon.image = [UIImage imageNamed:@"xin.png"];
//    [self.contentView addSubview:_image_VisitIcon];
//    
//    _lab_VisitVolume = [[UILabel alloc] init];
//    _lab_VisitVolume.backgroundColor = COLOR_CLEAR;
//    _lab_VisitVolume.textColor = COLOR_NEWSLIST_DESCRIPTION;
//    _lab_VisitVolume.font = [UIFont systemFontOfSize:10];
//    _lab_VisitVolume.textAlignment = UITextAlignmentLeft;
//    
//    [self.contentView addSubview:_lab_VisitVolume];
//    [self.contentView addSubview:_lab_newsType];
    
}

-(void)setContainer{
    
    FSOneDayNewsObject *o = (FSOneDayNewsObject *)_data;
    
    if (o==nil) {
        _lab_title.text = @"数据出问题了啦！";
        return;
    }
    
    
    _image_channelIcon.defaultFileName = @"人.png";
    if ([o.channalIcon length]>0) {
        _image_channelIcon.urlString = o.channalIcon;//@"http://mobile.app.people.com.cn:81/news2/images/channel/selected/1_18_2.png";
        _image_channelIcon.imageCuttingKind = ImageCuttingKind_fixrect;
//        _image_Icon.image = [UIImage imageWithContentsOfFile: getFileNameWithURLString(_image_channelIcon.urlString, getCachesPath())];
        
        _image_channelIcon.localStoreFileName = getFileNameWithURLString(o.channalIcon, getCachesPath());
    }
    else{
        ;
    }
    
    if ([o.picture length]>0 && [self isDownloadPic]) {
        _image_newsimage.urlString = o.picture;
        _image_newsimage.localStoreFileName = getFileNameWithURLString(o.picture, getCachesPath());
        _image_newsimage.imageCuttingKind = ImageCuttingKind_fixrect;
    }else{
        _image_newsimage.urlString = @"";
    }
    
//    _lab_VisitVolume.text = [NSString stringWithFormat:@"%d", [o.browserCount intValue]];
//    _lab_newsType.text = [NSString stringWithFormat:@"来源:%@",o.source];
    //NSLog(@"o.kind:%@",_lab_VisitVolume.text);
    _lab_title.text = o.title;
    _lab_description.text = [NSString stringWithFormat:@"%@",o.news_abstract];

}


-(void)doSomethingAtLayoutSubviews{
    [self setContainer];
    _cellLeftLine.frame = CGRectMake(26.0f, 0, 2.0f, self.frame.size.height);
    
    _image_channelIcon.frame = CGRectMake(13, 9, 30, 30);
    [_image_channelIcon updateAsyncImageView];
    
    
//    _image_Icon.frame = CGRectMake(13, 9, 30, 30);
//    if (_image_Icon.image == nil) {
//        _image_Icon.image = [UIImage imageNamed:@"AsyncImage.png"]; 
//    }
    
    
    
//    _cellBOXtop.frame = CGRectMake(6, 4, self.frame.size.width - 12, _cellBOXtop.image.size.height);
//    _cellBOXbottom.frame = CGRectMake(6, self.frame.size.height-_cellBOXbottom.image.size.height-4, self.frame.size.width - 12, _cellBOXbottom.image.size.height);
//    _cellBOXmidle.frame = CGRectMake(6, _cellBOXtop.image.size.height+4, self.frame.size.width - 12, self.frame.size.height-_cellBOXtop.image.size.height-10);
    
    _contenBGRView.frame = CGRectMake(6, 4, self.frame.size.width - 12, self.frame.size.height - 8);
    _lineView.frame = CGRectMake(44, 34, self.frame.size.width - 56, 1);
    
    _oneday_eastImage.frame = CGRectMake(self.frame.size.width - 20, 15, 6, 8);
    
    if ([_image_newsimage.urlString length]>0 && [self isDownloadPic]) {
        
//        _image_VisitIcon.frame = CGRectMake(128, self.frame.size.height - 19-13+move_down_space, 11, 11);
//        _lab_VisitVolume.frame = CGRectMake(128+14, self.frame.size.height - 38+move_down_space, 60, 22);
//        
//        _lab_newsType.frame = CGRectMake(self.frame.size.width - 108, self.frame.size.height - 38+move_down_space, 180, 22);
        
        
//        _labContainbackground.image = [UIImage imageNamed:@"box.png"];
//        _labContainbackground.frame = CGRectMake(6, 0, self.frame.size.width - 12, self.frame.size.height-12);
        _image_newsimage.alpha = 1.0f;
        _image_newsimage.frame = CGRectMake(46, 38+move_down_space, 75, 57);
        [_image_newsimage updateAsyncImageView];
        _lab_title.frame = CGRectMake(46, 6, self.frame.size.width - 46 - 25, 28);
        _lab_description.numberOfLines = 4;
        _lab_description.frame = CGRectMake(128, 34+move_down_space, self.frame.size.width - 128-25, 66);
        
    }
    else{
//        _image_VisitIcon.frame = CGRectMake(50, self.frame.size.height - 13-13+move_down_space, 11, 11);
//        _lab_VisitVolume.frame = CGRectMake(50+14, self.frame.size.height - 32+move_down_space, 60, 22);
//        
//        _lab_newsType.frame = CGRectMake(self.frame.size.width - 108, self.frame.size.height - 32+move_down_space, 180, 22);
//        
        
//        _labContainbackground.image = [UIImage imageNamed:@"box2.png"];
//        _labContainbackground.frame = CGRectMake(6, 0, self.frame.size.width - 12, self.frame.size.height-12);
        _image_newsimage.alpha = 0.0f;
        _lab_title.frame = CGRectMake(50, 4, self.frame.size.width - 50 - 25, 28);
        _lab_description.numberOfLines = 3;
        _lab_description.frame = CGRectMake(50, 28+move_down_space, self.frame.size.width - 50-25, 52);
        
    }
    
}


-(BOOL)isDownloadPic{
    
    BOOL rest = NO;
    
    if (![[GlobalConfig shareConfig] isSettingDownloadPictureUseing2G_3G]) {
        //NSLog(@"isSettingDownloadPictureUseing2G_3G");
        rest = YES;
        return rest;
    }
    
    if ([[GlobalConfig shareConfig] isDownloadPictureUseing2G_3G]) {
        //NSLog(@"isDownloadPictureUseing2G_3G");
        rest = YES;
    }
    else{
        if (!checkNetworkIsOnlyMobile()) {
            //NSLog(@"checkNetworkIsOnlyMobile yes");
            rest = YES;
        }
        else{
            //NSLog(@"checkNetworkIsOnlyMobile no");
        }
    }
    return rest;
}

//*******************************
+(CGFloat)computCellHeight:(NSObject *)cellData cellWidth:(CGFloat)cellWidth{
     FSOneDayNewsObject *o = (FSOneDayNewsObject *)cellData;
    if (o!=nil) {
        if ([o.picture length]>0) {
            return TODAYNEWSLIST_CELL_WITHEIMAGE_HEIGHT;
        }
        else{
            return TODAYNEWSLIST_CELL_HEIGHT;
        }
    }
    return 44;
}

@end
