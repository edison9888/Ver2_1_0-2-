//
//  FSDeepPriorPictureView.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-9.
//
//

#import <UIKit/UIKit.h>

@interface FSDeepPriorPictureView : UIView {
@private
    UIImageView * _ivPicture;
}

- (void)setPictureURLString:(NSString *)value;

@end
