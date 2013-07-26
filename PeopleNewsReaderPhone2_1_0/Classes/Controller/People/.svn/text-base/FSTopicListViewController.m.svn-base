//
//  FSTopicListViewController.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-23.
//
//

#import "FSTopicListViewController.h"

@interface FSTopicListViewController ()

@end

@implementation FSTopicListViewController
@synthesize  deepid = _deepid;

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc {
    [_tableView release];
    [_deepid release];
    [super dealloc];
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

- (void)doSomethingForViewFirstTimeShow {
    
}

- (void)loadChildView {
#ifdef MYDEBUG
    NSLog(@"deepid:%@", _deepid);
#endif
    _tableView = [[FSTableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
}

- (void)layoutControllerViewWithRect:(CGRect)rect {
    _tableView.frame = CGRectMake(0.0f, 0.0f, rect.size.width, rect.size.height);
    
}

@end
