//
//  FSDeepPictureView.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-7.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "FSDeepPictureObject.h"

@interface FSDeepPictureView : UIView {
@private
    FSDeepPictureObject *_deepPictureObject;
    UIScrollView *_svContainer;
    UIImageView *_ivPicture;
    UIImageView *_ivPictureCover;
    UILabel *_lblPicture;
    
    CGFloat _bottomControlHeight;
}

@property (nonatomic, retain) FSDeepPictureObject *deepPictureObject;
@property (nonatomic) CGFloat bottomControlHeight;

@end
