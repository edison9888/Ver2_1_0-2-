//
//  FSNewsCommentListCell.h
//  PeopleNewsReaderPhone
//
//  Created by Xu dandan on 12-11-2.
//
//

#import <UIKit/UIKit.h>
#import "FSTableViewCell.h"

@interface FSNewsCommentListCell : FSTableViewCell{
@protected
    UIImageView *_cellBackground;
    UIImageView *_talkimage;
    UIImageView *_commViewBGR;
    
    UILabel *_lab_nickname;
    UILabel *_lab_content;
    UILabel *_lab_timestamp;
    
    UILabel *_lab_Admin;
    UILabel *_lab_AdminContent;
    UILabel *_lab_AdminTimestamp;
    
}

@end
