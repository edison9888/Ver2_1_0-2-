//
//  FSDeepOuterView.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-8.
//
//

#import <UIKit/UIKit.h>
#import "FSDeepOuterObject.h"
#import "FSNetworkData.h"
#import "FSBaseContainerView.h"

@interface FSDeepOuterView : FSBaseContainerView <FSNetworkDataDelegate>{
@private
    FSDeepOuterObject *_outerObject;
    
    
    UIImageView *_topimage;
    UIImageView *_titlebackground;
    UIImageView *_lineImage;
    
    UILabel *_lblSubjectTitle;
    UILabel *_lblTitle;
    UILabel *_lblLeadContent;
    CGFloat _clientHeight;
}

@property (nonatomic, retain) FSDeepOuterObject *outerObject;
@property (nonatomic, readonly) CGFloat clientHeight;


-(void)downloadImages;

@end
