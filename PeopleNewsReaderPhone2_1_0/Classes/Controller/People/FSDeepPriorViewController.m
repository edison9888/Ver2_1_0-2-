//
//  FSDeepPriorViewController.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-2.
//
//

#import "FSDeepPriorViewController.h"
#import "FSDeepPriorFocusObject.h"
#import "FSDeepPageContainerController.h"
#import "FSWebViewForOpenURLViewController.h"
#import "FSNewsContainerViewController.h"

#import "FSDeepPriorTOPpageControllView.h"

#import "FS_GZF_DeepPriorListDAO.h"
#import "FS_GZF_DeepPriorDAO.h"


#define FSDEEP_PRIOR_TOP_FOCUS_HEIGHT 185.0f

#define FSDEEP_PRIOR_TOP_INFO_HEIGHT 30.0f

@interface FSDeepPriorViewController ()

@end

@implementation FSDeepPriorViewController

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

- (void)dealloc {
//    _deepTopPriorData.parentDelegate = nil;
//    _deepBottomPriorData.parentDelegate = nil;
//    [_deepTopPriorData release];
//    [_deepBottomPriorData release];

    
    [_topContainerView release];
    [_tvList release];
    [_lblTopInfo release];
    _fs_GZF_DeepPriorDAO.parentDelegate = NULL;
    [_fs_GZF_DeepPriorDAO release];
    _fs_GZF_DeepPriorListDAO.parentDelegate = NULL;
    [_fs_GZF_DeepPriorListDAO release];
    [super dealloc];
}

- (void)initDataModel {
    //_deepTopPriorData = [[FSDeepPriorDAO alloc] init];
    //_deepTopPriorData.parentDelegate = self;
    
    //_deepBottomPriorData = [[FSDeepPriorListDAO alloc] init];
    //_deepBottomPriorData.parentDelegate = self;
    
    _fs_GZF_DeepPriorListDAO = [[FS_GZF_DeepPriorListDAO alloc] init];
    _fs_GZF_DeepPriorListDAO.parentDelegate = self;
    
    _fs_GZF_DeepPriorDAO = [[FS_GZF_DeepPriorDAO alloc] init];
    _fs_GZF_DeepPriorDAO.parentDelegate = self;
    
}

- (void)doSomethingForViewFirstTimeShow {
    //_deepTopPriorData.deepid = self.deepid;
    //[_deepTopPriorData GETData];
    
    
    _fs_GZF_DeepPriorDAO.deepid = self.deepid;
    [_fs_GZF_DeepPriorDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
    _canDELETE = NO;
    
    //_fs_GZF_DeepPriorListDAO.deepid = self.deepid;
    //[_fs_GZF_DeepPriorListDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
    
}

- (void)loadChildView {
    
    
    UIImageView *imageBGR = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"deep_baground.png"]];
    imageBGR.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:imageBGR];
    [imageBGR release];
    
    _topContainerView = [[FSHorizontalScrollPageContainerView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, FSDEEP_PRIOR_TOP_FOCUS_HEIGHT)];
    _topContainerView.delegate = self;
    [self.view addSubview:_topContainerView];
    
    _lblTopInfo = [[UILabel alloc] initWithFrame:CGRectZero];
    [_lblTopInfo setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.75]];
    [_lblTopInfo setFont:[UIFont systemFontOfSize:16.0f]];
    [_lblTopInfo setTextAlignment:NSTextAlignmentRight];
    [_lblTopInfo setTextColor:[UIColor whiteColor]];
    //[self.view addSubview:_lblTopInfo];
    
    _fsDeepPriorTOPpageControllView = [[FSDeepPriorTOPpageControllView alloc] init];
    [self.view addSubview:_fsDeepPriorTOPpageControllView];
    
//    _bottomContainerView = [[FSHorizontalScrollPageContainerView alloc] initWithFrame:CGRectMake(0.0f, FSDEEP_PRIOR_TOP_FOCUS_HEIGHT, self.view.frame.size.width, self.view.frame.size.height - FSDEEP_PRIOR_TOP_FOCUS_HEIGHT)];
//    _bottomContainerView.delegate = self;
//    [self.view addSubview:_bottomContainerView];
    _tvList = [[FSTableView alloc] initWithFrame:CGRectMake(0.0f, FSDEEP_PRIOR_TOP_FOCUS_HEIGHT, self.view.frame.size.width, self.view.frame.size.height - FSDEEP_PRIOR_TOP_FOCUS_HEIGHT) style:UITableViewStylePlain];
    _tvList.dataSource = self;
    _tvList.delegate = self;
    _tvList.assistantViewFlag = FSTABLEVIEW_ASSISTANT_BOTTOM_VIEW;
    _tvList.parentDelegate = self;
    _tvList.separatorStyle = NO;
    _tvList.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tvList];
}

- (void)layoutControllerViewWithRect:(CGRect)rect {
    _topContainerView.frame = CGRectMake(0.0f, 0.0f, rect.size.width, FSDEEP_PRIOR_TOP_FOCUS_HEIGHT);
    _lblTopInfo.frame = CGRectMake(0.0f, FSDEEP_PRIOR_TOP_FOCUS_HEIGHT - FSDEEP_PRIOR_TOP_INFO_HEIGHT, rect.size.width, FSDEEP_PRIOR_TOP_INFO_HEIGHT);
    _fsDeepPriorTOPpageControllView.frame = CGRectMake(0.0f, FSDEEP_PRIOR_TOP_FOCUS_HEIGHT - FSDEEP_PRIOR_TOP_INFO_HEIGHT, rect.size.width, FSDEEP_PRIOR_TOP_INFO_HEIGHT);
    //_bottomContainerView.frame = CGRectMake(0.0f, FSDEEP_PRIOR_TOP_FOCUS_HEIGHT, rect.size.width, rect.size.height - FSDEEP_PRIOR_TOP_FOCUS_HEIGHT);
    _tvList.frame = CGRectMake(0.0f, FSDEEP_PRIOR_TOP_FOCUS_HEIGHT, rect.size.width, rect.size.height - FSDEEP_PRIOR_TOP_FOCUS_HEIGHT-26);
}

- (void)doSomethingWithDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status {
    NSLog(@"doSomethingWithDAO:%@",sender);
//    if ([sender isEqual:_deepTopPriorData]) {
//        if (status == FSBaseDAOCallBack_BufferSuccessfulStatus ||
//            status == FSBaseDAOCallBack_SuccessfulStatus) {
//            [_topContainerView loadPages];
//            _deepBottomPriorData.deepid = self.deepid;
//            [_deepBottomPriorData GETData];
//        }
//    } else if ([sender isEqual:_deepBottomPriorData]) {
//        if (status == FSBaseDAOCallBack_BufferSuccessfulStatus ||
//            status == FSBaseDAOCallBack_SuccessfulStatus) {
//            NSArray *sections = [_deepBottomPriorData.fetchedResultsController sections];
//            id<NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:0];
//            NSInteger numberOfObjects = [sectionInfo numberOfObjects];
//            FSLog(@"numberOfObjects:%d", numberOfObjects);
//            
//            [_tvList loaddingComplete];
//            [_tvList reloadData];
//        }
//    }
    
    if ([sender isEqual:_fs_GZF_DeepPriorDAO]) {
        if (status == FSBaseDAOCallBack_BufferSuccessfulStatus || status == FSBaseDAOCallBack_SuccessfulStatus) {
            NSLog(@"_fs_GZF_DeepPriorDAO:%d",[_fs_GZF_DeepPriorDAO.objectList count]);
            [_topContainerView loadPages];
            if (status == FSBaseDAOCallBack_SuccessfulStatus) {
                [_fs_GZF_DeepPriorDAO operateOldBufferData];
                _fs_GZF_DeepPriorListDAO.deepid = self.deepid;
                [_fs_GZF_DeepPriorListDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
            }
        }
    }
    else if ([sender isEqual:_fs_GZF_DeepPriorListDAO]){
        if (status == FSBaseDAOCallBack_BufferSuccessfulStatus ||
            status == FSBaseDAOCallBack_SuccessfulStatus) {
        
            FSLog(@"numberOfObjects:%d", [_fs_GZF_DeepPriorListDAO.objectList count]);
            [_tvList loaddingComplete];
            [_tvList reloadData];
            if (status == FSBaseDAOCallBack_SuccessfulStatus) {
                [_fs_GZF_DeepPriorListDAO operateOldBufferData];
                _canDELETE = YES;
            }
            
        }
    }
}

#pragma -
//视图数量
- (NSInteger)horizontalScrollPageContainerViewPageCount:(FSHorizontalScrollPageContainerView *)sender {
    if ([sender isEqual:_topContainerView]) {
        //NSArray *sections = [_deepTopPriorData.fetchedResultsController sections];
        if ([_fs_GZF_DeepPriorDAO.objectList count] > 0) {
            _fsDeepPriorTOPpageControllView.pageNumber = [_fs_GZF_DeepPriorDAO.objectList count];
            return [_fs_GZF_DeepPriorDAO.objectList count];
        } else {
            _fsDeepPriorTOPpageControllView.pageNumber = 0;
            return 0;
        }
    } /*else if ([sender isEqual:_bottomContainerView]) {
        NSArray *sections = [_deepBottomPriorData.fetchedResultsController sections];
        if ([sections count] > 0) {
            id<NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:0];
            return [sectionInfo numberOfObjects];
        } else {
            return 0;
        }
    } */else {
        return 0;
    }
}
//视图
- (UIView *)horizontalScrollPageContainerViewPageView:(FSHorizontalScrollPageContainerView *)sender withPageNumber:(NSInteger)pageNumber {
    if ([sender isEqual:_topContainerView]) {
        //NSIndexPath *indexPath = [sender indexPathWithPageNumber:pageNumber];
        
        //FSDeepPriorFocusObject *focusObj = [_deepTopPriorData.fetchedResultsController objectAtIndexPath:indexPath];
        if (pageNumber<[_fs_GZF_DeepPriorDAO.objectList count]) {
            FSDeepPriorFocusObject *focusObj = [_fs_GZF_DeepPriorDAO.objectList objectAtIndex:pageNumber];
            NSLog(@"focusObj.picture:%@",focusObj.picture);
            FSDeepPriorPictureView *picView = [[[FSDeepPriorPictureView alloc] initWithFrame:CGRectMake(pageNumber * sender.frame.size.width, 0.0f, sender.frame.size.width, sender.frame.size.height)] autorelease];
            [picView setPictureURLString:focusObj.picture];
            return picView;
        }
        return nil;
    } /*else if ([sender isEqual:_bottomContainerView]) {
        NSIndexPath *indexPath = [sender indexPathWithPageNumber:pageNumber];
        FSTopicPriorObject *topicObj = [_deepBottomPriorData.fetchedResultsController objectAtIndexPath:indexPath];
        FSDeepPriorListView *priorView = [[[FSDeepPriorListView alloc] initWithFrame:CGRectMake(pageNumber * sender.frame.size.width, 0.0f, sender.frame.size.width, sender.frame.size.height)] autorelease];
        [priorView setTopicPriorObject:topicObj];
        return priorView;
    } */else {
        return nil;
    }
}

//选中的视图
- (void)horizontalScrollPageContainerViewDidSelected:(FSHorizontalScrollPageContainerView *)sender withPageNumber:(NSInteger)pageNumber {
    
    if (pageNumber<[_fs_GZF_DeepPriorDAO.objectList count]) {
        FSDeepPriorFocusObject *linkObj = [_fs_GZF_DeepPriorDAO.objectList objectAtIndex:pageNumber];
        if ([linkObj.flag integerValue] == 1) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"isPopoNext" object:self userInfo:nil];
            FSNewsContainerViewController *fsNewsContainerViewController = [[FSNewsContainerViewController alloc] init];
            
            fsNewsContainerViewController.obj = nil;
            fsNewsContainerViewController.FCObj = nil;
            fsNewsContainerViewController.newsSourceKind = NewsSourceKind_ShiKeNews;
            fsNewsContainerViewController.isNewNavigation = YES;
            [self presentModalViewController:fsNewsContainerViewController animated:YES];
            //[self.fsSlideViewController pres:fsNewsContainerViewController animated:YES];
            [fsNewsContainerViewController release];
            [[FSBaseDB sharedFSBaseDB] updata_visit_message:linkObj.deepid];
        }
        else if ([linkObj.flag integerValue] == 2){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"isPopoNext" object:self userInfo:nil];
            FSWebViewForOpenURLViewController *fsWebViewForOpenURLViewController = [[FSWebViewForOpenURLViewController alloc] init];
            fsWebViewForOpenURLViewController.urlString = linkObj.link;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"HiddenNavigationItem" object:self userInfo:nil];
            fsWebViewForOpenURLViewController.withOutToolbar = NO;
            [self presentModalViewController:fsWebViewForOpenURLViewController animated:YES];
            [fsWebViewForOpenURLViewController release];
        }
        else if ([linkObj.flag integerValue] == 3){//内嵌浏览器
            NSURL *url = [[NSURL alloc] initWithString:linkObj.link];
            [[UIApplication sharedApplication] openURL:url];
            [url release];
            
            
        }
    }
}

- (void)horizontalScrollPageContainerViewDidScroll:(FSHorizontalScrollPageContainerView *)sender withPageNumber:(NSInteger)pageNumber {
    if ([sender isEqual:_topContainerView]) {
        NSString *strTopInfo = [[NSString alloc] initWithFormat:@"%d / %d    ", (pageNumber + 1), sender.pageCount];
        _lblTopInfo.text = strTopInfo;
        _fsDeepPriorTOPpageControllView.CurrentPage = pageNumber;
        FSDeepPriorFocusObject *focusObj = [_fs_GZF_DeepPriorDAO.objectList objectAtIndex:pageNumber];
        _fsDeepPriorTOPpageControllView.data = focusObj.title;//[[NSString alloc] initWithFormat:@"这个可以有标题的：%d / %d    ", (pageNumber + 1), sender.pageCount];
        [strTopInfo release];
    }
    
}

#pragma -
#pragma UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSArray *sections = [_deepBottomPriorData.fetchedResultsController sections];
//    id<NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
//    
//    //NSInteger numberOfObjects = [sectionInfo numberOfObjects];
//    
    
    NSInteger numberOfObjects = [_fs_GZF_DeepPriorListDAO.objectList count];
    NSInteger count = numberOfObjects / 2;
    if (numberOfObjects % 2 != 0) {
        count++;
    } else {

    }
    FSLog(@"DEEPPRIOR.COUNT:%d", count);
    return count;
//    return [sectionInfo numberOfObjects];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *deepPriorListCellId = @"deepPriorListCellId";
    FSDeepPriorListCell *cell = nil;
    //cell = [tableView dequeueReusableCellWithIdentifier:deepPriorListCellId forIndexPath:indexPath];
    cell = [tableView dequeueReusableCellWithIdentifier:deepPriorListCellId];
    if (cell == nil) {
        cell = [[[FSDeepPriorListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deepPriorListCellId] autorelease];
    }
    
    cell.indexPath = indexPath;
    cell.parentDelegate = self;
//    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
//    NSIndexPath *oneIndexPath = [NSIndexPath indexPathForRow:row * 2 + 0 inSection:section];
    FSTopicPriorObject *oneObj = nil;
    
    @try {
        oneObj = [_fs_GZF_DeepPriorListDAO.objectList objectAtIndex:row*2];//[_deepBottomPriorData.fetchedResultsController objectAtIndexPath:oneIndexPath];
    }
    @catch (NSException *exception) {
        oneObj = nil;
    }

    FSTopicPriorObject *twoObj = nil;
//    NSIndexPath *towIndexPath = [NSIndexPath indexPathForRow:row * 2 + 1 inSection:section];
    @try {
        twoObj = [_fs_GZF_DeepPriorListDAO.objectList objectAtIndex:row*2+1];//[_deepBottomPriorData.fetchedResultsController objectAtIndexPath:towIndexPath];
    }
    @catch (NSException *exception) {
        twoObj = nil;
    }

    [cell setCellShouldWidth:tableView.frame.size.width];
    [cell setOneTopicPriorObject:oneObj];
    [cell setTwoTopicPriorObject:twoObj];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //NSArray *sections = [_deepBottomPriorData.fetchedResultsController sections];
    return 1;
    //return [sections count];
}

#pragma -
#pragma UITableViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	[_tvList bottomScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	[_tvList bottomScrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)tableViewNextDataSource:(FSTableView *)sender {
   
    FSTopicPriorObject *topicPriorObj = [_fs_GZF_DeepPriorListDAO.objectList lastObject];
    
    
    _fs_GZF_DeepPriorListDAO.deepid = self.deepid;
    _fs_GZF_DeepPriorListDAO.lastDeepid = topicPriorObj.deepid;
    [_fs_GZF_DeepPriorListDAO HTTPGetDataWithKind:GET_DataKind_Next];
}

- (void)tableViewRefreshDataSource:(FSTableView *)sender {
    _fs_GZF_DeepPriorListDAO.deepid = self.deepid;
    [_fs_GZF_DeepPriorListDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 205.0f;
}

#pragma -
- (void)deepPriorListCell:(FSDeepPriorListCell *)sender withDeepPriorListExView:(FSDeepPriorListExView *)listView {
    //往期
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"isPopoNext" object:self userInfo:nil];
    
    NSLog(@"deepPriorListCell 往期:%@",listView.topicPriorObject.deepid);
    FSDeepPageContainerController *pageContainerCtrl = [[FSDeepPageContainerController alloc] init];
    pageContainerCtrl.deepid = listView.topicPriorObject.deepid;
    
    UINavigationController *navPageContainerCtrl = [[UINavigationController alloc] initWithRootViewController:pageContainerCtrl];
    [self presentModalViewController:navPageContainerCtrl animated:YES];
    [pageContainerCtrl release];
    [navPageContainerCtrl release];
    
    
}

@end
