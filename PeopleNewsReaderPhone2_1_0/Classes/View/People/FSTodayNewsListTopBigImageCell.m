//
//  FSTodayNewsListTopBigImageCell.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-1.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSTodayNewsListTopBigImageCell.h"
#import "FSCommonFunction.h"
#import "FSOneNewsListTopCellTextFloatView.h"

#import "FSFocusTopObject.h"

#define VISITICON_BEGIN_X 220.0f

@implementation FSTodayNewsListTopBigImageCell

@synthesize typeMark = _typeMark;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
       
    }
    return self;
}

-(void)doSomethingAtDealloc{
    [_fsImagesScrInRowView release];
    [_lab_NewsType release];
//    [_lab_VisitVolume release];
//    [_image_Footprint release];
    //[_fsOneNewsListTopCellTextFloatView release];
    [_lab_VVBackground release];
}



-(void)doSomethingAtInit{
    
//    self.selectionStyle = UITableViewCellSelectionStyleNone;
//    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ChannelSettingViewBGR.png"]];
//    self.backgroundView = image;
//    [image release];
    self.contentView.backgroundColor = COLOR_NEWSLIST_TITLE_WHITE;
    _typeMark = 0;
    
    _lab_VVBackground = [[UILabel alloc] init];
    _lab_VVBackground.backgroundColor = COLOR_CLEAR;
    _lab_VVBackground.alpha = 0.5;
    
    
    _fsImagesScrInRowView = [[FSImagesScrInRowView alloc] init];
    _fsImagesScrInRowView.parentDelegate = self;
    
    _lab_NewsType = [[UILabel alloc] init];
//    _lab_VisitVolume = [[UILabel alloc] init];
//    _image_Footprint = [[UIImageView alloc] init];
    
    //_fsOneNewsListTopCellTextFloatView = [[FSOneNewsListTopCellTextFloatView alloc] init];
    
 
    [self.contentView addSubview:_fsImagesScrInRowView];
    [self.contentView addSubview:_lab_VVBackground];
//    [self.contentView addSubview:_lab_VisitVolume];
    [self.contentView addSubview:_lab_NewsType];
//    [self.contentView addSubview:_image_Footprint];
    //[self.contentView addSubview:_fsOneNewsListTopCellTextFloatView];
    
    
    _lab_NewsType.backgroundColor = COLOR_CLEAR;
    _lab_NewsType.textColor = COLOR_NEWSLIST_TITLE_WHITE;
    _lab_NewsType.textAlignment = UITextAlignmentLeft;
    _lab_NewsType.numberOfLines = 1;
    _lab_NewsType.font = [UIFont systemFontOfSize:14];
    
//    _lab_VisitVolume.backgroundColor = COLOR_CLEAR;
//    _lab_VisitVolume.textColor = COLOR_NEWSLIST_TITLE_WHITE;
//    _lab_VisitVolume.textAlignment = UITextAlignmentLeft;
//    _lab_VisitVolume.numberOfLines = 1;
//    _lab_VisitVolume.font = [UIFont systemFontOfSize:LIST_BOTTOM_TEXT_FONT];
//    
//    _image_Footprint.image = [UIImage imageNamed:@"xin.png"];
//    _image_Footprint.alpha = 0.0;
    
    
}

-(void)setDayPattern:(BOOL)is_day{
    NSLog(@"setDayPattern"); 
}

-(void)setContent{
    
    
 //   _image_Footprint.alpha = 1.0;
    //_fsOneNewsListTopCellTextFloatView.data = @"新闻标题和新闻简介新闻标题和新闻简介的显示位置介新闻标题和新闻简介的显示位置介新闻标题和新闻简介的显示位置";
    if ([_fsImagesScrInRowView.objectList count]>0) {
        FSFocusTopObject *o = [_fsImagesScrInRowView.objectList objectAtIndex:0];
        //_fsOneNewsListTopCellTextFloatView.data = o;
        
//        _lab_VisitVolume.text = [NSString stringWithFormat:@"%d",[o.browserCount integerValue]];
        //NSLog(@"_lab_VisitVolume.text:%@",_lab_VisitVolume.text);
        if ([o.title length]>16) {
            _lab_NewsType.text = [o.title substringToIndex:16];
        }
        else{
            _lab_NewsType.text = o.title;
        }
        
    }

}

-(void)setCellKind{
        

}

-(void)doSomethingAtLayoutSubviews{
    //NSLog(@"FSTodayNewsListTopBigImageCell doSomethingAtLayoutSubviews");
    [self setCellKind];
    //NSLog(@"%@",self);
    _fsImagesScrInRowView.frame = CGRectMake(0, 0, self.frame.size.width, TODAYNEWSLIST_TOP_CELL_HEIGHT);
    _fsImagesScrInRowView.imageSize = CGSizeMake(self.frame.size.width, TODAYNEWSLIST_TOP_CELL_HEIGHT);
    _fsImagesScrInRowView.pageControlViewShow = YES;
    _fsImagesScrInRowView.spacing = 0.0;
    _fsImagesScrInRowView.bottonHeigh = TODAYNEWSLIST_TOP_BOTTOM_HEIGHT;
    _fsImagesScrInRowView.objectList =  (NSArray *)_data;
    
    //_fsOneNewsListTopCellTextFloatView.frame = CGRectMake(0, self.frame.size.height-TODAYNEWSLIST_TOP_BOTTOM_HEIGHT -30, self.frame.size.width, 30);
    
        
//    _image_Footprint.frame = CGRectMake(VISITICON_BEGIN_X-5, self.frame.size.height - 11-9, 11, 11);
//    
//    _lab_VisitVolume.frame = CGRectMake(VISITICON_BEGIN_X+9, self.frame.size.height - TODAYNEWSLIST_TOP_BOTTOM_HEIGHT, self.frame.size.width, TODAYNEWSLIST_TOP_BOTTOM_HEIGHT);
     _lab_NewsType.frame = CGRectMake(4, self.frame.size.height - TODAYNEWSLIST_TOP_BOTTOM_HEIGHT, self.frame.size.width, TODAYNEWSLIST_TOP_BOTTOM_HEIGHT);
   
    _lab_VVBackground.frame = CGRectMake(0, self.frame.size.height - TODAYNEWSLIST_TOP_BOTTOM_HEIGHT, self.frame.size.width, TODAYNEWSLIST_TOP_BOTTOM_HEIGHT);
        
   
    
    [self setContent];
    
}



+(CGFloat)getCellHeight{
    
    return 0;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)fsBaseContainerViewTouchEvent:(FSBaseContainerView *)sender{
    FSImagesScrInRowView *o = (FSImagesScrInRowView *)sender;
    if (o.isMove) {
        //NSLog(@"FSTodayNewsListTopBigImageCell:%d",o.imageIndex);
        if ([_fsImagesScrInRowView.objectList count]>o.imageIndex) {
            FSFocusTopObject *o1 =[(NSArray *)_data objectAtIndex:o.imageIndex];
            
            //_fsOneNewsListTopCellTextFloatView.data = [_fsImagesScrInRowView.objectList objectAtIndex:o.imageIndex];
            
            //_fsOneNewsListTopCellTextFloatView.data = o1;
            
            //_lab_VisitVolume.text = [NSString stringWithFormat:@"%d",[o1.browserCount integerValue]];
            if ([o1.title length]>16) {
                _lab_NewsType.text = [o1.title substringToIndex:16];
            }
            else{
                _lab_NewsType.text = o1.title;
            }
        }
    }
    else{
        NSLog(@"touch");
        if ([_fsImagesScrInRowView.objectList count]>o.imageIndex) {
            if ([_parentDelegate respondsToSelector:@selector(tableViewCellPictureTouched:)]) {
                [_parentDelegate tableViewCellPictureTouched:o.imageIndex];
            }
        }
    }
}

@end
