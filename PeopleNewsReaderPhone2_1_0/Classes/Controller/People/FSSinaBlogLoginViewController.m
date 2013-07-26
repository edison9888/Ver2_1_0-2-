//
//  FSSinaBlogLoginViewController.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-12-13.
//
//

#import "FSSinaBlogLoginViewController.h"


#define kWBAuthorizeURL     @"https://api.weibo.com/oauth2/authorize"

#define kWBSDKDemoAppKey @"1368810072"
#define kWBSDKDemoAppSecret @"5dd07c1fd64d4e3ba3bef34ec59edfa1"

#define kWBAlertViewLogOutTag 100
#define FSSETTING_VIEW_NAVBAR_HEIGHT 44.0f


@interface FSSinaBlogLoginViewController ()

@end

@implementation FSSinaBlogLoginViewController

@synthesize sinaWBEngine = _sinaWBEngine;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"新浪微博授权";
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

-(NSString *)inputUserNamnePrompt{
    return @"请输入新浪通行证";
}

-(NSString *)bagroundImageName{
    return @"Default-568h@2x.png";
}


-(void)loadChildView{
    [super loadChildView];
    
//    //返回按钮
//    UIButton *returnBT = [[UIButton alloc] init];
//    [returnBT setBackgroundImage:[UIImage imageNamed:@"returnbackBT.png"] forState:UIControlStateNormal];
//    //[returnBT setTitle:NSLocalizedString(@"返回", nil) forState:UIControlStateNormal];
//    returnBT.titleLabel.font = [UIFont systemFontOfSize:12];
//    [returnBT addTarget:self action:@selector(goBackToParent:) forControlEvents:UIControlEventTouchUpInside];
//    [returnBT setTitleColor:COLOR_NEWSLIST_TITLE_WHITE forState:UIControlStateNormal];
//    returnBT.frame = CGRectMake(0, 0, 55, 30);
//    
//    //self.navigationItem.leftBarButtonItem
//    
//    
//    UIBarButtonItem *returnButton = [[UIBarButtonItem alloc] initWithCustomView:returnBT];
//    self.navigationItem.leftBarButtonItem = returnButton;
//    [returnButton release];
//    [returnBT release];
    
    if (_sinaWBEngine == nil) {
		WBEngine *wbengine = [[WBEngine alloc] initWithAppKey:kWBSDKDemoAppKey appSecret:kWBSDKDemoAppSecret];
		[wbengine setRootViewController:self];
		[wbengine setDelegate:self];
		[wbengine setRedirectURI:@"http://wap.people.com.cn"];
		[wbengine setIsUserExclusive:NO];
		self.sinaWBEngine = wbengine;
		[wbengine release];
        //NSLog(@"_sinaWBEngine");
	}
	
	if ([_sinaWBEngine isLoggedIn] && ![_sinaWBEngine isAuthorizeExpired]) {
		//显示发送微博的主体
		//NSLog(@"1111112222");
	} else {
        //NSLog(@"登陆界面！！");
        [_sinaWBEngine setDelegate:self];
		[_sinaWBEngine logIn_gazf];
        
        UIView *contanview = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
        
        self.view = contanview;
        [contanview release];
        
        self.view.backgroundColor = COLOR_BLACK;
        [self.view addSubview:_sinaWBEngine.authorize.LoginwebView];
        
        CGRect rect = _sinaWBEngine.authorize.LoginwebView.frame;
        
        if (self.isnavTopBar) {
            _sinaWBEngine.authorize.LoginwebView.frame = CGRectMake(0, FSSETTING_VIEW_NAVBAR_HEIGHT, rect.size.width, rect.size.height);
            [self.view addSubview:_navTopBar];
        }
        else{
            _sinaWBEngine.authorize.LoginwebView.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
        }
        
        //self.view = _sinaWBEngine.authorize.LoginwebView;
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
    FSInformationMessageView *informationMessageView = [[FSInformationMessageView alloc] initWithFrame:CGRectMake(70, 70, 70, 70)];
    informationMessageView.parentDelegate = self;
    [informationMessageView showInformationMessageViewInView:self.view
                                                 withMessage:@"登陆成功"
                                            withDelaySeconds:0.8
                                            withPositionKind:PositionKind_Horizontal_Center
                                                  withOffset:40.0f];
    [informationMessageView release];
    */
    if ([self.parentDelegate respondsToSelector:@selector(loginSuccesss:)]) {
        [self.parentDelegate loginSuccesss:YES];
    }
    
    if (self.isnavTopBar){
        [self dismissModalViewControllerAnimated:YES];
        return;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
	//[self sendShareSinaWeibo];
}

- (void)engine:(WBEngine *)engine didFailToLogInWithError:(NSError *)error
{
    //[indicatorView stopAnimating];
    FSInformationMessageView *informationMessageView = [[FSInformationMessageView alloc] initWithFrame:CGRectMake(70, 70, 70, 70)];
    informationMessageView.parentDelegate = self;
    [informationMessageView showInformationMessageViewInView:self.view
                                                 withMessage:@"登录失败"
                                            withDelaySeconds:1.2
                                            withPositionKind:PositionKind_Horizontal_Center
                                                  withOffset:40.0f];
    [informationMessageView release];
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




@end
