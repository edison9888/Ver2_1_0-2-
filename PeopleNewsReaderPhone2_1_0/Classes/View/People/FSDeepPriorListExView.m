//
//  FSDeepPriorListExView.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-15.
//
//

#import "FSDeepPriorListExView.h"
#import "FSCommonFunction.h"
#import "FSHTTPWebExData.h"
#import "FSConst.h"

#define FSDEEP_PRIOR_LIST_LEFT_RIGHT_SPACE 12.0f
#define FSDEEP_PRIOR_LIST_TOP_BOTTOM_SPACE 12.0f
#define FSDEEP_PRIOR_ROW_SPACE 10.0f

@interface FSDeepPriorListExView()
- (void)inner_Layout;
@end

@implementation FSDeepPriorListExView
@synthesize topicPriorObject = _topicPriorObject;
@synthesize indexPath = _indexPath;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //self.backgroundColor = [UIColor yellowColor];
        
        _ivPicture = [[FSAsyncImageView alloc] initWithFrame:CGRectZero];
        _ivPicture.userInteractionEnabled = NO;
        [self addSubview:_ivPicture];
        _ivPicture.backgroundColor = [UIColor clearColor];
        
        _lblTitle = [[UILabel alloc] initWithFrame:CGRectZero];
        [_lblTitle setBackgroundColor:[UIColor clearColor]];
        [_lblTitle setFont:[UIFont boldSystemFontOfSize:18.0f]];
        [_lblTitle setTextColor:COLOR_NEWSLIST_TITLE];
        [_lblTitle setNumberOfLines:3];
        [self addSubview:_lblTitle];
        
        _lblDateTime = [[UILabel alloc] initWithFrame:CGRectZero];
        [_lblDateTime setBackgroundColor:[UIColor clearColor]];
        [_lblDateTime setFont:[UIFont boldSystemFontOfSize:18.0f]];
        [_lblDateTime setTextColor:[UIColor whiteColor]];
        //[self addSubview:_lblDateTime];
        
    }
    return self;
}

- (void)dealloc {
    [_indexPath release];
    [_lblTitle release];
    [_lblDateTime release];
    [_ivPicture release];
    [super dealloc];
}

- (void)setFrame:(CGRect)value {
    BOOL needLayout = CGSizeEqualToSize(self.frame.size, value.size);
    [super setFrame:value];
    if (needLayout) {
        
        [self inner_Layout];
    }
}


- (void)setTopicPriorObject:(FSTopicPriorObject *)value {
    if (value != _topicPriorObject) {
        [_topicPriorObject release];
        _topicPriorObject = [value retain];
        NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:[_topicPriorObject.timestamp doubleValue]];
        _lblDateTime.text = dateToString_YMD(date);
        [date release];

        FSLog(@"_topicLink:%@", _topicPriorObject.pictureLink);
        _ivPicture.localStoreFileName = getFileNameWithURLString(_topicPriorObject.pictureLink, getCachesPath());
        [_ivPicture setUrlString:_topicPriorObject.pictureLink];
        
        [self inner_Layout];
    }
}

- (void)inner_Layout {
    if (!_topicPriorObject) {
        return;
    }
    
    CGSize sizeTmp = CGSizeZero;
    
    //STEP 1.
    _lblTitle.text = _topicPriorObject.title;
    
    CGFloat clientWith = self.frame.size.width - FSDEEP_PRIOR_LIST_LEFT_RIGHT_SPACE * 2.0f;
    CGFloat top = 0.0f;
//    sizeTmp = [_lblDateTime.text sizeWithFont:_lblDateTime.font];
//    top = self.frame.size.height - FSDEEP_PRIOR_LIST_TOP_BOTTOM_SPACE - sizeTmp.height;
//    _lblDateTime.frame = CGRectMake(FSDEEP_PRIOR_LIST_LEFT_RIGHT_SPACE,
//                                    top,
//                                    sizeTmp.width,
//                                    sizeTmp.height);
    
    //STEP 3.
    sizeTmp = [_lblTitle.text sizeWithFont:_lblTitle.font
                         constrainedToSize:CGSizeMake(clientWith, 8192)
                             lineBreakMode:_lblTitle.lineBreakMode];
    
    
    top = self.frame.size.height - FSDEEP_PRIOR_LIST_TOP_BOTTOM_SPACE - sizeTmp.height;
    _lblTitle.frame = CGRectMake((self.frame.size.width - sizeTmp.width) / 2.0f,
                                 top,
                                 sizeTmp.width,
                                 sizeTmp.height);
    
    
    //STEP 2.
    //_ivPicture.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
    _ivPicture.frame = CGRectMake(0.0f, FSDEEP_PRIOR_LIST_TOP_BOTTOM_SPACE/2, self.frame.size.width, top- FSDEEP_PRIOR_LIST_TOP_BOTTOM_SPACE);
    [_ivPicture updateAsyncImageView];
    FSLog(@"_ivPicture:%@", NSStringFromCGRect(_ivPicture.frame));
    
}


@end
