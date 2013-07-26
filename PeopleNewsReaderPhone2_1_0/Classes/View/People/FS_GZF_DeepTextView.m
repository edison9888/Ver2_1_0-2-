//
//  FS_GZF_DeepTextView.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-1-7.
//
//

#import "FS_GZF_DeepTextView.h"
#import "FSCommonFunction.h"

#define TOP_IMAGE_HEIGHT 90.0f
#define TITLE_BACKGROUND_HEIGHT 35.0f
#define FSDEEP_OUTER_LEFT_RIGHT_SPACE 12.0f
#define FSDEEP_OUTER_ROW_SPACE 4.0f


@implementation FS_GZF_DeepTextView

@synthesize title = _title;

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
    //[_backGimage release];
}

-(void)doSomethingAtInit{
    self.backgroundColor = COLOR_NEWSLIST_TITLE_WHITE;
    
//    _backGimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"deep_baground.png"]];
//    [self addSubview:_backGimage];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    _scrollView.delegate = self;
    _scrollView.backgroundColor = [UIColor clearColor];
    [self addSubview:_scrollView];
    

    
}

-(void)doSomethingAtLayoutSubviews{
    
    _contentObject = (FSDeepContentObject *)self.data;
    
    if (_contentObject == nil) {
        return;
    }
    
    //_backGimage.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
    _scrollView.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height-30);
    NSLog(@"doSomethingAtLayoutSubviews:%@",self);
    
    
    _ChildObjects = [[_contentObject.childContent allObjects] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        FSDeepContent_ChildObject *childObj1 = (FSDeepContent_ChildObject *)obj1;
        FSDeepContent_ChildObject *childObj2 = (FSDeepContent_ChildObject *)obj2;
        NSInteger obj1Index = [childObj1.orderIndex intValue];
        NSInteger obj2Index = [childObj2.orderIndex intValue];
        if (obj1Index < obj2Index) {
            return NSOrderedAscending;
        } else if (obj1Index > obj2Index) {
            return  NSOrderedDescending;
        } else {
            return NSOrderedSame;
        }
    }];
    
    
    //NSLog(@"_ChildObjects:%@",_ChildObjects);
    
    
    NSString *loaclFile = getFileNameWithURLString(_contentObject.subjectPic, getCachesPath());
    if (![[NSFileManager defaultManager] fileExistsAtPath:loaclFile]) {
        [FSNetworkData networkDataWithURLString:_contentObject.subjectPic withLocalStoreFileName:loaclFile withDelegate:self];
    }
    else{
        ;
    }
    [self downloadImages];
    [self inner_Layout];
    
}


-(void)inner_Layout{
    CGFloat top=0.0f;
    CGFloat clientWidth = self.frame.size.width - FSDEEP_OUTER_LEFT_RIGHT_SPACE * 2.0f;
    CGSize sizeTmp = CGSizeZero;
    //STEP 1.
    
    NSArray *subViews = [_scrollView subviews];
    for (UIView *v in subViews) {
        [v removeFromSuperview];
    }
    
//    UIImageView *topimage = [[UIImageView alloc] initWithFrame:CGRectZero];
//    topimage.image = [self setImageWithURL:_contentObject.subjectPic];
//    if (topimage.image!=nil) {
//        topimage.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, TOP_IMAGE_HEIGHT);
//        top = top+TOP_IMAGE_HEIGHT;
//        [_scrollView addSubview:topimage];
//    }
//    [topimage release];
    
    
    UIImageView *deep_titleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Deep_TextTitle.png"]];
    deep_titleImage.frame = CGRectMake(0.0f, 4.0f, deep_titleImage.image.size.width, deep_titleImage.image.size.height);
    [_scrollView addSubview:deep_titleImage];
    
    UIImageView *deep_MtitleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Deep_textTitleM.png"]];
    deep_MtitleImage.frame = CGRectMake(0.0f, 4.0f, deep_titleImage.image.size.width, deep_titleImage.image.size.height);
    [_scrollView addSubview:deep_MtitleImage];
    
    
    
    UILabel *labDeepTitle = [[UILabel alloc] init];
    labDeepTitle.backgroundColor = COLOR_CLEAR;
    labDeepTitle.textColor = COLOR_NEWSLIST_TITLE_WHITE;
    labDeepTitle.text = self.title;
    labDeepTitle.font = [UIFont systemFontOfSize:20];
    sizeTmp = [labDeepTitle.text sizeWithFont:labDeepTitle.font
                            constrainedToSize:CGSizeMake(clientWidth, 8192)
                                lineBreakMode:labDeepTitle.lineBreakMode];
    
    
    labDeepTitle.frame = CGRectMake(6.0f, 4.0f, sizeTmp.width, deep_titleImage.image.size.height);
    [_scrollView addSubview:labDeepTitle];
    
    
    
    
    
    if (sizeTmp.width>deep_titleImage.image.size.width-4) {
        deep_titleImage.frame = CGRectMake(sizeTmp.width-deep_titleImage.image.size.width+14, 4.0f, deep_titleImage.image.size.width, deep_titleImage.image.size.height);
        deep_MtitleImage.frame = CGRectMake(0.0f, 4.0f, sizeTmp.width-deep_titleImage.image.size.width+14, deep_titleImage.image.size.height);
    }
    else{
        deep_titleImage.frame = CGRectMake(0, 4.0f, deep_titleImage.image.size.width, deep_titleImage.image.size.height);
        deep_MtitleImage.frame = CGRectZero;
    }
    
    
    [labDeepTitle release];
    [deep_titleImage release];
    [deep_MtitleImage release];

    top = top+ deep_titleImage.image.size.height +16.0f;
    
    //STEP 2.
    UIImageView *titlebackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"deep_textline.png"]];
    titlebackground.frame = CGRectMake(FSDEEP_OUTER_LEFT_RIGHT_SPACE, top, self.frame.size.width-FSDEEP_OUTER_LEFT_RIGHT_SPACE*2, 2);
    [_scrollView addSubview:titlebackground];
    
    UILabel *subjectTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    subjectTitle.textAlignment  = UITextAlignmentCenter;
    subjectTitle.textColor = COLOR_NEWSLIST_TITLE;
    subjectTitle.numberOfLines = 3;
    subjectTitle.font = [UIFont systemFontOfSize:18];
    subjectTitle.backgroundColor = [UIColor clearColor];
    subjectTitle.text = _contentObject.subjectTile;
    [_scrollView addSubview:subjectTitle];
    subjectTitle.frame = CGRectMake(FSDEEP_OUTER_LEFT_RIGHT_SPACE, top, self.frame.size.width-FSDEEP_OUTER_LEFT_RIGHT_SPACE*2, TITLE_BACKGROUND_HEIGHT);
    
    [subjectTitle release];
    [titlebackground release];
    
    
    top = top+TITLE_BACKGROUND_HEIGHT + FSDEEP_OUTER_ROW_SPACE;
    
    //STEP 3.
    
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    lblTitle.textAlignment  = UITextAlignmentCenter;
    lblTitle.textColor = COLOR_NEWSLIST_DESCRIPTION;
    lblTitle.numberOfLines = 3;
    lblTitle.font = [UIFont systemFontOfSize:16];
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.text = _contentObject.title;
    [_scrollView addSubview:lblTitle];
    
    
    
    sizeTmp = [lblTitle.text sizeWithFont:lblTitle.font
                         constrainedToSize:CGSizeMake(clientWidth, 8192)
                             lineBreakMode:lblTitle.lineBreakMode];
    lblTitle.frame = CGRectMake((self.frame.size.width - sizeTmp.width) / 2.0f,
                                 top,
                                 sizeTmp.width,
                                 sizeTmp.height);
    [lblTitle release];
    top += (sizeTmp.height + FSDEEP_OUTER_ROW_SPACE);
    
    
    
    
    //STEP 4.
    
    UIImageView *lineImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"deep_textline.png"]];
    lineImage.frame = CGRectMake(FSDEEP_OUTER_LEFT_RIGHT_SPACE,top, self.frame.size.width-FSDEEP_OUTER_LEFT_RIGHT_SPACE*2, 2);
    [_scrollView addSubview:lineImage];
    [lineImage release];
    top += (2 + FSDEEP_OUTER_ROW_SPACE);
    
    
    //STEP 5.
    
    _ChildObjects = [[_contentObject.childContent allObjects] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        FSDeepContent_ChildObject *childObj1 = (FSDeepContent_ChildObject *)obj1;
        FSDeepContent_ChildObject *childObj2 = (FSDeepContent_ChildObject *)obj2;
        NSInteger obj1Index = [childObj1.orderIndex intValue];
        NSInteger obj2Index = [childObj2.orderIndex intValue];
        if (obj1Index < obj2Index) {
            return NSOrderedAscending;
        } else if (obj1Index > obj2Index) {
            return  NSOrderedDescending;
        } else {
            return NSOrderedSame;
        }
    }];
    
    for (FSDeepContent_ChildObject *childObj in _ChildObjects) {
        //NSLog(@"childObj:%@",childObj);
        if ([childObj.flag intValue] == _pictureFlag) {
            //图片
            UIImageView *topimage = [[UIImageView alloc] initWithFrame:CGRectZero];
            topimage.image = [self setImageWithURL:childObj.content];
            if (topimage.image!=nil) {
                
                CGSize imageSize = scalImageSizeFixWidth(topimage.image, self.frame.size.width-FSDEEP_OUTER_LEFT_RIGHT_SPACE*2);
                
                topimage.frame = CGRectMake(FSDEEP_OUTER_LEFT_RIGHT_SPACE, top, imageSize.width, imageSize.width);
                
                top = top+topimage.image.size.height +FSDEEP_OUTER_ROW_SPACE;
                [_scrollView addSubview:topimage];
            }
            [topimage release];
            
        } else if ([childObj.flag intValue] == _textFlag) {
            //文字
            UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectZero];
            lblTitle.textAlignment  = UITextAlignmentLeft;
            lblTitle.textColor = COLOR_DEEP_TEXT;
            lblTitle.numberOfLines = 199;
            lblTitle.font = [UIFont systemFontOfSize:16];
            lblTitle.backgroundColor = [UIColor clearColor];
            lblTitle.text = childObj.content;
            [_scrollView addSubview:lblTitle];
            
            
            
            sizeTmp = [lblTitle.text sizeWithFont:lblTitle.font
                                constrainedToSize:CGSizeMake(clientWidth, 8192)
                                    lineBreakMode:lblTitle.lineBreakMode];
            lblTitle.frame = CGRectMake((self.frame.size.width - sizeTmp.width) / 2.0f,
                                        top,
                                        sizeTmp.width,
                                        sizeTmp.height);
            [lblTitle release];
            top += (sizeTmp.height + FSDEEP_OUTER_ROW_SPACE);
        }
    }
    
    _clientHeight = top + 24.0f;
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, _clientHeight);
    
}



-(UIImage *)setImageWithURL:(NSString *)URL{
    NSString *loaclFile = getFileNameWithURLString(URL, getCachesPath());
    if ([[NSFileManager defaultManager] fileExistsAtPath:loaclFile]) {
        UIImage *imageOri = [UIImage imageWithContentsOfFile:loaclFile];
        return imageOri;
    }
    else{
        
    }
    return nil;
}


//downloadImages
//******************************
-(void)downloadImages{
    
    for (FSDeepContent_ChildObject *childObj in _ChildObjects) {
        if ([childObj.flag intValue] == _pictureFlag) {
            NSString *loaclFile = getFileNameWithURLString(childObj.content, getCachesPath());
            if (![[NSFileManager defaultManager] fileExistsAtPath:loaclFile]) {
                [FSNetworkData networkDataWithURLString:childObj.content withLocalStoreFileName:loaclFile withDelegate:self];
            }
            else{
                [self inner_Layout];
            }
        }
    }
}

-(void)networkDataDownloadDataComplete:(FSNetworkData *)sender isError:(BOOL)isError data:(NSData *)data{
    NSLog(@"networkDataDownloadDataComplete:%@",self);
    [self inner_Layout];
}




@end
