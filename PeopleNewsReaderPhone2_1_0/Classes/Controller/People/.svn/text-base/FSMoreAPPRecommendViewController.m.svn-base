//
//  FSMoreAPPRecommendViewController.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-3-21.
//
//

#import "FSMoreAPPRecommendViewController.h"

#import "FS_GZF_AppRecommendDAO.h"
#import "FSRecommentAPPObject.h"

#import "FSAppStoreViewController.h"

#define FSSETTING_VIEW_NAVBAR_HEIGHT 44.0f

@interface FSMoreAPPRecommendViewController ()

@end

@implementation FSMoreAPPRecommendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



-(void)dealloc{
    
    [_navTopBar release];
    [_fsMoreAPPRecommendView release];
    [_fs_GZF_AppRecommendDAO release];
    [super dealloc];
}


-(void)loadChildView{
    
    _navTopBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, FSSETTING_VIEW_NAVBAR_HEIGHT)];
#ifdef __IPHONE_5_0
    [_navTopBar setBackgroundImage:[UIImage imageNamed: @"navigatorBar.png"] forBarMetrics:UIBarMetricsDefault];
#endif
    
    [self.view addSubview:_navTopBar];
    
    UIButton *returnBT = [[UIButton alloc] init];
    [returnBT setBackgroundImage:[UIImage imageNamed:@"returnbackBT.png"] forState:UIControlStateNormal];
    [returnBT addTarget:self action:@selector(returnBack:) forControlEvents:UIControlEventTouchUpInside];
    returnBT.frame = CGRectMake(3, 7, 55, 30);
    [_navTopBar addSubview:returnBT];
    [returnBT release];
    
    _fsMoreAPPRecommendView = [[FSMoreAPPRecommendView alloc] init];
    _fsMoreAPPRecommendView.parentDelegate = self;
    [self.view addSubview:_fsMoreAPPRecommendView];
}

-(void)returnBack:(id)sender{
    FSLog(@"returnBack");
    
    [self dismissModalViewControllerAnimated:YES];
}


-(void)initDataModel{
    _fs_GZF_AppRecommendDAO = [[FS_GZF_AppRecommendDAO alloc] init];
    _fs_GZF_AppRecommendDAO.parentDelegate = self;
}

-(void)doSomethingForViewFirstTimeShow{
    [_fs_GZF_AppRecommendDAO HTTPGetDataWithKind:GET_DataKind_Unlimited];
}


-(void)layoutControllerViewWithRect:(CGRect)rect{
    _fsMoreAPPRecommendView.frame = CGRectMake(0, 44, rect.size.width, rect.size.height-94);
    
}


#pragma mark -
#pragma FSTableContainerViewDelegate mark


-(NSInteger)tableViewSectionNumber:(FSTableContainerView *)sender{
    return 1;
}

-(NSInteger)tableViewNumberInSection:(FSTableContainerView *)sender section:(NSInteger)section{
    
    return [_fs_GZF_AppRecommendDAO.objectList count];
    
}



-(NSObject *)tableViewCellData:(FSTableContainerView *)sender withIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    return [_fs_GZF_AppRecommendDAO.objectList objectAtIndex:row];
}


-(void)tableViewDataSourceDidSelected:(FSTableContainerView *)sender withIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = [indexPath row];
    
    FSRecommentAPPObject *obj = [_fs_GZF_AppRecommendDAO.objectList objectAtIndex:row];
    NSLog(@"the url is %@",obj.appLink);
    [self addMyWebView:obj];
}



-(void)doSomethingWithDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status{
    if ([sender isEqual:_fs_GZF_AppRecommendDAO]) {
        if (status == FSBaseDAOCallBack_SuccessfulStatus || status == FSBaseDAOCallBack_BufferSuccessfulStatus) {
            
            if ([_fs_GZF_AppRecommendDAO.objectList count]>0) {
                
                [_fsMoreAPPRecommendView loadData];
                
                if (status == FSBaseDAOCallBack_BufferSuccessfulStatus) {
                    [_fs_GZF_AppRecommendDAO operateOldBufferData];
                }
                
            }
        
        }
    }
}



-(void)addMyWebView:(FSRecommentAPPObject *)obj{
    
    
    double version = [[UIDevice currentDevice].systemVersion doubleValue];
    
    if (version >= 6.0 && [obj.applinkid length]>1) {
        
        
        
        NSString *idstr = obj.applinkid;
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
        
    }else{
        
        NSURL *appUrl = [NSURL URLWithString:obj.appLink];
        
        [[UIApplication sharedApplication] openURL:appUrl];
        
        NSLog(@"appUrl is %@",obj.appLink);
    }

    
}

#pragma mark -
#pragma mark SKStoreProductViewControllerDelegate
-(void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:nil];
    
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

@end
