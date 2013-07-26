//
//  FSTodayNewsListCell.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-7-31.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSTodayNewsListCell.h"
#import "FSCellImagesObject.h"

@implementation FSTodayNewsListCell

@synthesize images = _images;
@synthesize withoutImage = _withoutImage;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}


-(void)doSomethingAtDealloc{
    [_lab_NewsTitle release];
    [_lab_NewsDescription release];
    [_lab_NewsType release];
    [_lab_VisitVolume release];
    [_lab_ImageNumber release];
    [_image_Footprint release];
    [_image_ImageIcon release];
    [_imageScrContentView release];
    
}


-(void)doSomethingAtInit{
    
    _lab_NewsTitle = [[UILabel alloc] init];
    _lab_NewsDescription = [[UILabel alloc] init];
    _lab_NewsType = [[UILabel alloc] init];
    _lab_VisitVolume = [[UILabel alloc] init];
    _lab_ImageNumber = [[UILabel alloc] init];
    
    _image_Footprint = [[UIImageView alloc] init];
    _image_ImageIcon = [[UIImageView alloc] init];
    
    
    _imageScrContentView = [[FSImageScrContentView alloc] init];
    _imageScrContentView.parentDelegate = self;
    
    [self.contentView addSubview:_lab_NewsTitle];
    [self.contentView addSubview:_lab_NewsDescription];
    [self.contentView addSubview:_lab_NewsType];
    [self.contentView addSubview:_lab_VisitVolume];
    [self.contentView addSubview:_lab_ImageNumber];
    
    [self.contentView addSubview:_image_Footprint];
    [self.contentView addSubview:_image_ImageIcon];
    [self.contentView addSubview:_imageScrContentView];
    
    _lab_NewsTitle.backgroundColor = COLOR_CLEAR;
    _lab_NewsTitle.textColor = COLOR_NEWSLIST_TITLE;
    _lab_NewsTitle.textAlignment = UITextAlignmentLeft;
    _lab_NewsTitle.numberOfLines = 1;
    _lab_NewsTitle.font = [UIFont systemFontOfSize:TODAYNEWSLIST_TITLE_FONT];
    
    _lab_NewsDescription.backgroundColor = COLOR_CLEAR;
    _lab_NewsDescription.textColor = COLOR_NEWSLIST_TITLE;
    _lab_NewsDescription.textAlignment = UITextAlignmentLeft;
    _lab_NewsDescription.numberOfLines = 3;
    _lab_NewsDescription.font = [UIFont systemFontOfSize:TODAYNEWSLIST_DESCRIPTION_FONT];
    
    _lab_VisitVolume.backgroundColor = COLOR_CLEAR;
    _lab_VisitVolume.textColor = COLOR_NEWSLIST_TITLE;
    _lab_VisitVolume.textAlignment = UITextAlignmentLeft;
    _lab_VisitVolume.numberOfLines = 1;
    _lab_VisitVolume.font = [UIFont systemFontOfSize:LIST_BOTTOM_TEXT_FONT];
    
    _lab_NewsType.backgroundColor = COLOR_CLEAR;
    _lab_NewsType.textColor = COLOR_NEWSLIST_TITLE;
    _lab_NewsType.textAlignment = UITextAlignmentRight;
    _lab_NewsType.numberOfLines = 1;
    _lab_NewsType.font = [UIFont systemFontOfSize:LIST_BOTTOM_TEXT_FONT];
    
    
    _lab_ImageNumber.backgroundColor = COLOR_CLEAR;
    _lab_ImageNumber.textColor = COLOR_NEWSLIST_TITLE;
    _lab_ImageNumber.textAlignment = UITextAlignmentLeft;
    _lab_ImageNumber.numberOfLines = 1;
    _lab_ImageNumber.font = [UIFont systemFontOfSize:LIST_BOTTOM_TEXT_FONT];
    
    _image_Footprint.image = [UIImage imageNamed:@"VisitNumberIcon.png"];
    _image_ImageIcon.image = [UIImage imageNamed:@"VisitNumberIcon.png"];
    
    _images = [[NSMutableArray alloc] init];
    [_images addObject:@"F201208071344309378553653.jpg"];
    [_images addObject:@"F201208071344309378553653.jpg"];
    [_images addObject:@"F201208071344309378553653.jpg"];
    
    
    _imageScrContentView.imageSize = CGSizeMake(TODAYNEWSLIST_IMAGESIZE_WIDTH, TODAYNEWSLIST_IMAGESIZE_HEIGHT);
    
    _withoutImage = YES;
    
    
}

-(void)setDayPattern:(BOOL)is_day{
    NSLog(@"setDayPattern"); 
}


-(void)doSomethingAtLayoutSubviews{
    if ([_data isKindOfClass:[FSCellImagesObject class]]) {
        FSCellImagesObject *o = (FSCellImagesObject *)_data;
        if ([o.channel_icons count]>0) {
            [_images removeAllObjects];
            [_images addObjectsFromArray:o.channel_icons];
            _withoutImage = NO;
        }
        
    }
    CGFloat y= LIST_TOP_INDENT;
    _lab_NewsTitle.frame = CGRectMake(TODAYNEWSLIST_TABLEVIEWCELL_LEFT_INDENT, y, _cellShouldWidth-TODAYNEWSLIST_TABLEVIEWCELL_LEFT_INDENT*2, TODAYNEWSLIST_CELL_TITLE_HEIGHT);
    y = y + TODAYNEWSLIST_CELL_TITLE_HEIGHT+LIST_TOP_INDENT;
    _lab_NewsDescription.frame = CGRectMake(TODAYNEWSLIST_TABLEVIEWCELL_LEFT_INDENT, y, _cellShouldWidth-TODAYNEWSLIST_TABLEVIEWCELL_LEFT_INDENT*2, TODAYNEWSLIST_CELL_DESCRIPTION_HEIGHT);
    y = y + TODAYNEWSLIST_CELL_DESCRIPTION_HEIGHT;
    
    if (_withoutImage) {
        _image_ImageIcon.frame = CGRectMake(_cellShouldWidth - 85, y, LIST_BOTTOM_WIDTH, LIST_BOTTOM_HEIGHT);
        _image_ImageIcon.alpha = 1.0f;
        
        _lab_ImageNumber.frame = CGRectMake(_image_ImageIcon.frame.origin.x + LIST_BOTTOM_WIDTH, y, LIST_BOTTOM_WIDTH, LIST_BOTTOM_HEIGHT);
    }
    else{
        _imageScrContentView.frame = CGRectMake(TODAYNEWSLIST_TABLEVIEWCELL_LEFT_INDENT, y, _cellShouldWidth-TODAYNEWSLIST_TABLEVIEWCELL_LEFT_INDENT, TODAYNEWSLIST_CELL_IMAGES_HEIGHT);
        
        y = y + TODAYNEWSLIST_CELL_IMAGES_HEIGHT;
        _image_ImageIcon.alpha = 0.0f;
        
    }
    
    
    
    _image_Footprint.frame = CGRectMake(TODAYNEWSLIST_TABLEVIEWCELL_LEFT_INDENT, y, LIST_BOTTOM_WIDTH, LIST_BOTTOM_HEIGHT);
    
    
    _lab_VisitVolume.frame = CGRectMake(LIST_LEFT_AND_RIGHT_INDENT+LIST_BOTTOM_WIDTH, y, ROUTINE_NEWS_LIST_TEXT_WIDTH, LIST_BOTTOM_HEIGHT);
    _lab_NewsType.frame = CGRectMake(_cellShouldWidth - 50, y, 36, LIST_BOTTOM_HEIGHT);
    
    _lab_NewsTitle.text = @"新闻标题新闻标题新闻标题新闻标题新闻标题新闻标题"; 
    _lab_NewsDescription.text = @"新闻摘要新闻摘要新闻摘要新闻摘要新闻摘要新闻摘要新闻摘要新闻摘要新闻摘要新闻摘要新闻摘要新闻摘要";
    
    _lab_VisitVolume.text = @"33";
    _lab_NewsType.text = @"专题";
    _lab_ImageNumber.text = @"3";
    
    if (!_withoutImage){
        [_imageScrContentView setImages:_images spacing:6];
    }
}


+(CGFloat)getCellHeight{
    
    return TODAYNEWSLIST_CELL_HEIGHT;
}


-(void)touchImageInside:(FSImageScrContentView *)sender withImageURLString:(NSString *)imageURLString withImageLocalPath:(NSString *)imageLocalPath imageID:(NSString *)imageID{
    NSLog(@"FSChannelListForNewsCellFSChannelListForNewsCell touchImageInside");
    if ([self.parentDelegate respondsToSelector:@selector(tableViewCellPictureTouched:withImageURLString:withImageLocalPath:imageID:)]) {
        [self.parentDelegate tableViewCellPictureTouched:self withImageURLString:imageURLString withImageLocalPath:imageLocalPath imageID:imageID];
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
