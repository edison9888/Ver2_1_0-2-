//
//  FSDeepTextViewController.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-29.
//
//

#import "FSDeepTextViewController.h"
#import "FSDeepContentObject.h"
#import "FS_GZF_DeepTextDAO.h"

@interface FSDeepTextViewController ()

@end

@implementation FSDeepTextViewController
@synthesize contentid = _contentid;

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
//    _textData.parentDelegate = nil;
//    [_textData release];
    [_fs_GZF_DeepTextWebView release];
    [_contentid release];
//    [_textView release];
    _fs_GZF_DeepTextDAO.parentDelegate = NULL;
    [_fs_GZF_DeepTextDAO release];
//    [_fs_GZF_DeepTextView release];
    
    [super dealloc];
}

- (void)initDataModel {
//    _textData = [[FSDeepTextDAO alloc] init];
//    _textData.parentDelegate = self;
    
    _fs_GZF_DeepTextDAO = [[FS_GZF_DeepTextDAO alloc] init];
    _fs_GZF_DeepTextDAO.parentDelegate = self;
    
}

- (void)doSomethingForViewFirstTimeShow {
    //NSLog(@"1111111 77777");
   // _textData.contentid = _contentid;
    //NSLog(@"???????");
    //[_textData GETData];
    //NSLog(@"doSomethingForViewFirstTimeShow FSDeepTextViewController");
    
    _fs_GZF_DeepTextDAO.deepid = _contentid;
    [_fs_GZF_DeepTextDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
    self.canDELETE = NO;
}

- (void)loadChildView {
    self.view.backgroundColor = [UIColor whiteColor];
 
//    _textView = [[FSDeepTextView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)];
//    _textView = [[FSDeepContentTextView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)];
//    _textView.pictureFlag = _textData.pictureFlag;
//    _textView.textFlag = _textData.textFlag;
    
//    _textView.pictureFlag = FSDEEP_TEXT_CHILD_PIC_NODE_FLAG;
//    _textView.textFlag = FSDEEP_TEXT_CHILD_TXT_NODE_FLAG;
    
    //_textView.delegate = self;
    //[self.view addSubview:_textView];
    
    
//    _fs_GZF_DeepTextView = [[FS_GZF_DeepTextView alloc] initWithFrame:CGRectZero];
//    _fs_GZF_DeepTextView.pictureFlag = FSDEEP_TEXT_CHILD_PIC_NODE_FLAG;
//    _fs_GZF_DeepTextView.textFlag = FSDEEP_TEXT_CHILD_TXT_NODE_FLAG;
//    
//    [self.view addSubview:_fs_GZF_DeepTextView];
    
    _fs_GZF_DeepTextWebView = [[FS_GZF_DeepTextWebView alloc] initWithFrame:CGRectZero];
    _fs_GZF_DeepTextWebView.pictureFlag = FSDEEP_TEXT_CHILD_PIC_NODE_FLAG;
    _fs_GZF_DeepTextWebView.textFlag = FSDEEP_TEXT_CHILD_TXT_NODE_FLAG;
    
    [self.view addSubview:_fs_GZF_DeepTextWebView];
}

- (void)layoutControllerViewWithRect:(CGRect)rect {
   // _textView.frame = CGRectMake(0.0f, 0.0f, rect.size.width, rect.size.height);
    //_fs_GZF_DeepTextView.frame = CGRectMake(0.0f, 0.0f, rect.size.width, rect.size.height);
    _fs_GZF_DeepTextWebView.frame = CGRectMake(0.0f, 0.0f, rect.size.width, rect.size.height);
}

- (void)doSomethingWithDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status {
     NSLog(@"doSomethingWithDAO:%@,%d,%@",sender,status,_fs_GZF_DeepTextWebView);
//    if ([sender isEqual:_textData]) {
//        if (status == FSBaseDAOCallBack_BufferSuccessfulStatus ||
//            status == FSBaseDAOCallBack_SuccessfulStatus) {
//            FSDeepContentObject *contentObj = (FSDeepContentObject *)_textData.contentObject;
//            FSLog(@"deepContentObject:%@", contentObj);
//            FSLog(@"deepContentChildObject:%@", contentObj.childContent);
//            FSLog(@"deepContentChildObject.count:%d", [contentObj.childContent count]);
//            
//            _textView.contentObject = contentObj;
//        }
//    }
    
    if ([sender isEqual:_fs_GZF_DeepTextDAO]) {
        if (status == FSBaseDAOCallBack_SuccessfulStatus || status == FSBaseDAOCallBack_BufferSuccessfulStatus) {
                        
            if (status == FSBaseDAOCallBack_SuccessfulStatus) {
                //[_fs_GZF_DeepTextDAO operateOldBufferData];
                FSDeepContentObject *contentObj = _fs_GZF_DeepTextDAO.fsDeepContentObject;
                if (contentObj!=nil) {
                    _fs_GZF_DeepTextWebView.title = _Deep_title;
                    _fs_GZF_DeepTextWebView.data = contentObj;
                    _canDELETE = YES;
                    NSLog(@"show _fs_GZF_DeepTextWebView");
                }
                
            }
        }
    }
}


@end
