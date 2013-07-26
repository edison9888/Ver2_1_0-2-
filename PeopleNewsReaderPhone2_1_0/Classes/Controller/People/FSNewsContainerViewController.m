//
//  FSNewsContainerViewController.m
//  PeopleNewsReaderPhone
//
//  Created by Xu dandan on 12-10-25.
//
//

#import "FSNewsContainerViewController.h"
#import "PeopleNewsReaderPhoneAppDelegate.h"

#import "FSNetworkDataManager.h"

#import "FS_GZF_CommentListDAO.h"
#import "FSNewsDitailObject.h"
#import "FSOneDayNewsObject.h"
#import "FSFocusTopObject.h"
#import "NTESNBSMSManager.h"

#import "FSBaseDB.h"
#import "FSMyFaverateObject.h"

#import "FS_GZF_NewsCommentPOSTXMLDAO.h"

#import "FSShareIconContainView.h"
#import "FSShareNoticView.h"

#import "FSPeopleBlogShareViewController.h"
#import "FSNetEaseBlogShareViewController.h"
#import "FSSinaBlogShareViewController.h"

#import "FSCommentListViewController.h"


#define kWBSDKDemoAppKey @"1368810072"
#define kWBSDKDemoAppSecret @"5dd07c1fd64d4e3ba3bef34ec59edfa1"

#define kWBAlertViewLogOutTag 100
#define FSSETTING_VIEW_NAVBAR_HEIGHT 44.0f


@implementation FSNewsContainerViewController

@synthesize sinaWBEngine = _sinaWBEngine;
@synthesize obj = _obj;
@synthesize FCObj = _FCObj;
@synthesize FavObj = _FavObj;
@synthesize isNewNavigation = _isNewNavigation;
@synthesize newsSourceKind = _newsSourceKind;
@synthesize newsID = _newsID;

- (id)init {
    self = [super init];
    if (self) {
        self.isNewNavigation = NO;
        _obj = nil;
        _FCObj = nil;
        _FavObj = nil;
        _newsID = @"";
    }
    return self;
}

- (void)dealloc {
    [_fsShareNoticView release];
    [_fsNewsContainerView release];
    _fs_GZF_CommentListDAO.parentDelegate = NULL;
    [_fs_GZF_CommentListDAO release];
    _fs_GZF_NewsContainerDAO.parentDelegate = NULL;
    [_fs_GZF_NewsContainerDAO release];
    _fs_GZF_NewsCommentPOSTXMLDAO.parentDelegate = NULL;
    [_fs_GZF_NewsCommentPOSTXMLDAO release];
    [_navTopBar release];
    [_fsShareIconContainView release];
    [_sinaWBEngine release];
    
    [_obj release];
    
    [_FCObj release];
   
    [_FavObj release];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SHARE_SUCCESSFUL_NOTICE object:nil];
    
    [super dealloc];
}


-(void)loadChildView{
    
    //[[FSNetworkDataManager shareNetworkDataManager] CancelAllOpration];
    //注册通知
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(shareSuccess:)
												 name:SHARE_SUCCESSFUL_NOTICE object:nil];
     
    
    _navTopBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, FSSETTING_VIEW_NAVBAR_HEIGHT)];
    _navTopBar.alpha = 0.0;
#ifdef __IPHONE_5_0
    [_navTopBar setBackgroundImage:[UIImage imageNamed: @"navigatorBar.png"] forBarMetrics:UIBarMetricsDefault];
#endif
	[self.view addSubview:_navTopBar];
    
    
    _fsNewsContainerView = [[FSNewsContainerView alloc] init];
    _fsNewsContainerView.parentDelegate = self;
    [self.view addSubview:_fsNewsContainerView];
    
    _fsShareIconContainView = [[FSShareIconContainView alloc] initWithFrame:CGRectZero];
    _fsShareIconContainView.parentDelegate = self;
    [self.view addSubview:_fsShareIconContainView];
    
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightAction:)];
    swipeLeft.delegate = self;
    swipeLeft.direction = UISwipeGestureRecognizerDirectionRight;
    [_fsNewsContainerView addGestureRecognizer:swipeLeft];
    [swipeLeft release];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftAction:)];
    swipeRight.delegate = self;
    swipeRight.direction = UISwipeGestureRecognizerDirectionLeft;
    [_fsNewsContainerView addGestureRecognizer:swipeRight];
    [swipeRight release];
    
    
    UIButton *returnBT = [[UIButton alloc] init];
    [returnBT setBackgroundImage:[UIImage imageNamed:@"returnbackBT.png"] forState:UIControlStateNormal];
    //[returnBT setTitle:NSLocalizedString(@"返回", nil) forState:UIControlStateNormal];
    returnBT.titleLabel.font = [UIFont systemFontOfSize:12];
    [returnBT addTarget:self action:@selector(returnBack:) forControlEvents:UIControlEventTouchUpInside];
    [returnBT setTitleColor:COLOR_NEWSLIST_TITLE_WHITE forState:UIControlStateNormal];
    returnBT.frame = CGRectMake(0, 0, 55, 30);
    
    //self.navigationItem.leftBarButtonItem
    
   
    UIBarButtonItem *returnButton = [[UIBarButtonItem alloc] initWithCustomView:returnBT];
    if (self.isNewNavigation) {
        returnBT.frame = CGRectMake(3, 7, 55, 30);
        [_navTopBar addSubview:returnBT];
    }
    else{
        self.navigationItem.leftBarButtonItem = returnButton;
    }
    
    [returnButton release];
    [returnBT release];
    
    _fsShareNoticView = [[FSShareNoticView alloc] init];
    _fsShareNoticView.parentDelegate = self;
    _fsShareNoticView.alpha = 0.0f;
    [self.view addSubview:_fsShareNoticView];
}



-(void)initDataModel{
    _fs_GZF_NewsContainerDAO = [[FS_GZF_NewsContainerDAO alloc] init];
    _fs_GZF_NewsContainerDAO.parentDelegate = self;
    
    _fs_GZF_CommentListDAO = [[FS_GZF_CommentListDAO alloc] init];
    _fs_GZF_CommentListDAO.parentDelegate = self;
    
    _fs_GZF_NewsCommentPOSTXMLDAO = [[FS_GZF_NewsCommentPOSTXMLDAO alloc] init];
    _fs_GZF_NewsCommentPOSTXMLDAO.parentDelegate = self;
}

-(void)doSomethingForViewFirstTimeShow{
    
    if (_obj!=nil) {
        _fs_GZF_NewsContainerDAO.newsid = _obj.newsid;
        _fs_GZF_CommentListDAO.newsid = _obj.newsid;
        _fs_GZF_CommentListDAO.count = @"6";
    }
    else if (_FCObj!=nil) {
        _fs_GZF_NewsContainerDAO.newsid = _FCObj.newsid;
        _fs_GZF_CommentListDAO.newsid =  _FCObj.newsid;
        _fs_GZF_CommentListDAO.count = @"6";
       
    }
    else if (_FavObj!=nil){
        _fs_GZF_NewsContainerDAO.newsid = _FavObj.newsid;
        _fs_GZF_CommentListDAO.newsid = _FavObj.newsid;
        _fs_GZF_CommentListDAO.count = @"6";
    }
    
    if (self.newsSourceKind == NewsSourceKind_PushNews) {
        _fs_GZF_NewsContainerDAO.newsid = self.newsID;
        _fs_GZF_CommentListDAO.newsid = self.newsID;
        _fs_GZF_CommentListDAO.count = @"6";
    }
    
    FSMyFaverateObject *o = (FSMyFaverateObject *)[self ObjIsInFaverate];
    if (o!= nil) {
        _fsNewsContainerView.isInFaverate = YES;
    }
    _fs_GZF_NewsContainerDAO.newsSourceKind = self.newsSourceKind;
    //NSLog(@"doSomethingForViewFirstTimeShowdoSomethingForViewFirstTimeShow");
    [_fs_GZF_NewsContainerDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
    
    if (self.isNewNavigation) {
        _fsNewsContainerView.frame = CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-44);
        _navTopBar.alpha = 1.0;
    }
    else{
        _navTopBar.alpha = 0.0;
        _fsNewsContainerView.frame = self.view.frame;

    }
    _fsShareNoticView.frame = CGRectMake((self.view.frame.size.width - 219)/2, (self.view.frame.size.height-160)/2, 219, 70);
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//    
//    NSInteger k = [self retainCount];
//    for (NSInteger i=0; i<k-2; i++) {
//        [self release];
//    }
//    
    NSLog(@"%@.viewDidDisappear:%d",self,[self retainCount]);
}


-(void)returnBack:(id)sender{
    FSLog(@"returnBack");
    
    if (self.isNewNavigation){
        [self dismissModalViewControllerAnimated:YES];
        return;
    }
        
    [self.navigationController popViewControllerAnimated:YES];
    
    //[self.navigationController dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark TouchEvent and Related Motion Methods

-(void)swipeRightAction:(id)sender{
    
    FSLog(@"returnBack");
    
    if (self.isNewNavigation){
        [self dismissModalViewControllerAnimated:YES];
        return;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)swipeLeftAction:(id)sender{
    
    ;
}

-(void)swipeUpAction{
    //全屏
    NSLog(@"全屏全屏");
    
    if (_fsShareIconContainView.isShow) {
        return;
    }
    if (![[GlobalConfig shareConfig] readContentFullScreen]) {
        return;
    }
    
    _fsNewsContainerView.isFullScream = NO;
    
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.4];
    _navTopBar.alpha = 0.0;
    if (self.isNewNavigation) {
        _fsNewsContainerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+40);
        //NSLog(@"%@",NSStringFromCGRect(_fsNewsContainerView.frame));
        _navTopBar.alpha = 0.0;
        
    }
    else{
        self.navigationController.navigationBarHidden = YES;
        _fsNewsContainerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+40);
         //NSLog(@"111%@",NSStringFromCGRect([UIScreen mainScreen].applicationFrame));
        //NSLog(@"%@",NSStringFromCGRect(_fsNewsContainerView.frame));
    }
    [UIView commitAnimations];
    
    
}


-(void)swipeDownAction{
    //显示工具栏等
    NSLog(@"显示工具栏等");
    
    if (_fsShareIconContainView.isShow) {
        return;
    }
    if (![[GlobalConfig shareConfig] readContentFullScreen]) {
        return;
    }
    
    
    _fsNewsContainerView.isFullScream = YES;
    
    _fsNewsContainerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.4];
    if (self.isNewNavigation) {
        _fsNewsContainerView.frame = CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-40);
        _navTopBar.alpha = 1.0;
    }
    else{
        _navTopBar.alpha = 0.0;
        self.navigationController.navigationBarHidden = NO;
        _fsNewsContainerView.frame = self.view.frame;
    }
    [UIView commitAnimations];
}



-(void)doSomethingWithDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status{
    NSLog(@"doSomethingWithDAO sender:%@ :%d",sender,status);
    if ([sender isEqual:_fs_GZF_NewsContainerDAO]) {
        if (status == FSBaseDAOCallBack_SuccessfulStatus ||
			status == FSBaseDAOCallBack_BufferSuccessfulStatus) {
             NSMutableDictionary *array = [[NSMutableDictionary alloc] init];
            if (_fs_GZF_NewsContainerDAO.cobj!=nil) {
                //NSLog(@"_fs_GZF_NewsContainerDAO.cobj:%@",_fs_GZF_NewsContainerDAO.cobj);
                [array setValue:_fs_GZF_NewsContainerDAO.cobj forKey:@"NewsContainerDAO"];
            }
            if ([_fs_GZF_NewsContainerDAO.objectList count]>0) {
                
                [array setValue:_fs_GZF_NewsContainerDAO.objectList forKey:@"objectList"];
            }
            
            _fsNewsContainerView.data = array;
            [array release];
            
            if (status == FSBaseDAOCallBack_SuccessfulStatus) {
                [_fs_GZF_NewsContainerDAO operateOldBufferData];
            }
            
            [_fs_GZF_CommentListDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
        }
    }
    
    if ([sender isEqual:_fs_GZF_CommentListDAO]) {
        if (status == FSBaseDAOCallBack_SuccessfulStatus) {
            FSLog(@"_fs_GZF_CommentListDAO:%d",[_fs_GZF_CommentListDAO.objectList count]);
            if ([_fs_GZF_CommentListDAO.objectList count]>0) {
                [_fsNewsContainerView didReciveComment:_fs_GZF_CommentListDAO.objectList];
            }
            else{
                ;
            }
            
//            NSMutableDictionary *array = [[NSMutableDictionary alloc] init];
//            if (_fs_GZF_NewsContainerDAO.cobj!=nil) {
//                //NSLog(@"_fs_GZF_NewsContainerDAO.cobj:%@",_fs_GZF_NewsContainerDAO.cobj);
//                [array setValue:_fs_GZF_NewsContainerDAO.cobj forKey:@"NewsContainerDAO"];
//            }
//            if ([_fs_GZF_NewsContainerDAO.objectList count]>0) {
//                
//                [array setValue:_fs_GZF_NewsContainerDAO.objectList forKey:@"objectList"];
//            }
//            [array setValue:_fs_GZF_CommentListDAO.objectList forKey:@"CommentListDAO"];
//            _fsNewsContainerView.data = array;
//            [array release];
            
        }
    }
    
    if ([sender isEqual:_fs_GZF_NewsCommentPOSTXMLDAO]) {
        FSLog(@"_fs_GZF_NewsCommentPOSTXMLDAO:%d",status);
        if (status == FSBaseDAOCallBack_SuccessfulStatus) {
            //评论成功
            _fsShareNoticView.data = @"评论成功！";
            _fsShareNoticView.backgroundColor = COLOR_CLEAR;
            _fsShareNoticView.alpha = 1.0f;
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:3.0];
            _fsShareNoticView.alpha = 0.0f;
            [UIView commitAnimations];
        }
        else if (status == FSBaseDAOCallBack_UnknowErrorStatus){
            _fsShareNoticView.data = @"评论失败！";
            _fsShareNoticView.backgroundColor = COLOR_CLEAR;
            _fsShareNoticView.alpha = 1.0f;
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:3.0];
            _fsShareNoticView.alpha = 0.0f;
            [UIView commitAnimations];
        }
    }
    
}




//***************************************************************

-(void)shareSuccess:(NSNotification *)notification{
    _fsShareNoticView.data = @"分享成功！";
    _fsShareNoticView.backgroundColor = COLOR_CLEAR;
    _fsShareNoticView.alpha = 1.0f;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:4.0];
    _fsShareNoticView.alpha = 0.0f;
    [UIView commitAnimations];
}

-(void)share{
    
    _fsShareIconContainView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, [_fsShareIconContainView getHeight]);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.6];
    _fsShareIconContainView.frame = CGRectMake(0, self.view.frame.size.height-[_fsShareIconContainView getHeight], self.view.frame.size.width, [_fsShareIconContainView getHeight]);
    _fsShareIconContainView.isShow = YES;
    [UIView commitAnimations];
    return;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"分享" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"分享到人民微博",@"分享到新浪微博",@"分享到网易微博",@"分享到微信",@"短信分享",@"邮件分享",nil];
	actionSheet.delegate = self;
	[actionSheet showInView:self.view.window];
	[actionSheet release];
}

-(void)fav{
    if (_obj != nil) {
        FSMyFaverateObject *o = (FSMyFaverateObject *)[self ObjIsInFaverate];
        if (o!= nil) {
            [[FSBaseDB sharedFSBaseDB].managedObjectContext deleteObject:o];
        }
        else{
            FSMyFaverateObject *o = (FSMyFaverateObject *)[[FSBaseDB sharedFSBaseDB] insertObject:@"FSMyFaverateObject"];
            o.newsid = _obj.newsid;
            o.news_abstract =_obj.news_abstract;
            o.title = _obj.title;
            o.group = _obj.group;
            o.timestamp = _obj.timestamp;
            o.link = _obj.link;
            o.picture = _obj.picture;
            o.browserCount = _obj.browserCount;
            o.source = _obj.source;
            NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:0.0f];
            NSTimeInterval currentTimeInterval = [date timeIntervalSince1970];
            NSString *string = [NSString stringWithFormat:@"%f",currentTimeInterval];
            o.UPDATE_DATE = string;
            [date release];
        }
    }
    else if (_FCObj != nil){
        
        FSMyFaverateObject *o = (FSMyFaverateObject *)[self ObjIsInFaverate];
        if (o!= nil) {
            [[FSBaseDB sharedFSBaseDB].managedObjectContext deleteObject:o];
        }
        else{
            NSString *newsContent = [_fs_GZF_NewsContainerDAO.cobj.content substringToIndex:80];
            newsContent = [newsContent stringByReplacingOccurrencesOfString:@"　　" withString:@""];
            newsContent = [newsContent stringByReplacingOccurrencesOfString:@" " withString:@""];
            newsContent = [newsContent stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            newsContent = [newsContent stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            
            FSMyFaverateObject *o = (FSMyFaverateObject *)[[FSBaseDB sharedFSBaseDB] insertObject:@"FSMyFaverateObject"];
            o.newsid = _FCObj.newsid;
            o.title = _FCObj.title;
            o.news_abstract =newsContent;
            o.picture = _FCObj.picture;
            o.channelid = _FCObj.channelid;
            o.browserCount = _FCObj.browserCount;
            o.timestamp = _FCObj.timestamp;
            o.link = _FCObj.link;
            o.group = _FCObj.group;
            o.source = @"";
            NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:0.0f];
            NSTimeInterval currentTimeInterval = [date timeIntervalSince1970];
            NSString *string = [NSString stringWithFormat:@"%f",currentTimeInterval];
            o.UPDATE_DATE = string;
            [date release];
        }
    }
    else if (_FavObj!=nil){
        FSMyFaverateObject *o = (FSMyFaverateObject *)[self ObjIsInFaverate];
        if (o!= nil) {
            [[FSBaseDB sharedFSBaseDB].managedObjectContext deleteObject:o];
            [[FSBaseDB sharedFSBaseDB].managedObjectContext save:nil];
            if (self.isNewNavigation){
                [self dismissModalViewControllerAnimated:YES];
                return;
            }
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            FSMyFaverateObject *o = (FSMyFaverateObject *)[[FSBaseDB sharedFSBaseDB] insertObject:@"FSMyFaverateObject"];
            o.newsid = _FavObj.newsid;
            o.news_abstract =_FavObj.news_abstract;
            o.title = _FavObj.title;
            o.picture = _FavObj.picture;
            o.channelid = _FavObj.channelid;
            o.browserCount = _FavObj.browserCount;
            o.timestamp = _FavObj.timestamp;
            o.link = _FavObj.link;
            o.group = _FavObj.group;
            o.source = _FavObj.source;
            NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:0.0f];
            NSTimeInterval currentTimeInterval = [date timeIntervalSince1970];
            NSString *string = [NSString stringWithFormat:@"%f",currentTimeInterval];
            o.UPDATE_DATE = string;
            [date release];
        }
    }
    
    if (self.newsSourceKind == NewsSourceKind_PushNews) {
        FSMyFaverateObject *o = (FSMyFaverateObject *)[self ObjIsInFaverate];
        if (o!= nil) {
            [[FSBaseDB sharedFSBaseDB].managedObjectContext deleteObject:o];
            [[FSBaseDB sharedFSBaseDB].managedObjectContext save:nil];
            if (self.isNewNavigation){
                [self dismissModalViewControllerAnimated:YES];
                return;
            }
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            FSMyFaverateObject *o = (FSMyFaverateObject *)[[FSBaseDB sharedFSBaseDB] insertObject:@"FSMyFaverateObject"];
            o.newsid = self.newsID;
            
            NSString *newsContent = [_fs_GZF_NewsContainerDAO.cobj.content substringToIndex:80];
            newsContent = [newsContent stringByReplacingOccurrencesOfString:@"　　" withString:@""];
            newsContent = [newsContent stringByReplacingOccurrencesOfString:@" " withString:@""];
            newsContent = [newsContent stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            newsContent = [newsContent stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            
            o.news_abstract = newsContent;
            o.title = _fs_GZF_NewsContainerDAO.cobj.title;
            o.group = @"";
            
            NSNumber *tempNumber = [[NSNumber alloc] initWithInt:[_fs_GZF_NewsContainerDAO.cobj.timestamp intValue]];
            o.timestamp = tempNumber;
            [tempNumber release];
            
            NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:0.0f];
            NSTimeInterval currentTimeInterval = [date timeIntervalSince1970];
            NSString *string = [NSString stringWithFormat:@"%f",currentTimeInterval];
            o.UPDATE_DATE = string;
            [date release];
        }
    }
    
    [[FSBaseDB sharedFSBaseDB].managedObjectContext save:nil];
    
}

-(NSObject *)ObjIsInFaverate{
    
    if (_obj != nil) {
        NSArray *array = [[FSBaseDB sharedFSBaseDB] getObjectsByKeyWithName:@"FSMyFaverateObject" key:@"newsid" value:_obj.newsid];
        if ([array count]>0) {
            for (FSMyFaverateObject *o in array) {
                if ([o.group isEqualToString:_obj.group]) {
                    return o;
                }
            }
        }
        else{
            return nil;
        }
    }
    else if (_FCObj != nil){
        NSArray *array = [[FSBaseDB sharedFSBaseDB] getObjectsByKeyWithName:@"FSMyFaverateObject" key:@"newsid" value:_FCObj.newsid];
        if ([array count]>0) {
            for (FSMyFaverateObject *o in array) {
                if ([o.group isEqualToString:_FCObj.group]) {
                    return o;
                }
            }
        }
        else{
            return nil;
        }
    }
    else if(_FavObj!=nil){
        NSArray *array = [[FSBaseDB sharedFSBaseDB] getObjectsByKeyWithName:@"FSMyFaverateObject" key:@"newsid" value:_FavObj.newsid];
        if ([array count]>0) {
            for (FSMyFaverateObject *o in array) {
                if ([o.group isEqualToString:_FavObj.group]) {
                    return o;
                }
            }
        }
        else{
            return nil;
        }
    }
    
    if (self.newsSourceKind == NewsSourceKind_PushNews) {
        NSArray *array = [[FSBaseDB sharedFSBaseDB] getObjectsByKeyWithName:@"FSMyFaverateObject" key:@"newsid" value:self.newsID];
        if ([array count]>0) {
            for (FSMyFaverateObject *o in array) {
                return o;
            }
        }
        else{
            return nil;
        }
    }
    
    return nil;
}

-(void)commentUpdata:(NSString *)content{
   
    if (self.obj!=nil) {
        _fs_GZF_NewsCommentPOSTXMLDAO.newsid = self.obj.newsid;
        _fs_GZF_NewsCommentPOSTXMLDAO.channelid = self.obj.channelid;
        
    }
    if (self.FCObj!=nil) {
        _fs_GZF_NewsCommentPOSTXMLDAO.newsid = self.FCObj.newsid;
        _fs_GZF_NewsCommentPOSTXMLDAO.channelid = self.FCObj.channelid;
    }
    _fs_GZF_NewsCommentPOSTXMLDAO.username = @"iphone 网友";
    _fs_GZF_NewsCommentPOSTXMLDAO.content = content;
    
    if ([_fs_GZF_NewsCommentPOSTXMLDAO.newsid length]==0) {
        ;//数据不完整
    }
    [_fs_GZF_NewsCommentPOSTXMLDAO HTTPPostDataWithKind:HTTPPOSTDataKind_Normal];
}


#pragma mark - 
#pragma mark FSBaseContainerViewDelegate

-(void)fsBaseContainerViewTouchEvent:(FSBaseContainerView *)sender{
    if ([sender isEqual:_fsNewsContainerView]) {
        switch (_fsNewsContainerView.touchEvenKind) {
            case TouchEvenKind_FaverateSelect:
                [self fav];
                break;
            case TouchEvenKind_ShareSelect:
                _fsNewsContainerView.userInteractionEnabled = NO;
                [self share];
                break;
            case TouchEvenKind_Commentsend:
                [self commentUpdata:_fsNewsContainerView.comment_content];
                break;
            case TouchEvenKind_ScrollUp:
                [self swipeUpAction];
                break;
            case TouchEvenKind_ScrollDown:
                [self swipeDownAction];
                break;
            case TouchEvenKind_PopCommentList:
                [self swipeDownAction];
                [self showCommentList];
                break;
            default:
                break;
        }
        ;
    }
    
    if ([sender isEqual:_fsShareIconContainView]) {
        switch (_fsShareIconContainView.shareSelectEvent) {
            case ShareSelectEvent_return:
                break;
            case ShareSelectEvent_sina:
                NSLog(@"分享到新浪微博");
                if (self.isNewNavigation) {
                    FSSinaBlogShareViewController *fsSinaBlogShareViewController = [[FSSinaBlogShareViewController alloc] init];
                    fsSinaBlogShareViewController.withnavTopBar = YES;
                    fsSinaBlogShareViewController.shareContent = [self shareContent];
                    [self presentModalViewController:fsSinaBlogShareViewController animated:YES];
                    //[self.fsSlideViewController pres:fsNewsContainerViewController animated:YES];
                    [fsSinaBlogShareViewController release];
                }
                else{
                    FSSinaBlogShareViewController *fsSinaBlogShareViewController = [[FSSinaBlogShareViewController alloc] init];
                    fsSinaBlogShareViewController.shareContent = [self shareContent];
                    [self.navigationController pushViewController:fsSinaBlogShareViewController animated:YES];
                    //[self.fsSlideViewController pres:fsNewsContainerViewController animated:YES];
                    [fsSinaBlogShareViewController release];
                }
                
                break;
            case ShareSelectEvent_netease:
                NSLog(@"分享到网易微博");
                if (self.isNewNavigation) {
                    FSNetEaseBlogShareViewController *fsNetEaseBlogShareViewController = [[FSNetEaseBlogShareViewController alloc] init];
                    fsNetEaseBlogShareViewController.withnavTopBar = YES;
                    fsNetEaseBlogShareViewController.shareContent = [self shareContent];
                    [self presentModalViewController:fsNetEaseBlogShareViewController animated:YES];
                    //[self.fsSlideViewController pres:fsNewsContainerViewController animated:YES];
                    [fsNetEaseBlogShareViewController release];
                }
                else{
                    FSNetEaseBlogShareViewController *fsNetEaseBlogShareViewController = [[FSNetEaseBlogShareViewController alloc] init];
                    fsNetEaseBlogShareViewController.shareContent = [self shareContent];
                    [self.navigationController pushViewController:fsNetEaseBlogShareViewController animated:YES];
                    //[self.fsSlideViewController pres:fsNewsContainerViewController animated:YES];
                    [fsNetEaseBlogShareViewController release];
                }
                
                break;
            case ShareSelectEvent_weixin:
                [self sendShareWeiXin];
                break;
            case ShareSelectEvent_peopleBlog:
                NSLog(@"分享到人民微博");
                if (self.isNewNavigation) {
                    FSPeopleBlogShareViewController *fsPeopleBlogShareViewController = [[FSPeopleBlogShareViewController alloc] init];
                    fsPeopleBlogShareViewController.withnavTopBar = YES;
                    fsPeopleBlogShareViewController.shareContent = [self shareContent];
                    [self presentModalViewController:fsPeopleBlogShareViewController animated:YES];
                    //[self.fsSlideViewController pres:fsNewsContainerViewController animated:YES];
                    [fsPeopleBlogShareViewController release];
                }
                else{
                    FSPeopleBlogShareViewController *fsPeopleBlogShareViewController = [[FSPeopleBlogShareViewController alloc] init];
                    fsPeopleBlogShareViewController.shareContent = [self shareContent];
                    [self.navigationController pushViewController:fsPeopleBlogShareViewController animated:YES];
                    //[self.fsSlideViewController pres:fsNewsContainerViewController animated:YES];
                    [fsPeopleBlogShareViewController release];
                }
                
                break;
            case ShareSelectEvent_mail:
                NSLog(@"邮件分享");
                if ([MFMailComposeViewController canSendMail]) {
                    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
                    picker.mailComposeDelegate = self;
                    [picker setSubject:_fs_GZF_NewsContainerDAO.cobj.title];
                    
                    NSArray *toRecipients = [NSArray arrayWithObject:@"[email][/email]"];
                    [picker setToRecipients:toRecipients];
                    NSString *emailBody = [self shareContent];
                    [picker setMessageBody:emailBody isHTML:NO];
                    [self presentModalViewController:picker animated:YES];
                    [picker release];
                }
                else{
                    FSInformationMessageView *informationMessageView = [[FSInformationMessageView alloc] initWithFrame:CGRectZero];
                    informationMessageView.parentDelegate = self;
                    [informationMessageView showInformationMessageViewInView:self.view
                                                                 withMessage:@"请先设置您的邮箱再分享，谢谢！"
                                                            withDelaySeconds:2.0f
                                                            withPositionKind:PositionKind_Vertical_Horizontal_Center
                                                                  withOffset:0.0f];
                    
                    [self performSelector:@selector(shearWithMail) withObject:nil afterDelay:1.5];
                }
                
                break;
            case ShareSelectEvent_message:
                NSLog(@"短信分享");
                [NTESNBSMSManager sharedSMSManager].smsBody = [self shareContent];
                [NTESNBSMSManager sharedSMSManager].pushNavigation = self.navigationController;
                [[NTESNBSMSManager sharedSMSManager] pushSMSComposer];
                break;
            default:
                break;
        }
        NSLog(@"。。。。。。。。。");
        _fsNewsContainerView.userInteractionEnabled = YES;
        _fsShareIconContainView.isShow = NO;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.6];
        _fsShareIconContainView.frame = CGRectMake(0, self.view.frame.size.height+44, self.view.frame.size.width, [_fsShareIconContainView getHeight]);
        [UIView commitAnimations];
        
    }
}

-(NSString *)shareContent{
    NSString *newsContent;
    NSString *resultStr;
    
    
    if (self.newsSourceKind == NewsSourceKind_ShiKeNews && _FCObj==nil) {
        
        if (self.obj!=nil) {
            if ([self.obj.news_abstract length]>90) {
                
                newsContent = [self.obj.news_abstract substringToIndex:90];
                newsContent = [newsContent stringByReplacingOccurrencesOfString:@"　　" withString:@""];
                newsContent = [newsContent stringByReplacingOccurrencesOfString:@" " withString:@""];
                newsContent = [newsContent stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                newsContent = [newsContent stringByReplacingOccurrencesOfString:@"\r" withString:@""];
                newsContent = [NSString stringWithFormat:@"【%@】%@",_fs_GZF_NewsContainerDAO.cobj.title,newsContent];
            }
            else{
                newsContent = [NSString stringWithFormat:@"【%@】%@",_fs_GZF_NewsContainerDAO.cobj.title,self.obj.news_abstract];
            }
        }
        
        if (self.FavObj!=nil) {
            if ([self.FavObj.news_abstract length]>90) {
                newsContent = [self.FavObj.news_abstract substringToIndex:90];
                newsContent = [newsContent stringByReplacingOccurrencesOfString:@"　　" withString:@""];
                newsContent = [newsContent stringByReplacingOccurrencesOfString:@" " withString:@""];
                newsContent = [newsContent stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                newsContent = [newsContent stringByReplacingOccurrencesOfString:@"\r" withString:@""];
                newsContent = [NSString stringWithFormat:@"【%@】%@",_fs_GZF_NewsContainerDAO.cobj.title,newsContent];
            }
            else{
                newsContent = [NSString stringWithFormat:@"【%@】%@",_fs_GZF_NewsContainerDAO.cobj.title,self.FavObj.news_abstract];
            }
        }
    }
    else{
        if ([_fs_GZF_NewsContainerDAO.cobj.content length]>90) {
            
            newsContent = [_fs_GZF_NewsContainerDAO.cobj.content substringToIndex:90];
            NSLog(@"newsContent:%@",newsContent);
            newsContent = [newsContent stringByReplacingOccurrencesOfString:@"　　" withString:@""];
            newsContent = [newsContent stringByReplacingOccurrencesOfString:@" " withString:@""];
            newsContent = [newsContent stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            newsContent = [newsContent stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            newsContent = [NSString stringWithFormat:@"【%@】%@",_fs_GZF_NewsContainerDAO.cobj.title,newsContent];
        }
        else{
            newsContent = [NSString stringWithFormat:@"【%@】%@",_fs_GZF_NewsContainerDAO.cobj.title,_fs_GZF_NewsContainerDAO.cobj.content];
        }
    }
    
    
    if ([_fs_GZF_NewsContainerDAO.cobj.shortUrl length]>0) {
        resultStr = [NSString stringWithFormat:@"%@-->详见：%@",newsContent,_fs_GZF_NewsContainerDAO.cobj.shortUrl];
    }
    else{
        resultStr = [NSString stringWithFormat:@"%@",newsContent];
    }
    
    return resultStr;
}


-(void)showCommentList{
    if (self.isNewNavigation) {
        FSCommentListViewController *fsCommentListViewController = [[FSCommentListViewController alloc] init];
        fsCommentListViewController.withnavTopBar = YES;
        fsCommentListViewController.newsid = _fs_GZF_CommentListDAO.newsid;
        [self presentModalViewController:fsCommentListViewController animated:YES];
        [fsCommentListViewController release];
    }
    else{
        FSCommentListViewController *fsCommentListViewController = [[FSCommentListViewController alloc] init];
        fsCommentListViewController.newsid = _fs_GZF_CommentListDAO.newsid;
        [self.navigationController pushViewController:fsCommentListViewController animated:YES];
        [fsCommentListViewController release];
    }
    
}


#pragma mark -
#pragma mark UIActionSheetDelegate

#pragma mark -
#pragma mark FSBaseContentViewDelegate


-(void)shearWithMail{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:"]];    
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    NSLog(@"result:%d",result);
    
    
    if (result == MFMailComposeResultCancelled) {
        FSInformationMessageView *informationMessageView = [[FSInformationMessageView alloc] initWithFrame:CGRectZero];
        informationMessageView.parentDelegate = self;
        [informationMessageView showInformationMessageViewInView:self.view
                                                     withMessage:@"取消分享"
                                                withDelaySeconds:2.0f
                                                withPositionKind:PositionKind_Vertical_Horizontal_Center
                                                      withOffset:0.0f];
        [informationMessageView release];
    }else if(result == MFMailComposeResultFailed){
        FSInformationMessageView *informationMessageView = [[FSInformationMessageView alloc] initWithFrame:CGRectZero];
        informationMessageView.parentDelegate = self;
        [informationMessageView showInformationMessageViewInView:self.view
                                                     withMessage:@"分享邮件发送失败！"
                                                withDelaySeconds:2.0f
                                                withPositionKind:PositionKind_Vertical_Horizontal_Center
                                                      withOffset:0.0f];
    }else if(result == MFMailComposeResultSaved){
        FSInformationMessageView *informationMessageView = [[FSInformationMessageView alloc] initWithFrame:CGRectZero];
        informationMessageView.parentDelegate = self;
        [informationMessageView showInformationMessageViewInView:self.view
                                                     withMessage:@"分享邮件已保存到草稿箱！"
                                                withDelaySeconds:2.0f
                                                withPositionKind:PositionKind_Vertical_Horizontal_Center
                                                      withOffset:0.0f];
    }
    else if(result == MFMailComposeResultSent){
        FSInformationMessageView *informationMessageView = [[FSInformationMessageView alloc] initWithFrame:CGRectZero];
        informationMessageView.parentDelegate = self;
        [informationMessageView showInformationMessageViewInView:self.view
                                                     withMessage:@"分享邮件已发送！"
                                                withDelaySeconds:2.0f
                                                withPositionKind:PositionKind_Vertical_Horizontal_Center
                                                      withOffset:0.0f];
    }
    
    
    
    [controller dismissModalViewControllerAnimated:YES];
    
}


- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==0) {
		NSLog(@"分享到人民微博");
        FSPeopleBlogShareViewController *fsPeopleBlogShareViewController = [[FSPeopleBlogShareViewController alloc] init];
        fsPeopleBlogShareViewController.shareContent = @"人民网微博分享测试";
        [self.navigationController pushViewController:fsPeopleBlogShareViewController animated:YES];
        //[self.fsSlideViewController pres:fsNewsContainerViewController animated:YES];
        [fsPeopleBlogShareViewController release];
	}else if(buttonIndex==1){
        NSLog(@"分享到新浪微博");
        [self ShareInSinaMicroBlog];
        
    }else if(buttonIndex==2){
        NSLog(@"分享到网易微博");
        FSNetEaseBlogShareViewController *fsNetEaseBlogShareViewController = [[FSNetEaseBlogShareViewController alloc] init];
        fsNetEaseBlogShareViewController.shareContent = @"网易微博分享测试";
        [self.navigationController pushViewController:fsNetEaseBlogShareViewController animated:YES];
        //[self.fsSlideViewController pres:fsNewsContainerViewController animated:YES];
        [fsNetEaseBlogShareViewController release];
    }else if(buttonIndex==3){
        NSLog(@"分享到微信");
        [self sendShareWeiXin];
    }else if(buttonIndex==4){
        NSLog(@"短信分享");
        
        NSString *sharedMsg = [NSString stringWithFormat:@"短信分享测试"];
		[NTESNBSMSManager sharedSMSManager].smsBody = sharedMsg;
		[NTESNBSMSManager sharedSMSManager].pushNavigation = self.navigationController;
        [[NTESNBSMSManager sharedSMSManager] pushSMSComposer];
         
    }else if(buttonIndex==5){
        
        NSLog(@"邮件分享");
        NSString *sharedMsg = [NSString stringWithFormat:@"邮件分享测试"];
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = sharedMsg;
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
                                                           message:@"已粘贴到剪贴板"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        [self performSelector:@selector(shearWithMail) withObject:nil afterDelay:0.5];
         
    }else if(buttonIndex==6){
        NSLog(@"取消");
        return;
    }
}



//******************************************************************
-(void)ShareInSinaMicroBlog{
    //新浪微博
    if (_sinaWBEngine == nil) {
		WBEngine *wbengine = [[WBEngine alloc] initWithAppKey:kWBSDKDemoAppKey appSecret:kWBSDKDemoAppSecret];
		[wbengine setRootViewController:self];
		[wbengine setDelegate:self];
		[wbengine setRedirectURI:@"http://wap.people.com.cn"];
		[wbengine setIsUserExclusive:NO];
		self.sinaWBEngine = wbengine;
		[wbengine release];
	}
	
	if ([_sinaWBEngine isLoggedIn] && ![_sinaWBEngine isAuthorizeExpired]) {
		//显示发送微博的主体
		[self sendShareSinaWeibo];
	} else {
		[_sinaWBEngine logIn];
	}
}

- (void)sendShareSinaWeibo {
    //发送新浪微博
	if (_fs_GZF_NewsContainerDAO.cobj!=nil) {
		//NSString *sharedMsg = [NSString stringWithFormat:@"我在人民网新闻iphone客户端发现新闻：《%@》，与你分享。%@",docTitle,shortURL];
        FSNewsDitailObject *o = _fs_GZF_NewsContainerDAO.cobj;
        
        
        NSLog(@"shareContent:%@",o.title);
        NSString *sharedMsg = [NSString stringWithFormat:@"%@",o.title];
        //NSString *sharedMsg = [NSString stringWithFormat:@"%@...，详见:%@",shareContent,@" "];
		WBSendView *sendView = [[WBSendView alloc] initWithAppKey:kWBSDKDemoAppKey appSecret:kWBSDKDemoAppSecret text:sharedMsg image:nil];
		[sendView setDelegate:self];
		
		[sendView show:YES];
		[sendView release];
		//[strContent release];
	} else {
        //内容不能为空
	}
    
}

#pragma mark - WBEngineDelegate Methods

#pragma mark Authorize

- (void)engineAlreadyLoggedIn:(WBEngine *)engine
{
    //[indicatorView stopAnimating];
    if ([engine isUserExclusive])
    {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
                                                           message:@"请先登出！"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
}

- (void)engineDidLogIn:(WBEngine *)engine
{
    //[indicatorView stopAnimating];
    /*
     UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
     message:@"登录成功！"
     delegate:self
     cancelButtonTitle:@"确定"
     otherButtonTitles:nil];
     [alertView setTag:kWBAlertViewLogInTag];
     [alertView show];
     [alertView release];
     */
	[self sendShareSinaWeibo];
}

- (void)engine:(WBEngine *)engine didFailToLogInWithError:(NSError *)error
{
    //[indicatorView stopAnimating];
    NSLog(@"didFailToLogInWithError: %@", error);
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
													   message:@"登录失败！"
													  delegate:nil
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

- (void)engineDidLogOut:(WBEngine *)engine
{
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
													   message:@"登出成功！"
													  delegate:self
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
    [alertView setTag:kWBAlertViewLogOutTag];
	[alertView show];
	[alertView release];
}

- (void)engineNotAuthorized:(WBEngine *)engine
{
    
}

- (void)engineAuthorizeExpired:(WBEngine *)engine
{
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
													   message:@"请重新登录！"
													  delegate:nil
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}


#pragma mark - WBSendViewDelegate Methods

- (void)sendViewDidFinishSending:(WBSendView *)view
{
    [view hide:YES];
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
													   message:@"分享成功！"
													  delegate:nil
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

- (void)sendView:(WBSendView *)view didFailWithError:(NSError *)error
{
    //#ifdef MYDEBUG
    NSLog(@"didFailWithError: %@[%d]", error, [error code]);
    //#endif
    //[view hide:YES];
	NSString *strMessage = [[NSString alloc] initWithFormat:@"%@", @"分享失败！"];
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
													   message:strMessage
													  delegate:nil
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
	[alertView show];
	[alertView release];
	[strMessage release];
}

- (void)sendViewNotAuthorized:(WBSendView *)view
{
    [view hide:YES];
    
    //[self dismissModalViewControllerAnimated:YES];
}

- (void)sendViewAuthorizeExpired:(WBSendView *)view
{
    [view hide:YES];
    
    //[self dismissModalViewControllerAnimated:YES];
}


//******************************************************************

//微信

- (void)sendShareWeiXin{
    if (1) {
        NSString *newsContent;
                
        if (self.newsSourceKind == NewsSourceKind_ShiKeNews && _FCObj==nil) {
            
            if (self.obj!=nil) {
                if ([self.obj.news_abstract length]>90) {
                    
                    newsContent = [self.obj.news_abstract substringToIndex:90];
                    newsContent = [newsContent stringByReplacingOccurrencesOfString:@"　　" withString:@""];
                    newsContent = [newsContent stringByReplacingOccurrencesOfString:@" " withString:@""];
                    newsContent = [newsContent stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                    newsContent = [newsContent stringByReplacingOccurrencesOfString:@"\r" withString:@""];
                    
                }
                else{
                    newsContent = [NSString stringWithFormat:@"%@",self.obj.news_abstract];
                }
            }
            
            if (self.FavObj!=nil) {
                if ([self.FavObj.news_abstract length]>90) {
                    newsContent = [self.FavObj.news_abstract substringToIndex:90];
                    newsContent = [newsContent stringByReplacingOccurrencesOfString:@"　　" withString:@""];
                    newsContent = [newsContent stringByReplacingOccurrencesOfString:@" " withString:@""];
                    newsContent = [newsContent stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                    newsContent = [newsContent stringByReplacingOccurrencesOfString:@"\r" withString:@""];
                                    }
                else{
                    newsContent = [NSString stringWithFormat:@"%@",self.FavObj.news_abstract];
                }
            }
        }
        else{
            if ([_fs_GZF_NewsContainerDAO.cobj.content length]>90) {
                
                newsContent = [_fs_GZF_NewsContainerDAO.cobj.content substringToIndex:90];
                NSLog(@"newsContent:%@",newsContent);
                newsContent = [newsContent stringByReplacingOccurrencesOfString:@"　　" withString:@""];
                newsContent = [newsContent stringByReplacingOccurrencesOfString:@" " withString:@""];
                newsContent = [newsContent stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                newsContent = [newsContent stringByReplacingOccurrencesOfString:@"\r" withString:@""];
                
            }
            else{
                newsContent = [NSString stringWithFormat:@"%@",_fs_GZF_NewsContainerDAO.cobj.content];
            }
        }

        
        
        PeopleNewsReaderPhoneAppDelegate*appDelegate = (PeopleNewsReaderPhoneAppDelegate *)[UIApplication sharedApplication].delegate;
        
        /*
         UIImage *image = [UIImage imageNamed:@"icon-72.png"];
         if (![appDelegate sendWXMidiaMessage:@"人民新闻微信分享" content:shareContent thumbImage:image webURL:shortURL]) {
         [CommonFuncs showMessage:@"人民新闻" ContentMessage:@"不能分享到微信，请确认安装了最新版本的微信客户端"];
         }
         */
        
//        
//        if (![appDelegate sendWXTextMessage:newsContent]) {
//            ;
//        }
//        return;
        UIImage *image = [UIImage imageNamed:@"icon@2x.png"];
        
        if (![appDelegate sendWXMidiaMessage:_fs_GZF_NewsContainerDAO.cobj.title content:newsContent thumbImage:image webURL:_fs_GZF_NewsContainerDAO.cobj.shortUrl]) {
			//[CommonFuncs showMessage:@"人民新闻" ContentMessage:@"不能分享到微信，请确认安装了最新版本的微信客户端"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"人民新闻" message:@"不能分享到微信，请确认安装了最新版本的微信客户端" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
		}
        else{
            NSLog(@"sendShareWeiXin fail");
        }
	} else {
        //[CommonFuncs showMessage:@"人民新闻" ContentMessage:@"正文内容不存在"];
	}
    
}



@end
