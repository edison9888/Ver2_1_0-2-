//
//  FSDeepFloatingTitleView.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-23.
//
//

#import "FSDeepFloatingTitleView.h"

#define LEFT_ARROW_NAVIGATION_WIDTH  24.0f//48.0f
#define RIGHT_ARROW_NAVIGATION_WIDTH 24.0f//48.0f

#define COL_SPACE 8.0f
#define ROW_SPACE 12.0f

#define TOP_SPACE 8.0f
#define BOTTOM_SPACE 8.0f


@implementation FSDeepFloatingTitleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _backGround = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Deep_yinying.png"]];
//        _backGround.alpha = 0.0f;
//        [self addSubview:_backGround];
        
        
        _title_leftImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        _title_leftImage.image = [UIImage imageNamed:@"Deep_coverline.png"];
        [self addSubview:_title_leftImage];
        
        _title_rightImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        _title_rightImage.image = [UIImage imageNamed:@"Deep_coverline.png"];
        //[self addSubview:_title_rightImage];
        
        
        _lblTitle = [[UILabel alloc] initWithFrame:CGRectZero];
        [_lblTitle setBackgroundColor:[UIColor clearColor]];
        [_lblTitle setNumberOfLines:3];
        [_lblTitle setFont:[UIFont boldSystemFontOfSize:14.0f]];
        [_lblTitle setTextColor:[UIColor blackColor]];
        _lblTitle.textAlignment = UITextAlignmentCenter;
        [self addSubview:_lblTitle];
        
        
        _lblDateTime = [[UILabel alloc] initWithFrame:CGRectZero];
        [_lblDateTime setBackgroundColor:[UIColor clearColor]];
        [_lblDateTime setFont:[UIFont boldSystemFontOfSize:12.0f]];
        [_lblDateTime setTextColor:[UIColor whiteColor]];
        _lblDateTime.textAlignment = UITextAlignmentRight;
        //[self addSubview:_lblDateTime];
        
//        self.backgroundColor = [UIColor colorWithRed:75.0f / 255.0f green:75.0f / 255.0f blue:75.0f / 255.0f alpha:0.85f];
//        self.layer.shadowColor = [UIColor blackColor].CGColor;
//        self.layer.shadowOffset = CGSizeMake(0.0f, -3.0f);
//        self.layer.shadowOpacity = 0.0f;

        self.userInteractionEnabled = NO;
    }
    return self;
}


-(void)dealloc{
    [_backGround release];
    [_lblTitle release];
    [_lblDateTime release];
    [_title_rightImage release];
    [_title_leftImage release];
    [super dealloc];
}

- (void)setTitle:(NSString *)titleValue withDateTime:(NSString *)dateTimeValue {
    _lblTitle.text = titleValue;
    _lblDateTime.text = dateTimeValue;
    
    _backGround.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
    
    CGFloat clientWith = self.frame.size.width - LEFT_ARROW_NAVIGATION_WIDTH - RIGHT_ARROW_NAVIGATION_WIDTH;
    CGFloat clientHeight = self.frame.size.height;
    
    CGSize dateTimeSize = [_lblDateTime.text sizeWithFont:_lblDateTime.font];
    
    
    CGSize titleSize = [_lblTitle.text sizeWithFont:_lblTitle.font
                                  constrainedToSize:CGSizeMake(clientWith, clientHeight - dateTimeSize.height)
                                      lineBreakMode:_lblTitle.lineBreakMode];
    
    CGFloat rowSpace = (clientHeight - titleSize.height - dateTimeSize.height) / 3.0f;
    
    CGFloat top = rowSpace;
    _lblDateTime.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
    
    top += (dateTimeSize.height + rowSpace);
    _lblTitle.frame = CGRectMake(0.0f, 6.0f, self.frame.size.width, self.frame.size.height);
    
    
    _title_leftImage.frame = CGRectMake((self.frame.size.width-_title_leftImage.image.size.width)/2, (self.frame.size.height-_title_leftImage.image.size.height)/2+titleSize.height, _title_leftImage.image.size.width, _title_leftImage.image.size.height);
    
    _title_rightImage.frame = CGRectMake(self.frame.size.width-(self.frame.size.width-titleSize.width)/2+2, (self.frame.size.height-_title_rightImage.image.size.height)/2, _title_rightImage.image.size.width, _title_rightImage.image.size.height);
}

@end
