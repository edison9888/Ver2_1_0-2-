//
//  FSDeepOuterLinkViewController.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-29.
//
//

#import "FSDeepOuterLinkViewController.h"
#import "FSDeepOuterObject.h"
#import "FSDeepOuterLinkListObject.h"

#import "FS_GZF_DeepOuterLinkListDAO.h"
#import "FS_GZF_DeepOuterLinkDAO.h"

#import "FSNewsContainerViewController.h"
#import "FSWebViewForOpenURLViewController.h"

#define TABLEVIEW_HEIGHT 240.0f

@interface FSDeepOuterLinkViewController ()

@end

@implementation FSDeepOuterLinkViewController
@synthesize outerid = _outerid;

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
    [_tvOutLinkList release];
    [_deepOuterView release];
    
    //[_outerid release];
//    _deepOuterData.parentDelegate = nil;
//    _deepOuterLinkListData.parentDelegate = nil;
//    [_deepOuterLinkListData release];
//    [_deepOuterData release];
    _fs_GZF_DeepOuterLinkListDAO.parentDelegate = NULL;
    [_fs_GZF_DeepOuterLinkListDAO release];
    _fs_GZF_DeepOuterLinkDAO.parentDelegate = NULL;
    [_fs_GZF_DeepOuterLinkDAO release];
    
    [super dealloc];
}

- (void)initDataModel {
//    _deepOuterData = [[FSDeepOuterDAO alloc] init];
//    _deepOuterData.parentDelegate = self;
//    
//    _deepOuterLinkListData = [[FSDeepOuterLinkListDAO alloc] init];
//    _deepOuterLinkListData.parentDelegate = self;
    
    _fs_GZF_DeepOuterLinkListDAO = [[FS_GZF_DeepOuterLinkListDAO alloc] init];
    _fs_GZF_DeepOuterLinkListDAO.parentDelegate = self;
    
    _fs_GZF_DeepOuterLinkDAO = [[FS_GZF_DeepOuterLinkDAO alloc] init];
    _fs_GZF_DeepOuterLinkDAO.parentDelegate = self;
    
}

- (void)doSomethingForViewFirstTimeShow {
//    _deepOuterData.outerid = _outerid;
//    //[_deepOuterData GETData];
//    
//    _deepOuterLinkListData.outerid = _outerid;
//    //[_deepOuterLinkListData GETData];
    
     _fs_GZF_DeepOuterLinkDAO.deepid = _outerid;
    [_fs_GZF_DeepOuterLinkDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
    //_fs_GZF_DeepOuterLinkListDAO.deepid = _outerid;
    //[_fs_GZF_DeepOuterLinkListDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
    _canDELETE = NO;
   
}

- (void)loadChildView {
    UIImageView *backBGR = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"deep_baground.png"]];
    backBGR.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:backBGR];
    [backBGR release];
    
    _deepOuterView = [[FSDeepOuterView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)];
    _deepOuterView.parentDelegate = self;
    [self.view addSubview:_deepOuterView];
    
    _tvOutLinkList = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 240.0f, self.view.frame.size.width, self.view.frame.size.height - 240.0f) style:UITableViewStylePlain];
    _tvOutLinkList.dataSource = self;
    _tvOutLinkList.delegate = self;
    [self.view addSubview:_tvOutLinkList];
}

- (void)layoutControllerViewWithRect:(CGRect)rect {
    //_deepOuterView.frame = CGRectMake(0.0f, 0.0f, rect.size.width, rect.size.height);
     _tvOutLinkList.frame = CGRectMake(12, _deepOuterView.clientHeight, rect.size.width-24, rect.size.height - _deepOuterView.clientHeight - 30);
}


- (void)doSomethingWithDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status {
     NSLog(@"doSomethingWithDAO:%@",sender);
//    if ([sender isEqual:_deepOuterData]) {
//        if (status == FSBaseDAOCallBack_BufferSuccessfulStatus ||
//            status == FSBaseDAOCallBack_SuccessfulStatus) {
//            _deepOuterView.outerObject = (FSDeepOuterObject *)_deepOuterData.contentObject;
//            //[self layoutControllerViewWithRect:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)];
//            [_tvOutLinkList reloadData];
//        }
//    } else if ([sender isEqual:_deepOuterLinkListData]) {
//        if (status == FSBaseDAOCallBack_BufferSuccessfulStatus ||
//            status == FSBaseDAOCallBack_SuccessfulStatus) {
////            NSArray *sections = [_deepOuterLinkListData.fetchedResultsController sections];
////            if ([sections count] > 0) {
////                id <NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:0];
////                FSLog(@"Deep.outerLinkListCount.count:%d", [sectionInfo numberOfObjects]);
////                
////            }
//            [_tvOutLinkList reloadData];
//        }
//    }
    
    
    if ([sender isEqual:_fs_GZF_DeepOuterLinkListDAO]) {
        if (status == FSBaseDAOCallBack_BufferSuccessfulStatus || status == FSBaseDAOCallBack_SuccessfulStatus) {
            NSLog(@"_fs_GZF_DeepOuterLinkListDAO:%d",[_fs_GZF_DeepOuterLinkListDAO.objectList count]);
            _tvOutLinkList.frame = CGRectMake(12, _deepOuterView.clientHeight, self.view.frame.size.width-24, self.view.frame.size.height - _deepOuterView.clientHeight - 30);
           
            
            if (status == FSBaseDAOCallBack_SuccessfulStatus) {
                [_fs_GZF_DeepOuterLinkListDAO operateOldBufferData];
                [_tvOutLinkList reloadData];
                _canDELETE = YES;
            }
        }
    }else if([sender isEqual:_fs_GZF_DeepOuterLinkDAO]){
        if (status == FSBaseDAOCallBack_BufferSuccessfulStatus || status == FSBaseDAOCallBack_SuccessfulStatus) {
            NSLog(@"_fs_GZF_DeepOuterLinkDAO:%d",[_fs_GZF_DeepOuterLinkDAO.objectList count]);
            if ([_fs_GZF_DeepOuterLinkDAO.objectList count]>0) {
                _deepOuterView.outerObject = (FSDeepOuterObject *)[_fs_GZF_DeepOuterLinkDAO.objectList objectAtIndex:0];
                NSLog(@"_deepOuterView.outerObject:%@",_deepOuterView.outerObject);
                //[self layoutControllerViewWithRect:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)];
                [_tvOutLinkList reloadData];
                if (status == FSBaseDAOCallBack_SuccessfulStatus) {
                    [_fs_GZF_DeepOuterLinkDAO operateOldBufferData];
                    _fs_GZF_DeepOuterLinkListDAO.deepid = _outerid;
                    [_fs_GZF_DeepOuterLinkListDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
                }
                
                
            }
        }
    }
}



-(void)fsBaseContainerViewTouchEvent:(FSBaseContainerView *)sender{
    if ([sender isEqual:_deepOuterView]) {
        _tvOutLinkList.frame = CGRectMake(12, _deepOuterView.clientHeight, self.view.frame.size.width-24, self.view.frame.size.height - _deepOuterView.clientHeight - 30);
    }
}


#pragma -
#pragma UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
//    NSArray *sections = [_deepOuterLinkListData.fetchedResultsController sections];
//    return [sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_fs_GZF_DeepOuterLinkListDAO.objectList count];
    
//    NSArray *sections = [_deepOuterLinkListData.fetchedResultsController sections];
//    id <NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
//    
//    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    static NSString *deepOutLinkCellIdentifier = @"deepOutLinkCellIdentifier";
    
    cell = [tableView dequeueReusableCellWithIdentifier:deepOutLinkCellIdentifier];
    //cell = [tableView dequeueReusableCellWithIdentifier:deepOutLinkCellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deepOutLinkCellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    FSDeepOuterLinkListObject *linkObj = [_fs_GZF_DeepOuterLinkListDAO.objectList objectAtIndex:[indexPath row]];
    //FSDeepOuterLinkListObject *linkObj = [_deepOuterLinkListData.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = linkObj.title;
    
    return cell;
}

#pragma -
#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSInteger index = [indexPath row];
    if (index<[_fs_GZF_DeepOuterLinkListDAO.objectList count]) {
        FSDeepOuterLinkListObject *linkObj = [_fs_GZF_DeepOuterLinkListDAO.objectList objectAtIndex:index];
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
            [[FSBaseDB sharedFSBaseDB] updata_visit_message:linkObj.outerid];
        }
        else if ([linkObj.flag integerValue] == 2){//内嵌浏览器
            [[NSNotificationCenter defaultCenter] postNotificationName:@"isPopoNext" object:self userInfo:nil];
            FSWebViewForOpenURLViewController *fsWebViewForOpenURLViewController = [[FSWebViewForOpenURLViewController alloc] init];
            fsWebViewForOpenURLViewController.urlString = linkObj.link;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"HiddenNavigationItem" object:self userInfo:nil];
            fsWebViewForOpenURLViewController.withOutToolbar = NO;
            [self presentModalViewController:fsWebViewForOpenURLViewController animated:YES];
            [fsWebViewForOpenURLViewController release];
        }
        else if ([linkObj.flag integerValue] == 3){
            NSURL *url = [[NSURL alloc] initWithString:linkObj.link];
            [[UIApplication sharedApplication] openURL:url];
            [url release];
            
            
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;//_deepOuterView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0f;//_deepOuterView.clientHeight;
}

@end
