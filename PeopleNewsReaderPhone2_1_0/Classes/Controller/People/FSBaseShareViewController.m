//
//  FSBaseShareViewController.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-11-7.
//
//

#import "FSBaseShareViewController.h"

#define FSSETTING_VIEW_NAVBAR_HEIGHT 44.0f


@interface FSBaseShareViewController ()

@end

@implementation FSBaseShareViewController
@synthesize withnavTopBar = _withnavTopBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _withnavTopBar = NO;
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
    [_fsBlogShareContentView release];
    [_fsShareNoticView release];
    [_navTopBar release];
    [super dealloc];
}


-(void)loadChildView{
    
    _navTopBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 44.0f)];
#ifdef __IPHONE_5_0
    [_navTopBar setBackgroundImage:[UIImage imageNamed: @"navigatorBar.png"] forBarMetrics:UIBarMetricsDefault];
#endif
    
    if (_withnavTopBar) {
        UINavigationItem *topItem = [[UINavigationItem alloc] init];
        NSArray *items = [[NSArray alloc] initWithObjects:topItem, nil];
        _navTopBar.items = items;
        _navTopBar.topItem.title = NSLocalizedString(@"网友评论", nil);
        [topItem release];
        [items release];
        [self.view addSubview:_navTopBar];
        
        
        UIButton *returnBT = [[UIButton alloc] init];
        [returnBT setBackgroundImage:[UIImage imageNamed:@"returnbackBT.png"] forState:UIControlStateNormal];
        [returnBT addTarget:self action:@selector(returnBack:) forControlEvents:UIControlEventTouchUpInside];
        [returnBT setTitleColor:COLOR_NEWSLIST_TITLE_WHITE forState:UIControlStateNormal];
        returnBT.frame = CGRectMake(0, (FSSETTING_VIEW_NAVBAR_HEIGHT-34)/2, 65, 34);
        
        [_navTopBar addSubview:returnBT];
        [returnBT release];
        
        UIButton *senderBT = [[UIButton alloc] init];
        [senderBT setBackgroundImage:[UIImage imageNamed:@"top_2.png"] forState:UIControlStateNormal];
        [senderBT setTitle:@"分享" forState:UIControlStateNormal];
        senderBT.titleLabel.font = [UIFont systemFontOfSize:12];
        [senderBT addTarget:self action:@selector(senderBt:) forControlEvents:UIControlEventTouchUpInside];
        [senderBT setTitleColor:COLOR_NEWSLIST_TITLE_WHITE forState:UIControlStateNormal];
        senderBT.frame = CGRectMake(self.view.frame.size.width-55, (FSSETTING_VIEW_NAVBAR_HEIGHT-34)/2, 55, 34);
        
        
        [_navTopBar addSubview:senderBT];
        [senderBT release];
        

    
    }
    else{
        UIButton *returnBT = [[UIButton alloc] init];
        [returnBT setBackgroundImage:[UIImage imageNamed:@"returnbackBT.png"] forState:UIControlStateNormal];
        //[returnBT setTitle:NSLocalizedString(@"返回", nil) forState:UIControlStateNormal];
        returnBT.titleLabel.font = [UIFont systemFontOfSize:12];
        [returnBT addTarget:self action:@selector(returnBack:) forControlEvents:UIControlEventTouchUpInside];
        [returnBT setTitleColor:COLOR_NEWSLIST_TITLE_WHITE forState:UIControlStateNormal];
        returnBT.frame = CGRectMake(0, 0, 55, 30);
        
        //self.navigationItem.leftBarButtonItem
        
        
        UIBarButtonItem *returnButton = [[UIBarButtonItem alloc] initWithCustomView:returnBT];
        self.navigationItem.leftBarButtonItem = returnButton;
        [returnButton release];
        [returnBT release];
        
        
        UIButton *senderBT = [[UIButton alloc] init];
        [senderBT setBackgroundImage:[UIImage imageNamed:@"top_2.png"] forState:UIControlStateNormal];
        [senderBT setTitle:@"分享" forState:UIControlStateNormal];
        senderBT.titleLabel.font = [UIFont systemFontOfSize:12];
        [senderBT addTarget:self action:@selector(senderBt:) forControlEvents:UIControlEventTouchUpInside];
        [senderBT setTitleColor:COLOR_NEWSLIST_TITLE_WHITE forState:UIControlStateNormal];
        senderBT.frame = CGRectMake(0, 0, 55, 30);
        
        //self.navigationItem.leftBarButtonItem
        
        
        UIBarButtonItem *senderButton = [[UIBarButtonItem alloc] initWithCustomView:senderBT];
        self.navigationItem.rightBarButtonItem = senderButton;
        [senderButton release];
        [senderBT release];

        
    }

    
    
    _fsBlogShareContentView = [[FSBlogShareContentView alloc] init];
    _fsBlogShareContentView.parentDelegate = self;
    _fsBlogShareContentView.shareContent = self.shareContent;
    _fsBlogShareContentView.dataContent = self.dataContent;
    [self.view addSubview:_fsBlogShareContentView];
    
    _fsShareNoticView = [[FSShareNoticView alloc] init];
    _fsShareNoticView.parentDelegate = self;
    _fsShareNoticView.alpha = 0.0f;
    [self.view addSubview:_fsShareNoticView];
    
}

-(void)returnBack:(id)sender{
    if (_withnavTopBar){
        [self dismissModalViewControllerAnimated:YES];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(void)senderBt:(id)sender{
    [self postShareMessage];
}

-(void)postShareMessage{
    
}

-(void)initDataModel{
    
}

-(void)layoutControllerViewWithRect:(CGRect)rect{
    if (self.withnavTopBar) {
        _fsBlogShareContentView.frame = CGRectMake(0, 44.0f, rect.size.width, rect.size.height-44.0f);
    }
    else{
        _fsBlogShareContentView.frame = CGRectMake(0, 0.0f, rect.size.width, rect.size.height);
    }
    
    _fsShareNoticView.frame = CGRectMake((rect.size.width - 219)/2, (rect.size.height-160)/2, 219, 70);
}


-(void)doSomethingForViewFirstTimeShow{
    
}

-(void)doSomethingWithDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status{
    
}

-(void)returnToParentView{
    if (_withnavTopBar){
        [self dismissModalViewControllerAnimated:YES];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}




@end
