//
//  FSNewsContainerViewController.h
//  PeopleNewsReaderPhone
//
//  Created by Xu dandan on 12-10-25.
//
//

#import <UIKit/UIKit.h>
#import "FSBaseDataViewController.h"
#import "FSNewsContainerView.h"
//新浪微博
#import "WBEngine.h"
#import "WBSendView.h"
#import "WBLogInAlertView.h"
#import "FS_GZF_NewsContainerDAO.h"
#import <MessageUI/MessageUI.h>



@class FSOneDayNewsObject,FSFocusTopObject,FSMyFaverateObject,FS_GZF_NewsContainerDAO,FS_GZF_CommentListDAO,FS_GZF_NewsCommentPOSTXMLDAO;

@class FSShareIconContainView,FSShareNoticView;

@interface FSNewsContainerViewController : FSBaseDataViewController<FSBaseContainerViewDelegate,UIActionSheetDelegate,WBEngineDelegate,WBSendViewDelegate,UIGestureRecognizerDelegate,MFMailComposeViewControllerDelegate>{
@protected
    
    FSMyFaverateObject *_FavObj;
    FSOneDayNewsObject *_obj;
    FSFocusTopObject *_FCObj;
    
    FSNewsContainerView *_fsNewsContainerView;
    
    FSShareIconContainView *_fsShareIconContainView;
    FSShareNoticView *_fsShareNoticView;
    
    FS_GZF_NewsContainerDAO *_fs_GZF_NewsContainerDAO;
    FS_GZF_CommentListDAO *_fs_GZF_CommentListDAO;
    FS_GZF_NewsCommentPOSTXMLDAO *_fs_GZF_NewsCommentPOSTXMLDAO;
    
    //新浪微博
    WBEngine *_sinaWBEngine;
    
    BOOL _isNewNavigation;
    UINavigationBar *_navTopBar;
    
    NewsSourceKind _newsSourceKind;
    
    NSString *_newsID;
}

@property (nonatomic, retain) WBEngine *sinaWBEngine;
@property (nonatomic, retain) FSOneDayNewsObject *obj;
@property (nonatomic, retain) FSMyFaverateObject *FavObj;
@property (nonatomic, retain) FSFocusTopObject *FCObj;
@property (nonatomic, retain) NSString *newsID;
@property (nonatomic,assign) BOOL isNewNavigation;
@property (nonatomic,assign) NewsSourceKind newsSourceKind;


-(void)share;
-(void)commentUpdata:(NSString *)content;

-(void)ShareInSinaMicroBlog;
- (void)sendShareSinaWeibo;

- (void)sendShareWeiXin;

-(void)swipeUpAction;
-(void)swipeDownAction;

-(void)showCommentList;

-(void)fav;

-(NSString *)shareContent;

-(NSObject *)ObjIsInFaverate;

@end
