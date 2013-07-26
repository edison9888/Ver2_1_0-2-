//
//  FSAboutViewController.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-31.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSAboutViewController.h"

#import "FSAboutContaierView.h"

#define FSSETTING_VIEW_NAVBAR_HEIGHT 0.0f

@implementation FSAboutViewController

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

#pragma mark - View lifecycle


-(void)dealloc{
    //[_navTopBar release];
    [_fsAboutContaierView release];
    [super dealloc];
}

-(void)loadChildView{
    
    _fsAboutContaierView = [[FSAboutContaierView alloc] init];
    [self.view addSubview:_fsAboutContaierView];
    /*
    _navTopBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, FSSETTING_VIEW_NAVBAR_HEIGHT)];
#ifdef __IPHONE_5_0
    [_navTopBar setBackgroundImage:[UIImage imageNamed: @"navigatorBar.png"] forBarMetrics:UIBarMetricsDefault];
#endif
	UINavigationItem *topItem = [[UINavigationItem alloc] init];
	NSArray *items = [[NSArray alloc] initWithObjects:topItem, nil];
	_navTopBar.items = items;
	_navTopBar.topItem.title = NSLocalizedString(@"关于我们", nil);
	[topItem release];
	[items release];
	[self.view addSubview:_navTopBar];
    */
    self.title = NSLocalizedString(@"关于我们", nil);
    
    
    UIButton *returnBT = [[UIButton alloc] init];
    [returnBT setBackgroundImage:[UIImage imageNamed:@"returnbackBT.png"] forState:UIControlStateNormal];
    //[returnBT setTitle:NSLocalizedString(@"返回", nil) forState:UIControlStateNormal];
    returnBT.titleLabel.font = [UIFont systemFontOfSize:12];
    [returnBT addTarget:self action:@selector(returnBack:) forControlEvents:UIControlEventTouchUpInside];
    [returnBT setTitleColor:COLOR_NEWSLIST_TITLE_WHITE forState:UIControlStateNormal];
    returnBT.frame = CGRectMake(0, 0, 55, 30);
    
    UIBarButtonItem *returnButton = [[UIBarButtonItem alloc] initWithCustomView:returnBT];
    self.navigationItem.leftBarButtonItem = returnButton;
    [returnButton release];
    [returnBT release];
    
      
}

-(void)returnBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)layoutControllerViewWithRect:(CGRect)rect{
    _fsAboutContaierView.backgroundColor = [UIColor whiteColor];
    _fsAboutContaierView.frame = CGRectMake(0, FSSETTING_VIEW_NAVBAR_HEIGHT, rect.size.width, rect.size.height -FSSETTING_VIEW_NAVBAR_HEIGHT);
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
