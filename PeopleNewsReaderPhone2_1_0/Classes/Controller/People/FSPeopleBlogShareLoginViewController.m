//
//  FSPeopleBlogShareLoginViewController.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-11-9.
//
//

#import "FSPeopleBlogShareLoginViewController.h"
#import "FS_GZF_PeopleBlogLoginPOSTXMLDAO.h"

@interface FSPeopleBlogShareLoginViewController ()

@end

@implementation FSPeopleBlogShareLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"人民微博授权";
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

-(void)dealloc{
    [_fs_GZF_PeopleBlogLoginPOSTXMLDAO release];
    
    [super dealloc];
}

-(NSString *)inputUserNamnePrompt{
    return @"请输入人民网通行证";
}

-(NSString *)bagroundImageName{
    
    return @"Default.png";
}

-(void)initDataModel{
    
}


-(void)loginServer:(FSBaseLoginViewController *)sender{
    _fs_GZF_PeopleBlogLoginPOSTXMLDAO = [[FS_GZF_PeopleBlogLoginPOSTXMLDAO alloc] init];
    _fs_GZF_PeopleBlogLoginPOSTXMLDAO.parentDelegate = self;
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
	
    _fs_GZF_PeopleBlogLoginPOSTXMLDAO.userName = _tfUser.text;
    _fs_GZF_PeopleBlogLoginPOSTXMLDAO.userPassword = _tfPWD.text;
    
    [_fs_GZF_PeopleBlogLoginPOSTXMLDAO HTTPPostDataWithKind:HTTPPOSTDataKind_Normal];
    
}

-(void)doSomethingWithDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status{
    if ([sender isEqual:_fs_GZF_PeopleBlogLoginPOSTXMLDAO]) {
        if (status == FSBaseDAOCallBack_SuccessfulStatus) {
            if ([self.parentDelegate respondsToSelector:@selector(loginSuccesss:)]) {
                [self.parentDelegate loginSuccesss:YES];
            }
            
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
            if (self.isnavTopBar){
                [self dismissModalViewControllerAnimated:YES];
                return;
            }
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else if(status == FSBaseDAOCallBack_UnknowErrorStatus){
            if ([self.parentDelegate respondsToSelector:@selector(loginSuccesss:)]) {
                [self.parentDelegate loginSuccesss:NO];
            }
            FSInformationMessageView *informationMessageView = [[FSInformationMessageView alloc] initWithFrame:CGRectMake(70, 70, 70, 70)];
            informationMessageView.parentDelegate = self;
            [informationMessageView showInformationMessageViewInView:self.view
                                                         withMessage:@"登陆失败"
                                                    withDelaySeconds:1.2
                                                    withPositionKind:PositionKind_Horizontal_Center
                                                          withOffset:40.0f];
            [informationMessageView release];
            
            //[self performSelector:@selector(returnToParentView) withObject:nil afterDelay:1.5];
            //登陆失败
        }
    }
}


@end
