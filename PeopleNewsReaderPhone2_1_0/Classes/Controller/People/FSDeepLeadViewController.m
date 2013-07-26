//
//  FSDeepLeadViewController.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-29.
//
//

#import "FSDeepLeadViewController.h"

#import "FS_GZF_DeepLeadDAO.h"

@interface FSDeepLeadViewController ()

@end

@implementation FSDeepLeadViewController

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
    [_leadView release];
//    _leadData.parentDelegate = nil;
//    [_leadData release];
    _fs_GZF_DeepLeadDAO.parentDelegate = NULL;
    [_fs_GZF_DeepLeadDAO release];
    [super dealloc];
}

- (void)initDataModel {
//    _leadData = [[FSDeepLeadDAO alloc] init];
//    _leadData.parentDelegate = self;
    
    _fs_GZF_DeepLeadDAO = [[FS_GZF_DeepLeadDAO alloc] init];
    _fs_GZF_DeepLeadDAO.parentDelegate = self;
    
}

- (void)loadChildView {
    
//    UIImageView *backgrounDImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"deep_baground.png"]];
//    backgrounDImage.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
//    [self.view addSubview:backgrounDImage];
//    [backgrounDImage release];
    
    _leadView = [[FSDeepLeadView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_leadView];
}

- (void)doSomethingForViewFirstTimeShow {
    //_leadData.deepid = self.deepid;
    //[_leadData GETData];
    //NSLog(@"doSomethingForViewFirstTimeShow:%@",self);
    _fs_GZF_DeepLeadDAO.deepid = self.deepid;
    _canDELETE = NO;
    [_fs_GZF_DeepLeadDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
    
}

- (void)doSomethingWithDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status {
     NSLog(@"doSomethingWithDAO:%@ %d",sender,status);
//    if ([sender isEqual:_leadData]) {
//        if (status == FSBaseDAOCallBack_BufferSuccessfulStatus ||
//            status == FSBaseDAOCallBack_SuccessfulStatus) {
//            FSLog(@"Lead.ContentObject:%@", _leadData.contentObject);
//            _leadView.deepLeadObject = (FSDeepLeadObject *)_leadData.contentObject;
//        }
//    }
    
    if ([sender isEqual:_fs_GZF_DeepLeadDAO]) {
        if (status == FSBaseDAOCallBack_BufferSuccessfulStatus || status == FSBaseDAOCallBack_SuccessfulStatus) {
            if ([_fs_GZF_DeepLeadDAO.objectList count]>0) {
                
                if (status == FSBaseDAOCallBack_SuccessfulStatus) {
                    [_fs_GZF_DeepLeadDAO operateOldBufferData];
                    _canDELETE = YES;
                    //NSLog(@"_fs_GZF_DeepLeadDAO.objectList:%d",[_fs_GZF_DeepLeadDAO.objectList count]);
                    
                    //NSLog(@"o:%@",_fs_GZF_DeepLeadDAO.objectList);
                    _leadView.deepLeadObject = (FSDeepLeadObject *)[_fs_GZF_DeepLeadDAO.objectList objectAtIndex:0];
                }
            }
            
        }
    }
}

- (void)layoutControllerViewWithRect:(CGRect)rect {
    _leadView.frame = CGRectMake(0.0f, 0.0f, rect.size.width, rect.size.height);
}

@end
