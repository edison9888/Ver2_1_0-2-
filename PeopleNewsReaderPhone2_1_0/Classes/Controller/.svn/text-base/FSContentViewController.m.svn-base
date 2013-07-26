    //
//  FSContentViewController.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-9-25.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSContentViewController.h"


@implementation FSContentViewController

- (id)init {
	self = [super init];
	if (self) {
		
	}
	return self;
}

- (void)dealloc {
	[_webView release];
	[_toolBar release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)loadChildView {
	_webView = [[FSContentWebView alloc] initWithFrame:CGRectZero];
	[self.view addSubview:_webView];
	
	_toolBar = [[FSContentToolBar alloc] initWithFrame:CGRectZero];
	[self.view addSubview:_toolBar];
}

- (void)layoutControllerViewWithRect:(CGRect)rect {
	_webView.frame = CGRectMake(0.0f, 0.0f, rect.size.width, rect.size.height - _toolBar.toolBarClientHeight);
	
}



@end
