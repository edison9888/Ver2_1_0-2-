//
//  FSNewsContainerView.h
//  PeopleNewsReaderPhone
//
//  Created by Xu dandan on 12-10-26.
//
//

#import <UIKit/UIKit.h>
#import "FSBaseContainerView.h"

#import "FSNewsContainerWebView.h"
//#import "FSNewsContainerCommentListView.h"
#import "FSNewsDitailToolBar.h"


@interface FSNewsContainerView : FSBaseContainerView <UIGestureRecognizerDelegate,FSBaseContainerViewDelegate,UIScrollViewDelegate>{
@protected
    FSNewsContainerWebView *_fsNewsContainerWebView;
    //FSNewsContainerCommentListView *_fsNewsContainerCommentListView;
    
    FSNewsDitailToolBar *_fsNewsDitailToolBar;
    
    
    //UIScrollView *_scrollView;
    TouchEvenKind _touchEvenKind;
    NSString *_comment_content;
    CGFloat _oldContentOfset;
    
    BOOL _isFirstShow;
    
    BOOL _isInFaverate;
    
    BOOL _isFullScream;
    
}

@property (nonatomic,assign) TouchEvenKind touchEvenKind;
@property (nonatomic,retain) NSString *comment_content;
@property (nonatomic,assign) BOOL isInFaverate;
@property (nonatomic,assign) BOOL isFirstShow;
@property (nonatomic,assign) BOOL isFullScream;

-(CGFloat)getCommentListHeight;

-(void)showViewDelate;

-(void)didReciveComment:(NSArray *)CommentArray;

@end
