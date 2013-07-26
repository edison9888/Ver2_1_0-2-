//
//  FSNewsDitailToolBar.h
//  PeopleNewsReaderPhone
//
//  Created by Xu dandan on 12-10-31.
//
//

#import <UIKit/UIKit.h>
#import "FSBaseContainerView.h"
#import "HPGrowingTextView.h"


typedef  enum _TouchEvenKind{
    TouchEvenKind_FontSizeChange,//字体大小改变
    TouchEvenKind_FontSelect,//字体大小选择
    TouchEvenKind_FaverateSelect,//收藏
    TouchEvenKind_CommentSelect,//评论
    TouchEvenKind_Commentsend,//分享
    TouchEvenKind_ShareSelect,//分享
    TouchEvenKind_ScrollUp,//上滑
    TouchEvenKind_ScrollDown,//下滑
    TouchEvenKind_PopCommentList//下滑
} TouchEvenKind;


@interface FSNewsDitailToolBar : FSBaseContainerView<HPGrowingTextViewDelegate>{
@protected
    UIImageView *_toolbarBackground;
    UIImageView *_fontSelectBackground;
    UIImageView *_favNoticBackground;
    
    UIButton *_bt_faverate;
    UIButton *_bt_font;
    UIButton *_bt_comment;
    UIButton *_bt_share;
    
    
    UIButton *_bt_font_0;
    
    UIButton *_bt_font_1;
    
    UIButton *_bt_font_2;
    
    UIButton *_bt_font_3;
    
    BOOL _fontToolBarIsShow;
    TouchEvenKind _touchEvenKind;
    
    HPGrowingTextView *_growingText;
    
    UIImageView *_gtv_backgroundTop;
    UIImageView *_gtv_backgroundMin;
    UIImageView *_gtv_backgroundBt;
    
    UIButton *_sendBT;
    
    NSString *_comment_content;
    
    BOOL _isInFaverate;
    
    UIButton *_backgroundBT;
    
    UILabel *_lab_favNotic;
    
    
}

@property (nonatomic,retain) NSString *comment_content;

@property (nonatomic,assign) TouchEvenKind touchEvenKind;

@property (nonatomic,assign) BOOL isInFaverate;
@property (nonatomic,assign) BOOL fontToolBarIsShow;


-(void)fontToolBarCtr;
-(void)favNoticBar;

@end
