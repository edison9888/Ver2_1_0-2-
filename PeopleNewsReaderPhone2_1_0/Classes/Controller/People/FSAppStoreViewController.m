//
//  FSAppStoreViewController.m
//  PeopleNewsReaderPhone
//
//  Created by Qin,Zhuoran on 12-12-18.
//
//

#import "FSAppStoreViewController.h"

@interface FSAppStoreViewController ()

@end

@implementation FSAppStoreViewController

@synthesize url;
@synthesize isprsend = _isprsend;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        url = [[NSString alloc]init];
        self.isprsend = NO;
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
    [url release];
    [super dealloc];
}

#pragma mark - view life cycle

-(void)loadChildView{
    
    /*
    self.title = NSLocalizedString(@"App Store", nil);
    
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
    
    _fsAppStoreContainerView = [[FSAppStoreContainerView alloc]init];
    _fsAppStoreContainerView.data = self.url;
    //[_fsAppStoreContainerView setUrl:self.url];
    
    [self.view addSubview:_fsAppStoreContainerView];
    NSLog(@"_fsAppStoreContainerView.url %@",_fsAppStoreContainerView.url);
    //NSLog(@"self.url %@",self.url);
     */
   
    UIButton *returnBT = [[UIButton alloc] init];
    [returnBT setBackgroundImage:[UIImage imageNamed:@"returnbackBT.png"] forState:UIControlStateNormal];
    //[returnBT setTitle:NSLocalizedString(@"返回", nil) forState:UIControlStateNormal];
    returnBT.titleLabel.font = [UIFont systemFontOfSize:12];
    [returnBT addTarget:self action:@selector(returnBack:) forControlEvents:UIControlEventTouchUpInside];
    [returnBT setTitleColor:COLOR_NEWSLIST_TITLE_WHITE forState:UIControlStateNormal];
    returnBT.frame = CGRectMake(0, 0, 55, 30);
    
    UIBarButtonItem *returnButton = [[UIBarButtonItem alloc] initWithCustomView:returnBT];
    self.navigationItem.leftBarButtonItem = returnButton;
    
    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view setAlpha:0.4];
    UIActivityIndicatorView *_activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:self.view.frame];
    [_activityIndicatorView setCenter:self.view.center];
    [_activityIndicatorView setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleWhiteLarge];  //颜色根据不同的界面调整
    [_activityIndicatorView startAnimating];
    [self.view addSubview:_activityIndicatorView];
    
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
    
    NSString *idstr = self.url;
    NSInteger number = [idstr integerValue];
    NSLog(@"integer is %d",number);
    SKStoreProductViewController *storeViewController =
    [[SKStoreProductViewController alloc] init];
    
    storeViewController.delegate = self;
    
    
    NSDictionary *parameters =
    @{SKStoreProductParameterITunesItemIdentifier:
    [NSNumber numberWithInteger:number]};
    
    [storeViewController loadProductWithParameters:parameters
                                   completionBlock:^(BOOL result, NSError *error) {
                                       if (result)
                                           [self presentViewController:storeViewController animated:NO completion:nil];
                                   }];
    
    [returnButton release];
    [returnBT release];

}

#pragma mark -
#pragma mark SKStoreProductViewControllerDelegate
-(void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:nil];
    
    //[self.navigationController setNavigationBarHidden:NO animated:NO];
    if (self.isprsend) {
        [self dismissModalViewControllerAnimated:NO];
    }
    else{
        [self.navigationController popViewControllerAnimated:NO];
    }
}


-(void)returnBack:(id)sender{
    if (self.isprsend) {
        [self dismissModalViewControllerAnimated:YES];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)layoutControllerViewWithRect:(CGRect)rect{
        
} 

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



@end
