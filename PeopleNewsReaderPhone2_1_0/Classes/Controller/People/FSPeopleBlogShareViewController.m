//
//  FSPeopleBlogShareViewController.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-11-7.
//
//

#import "FSPeopleBlogShareViewController.h"

#import "FS_GZF_PeopleBlogSharePOSTXMLDAO.h"
#import "FSBaseDB.h"


@interface FSPeopleBlogShareViewController ()

@end

@implementation FSPeopleBlogShareViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"人民微博分享";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)doSomethingForViewFirstTimeShow{
    
}

-(void)initDataModel{
    _isLogin = NO;
    
    NSArray *array = [[FSBaseDB sharedFSBaseDB] getObjectsByKeyWithName:@"FSLoginObject" key:@"userKind" value:LOGIN_USER_KIND_PEOPLE_BLOG];
    if ([array count]>0) {
        _isLogin = YES;
    }
    _fs_GZF_PeopleBlogSharePOSTXMLDAO  = [[FS_GZF_PeopleBlogSharePOSTXMLDAO alloc] init];
    _fs_GZF_PeopleBlogSharePOSTXMLDAO.parentDelegate = self;
}

-(void)dealloc{
    [_fs_GZF_PeopleBlogSharePOSTXMLDAO release];
    [super dealloc];
}

-(void)postShareMessage{
    
    NSLog(@"_fsBlogShareContentView.shareContent:%@",[_fsBlogShareContentView getShareContent]);
    
    if (!_isLogin) {
        if (self.withnavTopBar) {
            FSPeopleBlogShareLoginViewController *fsPeopleBlogShareLoginViewController = [[FSPeopleBlogShareLoginViewController alloc] init];
            fsPeopleBlogShareLoginViewController.parentDelegate = self;
            fsPeopleBlogShareLoginViewController.isnavTopBar = YES;
            [self presentModalViewController:fsPeopleBlogShareLoginViewController animated:YES];
            [fsPeopleBlogShareLoginViewController release];
        }
        else{
            FSPeopleBlogShareLoginViewController *fsPeopleBlogShareLoginViewController = [[FSPeopleBlogShareLoginViewController alloc] init];
            fsPeopleBlogShareLoginViewController.parentDelegate = self;
            [self.navigationController pushViewController:fsPeopleBlogShareLoginViewController animated:YES];
            [fsPeopleBlogShareLoginViewController release];
        }
        
    }
    else{
        _fs_GZF_PeopleBlogSharePOSTXMLDAO.message = [_fsBlogShareContentView getShareContent];
        NSLog(@"_fs_GZF_PeopleBlogSharePOSTXMLDAO.message:%@",_fs_GZF_PeopleBlogSharePOSTXMLDAO.message);
        _fs_GZF_PeopleBlogSharePOSTXMLDAO.imagedata = nil;
        [_fs_GZF_PeopleBlogSharePOSTXMLDAO HTTPPostDataWithKind:HTTPPOSTDataKind_MultiPart];
        [_fsBlogShareContentView resignalTvContent];
        
    }
}

-(void)doSomethingWithDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status{
    if ([sender isEqual:_fs_GZF_PeopleBlogSharePOSTXMLDAO]) {
        if (status == FSBaseDAOCallBack_SuccessfulStatus) {
                /*
                 FSInformationMessageView *informationMessageView = [[FSInformationMessageView alloc] initWithFrame:CGRectMake(70, 70, 70, 70)];
                 informationMessageView.parentDelegate = self;
                 [informationMessageView showInformationMessageViewInView:self.view
                 withMessage:@"分享成功"
                 withDelaySeconds:1.2
                 withPositionKind:PositionKind_Horizontal_Center
                 withOffset:40.0f];
                 [informationMessageView release];
                 */
            [[NSNotificationCenter defaultCenter] postNotificationName:SHARE_SUCCESSFUL_NOTICE object:self userInfo:nil];
            NSLog(@"分享成功。。。。");
            [self performSelector:@selector(returnToParentView) withObject:nil afterDelay:0.0];
            } else if(status == FSBaseDAOCallBack_UnknowErrorStatus){
                /*
                 FSInformationMessageView *informationMessageView = [[FSInformationMessageView alloc] initWithFrame:CGRectMake(70, 70, 70, 70)];
                 informationMessageView.parentDelegate = self;
                 [informationMessageView showInformationMessageViewInView:self.view
                 withMessage:@"分享失败"
                 withDelaySeconds:1.2
                 withPositionKind:PositionKind_Horizontal_Center
                 withOffset:40.0f];
                 [informationMessageView release];
                 */
                _fsShareNoticView.data = @"分享失败！";
                _fsShareNoticView.backgroundColor = COLOR_CLEAR;
                _fsShareNoticView.alpha = 1.0f;
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:2.0];
                _fsShareNoticView.alpha = 0.0f;
                [UIView commitAnimations];
                
            }
            
    }
}

-(void)loginSuccesss:(BOOL)isSuccess{
    if (isSuccess) {
        _fs_GZF_PeopleBlogSharePOSTXMLDAO.message = [_fsBlogShareContentView getShareContent];
        _fs_GZF_PeopleBlogSharePOSTXMLDAO.imagedata = nil;
        [_fs_GZF_PeopleBlogSharePOSTXMLDAO HTTPPostDataWithKind:HTTPPOSTDataKind_MultiPart];
    }
    else{
        ;
    }
}



@end
