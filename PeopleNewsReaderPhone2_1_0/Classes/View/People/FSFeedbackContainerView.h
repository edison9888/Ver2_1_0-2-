//
//  FSFeedbackContainerView.h
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-9-28.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSBaseContainerView.h"


@class FSFeedBackNomalQContentView;

@interface FSFeedbackContainerView : FSBaseContainerView<UITextViewDelegate>{
@protected

    UIImageView *_background2;
   
    
    UIButton *_bt_feedBack;
    UIButton *_bt_nomalQ;
    
    UITextView *_feedbackwords;
    UITextView *_communication;
     
    UILabel *_lab_qq;
    UILabel *_lab_fx;
    UILabel *_lab_com;
    UILabel *_lab_fb;
    
    UIButton *_btn_submit;
    
    NSString *_contact;
    NSString *_message;
    
    FSFeedBackNomalQContentView *_fsFeedBackNomalQContentView;
    BOOL _isFirstShow;
   

}

@property (nonatomic,retain) NSString *contact;
@property (nonatomic,retain) NSString *message;

-(NSString *)getFeedbackMessage;

-(void)reLayoutChiledView:(NSInteger)make;


@end
