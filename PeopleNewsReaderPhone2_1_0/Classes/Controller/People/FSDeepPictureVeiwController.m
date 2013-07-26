//
//  FSDeepPictureVeiwController.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-29.
//
//

#import "FSDeepPictureVeiwController.h"
#import "FS_GZF_DeepPictureDAO.h"

@interface FSDeepPictureVeiwController ()

@end

@implementation FSDeepPictureVeiwController
@synthesize pictureid = _pictureid;

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
//    _pictureData.parentDelegate = nil;
//    [_pictureData release];
    //[_pictureid release];
    [_deepPictureView release];
    _fs_GZF_DeepPictureDAO.parentDelegate = NULL;
    [_fs_GZF_DeepPictureDAO release];
    [super dealloc];
}

- (void)initDataModel {
//    _pictureData = [[FSDeepPictureDAO alloc] init];
//    _pictureData.parentDelegate = self;
    
    _fs_GZF_DeepPictureDAO = [[FS_GZF_DeepPictureDAO alloc] init];
    _fs_GZF_DeepPictureDAO.parentDelegate = self;
}

- (void)loadChildView {
    self.view.backgroundColor = [UIColor whiteColor];
    _deepPictureView = [[FSDeepPictureView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)];
    _deepPictureView.bottomControlHeight = self.bottomControlHeight;
    [self.view addSubview:_deepPictureView];
}

- (void)layoutControllerViewWithRect:(CGRect)rect {
    _deepPictureView.frame = CGRectMake(0.0f, 0.0f, rect.size.width, rect.size.height);
    //FSLog(@"LeadPicture:%@", NSStringFromCGRect(rect));
}

- (void)doSomethingForViewFirstTimeShow {
    //_pictureData.pictureid = _pictureid;
    //[_pictureData GETData];
    
    _fs_GZF_DeepPictureDAO.deepid = _pictureid;
    [_fs_GZF_DeepPictureDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
    _canDELETE = NO;
    
}

- (void)doSomethingWithDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status {
     //NSLog(@"doSomethingWithDAO:%@",sender);
//    if ([sender isEqual:_pictureData]) {
//        if (status == FSBaseDAOCallBack_BufferSuccessfulStatus ||
//            status == FSBaseDAOCallBack_SuccessfulStatus) {
//            FSLog(@"picture.DeepObject:%@", _pictureData.contentObject);
//            _deepPictureView.deepPictureObject = (FSDeepPictureObject *)_pictureData.contentObject;
//        }
//    }
    
    if ([sender isEqual:_fs_GZF_DeepPictureDAO]) {
        if (status == FSBaseDAOCallBack_BufferSuccessfulStatus || status == FSBaseDAOCallBack_SuccessfulStatus) {
            //FSLog(@"picture.DeepObject:%@", _fs_GZF_DeepPictureDAO.objectList);
            if([_fs_GZF_DeepPictureDAO.objectList count]>0){
                 
                if (status == FSBaseDAOCallBack_SuccessfulStatus) {
                    [_fs_GZF_DeepPictureDAO operateOldBufferData];
                    _canDELETE = YES;
                    _deepPictureView.deepPictureObject = (FSDeepPictureObject *)[_fs_GZF_DeepPictureDAO.objectList objectAtIndex:0];
                }
            }
        }
    }
}

@end
