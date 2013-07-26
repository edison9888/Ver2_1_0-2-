//
//  FSDeepOuterView.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-8.
//
//

#import "FSDeepOuterView.h"
#import "FSCommonFunction.h"


#define FSDEEP_OUTER_LEFT_RIGHT_SPACE 12.0f
#define FSDEEP_OUTER_TOP_BOTTOM_SPACE 0.0f
#define FSDEEP_OUTER_ROW_SPACE 4.0f

#define TOP_IMAGE_HEIGHT 90.0f
#define TITLE_BACKGROUND_HEIGHT 40.0f

@interface FSDeepOuterView()
- (void)inner_Layout;
@end

@implementation FSDeepOuterView
@synthesize outerObject = _outerObject;
@synthesize clientHeight = _clientHeight;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _topimage = [[UIImageView alloc] initWithFrame:CGRectZero];
        _titlebackground = [[UIImageView alloc] initWithFrame:CGRectZero];
        _titlebackground.image = [UIImage imageNamed:@"deep_titleBGR.png"];
        _lineImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        _lineImage.image = [UIImage imageNamed:@"deep_fengexian.png"];
        
        [self addSubview:_topimage];
        [self addSubview:_titlebackground];
        [self addSubview:_lineImage];
        
        
        
        
        
        _lblSubjectTitle = [[UILabel alloc] initWithFrame:CGRectZero];
        [_lblSubjectTitle setBackgroundColor:[UIColor clearColor]];
        [_lblSubjectTitle setFont:[UIFont boldSystemFontOfSize:20.0f]];
        [_lblSubjectTitle setNumberOfLines:3];
        _lblSubjectTitle.textAlignment = UITextAlignmentCenter;
        [self addSubview:_lblSubjectTitle];
        
        _lblTitle = [[UILabel alloc] initWithFrame:CGRectZero];
        [_lblTitle setBackgroundColor:[UIColor clearColor]];
        [_lblTitle setFont:[UIFont boldSystemFontOfSize:18.0f]];
        [_lblTitle setNumberOfLines:3];
        [self addSubview:_lblTitle];
        
        _lblLeadContent = [[UILabel alloc] initWithFrame:CGRectZero];
        [_lblLeadContent setBackgroundColor:[UIColor clearColor]];
        [_lblLeadContent setFont:[UIFont systemFontOfSize:16.0f]];
        [_lblLeadContent setNumberOfLines:99];
        [self addSubview:_lblLeadContent];
        
        _clientHeight = 240.0f;

    }
    return self;
}

- (void)dealloc {
    [_lblLeadContent release];
    [_lblTitle release];
    [_lblSubjectTitle release];
    [_outerObject release];
    
    [_topimage release];
    [_titlebackground release];
    [_lineImage release];
    
    [super dealloc];
}

- (void)setFrame:(CGRect)value {
    BOOL needLayout = CGSizeEqualToSize(self.frame.size, value.size);
    [super setFrame:value];
    if (needLayout) {
        [self inner_Layout];
    }
}

- (void)setOuterObject:(FSDeepOuterObject *)value {
    if (value != _outerObject) {
        [_outerObject release];
        _outerObject = [value retain];
        [self downloadImages];
        [self inner_Layout];
    }
}



- (void)inner_Layout {
    if (!_outerObject) {
        return;
    }
    CGFloat clientWidth = self.frame.size.width - FSDEEP_OUTER_LEFT_RIGHT_SPACE * 2.0f;
    CGFloat top = FSDEEP_OUTER_TOP_BOTTOM_SPACE;
    CGSize sizeTmp = CGSizeZero;
    //STEP 1.
    
    if (_topimage.image!=nil) {
        _topimage.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, TOP_IMAGE_HEIGHT);
        
        top = top+TOP_IMAGE_HEIGHT;
    }
    
    _titlebackground.frame = CGRectMake(0.0f, top, self.frame.size.width, TITLE_BACKGROUND_HEIGHT);
    
    
    _lblSubjectTitle.text = _outerObject.subjectTile;
    _lblSubjectTitle.frame = _titlebackground.frame;
    
//    sizeTmp = [_lblSubjectTitle.text sizeWithFont:_lblSubjectTitle.font
//                                constrainedToSize:CGSizeMake(clientWidth, 8192)
//                                    lineBreakMode:_lblSubjectTitle.lineBreakMode];
//    
//    _lblSubjectTitle.frame = CGRectMake((self.frame.size.width - sizeTmp.width) / 2.0f,
//                                        top,
//                                        sizeTmp.width,
//                                        sizeTmp.height);
    
    top = top+TITLE_BACKGROUND_HEIGHT + FSDEEP_OUTER_ROW_SPACE;
    
    //STEP 2.
    _lblTitle.text = _outerObject.leadTitle;
    sizeTmp = [_lblTitle.text sizeWithFont:_lblTitle.font
                         constrainedToSize:CGSizeMake(clientWidth, 8192)
                             lineBreakMode:_lblTitle.lineBreakMode];
    _lblTitle.frame = CGRectMake((self.frame.size.width - sizeTmp.width) / 2.0f,
                                 top,
                                 sizeTmp.width,
                                 sizeTmp.height);
    
    top += (sizeTmp.height + FSDEEP_OUTER_ROW_SPACE);
    
    _lineImage.frame = CGRectMake(FSDEEP_OUTER_LEFT_RIGHT_SPACE,top, self.frame.size.width-FSDEEP_OUTER_LEFT_RIGHT_SPACE*2, 2);
    
    top += (2 + FSDEEP_OUTER_ROW_SPACE);
    
    //STEP 3.
    _lblLeadContent.text = _outerObject.leadContent;
    sizeTmp = [_lblLeadContent.text sizeWithFont:_lblLeadContent.font
                               constrainedToSize:CGSizeMake(clientWidth, 8192)
                                   lineBreakMode:_lblLeadContent.lineBreakMode];
    
    _lblLeadContent.frame = CGRectMake((self.frame.size.width - sizeTmp.width) / 2.0f,
                                       top,
                                       sizeTmp.width,
                                       sizeTmp.height);
    
    top += (sizeTmp.height + FSDEEP_OUTER_ROW_SPACE);
    
    _clientHeight = top + 24.0f;
    
    FSLog(@"subjectitlte:%@", _lblSubjectTitle.text);
    FSLog(@"title:%@", _lblTitle.text);
    FSLog(@"leadContent:%@", _lblLeadContent.text);
}

//downloadImages
//******************************
-(void)downloadImages{
    
    NSString *loaclFile = getFileNameWithURLString(_outerObject.subjectPic, getCachesPath());
    if (![[NSFileManager defaultManager] fileExistsAtPath:loaclFile]) {
        [FSNetworkData networkDataWithURLString:_outerObject.subjectPic withLocalStoreFileName:loaclFile withDelegate:self];
    }
    else{
        UIImage *imageOri = [UIImage imageWithContentsOfFile:loaclFile];
        if (imageOri!=nil) {
            _topimage.image = imageOri;
        }
    }
    
}

-(void)networkDataDownloadDataComplete:(FSNetworkData *)sender isError:(BOOL)isError data:(NSData *)data{
    UIImage *imageOri = [[UIImage alloc] initWithData:data];
    _topimage.image = imageOri;
    [imageOri release];
    [self inner_Layout];
    [self sendTouchEvent];
}

@end
