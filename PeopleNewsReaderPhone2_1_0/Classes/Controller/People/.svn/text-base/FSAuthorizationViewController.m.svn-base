//
//  FSAuthorizationViewController.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-9-12.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSAuthorizationViewController.h"
#import "FSSinaBlogLoginViewController.h"
#import "FSPeopleBlogShareLoginViewController.h"
#import "FSNetEaseBlogShareLoginViewController.h"

//新浪微博
#define kWBSDKDemoAppKey @"1368810072"
#define kWBSDKDemoAppSecret @"5dd07c1fd64d4e3ba3bef34ec59edfa1"


@implementation FSAuthorizationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)dealloc{
    [_engine release];
    [_netEaseEngine release];
    [super dealloc];
}


-(void)initDataModel{
    if (_engine == nil) {
		_engine = [[WBEngine alloc] initWithAppKey:kWBSDKDemoAppKey appSecret:kWBSDKDemoAppSecret];
		[_engine setRootViewController:self];
		[_engine setDelegate:self];
		[_engine setRedirectURI:@"http://wap.people.com.cn"];
		[_engine setIsUserExclusive:NO];
	}
	
	_netEaseEngine = [[NetEaseEngine alloc] init];
}

-(void)returnBack:(id)sender{
    FSLog(@"returnBack");
    
    if (self.isnavTopBar){
        [self dismissModalViewControllerAnimated:YES];
        return;
    }
    
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_fsALLSettingContainerView loadData];
}

#pragma mark - View lifecycle



-(NSString *)setTitle{
    _fsALLSettingContainerView.flag = 3;
    NSLog(@"setTitlesetTitlesetTitlesetTitle setTitlesetTitle");
    return @"账号绑定";
}

#pragma mark - 
#pragma FSTableContainerViewDelegate mark

 

-(NSInteger)tableViewSectionNumber:(FSTableContainerView *)sender{
    
    return 1;
}

-(NSInteger)tableViewNumberInSection:(FSTableContainerView *)sender section:(NSInteger)section{
    
    return 3;
}

-(NSObject *)tableViewCellData:(FSTableContainerView *)sender withIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    
    return [self BulCellObject:row];
    //return @"登陆账号";
}


-(NSObject *)BulCellObject:(NSInteger)row{
    NSMutableDictionary *dir = [[[NSMutableDictionary alloc] init] autorelease];
    
    if (row == 0) {
        [dir setValue:@"新浪微博" forKey:@"title"];
        if ([_engine isLoggedIn] && ![_engine isAuthorizeExpired]) {
            [dir setValue:@"1" forKey:@"key"];
        } else {
            [dir setValue:@"0" forKey:@"key"];
        }
        return dir;
    }else if (row == 1){
        [dir setValue:@"网易微博" forKey:@"title"];
        if ([_netEaseEngine isLogIn]) {
            [dir setValue:@"1" forKey:@"key"];
        } else {
            [dir setValue:@"0" forKey:@"key"];
        }
        return dir;
    }else if (row == 2){
        [dir setValue:@"人民微博" forKey:@"title"];
        NSArray *array = [[FSBaseDB sharedFSBaseDB] getObjectsByKeyWithName:@"FSLoginObject" key:@"userKind" value:LOGIN_USER_KIND_PEOPLE_BLOG];
        if ([array count]>0) {
            [dir setValue:@"1" forKey:@"key"];
        }
        else{
            [dir setValue:@"0" forKey:@"key"];
        }
        return dir;
    }
    return nil;
}

-(void)tableViewDataSourceDidSelected:(FSTableContainerView *)sender withIndexPath:(NSIndexPath *)indexPath{
    //NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    if (row == 0) {
        if ([_engine isLoggedIn] && ![_engine isAuthorizeExpired]) {
            [_engine logOut];
        } else {
            [self showSinaBlogLoginController];
        }
    }else if (row == 1){
        if ([_netEaseEngine isLogIn]) {
            [_netEaseEngine logOut];
        } else {
            [self showNetEaseBlogLoginController];
        }
        
    }else if (row == 2){
        NSArray *array = [[FSBaseDB sharedFSBaseDB] getObjectsByKeyWithName:@"FSLoginObject" key:@"userKind" value:LOGIN_USER_KIND_PEOPLE_BLOG];
        if ([array count]>0) {
            [[FSBaseDB sharedFSBaseDB] deleteObjectByKey:@"FSLoginObject" key:@"userKind" value:LOGIN_USER_KIND_PEOPLE_BLOG];
            [[FSBaseDB sharedFSBaseDB].managedObjectContext save:nil];
            [_fsALLSettingContainerView loadData];
        }
        else{
            [self showPeopleLoginController];
        }
    }
    
}

//********************************

-(void)showSinaBlogLoginController{
    
    if (self.isnavTopBar) {
        FSSinaBlogLoginViewController *fsSinaBlogLoginViewController = [[FSSinaBlogLoginViewController alloc] init];
        fsSinaBlogLoginViewController.sinaWBEngine = _engine;
        fsSinaBlogLoginViewController.parentDelegate = self;
        fsSinaBlogLoginViewController.isnavTopBar = YES;
        [self presentModalViewController:fsSinaBlogLoginViewController animated:YES];
        [fsSinaBlogLoginViewController release];
    }
    else{
        FSSinaBlogLoginViewController *fsSinaBlogLoginViewController = [[FSSinaBlogLoginViewController alloc] init];
        fsSinaBlogLoginViewController.sinaWBEngine = _engine;
        fsSinaBlogLoginViewController.parentDelegate = self;
        [self.navigationController pushViewController:fsSinaBlogLoginViewController animated:YES];
        [fsSinaBlogLoginViewController release];
    }
}

-(void)showPeopleLoginController{
    
    if (self.isnavTopBar) {
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

-(void)showNetEaseBlogLoginController{
    
    if (self.isnavTopBar) {
        FSNetEaseBlogShareLoginViewController *fsNetEaseBlogShareLoginViewController = [[FSNetEaseBlogShareLoginViewController alloc] init];
        fsNetEaseBlogShareLoginViewController.engine = _netEaseEngine;
        fsNetEaseBlogShareLoginViewController.parentDelegate = self;
        fsNetEaseBlogShareLoginViewController.isnavTopBar = YES;
        [self presentModalViewController:fsNetEaseBlogShareLoginViewController animated:YES];
        [fsNetEaseBlogShareLoginViewController release];
    }
    else{
        FSNetEaseBlogShareLoginViewController *fsNetEaseBlogShareLoginViewController = [[FSNetEaseBlogShareLoginViewController alloc] init];
        fsNetEaseBlogShareLoginViewController.engine = _netEaseEngine;
        fsNetEaseBlogShareLoginViewController.parentDelegate = self;
        [self.navigationController pushViewController:fsNetEaseBlogShareLoginViewController animated:YES];
        [fsNetEaseBlogShareLoginViewController release];
    }
   
}



//*****************************************

-(void)loginSuccesss:(BOOL)isSuccess{
    [_fsALLSettingContainerView loadData];
}

//--------------------------------------------------------

///WBEngineDelegate
//- (void)engineAlreadyLoggedIn:(WBEngine *)engine {
//
//}

// Log in successfully.
- (void)engineDidLogIn:(WBEngine *)engine {
	[_fsALLSettingContainerView loadData];
}

// Failed to log in.
// Possible reasons are:
// 1) Either username or password is wrong;
// 2) Your app has not been authorized by Sina yet.
- (void)engine:(WBEngine *)engine didFailToLogInWithError:(NSError *)error {
	[_fsALLSettingContainerView loadData];
}

// Log out successfully.
- (void)engineDidLogOut:(WBEngine *)engine {
	[_fsALLSettingContainerView loadData];
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
