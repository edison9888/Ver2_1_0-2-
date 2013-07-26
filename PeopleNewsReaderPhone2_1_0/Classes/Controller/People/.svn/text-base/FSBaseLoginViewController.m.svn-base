//
//  FSBaseLoginViewController.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-11-8.
//
//

#import "FSBaseLoginViewController.h"


#define LEFT_RIGHT_SPACE (IS_IPAD ? 24.0f : 6.0f)
#define COL_SPACE (IS_IPAD ? 16.0f : 8.0f)
#define TEXT_CONTROL_HEIGHT_SCALE 1.2
#define TOP_BOTTOM_SAPCE (IS_IPAD ? 30.0f : 30.0f)

#define ROW_SPACE (IS_IPAD ? 32.0f : 12.0f)

#define LABEL_WORD_FORAMT @"中中中中中"

#define BUTTON_WIDTH 113.0f
#define BUTTON_HEIGHT 30.0f
#define FSSETTING_VIEW_NAVBAR_HEIGHT 44.0f


//#define LOGIN_SUCCESSFUL_FLAG 1001



@interface FSBaseLoginViewController ()

@end

@implementation FSBaseLoginViewController

@synthesize parentDelegate = _parentDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.isnavTopBar = NO;
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
    [_tfUser release];
	[_tfPWD release];
	[_lblUser release];
	[_lblPWD release];
	[_btnLogin release];
    [_lblDescription release];
	[_ivDescription release];
    if (self.isnavTopBar){
        [_navTopBar release];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [super dealloc];
}


-(void)loadChildView{
    
	//注册键盘通知
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWasShown:)
												 name:UIKeyboardWillShowNotification object:nil];
	
	
    
    if (self.isnavTopBar) {
        
        _navTopBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, FSSETTING_VIEW_NAVBAR_HEIGHT)];
#ifdef __IPHONE_5_0
        [_navTopBar setBackgroundImage:[UIImage imageNamed: @"navigatorBar.png"] forBarMetrics:UIBarMetricsDefault];
#endif
        UINavigationItem *topItem = [[UINavigationItem alloc] init];
        NSArray *items = [[NSArray alloc] initWithObjects:topItem, nil];
        _navTopBar.items = items;
        _navTopBar.topItem.title = self.title;
        [topItem release];
        [items release];
        [self.view addSubview:_navTopBar];
        
        
        UIButton *returnBT = [[UIButton alloc] init];
        [returnBT setBackgroundImage:[UIImage imageNamed:@"returnbackBT.png"] forState:UIControlStateNormal];
        //[returnBT setTitle:NSLocalizedString(@"返回", nil) forState:UIControlStateNormal];
        returnBT.titleLabel.font = [UIFont systemFontOfSize:12];
        [returnBT addTarget:self action:@selector(goBackToParent:) forControlEvents:UIControlEventTouchUpInside];
        [returnBT setTitleColor:COLOR_NEWSLIST_TITLE_WHITE forState:UIControlStateNormal];
        returnBT.frame = CGRectMake(0, 0, 55, 30);
        
        returnBT.frame = CGRectMake(3, 7, 55, 30);
        [_navTopBar addSubview:returnBT];
        [returnBT release];
        
    }
    else{
        //返回按钮
        UIButton *returnBT = [[UIButton alloc] init];
        [returnBT setBackgroundImage:[UIImage imageNamed:@"returnbackBT.png"] forState:UIControlStateNormal];
        //[returnBT setTitle:NSLocalizedString(@"返回", nil) forState:UIControlStateNormal];
        returnBT.titleLabel.font = [UIFont systemFontOfSize:12];
        [returnBT addTarget:self action:@selector(goBackToParent:) forControlEvents:UIControlEventTouchUpInside];
        [returnBT setTitleColor:COLOR_NEWSLIST_TITLE_WHITE forState:UIControlStateNormal];
        returnBT.frame = CGRectMake(0, 0, 55, 30);
        
        //self.navigationItem.leftBarButtonItem
        
        
        UIBarButtonItem *returnButton = [[UIBarButtonItem alloc] initWithCustomView:returnBT];
        self.navigationItem.leftBarButtonItem = returnButton;
        [returnButton release];
        [returnBT release];
    }
        
	
    
	
	//初始化屏幕控件
	_ivDescription = [[UIImageView alloc] initWithFrame:CGRectZero];
	_ivDescription.image = [UIImage imageNamed:[self bagroundImageName]];
    _ivDescription.alpha = 0.4f;
	[self.view addSubview:_ivDescription];
	
	
	_lblUser = [[UILabel alloc] initWithFrame:CGRectZero];
	[_lblUser setBackgroundColor:[UIColor clearColor]];
	[_lblUser setFont:[UIFont boldSystemFontOfSize:18.0f]];
	[_lblUser setTextAlignment:UITextAlignmentRight];
	_lblUser.text = @"用户名:";
	[self.view addSubview:_lblUser];
	
	_lblPWD = [[UILabel alloc] initWithFrame:CGRectZero];
	[_lblPWD setBackgroundColor:[UIColor clearColor]];
	_lblPWD.text = @"密码:";
	[_lblPWD setFont:[UIFont boldSystemFontOfSize:18.0f]];
	[_lblPWD setTextAlignment:UITextAlignmentRight];
	[self.view addSubview:_lblPWD];
	
	_tfUser = [[UITextField alloc] initWithFrame:CGRectZero];
	[_tfUser setFont:[UIFont systemFontOfSize:16.0f]];
	_tfUser.placeholder = [self inputUserNamnePrompt];
	_tfUser.borderStyle = UITextBorderStyleRoundedRect;
	[self.view addSubview:_tfUser];
	
	
	_tfPWD = [[UITextField alloc] initWithFrame:CGRectZero];
	_tfPWD.placeholder = @"请输入密码";
	_tfPWD.borderStyle = UITextBorderStyleRoundedRect;
	_tfPWD.secureTextEntry = YES;
	[_tfPWD setFont:[UIFont systemFontOfSize:16.0f]];
	[self.view addSubview:_tfPWD];
	
	//UIColor *btnColor = [UIColor colorWithRed:58.0f / 255.0f green:151.0f / 255.0f blue:3.0f / 255.0f alpha:1.0f];
	//UIColor *btnColor = [UIColor colorWithRed:128.0f / 255.0f green:128.0f / 255.0f blue:128.0f / 255.0f alpha:1.0f];
	//SUIImage *imgBtn = createImageWithRect(CGRectMake(0.0f, 0.0f, BUTTON_WIDTH, BUTTON_HEIGHT), 8.0f, CGColorGetComponents(btnColor.CGColor), CGColorGetNumberOfComponents(btnColor.CGColor));
	
	_btnLogin = [[UIButton alloc] initWithFrame:CGRectZero];
	//UIImage *imgBtn = [[UIImage imageNamed:@"btnbg.png"] stretchableImageWithLeftCapWidth:12 topCapHeight:4];
    [_btnLogin setBackgroundImage:[UIImage imageNamed:@"login_denglu.png"] forState:UIControlStateNormal];
	//[_btnLogin setTitle:@"登录" forState:UIControlStateNormal];
	[_btnLogin setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[_btnLogin.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
	[_btnLogin addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
	//[_btnLogin setBackgroundImage:imgBtn forState:UIControlStateNormal];
	[_btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[self.view addSubview:_btnLogin];
	
	_lblDescription = [[UILabel alloc] initWithFrame:CGRectZero];
	[_lblDescription setFont:[UIFont boldSystemFontOfSize:24.0f]];
	[_lblDescription setBackgroundColor:[UIColor clearColor]];
	[_lblDescription setTextAlignment:UITextAlignmentCenter];
	[_lblDescription setNumberOfLines:99];
	[_lblDescription setTextColor:[UIColor colorWithRed:209.0f / 255.0f green:10.0f / 255.0f blue:10.0f / 255.0f alpha:0.95]];
	[self.view addSubview:_lblDescription];
    
}

- (void)goBackToParent:(id)sender {
    
    if (self.isnavTopBar){
        [self dismissModalViewControllerAnimated:YES];
        return;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)login:(id)sender{
    [self loginServer:self];
}

-(void)loginServer:(FSBaseLoginViewController *)sender{
    
}

-(NSString *)inputUserNamnePrompt{
    return nil;
}

-(NSString *)bagroundImageName{
    return nil;
}

-(void)doSomethingForViewFirstTimeShow{
    [_tfUser becomeFirstResponder];
}


- (void)keyboardWasShown:(NSNotification *)notification {
	NSDictionary *info = [notification userInfo];
	NSValue *value = nil;
	
	if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2) {
		value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
	} else {
#ifndef __IPHONE_3_2
		value = [info objectForKey:UIKeyboardBoundsUserInfoKey];
#endif
	}
	
	CGSize keyboardSize = [value CGRectValue].size;
	if (keyboardSize.width == _keyboardSize.width &&
		keyboardSize.height == _keyboardSize.height) {
		return;
	}
    CGFloat beginy=0.0f;
    if (self.isnavTopBar) {
        beginy = FSSETTING_VIEW_NAVBAR_HEIGHT;
    }
    
	_keyboardSize = keyboardSize;
	//STEP 1.计算高度
	_clientHeight = 0.0f;
	//CGSize clientSize = getCurrentViewFrameWithKeyboardSize(keyboardSize, self.interfaceOrientation, self);
	//_clientHeight = clientSize.height;
	
	
	//STEP 2.顶图
	//_ivDescription.frame = CGRectMake((self.view.frame.size.width - _ivDescription.image.size.width) / 2.0f, TOP_BOTTOM_SAPCE, _ivDescription.image.size.width, _ivDescription.image.size.height);
	_ivDescription.frame = CGRectMake(0.0f, beginy, self.view.frame.size.width, self.view.frame.size.height);
	
	//STEP 3.计算行间距
	CGFloat top = TOP_BOTTOM_SAPCE + beginy;// + _ivDescription.image.size.height + TOP_BOTTOM_SAPCE;
	CGFloat left = LEFT_RIGHT_SPACE;
	CGFloat rowSpace = ROW_SPACE;
	
	CGSize sizeTmpForUserRow = [LABEL_WORD_FORAMT sizeWithFont:_lblUser.font];
	sizeTmpForUserRow.height *=  TEXT_CONTROL_HEIGHT_SCALE;
	
	CGSize sizeTmpForPasswordRow = [LABEL_WORD_FORAMT sizeWithFont:_lblPWD.font];
	sizeTmpForPasswordRow.height *=  TEXT_CONTROL_HEIGHT_SCALE;
	
    //STEP 4.用户名行
	_lblUser.frame = CGRectMake(left, top, sizeTmpForUserRow.width, sizeTmpForUserRow.height);
	_tfUser.frame = CGRectMake(left + sizeTmpForUserRow.width + COL_SPACE,
														  top,
														  self.view.frame.size.width - left - sizeTmpForUserRow.width - COL_SPACE - LEFT_RIGHT_SPACE * 2.5f,
														  sizeTmpForUserRow.height);
	top += (sizeTmpForUserRow.height + rowSpace);
	
	//STEP 5.密码行
	
	
	_lblPWD.frame = CGRectMake(left, top, sizeTmpForPasswordRow.width, sizeTmpForPasswordRow.height);
	_tfPWD.frame = CGRectMake(left + sizeTmpForPasswordRow.width + COL_SPACE,
														 top,
														 self.view.frame.size.width - left - sizeTmpForPasswordRow.width - COL_SPACE - LEFT_RIGHT_SPACE * 2.5f,
														 sizeTmpForPasswordRow.height);
	top += (sizeTmpForPasswordRow.height + rowSpace);
	
	//STEP 6.按钮行
	//	if (_showRegisterButton) {
	//		_btnRegister.frame = [CommonFuncs roundSideRect:CGRectMake(LEFT_RIGHT_SPACE, top, BUTTON_WIDTH, BUTTON_HEIGHT)];
	//		_btnLogin.frame = [CommonFuncs roundSideRect:CGRectMake(self.view.frame.size.width - LEFT_RIGHT_SPACE - BUTTON_WIDTH, top, BUTTON_WIDTH, BUTTON_HEIGHT)];
	//	} else {
	//		_btnLogin.frame = [CommonFuncs roundSideRect:CGRectMake((self.view.frame.size.width - BUTTON_WIDTH) / 2.0f, top, BUTTON_WIDTH, BUTTON_HEIGHT)];
	//	}
	
    NSLog(@"top:%f",top);
	_btnLogin.frame = CGRectMake((self.view.frame.size.width - BUTTON_WIDTH) / 2.0f, top, BUTTON_WIDTH, BUTTON_HEIGHT);
}

-(void)returnToParentView{
    if (self.isnavTopBar){
        [self dismissModalViewControllerAnimated:YES];
        return;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
