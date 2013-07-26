//
//  FSLanguageSettingViewController.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-9-12.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSLanguageSettingViewController.h"

@implementation FSLanguageSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(NSString *)setTitle{
    _fsALLSettingContainerView.flag = 2;
    NSLog(@"setTitlesetTitlesetTitlesetTitle setTitlesetTitle");
    return @"语言环境";
}

#pragma mark - 
#pragma FSTableContainerViewDelegate mark

-(NSInteger)tableViewSectionNumber:(FSTableContainerView *)sender{
    return 1;
}

-(NSInteger)tableViewNumberInSection:(FSTableContainerView *)sender section:(NSInteger)section{
    
    return 3;
}

-(NSObject *)tableViewCellData:(FSTableContainerView *)sender withIndexPath:(NSIndexPath *)indexPath{
    return @"all_setting";
}

-(void)tableViewDataSourceDidSelected:(FSTableContainerView *)sender withIndexPath:(NSIndexPath *)indexPath{
    //NSInteger section = [indexPath section];
    //NSInteger row = [indexPath row];
    [_fsALLSettingContainerView tableCellselect:indexPath];
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
