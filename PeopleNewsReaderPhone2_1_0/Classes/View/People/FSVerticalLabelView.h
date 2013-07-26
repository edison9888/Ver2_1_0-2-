//
//  FSVerticalLabelView.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-7.
//
//

#import <UIKit/UIKit.h>
#import "FSVerticalLayoutView.h"

@interface FSVerticalLabelView : FSVerticalLayoutView {
@private
    UILabel *_lblContent;
}

- (void)setFont:(UIFont *)value;
- (void)setNumberOfLines:(NSInteger)value;


@end
