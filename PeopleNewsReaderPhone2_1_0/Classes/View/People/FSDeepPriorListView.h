//
//  FSDeepPriorListView.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-12.
//
//

#import <UIKit/UIKit.h>
#import "FSTopicPriorObject.h"

@interface FSDeepPriorListView : UIView {
@private
    UIImageView *_ivPicture;
    UILabel *_lblTitle;
    UILabel *_lblDateTime;
    
    FSTopicPriorObject *_topicPriorObject;
}

@property (nonatomic, retain) FSTopicPriorObject *topicPriorObject;

@end
