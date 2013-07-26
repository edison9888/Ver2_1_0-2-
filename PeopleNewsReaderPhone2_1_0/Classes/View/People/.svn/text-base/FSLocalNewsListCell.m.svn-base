//
//  FSLocalNewsListCell.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-2-4.
//
//

#import "FSLocalNewsListCell.h"
#import "GlobalConfig.h"
#import "FSAsyncImageView.h"
#import "FSCommonFunction.h"
#import "FSOneDayNewsObject.h"
#import "FSMyFaverateObject.h"

@implementation FSLocalNewsListCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newslist_beijing.png"]];
        //        self.backgroundView = image;
        //        [image release];
    }
    return self;
}

-(void)doSomethingAtDealloc{
    
    [_lab_NewsTitle release];
    //[_lab_NewsDescription release];
    [_lab_NewsType release];
    //[_lab_VisitVolume release];
    
    //[_image_Footprint release];
    [_image_Onright release];
    
}

-(void)doSomethingAtInit{
    
    _lab_NewsTitle = [[UILabel alloc] init];
    //_lab_NewsDescription = [[UILabel alloc] init];
    _lab_NewsType = [[UILabel alloc] init];
    //_lab_VisitVolume = [[UILabel alloc] init];
    
    //_image_Footprint = [[UIImageView alloc] init];
    _image_Onright = [[FSAsyncImageView alloc] init];
    _image_Onright.imageCuttingKind = ImageCuttingKind_fixrect;
    
    [self.contentView addSubview:_lab_NewsTitle];
    //[self.contentView addSubview:_lab_NewsDescription];
    //[self.contentView addSubview:_lab_VisitVolume];
    [self.contentView addSubview:_lab_NewsType];
    
    //[self.contentView addSubview:_image_Footprint];
    [self.contentView addSubview:_image_Onright];
    
    
    _lab_NewsTitle.backgroundColor = COLOR_CLEAR;
    _lab_NewsTitle.textColor = COLOR_NEWSLIST_TITLE;
    _lab_NewsTitle.textAlignment = UITextAlignmentLeft;
    _lab_NewsTitle.numberOfLines = 1;
    _lab_NewsTitle.font = [UIFont systemFontOfSize:TODAYNEWSLIST_TITLE_FONT];
    
    //    _lab_NewsDescription.backgroundColor = COLOR_CLEAR;
    //    _lab_NewsDescription.textColor = COLOR_NEWSLIST_DESCRIPTION;
    //    _lab_NewsDescription.textAlignment = UITextAlignmentLeft;
    //    _lab_NewsDescription.numberOfLines = 2;
    //    _lab_NewsDescription.font = [UIFont systemFontOfSize:TODAYNEWSLIST_DESCRIPTION_FONT];
    
//    _lab_VisitVolume.backgroundColor = COLOR_CLEAR;
//    _lab_VisitVolume.textColor = COLOR_NEWSLIST_DESCRIPTION;
//    _lab_VisitVolume.textAlignment = UITextAlignmentLeft;
//    _lab_VisitVolume.numberOfLines = 1;
//    _lab_VisitVolume.font = [UIFont systemFontOfSize:LIST_BOTTOM_TEXT_FONT];
    
    _lab_NewsType.backgroundColor = COLOR_CLEAR;
    _lab_NewsType.textColor = COLOR_NEWSLIST_DESCRIPTION;
    _lab_NewsType.textAlignment = UITextAlignmentLeft;
    _lab_NewsType.numberOfLines = 1;
    _lab_NewsType.font = [UIFont systemFontOfSize:LIST_BOTTOM_TEXT_FONT];
    
    //self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

-(void)setDayPattern:(BOOL)is_day{
    NSLog(@"setDayPattern");
}


-(void)doSomethingAtLayoutSubviews{
    
    //_image_Footprint.image = [UIImage imageNamed:@"xin.png"];
    
    if ([self.data isKindOfClass:[FSMyFaverateObject class]]) {
        FSMyFaverateObject *obj = (FSMyFaverateObject *)self.data;
        _lab_NewsTitle.text = obj.title;
        //_lab_NewsDescription.text = obj.news_abstract;
        //_lab_VisitVolume.text = [NSString stringWithFormat:@"%d",[obj.browserCount integerValue]];
        _lab_NewsType.text = [NSString stringWithFormat:@"%@",[self timeTostring:obj.timestamp]];
        
        NSString *defaultDBPath = obj.picture;
        NSString *loaclFile = getFileNameWithURLString(defaultDBPath, getCachesPath());
        _image_Onright.urlString = defaultDBPath;
        _image_Onright.localStoreFileName = loaclFile;
    }
    else{
        FSOneDayNewsObject *obj = (FSOneDayNewsObject *)self.data;
        _lab_NewsTitle.text = obj.title;
        //_lab_NewsDescription.text = obj.news_abstract;
        //_lab_VisitVolume.text = [NSString stringWithFormat:@"%d",[obj.browserCount integerValue]];
        _lab_NewsType.text = [NSString stringWithFormat:@"%@",[self timeTostring:obj.timestamp]];
        
        
        NSString *defaultDBPath = obj.picture;
        NSString *loaclFile = getFileNameWithURLString(defaultDBPath, getCachesPath());
        _image_Onright.urlString = defaultDBPath;
        _image_Onright.localStoreFileName = loaclFile;
    }
    
    
    
    if ([_image_Onright.urlString length]>0 && [self isDownloadPic]) {
        _image_Onright.frame = CGRectMake(10, 10, 75, 52);
        [_image_Onright updateAsyncImageView];
        _image_Onright.alpha = 1.0f;
        
        
        _lab_NewsTitle.frame = CGRectMake(92, 15, self.frame.size.width- 92 - 10, 25);
        //_lab_NewsDescription.frame = CGRectMake(92, 30, self.frame.size.width- 92 - 10, 36);
        
        
//        _image_Footprint.frame = CGRectMake(self.frame.size.width - 72, self.frame.size.height-15 - 12, 12, 12);
//        _lab_VisitVolume.frame = CGRectMake(self.frame.size.width - 60, self.frame.size.height-15 - 12, 60, 12);
        _lab_NewsType.frame = CGRectMake(self.frame.size.width - 66,self.frame.size.height-15 - 12, 160, 12);
        
    }
    else{
        _lab_NewsTitle.frame = CGRectMake(10, 15, self.frame.size.width- 20, 25);
        //_lab_NewsDescription.frame = CGRectMake(10, 30, self.frame.size.width-20, 36);
        
        
        _image_Onright.alpha = 0.0f;
//        _image_Footprint.frame = CGRectMake(self.frame.size.width - 72, self.frame.size.height-15 - 12, 12, 12);
//        _lab_VisitVolume.frame = CGRectMake(self.frame.size.width - 60, self.frame.size.height-15 - 12, 60, 12);
        _lab_NewsType.frame = CGRectMake(self.frame.size.width - 66,self.frame.size.height-15 - 12, 60, 12);
    }
    
}


-(BOOL)isDownloadPic{
    
    BOOL rest = NO;
    
    if (![[GlobalConfig shareConfig] isSettingDownloadPictureUseing2G_3G]) {
        rest = YES;
        return rest;
    }
    
    if ([[GlobalConfig shareConfig] isDownloadPictureUseing2G_3G]) {
        rest = YES;
    }
    else{
        if (!checkNetworkIsOnlyMobile()) {
            rest = YES;
        }
    }
    return rest;
}

-(NSString *)timeTostring:(NSNumber *)time{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[time doubleValue]];
    NSString *hm = dateToString_MDHM(date);
    
    return hm;
}


+(CGFloat)getCellHeight{
    return 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
