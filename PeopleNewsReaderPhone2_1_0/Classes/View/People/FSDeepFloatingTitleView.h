//
//  FSDeepFloatingTitleView.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-23.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface FSDeepFloatingTitleView : UIView {
@private
    UIImageView *_backGround;
    
    UIImageView *_title_leftImage;
    UIImageView *_title_rightImage;
    
    
    UILabel *_lblTitle;
    UILabel *_lblDateTime;
}

- (void)setTitle:(NSString *)titleValue withDateTime:(NSString *)dateTimeValue;

@end
