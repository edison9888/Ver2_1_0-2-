//
//  FSDeepLeadView.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-30.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "FSDeepLeadObject.h"

@interface FSDeepLeadView : UIView {
@private
    UIImageView *_ivLeadPic;
    UILabel *_lblDeepTitle;
    
    UILabel *_lblTitle;
    UILabel *_lblLeadContent;
    
    UIImageView *_gradentView;
    CAGradientLayer *_deepTitleLayer;
    
    FSDeepLeadObject *_deepLeadObject;
    NSString *_defaultPicture;
}

@property (nonatomic, retain) FSDeepLeadObject *deepLeadObject;
@property (nonatomic, retain) NSString *defaultPicture;

@end
