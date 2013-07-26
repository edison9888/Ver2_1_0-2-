//
//  FSDeepPageContainerController.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-1.
//
//

#import "FSDeepPageContainerController.h"

#import "FS_GZF_DeepPageListDAO.h"
#import "FSDeepPageObject.h"

#import "FSDeepLeadViewController.h"
#import "FSDeepPictureVeiwController.h"
#import "FSDeepTextViewController.h"
#import "FSDeepOuterLinkViewController.h"
#import "FSDeepInvestigateViewController.h"
#import "FSDeepEndViewController.h"
#import "FSDeepCommentViewController.h"
#import "FSDeepPriorViewController.h"



/*
 flag:1（导语页面）深度id
 flag:2（图片页面）图片id
 flag:3（文本页面）正文id
 flag:4（外链页面）外链id
 flag:5（调查页面）调查id
 flag:6（结束语页面）深度id
 flag:7（评论页面）深度id
 flag:8（往期页面）深度id
 */
#define FSDEEP_PAGE_LEAD 1
#define FSDEEP_PAGE_PICTURE 2
#define FSDEEP_PAGE_TEXT 3
#define FSDEEP_PAGE_OUTER 4
#define FSDEEP_PAGE_INVESTIGATE 5
#define FSDEEP_PAGE_END 6
#define FSDEEP_PAGE_COMMENT 7
#define FSDEEP_PAGE_PRIOR 8


@interface FSDeepPageContainerController ()

@end

@implementation FSDeepPageContainerController
@synthesize deepid = _deepid;
@synthesize Deep_title = _Deep_title;

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

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//    NSInteger k = [self retainCount];
//    for (NSInteger i=0; i<k-1; i++) {
//        [self release];
//    }
    
    NSLog(@"%@.viewDidDisappear:%d",self,[self retainCount]);
}

- (void)dealloc {
    [_deepid release];
//    _deepPageListData.parentDelegate = nil;
//    [_deepPageListData release];
    _fs_GZF_DeepPageListDAO.parentDelegate = NULL;
    [_fs_GZF_DeepPageListDAO release];
    [super dealloc];
}

- (void)initDataModel {
//    _deepPageListData = [[FSDeepPageListDAO alloc] init];
//    _deepPageListData.parentDelegate = self;
    
    _fs_GZF_DeepPageListDAO = [[FS_GZF_DeepPageListDAO alloc] init];
    _fs_GZF_DeepPageListDAO.parentDelegate = self;
}

- (void)doSomethingForViewFirstTimeShow {
//    _deepPageListData.deepid = self.deepid;
    
    _fs_GZF_DeepPageListDAO.deepid = self.deepid;
    [_fs_GZF_DeepPageListDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
    
    //[_deepPageListData GETData];
    
}

- (void)doSomethingWithDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status {
    NSLog(@"FSDeepPageContainerController doSomethingWithDAO:%@",_deepid);
//    if ([_deepPageListData isEqual:sender]) {
//        if (status == FSBaseDAOCallBack_BufferSuccessfulStatus ||
//            status == FSBaseDAOCallBack_SuccessfulStatus) {
//            NSArray *sections = [_deepPageListData.fetchedResultsController sections];
//            NSLog(@"sections:%d",[sections count]);
//            if ([sections count] > 0) {
//                id <NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:0];
//                FSLog(@"Deep.pageCount.count:%d", [sectionInfo numberOfObjects]);
//                
//                [self setPageControllerCount:[sectionInfo numberOfObjects]];
//            }
//
//        }
//    }
    
    if ([sender isEqual:_fs_GZF_DeepPageListDAO]) {
        if (status == FSBaseDAOCallBack_BufferSuccessfulStatus || status == FSBaseDAOCallBack_SuccessfulStatus) {
            NSLog(@"_fs_GZF_DeepPageListDAO:%d",[_fs_GZF_DeepPageListDAO.objectList count]);
            
            if (status == FSBaseDAOCallBack_SuccessfulStatus) {
                [_fs_GZF_DeepPageListDAO operateOldBufferData];
                [self setPageControllerCount:[_fs_GZF_DeepPageListDAO.objectList count]];
            }
        }
    }
}

- (Class)pageControllerClassWithPageNum:(NSInteger)pageNum {
    //NSIndexPath *indexPath = [self indexPathWithPageNum:pageNum];
    //FSDeepPageObject *pageObj = [_deepPageListData.fetchedResultsController objectAtIndexPath:indexPath];
    FSDeepPageObject *pageObj = [_fs_GZF_DeepPageListDAO.objectList objectAtIndex:pageNum];
    if (pageObj) {
        Class controllerClass = nil;
        NSInteger flag = [pageObj.flag intValue];
        
        switch (flag) {
            case FSDEEP_PAGE_LEAD:
                controllerClass = [FSDeepLeadViewController class];
                break;
            case FSDEEP_PAGE_PICTURE:
                controllerClass = [FSDeepPictureVeiwController class];
                break;
            case FSDEEP_PAGE_TEXT:
                controllerClass = [FSDeepTextViewController class];
                break;
            case FSDEEP_PAGE_OUTER:
                controllerClass = [FSDeepOuterLinkViewController class];
                break;
            case FSDEEP_PAGE_INVESTIGATE:
                controllerClass = [FSDeepInvestigateViewController class];
                break;
            case FSDEEP_PAGE_END:
                controllerClass = [FSDeepEndViewController class];
                break;
            case FSDEEP_PAGE_COMMENT:
                controllerClass = [FSDeepCommentViewController class];
                break;
            case FSDEEP_PAGE_PRIOR:
                controllerClass = [FSDeepPriorViewController class];
                break;
            default:
                break;
        }
        return controllerClass;

    }
    return nil;
}

- (void)initializePageController:(UIViewController *)viewController withPageNum:(NSInteger)pageNum {
    NSIndexPath  *indexPath = [self indexPathWithPageNum:pageNum];
    if (indexPath) {
        //FSDeepPageObject *pageObj = [_deepPageListData.fetchedResultsController objectAtIndexPath:indexPath];
        FSDeepPageObject *pageObj = [_fs_GZF_DeepPageListDAO.objectList objectAtIndex:pageNum];
        NSInteger flag = [pageObj.flag intValue];
        FSLog(@"deepPage.flag:%d[%@]", flag, pageObj.pageid);
        switch (flag) {
            case FSDEEP_PAGE_LEAD:
                //controllerClass = [FSDeepLeadViewController class];
                if ([viewController isKindOfClass:[FSDeepLeadViewController class]]) {
                    FSDeepLeadViewController *deepLeadCtrl = (FSDeepLeadViewController *)viewController;
                    deepLeadCtrl.bottomControlHeight = [self pageControlHeight];
                    deepLeadCtrl.deepid = pageObj.pageid;
                }
                break;
            case FSDEEP_PAGE_PICTURE:
                //controllerClass = [FSDeepPictureVeiwController class];
                if ([viewController isKindOfClass:[FSDeepPictureVeiwController class]]) {
                    FSDeepPictureVeiwController *deepPictureCtrl = (FSDeepPictureVeiwController *)viewController;
                    deepPictureCtrl.bottomControlHeight = [self pageControlHeight];
                    deepPictureCtrl.pictureid = pageObj.pageid;
                }
                break;
            case FSDEEP_PAGE_TEXT:
                if ([viewController isKindOfClass:[FSDeepTextViewController class]]) {
                    FSDeepTextViewController *deepTextCtrl = (FSDeepTextViewController *)viewController;
                    deepTextCtrl.contentid = pageObj.pageid;
                    deepTextCtrl.Deep_title = self.Deep_title;
                }
                //controllerClass = [FSDeepTextViewController class];
                break;
            case FSDEEP_PAGE_OUTER:
                //controllerClass = [FSDeepOuterLinkViewController class];
                if ([viewController isKindOfClass:[FSDeepOuterLinkViewController class]]) {
                    FSDeepOuterLinkViewController *outerLinkCtrl = (FSDeepOuterLinkViewController *)viewController;
                    outerLinkCtrl.outerid = pageObj.pageid;
                }
                break;
            case FSDEEP_PAGE_INVESTIGATE:
                //controllerClass = [FSDeepInvestigateViewController class];
                break;
            case FSDEEP_PAGE_END:
                //controllerClass = [FSDeepEndViewController class];
                if ([viewController isKindOfClass:[FSDeepEndViewController class]]) {
                    FSDeepEndViewController *deepEndCtrl = (FSDeepEndViewController *)viewController;
                    deepEndCtrl.deepid = pageObj.pageid;
                }
                break;
            case FSDEEP_PAGE_COMMENT:
                //controllerClass = [FSDeepCommentViewController class];
                break;
            case FSDEEP_PAGE_PRIOR:
                //controllerClass = [FSDeepPriorViewController class];
                if ([viewController isKindOfClass:[FSDeepPriorViewController class]]) {
                    FSDeepPriorViewController *deepPriorCtrl = (FSDeepPriorViewController *)viewController;
                    deepPriorCtrl.deepid = pageObj.pageid;
                }
                break;
            default:
                break;
        }
    }
}

@end
