//
//  FSCommentListViewController.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-11-30.
//
//


#import "FSCommentListViewController.h"
#import "FS_GZF_CommentListDAO.h"
#import "FSCommentObject.h"


#define FSSETTING_VIEW_NAVBAR_HEIGHT 44.0f


@interface FSCommentListViewController ()

@end

@implementation FSCommentListViewController

@synthesize newsid = _newsid;
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
//    [_fsNewsContainerCommentListView release];
    [_fsNewsCommentListView release];
    [_fs_GZF_CommentListDAO release];
    [super dealloc];
}

-(void)initDataModel{
    _fs_GZF_CommentListDAO = [[FS_GZF_CommentListDAO alloc] init];
    _fs_GZF_CommentListDAO.parentDelegate = self;
    _fs_GZF_CommentListDAO.newsid = self.newsid;
    _fs_GZF_CommentListDAO.count = @"0";
}

-(void)loadChildView{
//    _fsNewsContainerCommentListView = [[FSNewsContainerCommentListView alloc] init];
//    _fsNewsContainerCommentListView.parentDelegate = self;
//    _fsNewsContainerCommentListView.withOutSection = YES;
//    [self.view addSubview:_fsNewsContainerCommentListView];
    
    _fsNewsCommentListView = [[FSNewsCommentListView alloc] init];
    _fsNewsCommentListView.parentDelegate = self;
    [self.view addSubview:_fsNewsCommentListView];
    
    
    
    
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
    
    }
    else{
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
	
    
    
    
}

-(void)layoutControllerViewWithRect:(CGRect)rect{
//    _fsNewsContainerCommentListView.frame = CGRectMake(0, 44.0f, rect.size.width, rect.size.height-44.0f);
    if (_withnavTopBar) {
        _fsNewsCommentListView.frame = CGRectMake(0, 44.0f, rect.size.width, rect.size.height-44.0f);
    }
    else{
        _fsNewsCommentListView.frame = CGRectMake(0.0f, 0.0f, rect.size.width, rect.size.height);
    }
}

-(void)doSomethingForViewFirstTimeShow{
    [_fs_GZF_CommentListDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
}


-(void)doSomethingWithDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status{
    if ([sender isEqual:_fs_GZF_CommentListDAO]) {
        if (status == FSBaseDAOCallBack_BufferSuccessfulStatus || status == FSBaseDAOCallBack_SuccessfulStatus) {
            FSLog(@"_fs_GZF_CommentListDAO:%d",[_fs_GZF_CommentListDAO.objectList count]);
//            [_fsNewsContainerCommentListView loadData];
            _fsNewsCommentListView.data = _fs_GZF_CommentListDAO.objectList;
            if (status == FSBaseDAOCallBack_BufferSuccessfulStatus) {
                [_fs_GZF_CommentListDAO operateOldBufferData];
            }
            
        }
    }
}

-(void)returnBack:(id)sender{
    if (self.withnavTopBar) {
        [self dismissModalViewControllerAnimated:YES];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


-(void)fsBaseContainerViewTouchEvent:(FSBaseContainerView *)sender{
    
    FSCommentObject *o = [_fs_GZF_CommentListDAO.objectList lastObject];
    _fs_GZF_CommentListDAO.lastCommentid = o.commentid;
    [_fs_GZF_CommentListDAO HTTPGetDataWithKind:GET_DataKind_Next];
}


//#pragma mark -
//#pragma FSTableContainerViewDelegate mark
//
//-(CGFloat)getCommentListHeight{
//   
//    NSInteger mark =0;
//    for (FSCommentObject *o in _fs_GZF_CommentListDAO.objectList) {
//        if ([o.adminContent length]>0) {
//            mark = mark + 1;//有管理员回帖？？？？
//        }
//    }
//    return COMMENT_LIEST_CELL_HEIGHT*([_fs_GZF_CommentListDAO.objectList count]+mark);
//}
//
//-(NSInteger)tableViewSectionNumber:(FSTableContainerView *)sender{
//    return 1;
//}
//
//-(NSInteger)tableViewNumberInSection:(FSTableContainerView *)sender section:(NSInteger)section{
//    return [_fs_GZF_CommentListDAO.objectList count];
//}
//
//
//- (NSObject *)tableViewCellData:(FSTableContainerView *)sender withIndexPath:(NSIndexPath *)indexPath {
//    NSInteger row = [indexPath row];
//    
//    if ([_fs_GZF_CommentListDAO.objectList count]>row) {
//        FSCommentObject *obj = [_fs_GZF_CommentListDAO.objectList objectAtIndex:row];
//        return obj;
//    }
//    return nil;
//    
//}
//
//-(NSString *)tableViewSectionTitle:(FSTableContainerView *)sender section:(NSInteger)section{
//    
//    return @"网友热评";
//}
//
//-(void)tableViewDataSourceDidSelected:(FSTableContainerView *)sender withIndexPath:(NSIndexPath *)indexPath{
//    ;
//}
//
//-(void)tableViewTouchPicture:(FSTableContainerView *)sender index:(NSInteger)index{
//    NSLog(@"channel did selected!!");
//    
//}
//
//-(void)tableViewDataSource:(FSTableContainerView *)sender withTableDataSource:(TableDataSource)dataSource{
//    if (dataSource == tdsRefreshFirst) {
//        FSLog(@"FSNewsViewController  tdsRefreshFirst");
//        [_fs_GZF_CommentListDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
//    }
//    if (dataSource == tdsNextSection) {
//        FSCommentObject *o = [_fs_GZF_CommentListDAO.objectList lastObject];
//        _fs_GZF_CommentListDAO.lastCommentid = o.commentid;
//        [_fs_GZF_CommentListDAO HTTPGetDataWithKind:GET_DataKind_Next];
//    }
//}
//
//


@end
