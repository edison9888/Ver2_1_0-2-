//
//  FSDeepEndViewController.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-29.
//
//

#import "FSDeepEndViewController.h"
#import "FS_GZF_DeepEndDAO.h"

@interface FSDeepEndViewController ()

@end

@implementation FSDeepEndViewController

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
//    _deepEndData.parentDelegate = nil;
//    [_deepEndData release];
    _fs_GZF_DeepEndDAO.parentDelegate = NULL;
    [_fs_GZF_DeepEndDAO release];
    [_deepEndView release];
    [super dealloc];
}

- (void)initDataModel {
//    _deepEndData = [[FSDeepEndDAO alloc] init];
//    _deepEndData.parentDelegate = self;
    
    _fs_GZF_DeepEndDAO = [[FS_GZF_DeepEndDAO alloc] init];
    _fs_GZF_DeepEndDAO.parentDelegate = self;
}

- (void)doSomethingForViewFirstTimeShow {
//    _deepEndData.deepid = self.deepid;
//    //[_deepEndData GETData];
    
    _fs_GZF_DeepEndDAO.deepid = self.deepid;
    [_fs_GZF_DeepEndDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
    _canDELETE = NO;
}

- (void)loadChildView {
    //self.view.backgroundColor = [UIColor redColor];
    _deepEndView = [[FSDeepEndView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_deepEndView];
}

- (void)layoutControllerViewWithRect:(CGRect)rect {
    _deepEndView.frame = CGRectMake(0.0f, 0.0f, rect.size.width, rect.size.height);
}

- (void)doSomethingWithDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status {
     NSLog(@"doSomethingWithDAO:%@",sender);
//    if ([sender isEqual:_deepEndData]) {
//        if (status == FSBaseDAOCallBack_BufferSuccessfulStatus ||
//            status == FSBaseDAOCallBack_SuccessfulStatus) {
//            _deepEndView.deepEndObject = (FSDeepEndObject *)_deepEndData.contentObject;
//            
//            FSLog(@"deepEndView:%@", [self.view subviews]);
//        }
//    }
    
    if ([sender isEqual: _fs_GZF_DeepEndDAO]) {
        if (status == FSBaseDAOCallBack_SuccessfulStatus || status == FSBaseDAOCallBack_BufferSuccessfulStatus) {
            if ([_fs_GZF_DeepEndDAO.objectList count]>0) {
                if (status == FSBaseDAOCallBack_SuccessfulStatus) {
                    [_fs_GZF_DeepEndDAO operateOldBufferData];
                    _canDELETE = YES;
                     _deepEndView.deepEndObject = (FSDeepEndObject *)[_fs_GZF_DeepEndDAO.objectList objectAtIndex:0];
                }
            }
            
        }
    }
}

@end
