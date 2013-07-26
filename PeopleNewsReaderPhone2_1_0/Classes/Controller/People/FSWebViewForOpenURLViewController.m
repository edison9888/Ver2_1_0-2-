//
//  FSWebViewForOpenURLViewController.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-1-10.
//
//

#import "FSWebViewForOpenURLViewController.h"

#define TOOL_BROWSER_HEIGHT 44.0f


@interface FSWebViewForOpenURLViewController ()

@end

@implementation FSWebViewForOpenURLViewController

@synthesize urlString = _urlString;
@synthesize  withOutToolbar = _withOutToolbar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    [_webView release];
	[_navTopBar release];
	[_urlString release];
	
	[_backBrowserButton release];
	[_refreshButton release];
	[_goBrowserButton release];
	[_moreButton release];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"deep_refreshCurrentPage" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"deep_returnCurrentPage" object:nil];

    [super dealloc];
}

-(void)initDataModel{
    
}

-(void)loadChildView{
    _firstShow = YES;
    if (_withOutToolbar) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)];
    }else{
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0f, TOOL_BROWSER_HEIGHT, self.view.frame.size.width, self.view.frame.size.height - TOOL_BROWSER_HEIGHT)];
    }
	
	_webView.delegate = self;
	_webView.scalesPageToFit = YES;
	[self.view addSubview:_webView];
	
	_navTopBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, TOOL_BROWSER_HEIGHT)];
    _navTopBar.alpha = 0.0;
#ifdef __IPHONE_5_0
    [_navTopBar setBackgroundImage:[UIImage imageNamed: @"navigatorBar.png"] forBarMetrics:UIBarMetricsDefault];
#endif

	if (!_withOutToolbar) {
        _navTopBar.alpha = 1.0;
        [self.view addSubview:_navTopBar];
    }
    

	UIImage *image = [UIImage imageNamed:@"BT_fanhui.png"];//go-back.png  go-next.png
	UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
	backBtn.frame = CGRectMake(0.0f, 0.0f, image.size.width, image.size.height);
	[backBtn setBackgroundImage:image forState:UIControlStateNormal];
	[backBtn addTarget:self action:@selector(browserBack:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setTitle:NSLocalizedString(@"返回", nil) forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:12];
	//_backBrowserButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(browserBack:)];
    _backBrowserButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
	
	self.navigationItem.leftBarButtonItem = _backBrowserButton;
	
	image = [UIImage imageNamed:@"go-next.png"];
	UIButton *goBtn = [[UIButton alloc] initWithFrame:CGRectZero];
	goBtn.frame = CGRectMake(0.0f, 0.0f, image.size.width, image.size.height);
	[goBtn setBackgroundImage:image forState:UIControlStateNormal];
	[goBtn addTarget:self action:@selector(browserGo:) forControlEvents:UIControlEventTouchUpInside];
	_goBrowserButton = [[UIBarButtonItem alloc] initWithCustomView:goBtn];
	[goBtn release];
	
	
	_refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshCurrentPage:)];
    _refreshButton.tintColor = [UIColor blackColor];
	self.navigationItem.rightBarButtonItem = _refreshButton;
    //self.navigationItem.leftBarButtonItem = _backBrowserButton;
    
    if (!_withOutToolbar) {
        
        backBtn.frame = CGRectMake(3, 7, 55, 30);
        NSLog(@"self.view.frame.size.width:%f",self.view.frame.origin.y);
        
        UIImage *image = [UIImage imageNamed:@"refresh.png"];
        UIButton *refresh = [[UIButton alloc] initWithFrame:CGRectZero];
        refresh.frame = CGRectMake(self.view.frame.size.width - 40, 7, image.size.width, image.size.height);
        [refresh setBackgroundImage:image forState:UIControlStateNormal];
        [refresh addTarget:self action:@selector(refreshCurrentPage:) forControlEvents:UIControlEventTouchUpInside];
       [_navTopBar addSubview:backBtn];
        
        [_navTopBar addSubview:refresh];
        [refresh release];
        
    }

    [backBtn release];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(deep_refreshCurrentPage:)
												 name:@"deep_refreshCurrentPage" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(deep_returnCurrentPage:)
												 name:@"deep_returnCurrentPage" object:nil];
    
}


-(void)doSomethingForViewFirstTimeShow{
    if (_withOutToolbar) {
        _webView.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    }
    else{
        _webView.frame = CGRectMake(0.0f, TOOL_BROWSER_HEIGHT, self.view.frame.size.width, self.view.frame.size.height - TOOL_BROWSER_HEIGHT);
    }
    
    if (_firstShow) {
        //NSLog(@"_urlString:%@",_urlString);
        NSURL *url = [[NSURL alloc] initWithString:_urlString];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        [_webView loadRequest:request];
        [request release];
        [url release];
        _firstShow = NO;
    }

}

-(void)deep_refreshCurrentPage:(NSNotification *)sender{
    [_webView reload];
}


-(void)deep_returnCurrentPage:(NSNotification *)sender{
    NSLog(@"deep_returnCurrentPage。。。。。。");
    //[self.navigationController popViewControllerAnimated:YES];
    [self dismissModalViewControllerAnimated:YES];
}



- (void)goBackToParent:(id)sender {
	[self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)browserGo:(id)sender {
	[_webView goForward];
}

- (void)refreshCurrentPage:(id)sender {
	[_webView reload];
}


- (void)browserBack:(id)sender {
    if (_webView.canGoBack) {
        [_webView goBack];
    }
    else{
        if (!_withOutToolbar){
            [self dismissModalViewControllerAnimated:YES];
        }
        else{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
    }
}



#pragma mark -
#pragma mark UIWebViewDelegate
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    //NSLog(@"webViewDidStartLoad");
	
    
    FSIndicatorMessageView *indicatorMessageView = [[FSIndicatorMessageView alloc] initWithFrame:CGRectZero];
    [indicatorMessageView showIndicatorMessageViewInView:self.view withMessage: NSLocalizedString(@"DAOCallBack_Working", @"正在努力加载...")];
    [indicatorMessageView release];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	
    
    [FSIndicatorMessageView dismissIndicatorMessageViewInView:self.view];
    
    	
	_goBrowserButton.enabled = webView.canGoForward;
	
	NSString *js = @"document.title";
#ifdef MYDEBUG
	NSLog(@"title=%@", [webView stringByEvaluatingJavaScriptFromString:js]);
#endif
	self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:js];
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}





@end
