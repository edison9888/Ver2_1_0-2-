//
//  FSBlogShareContentView.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-11-8.
//
//

#import <UIKit/UIKit.h>
#import "FSBaseContainerView.h"

@interface FSBlogShareContentView : FSBaseContainerView{
@protected
    UITextView *_tvContent;
    CGFloat _cltHeight;
	CGSize _keyboardSize;
	NSInteger _sendCount;
    
    UIImageView *_imageView;
    
    NSString *_shareContent;
    NSData *_dataContent;
    
    UIButton *_at_button;
    UIButton *_face_button;
}

@property (nonatomic,retain)NSString *shareContent;
@property (nonatomic,retain)NSData *dataContent;

-(NSString *)getShareContent;

-(void)resignalTvContent;

@end
