//
//  FSDeepPriorListView.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-12.
//
//

#import "FSDeepPriorListView.h"
#import "FSCommonFunction.h"
#import "FSHTTPWebExData.h"

#define FSDEEP_PRIOR_LIST_LEFT_RIGHT_SPACE 12.0f
#define FSDEEP_PRIOR_LIST_TOP_BOTTOM_SPACE 24.0f
#define FSDEEP_PRIOR_ROW_SPACE 10.0f

@interface FSDeepPriorListView()
- (void)inner_Layout;
@end

@implementation FSDeepPriorListView
@synthesize topicPriorObject = _topicPriorObject;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _ivPicture = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_ivPicture];
        
        _lblTitle = [[UILabel alloc] initWithFrame:CGRectZero];
        [_lblTitle setBackgroundColor:[UIColor clearColor]];
        [_lblTitle setFont:[UIFont boldSystemFontOfSize:18.0f]];
        [_lblTitle setTextColor:[UIColor whiteColor]];
        [_lblTitle setNumberOfLines:3];
        [self addSubview:_lblTitle];
        
        _lblDateTime = [[UILabel alloc] initWithFrame:CGRectZero];
        [_lblDateTime setBackgroundColor:[UIColor clearColor]];
        [_lblDateTime setFont:[UIFont boldSystemFontOfSize:18.0f]];
        [_lblDateTime setTextColor:[UIColor whiteColor]];
        [self addSubview:_lblDateTime];

        
    }
    return self;
}

- (void)dealloc {
    [_topicPriorObject release];
    [_ivPicture release];
    [_lblTitle release];
    [_lblDateTime release];
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
        FSLog(@"priorPicture:%@", _topicPriorObject.pictureLink);
        NSString *picPath = getFileNameWithURLString(_topicPriorObject.pictureLink, getCachesPath());
        if ([[NSFileManager defaultManager] fileExistsAtPath:picPath]) {
            UIImage *image = [[UIImage alloc] initWithContentsOfFile:picPath];
            _ivPicture.image = image;
            [image release];
        } else {
            [FSHTTPWebExData HTTPGetDataWithURLString:_topicPriorObject.pictureLink blockCompletion:^(NSData *data, BOOL success) {
                if (success) {
                    BOOL isImage = NO;
                    UIImage *image = [[UIImage alloc] initWithData:data];
                    _ivPicture.image = image;
                    isImage = (image != nil);
                    [image release];
                    
                    [self inner_Layout];
                    
                    if (isImage) {
                        dispatch_queue_t saveQueue = dispatch_queue_create(NULL, NULL);
                        dispatch_async(saveQueue, ^{
                            [data writeToFile:picPath atomically:YES];
                        });
                        dispatch_release(saveQueue);
                    }

                }
            }];
        }
        
        [self inner_Layout];
    }
}

- (void)inner_Layout {
    if (!_topicPriorObject) {
        return;
    }
    
    CGSize sizeTmp = CGSizeZero;
    
    
    //STEP 1.
    if (_ivPicture.image) {
        sizeTmp = scalImageSizeInSize(_ivPicture.image, CGSizeMake(self.frame.size.width, self.frame.size.height));
        _ivPicture.frame = CGRectMake((self.frame.size.width - sizeTmp.width) / 2.0f,
                                      (self.frame.size.height - sizeTmp.height) / 2.0f,
                                      sizeTmp.width,
                                      sizeTmp.height);
    }
    FSLog(@"_ivPicture:%@", NSStringFromCGRect(_ivPicture.frame));
    //STEP 2.
    _lblTitle.text = _topicPriorObject.title;

    CGFloat clientWith = self.frame.size.width - FSDEEP_PRIOR_LIST_LEFT_RIGHT_SPACE * 2.0f;
    CGFloat top = 0.0f;
    sizeTmp = [_lblDateTime.text sizeWithFont:_lblDateTime.font];
    top = self.frame.size.height - FSDEEP_PRIOR_LIST_TOP_BOTTOM_SPACE - sizeTmp.height;
    _lblDateTime.frame = CGRectMake(FSDEEP_PRIOR_LIST_LEFT_RIGHT_SPACE,
                                    top,
                                    sizeTmp.width,
                                    sizeTmp.height);
    
    //STEP 3.
    sizeTmp = [_lblTitle.text sizeWithFont:_lblTitle.font
                         constrainedToSize:CGSizeMake(clientWith, 8192)
                             lineBreakMode:_lblTitle.lineBreakMode];
    
    
    top -= (FSDEEP_PRIOR_ROW_SPACE + sizeTmp.height);
    _lblTitle.frame = CGRectMake((self.frame.size.width - sizeTmp.width) / 2.0f,
                                 top,
                                 sizeTmp.width,
                                 sizeTmp.height);
    
}

@end
