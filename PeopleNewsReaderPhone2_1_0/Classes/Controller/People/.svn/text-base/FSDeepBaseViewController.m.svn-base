//
//  FSDeepBaseViewController.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-29.
//
//

#import "FSDeepBaseViewController.h"

@interface FSDeepBaseViewController ()

@end

@implementation FSDeepBaseViewController
@synthesize deepid = _deepid;
@synthesize bottomControlHeight = _bottomControlHeight;
@synthesize canDELETE = _canDELETE;
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

- (void)loadView {
    [super loadView];
}

- (void)dealloc {
    [_deepid release];
    [super dealloc];
}

- (FSControllerAdjustLayout)isManualLayout {
    return FSControllerAdjustLayout_Other_Manual;
}

-(void)viewDidAppear:(BOOL)animated{
    if (animated) {
        [self doSomethingForViewFirstTimeShow];
    }
}

@end
