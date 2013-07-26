//
//  FSDeepView.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-23.
//
//

#import <UIKit/UIKit.h>
#import "FSTopicObject.h"
#import "FSAsyncImageView.h"

@class FSDeepFloatingTitleView;

@interface FSDeepView : UIView {
@private
    
    FSAsyncImageView *_deepImageView;
    FSAsyncImageView *_deepLogoImageView;
    UIImageView *_backGroundImage;
    NSIndexPath *_indexPath;
    
    NSString *_deep_Title;
    
    FSDeepFloatingTitleView *_deepFloattingTitleView;
    UIImageView *_floatingViewBimage;
}

@property (nonatomic, retain) NSIndexPath *indexPath;
@property (nonatomic, retain) NSString *deep_Title;


- (void)setPictureURL:(NSString *)value;
- (void)setLogoPictureURL:(NSString *)value;

@end
