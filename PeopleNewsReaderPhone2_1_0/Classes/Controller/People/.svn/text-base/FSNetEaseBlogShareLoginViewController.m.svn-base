//
//  FSNetEaseBlogShareLoginViewController.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-11-9.
//
//

#import "FSNetEaseBlogShareLoginViewController.h"
#import "NetEaseEngine.h"

@interface FSNetEaseBlogShareLoginViewController ()

@end

@implementation FSNetEaseBlogShareLoginViewController

@synthesize engine = _engine;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"网易微博授权";
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
    return @"请输入网易通行证";
}

-(NSString *)bagroundImageName{
    return @"netease_beijing.png";
}


-(void)loginServer:(FSBaseLoginViewController *)sender{
    if ([_tfUser.text length] == 0) {
        FSInformationMessageView *informationMessageView = [[FSInformationMessageView alloc] initWithFrame:CGRectMake(70, 70, 70, 70)];
        informationMessageView.parentDelegate = self;
        [informationMessageView showInformationMessageViewInView:self.view
                                                     withMessage:@"请输入通行证"
                                                withDelaySeconds:1.0
                                                withPositionKind:PositionKind_Horizontal_Center
                                                      withOffset:40.0f];
        [informationMessageView release];
		[_tfUser becomeFirstResponder];
		return;
	}
	
	if ([_tfPWD.text length] == 0) {
        FSInformationMessageView *informationMessageView = [[FSInformationMessageView alloc] initWithFrame:CGRectMake(70, 70, 70, 70)];
        informationMessageView.parentDelegate = self;
        [informationMessageView showInformationMessageViewInView:self.view
                                                     withMessage:@"请输入密码"
                                                withDelaySeconds:1.0
                                                withPositionKind:PositionKind_Horizontal_Center
                                                      withOffset:40.0f];
        [informationMessageView release];
		[_tfPWD becomeFirstResponder];
		return;
	}
	
	[_tfUser resignFirstResponder];
	[_tfPWD resignFirstResponder];
	
	[_engine logInUsingUserID:_tfUser.text password:_tfPWD.text];
    if ([_engine isLogIn]) {
        //[CommonFuncs showMessage:@"" ContentMessage:@"登录成功"];
        NSLog(@"FSNetEaseBlogShareLoginViewController 登陆成功");
        
        
        /*
        
        FSInformationMessageView *informationMessageView = [[FSInformationMessageView alloc] initWithFrame:CGRectMake(70, 70, 70, 70)];
        informationMessageView.parentDelegate = self;
        [informationMessageView showInformationMessageViewInView:self.view
                                                     withMessage:@"登陆成功"
                                                withDelaySeconds:1.2
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
		
	} else {
        //[CommonFuncs showMessage:@"" ContentMessage:@"登录失败"];
        NSLog(@"FSNetEaseBlogShareLoginViewController 登陆失败");
        
        FSInformationMessageView *informationMessageView = [[FSInformationMessageView alloc] initWithFrame:CGRectMake(70, 70, 70, 70)];
        informationMessageView.parentDelegate = self;
        [informationMessageView showInformationMessageViewInView:self.view
                                                     withMessage:@"登陆失败"
                                                withDelaySeconds:1.2
                                                withPositionKind:PositionKind_Horizontal_Center
                                                      withOffset:40.0f];
        [informationMessageView release];
        
//        if ([self.parentDelegate respondsToSelector:@selector(loginSuccesss:)]) {
//            [self.parentDelegate loginSuccesss:NO];
//        }
        //[self performSelector:@selector(returnToParentView) withObject:nil afterDelay:1.5];
		
	}
}


@end
