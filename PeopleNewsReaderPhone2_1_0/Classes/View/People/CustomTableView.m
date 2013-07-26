//
//  CustomTableView.m
//  PeopleMicroBlogClient
//
//  Created by chen guoshuang on 11-2-7.
//  Copyright 2011 People. All rights reserved.
//

#import "CustomTableView.h"
#import "CustomTableTopBottomView.h"

#define BOTTOM_VIEW_HEIGHT 64.0f

#define TOP_VIEW_HEIGHT 64.0f

@implementation CustomTableView

@synthesize bottomShow = _bottomShow;
@synthesize topShow = _topShow;
@synthesize parentDelegate = _parentDelegate;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		_bottomShow = YES;
		_topShow = YES;
        // Initialization code.
		//[self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        /*
		_cttbNext = [[CustomTableTopBottomView alloc] initWithFrame:CGRectMake(0.0f, self.contentSize.height <= frame.size.height ? frame.size.height : self.contentSize.height, frame.size.width, BOTTOM_VIEW_HEIGHT) tbkWhich:tbkBottom];
		[_cttbNext setHidden:YES];
		[self addSubview:_cttbNext];
		*/
		//_cttbRefresh = [[CustomTableTopBottomView alloc] initWithFrame:CGRectMake(0.0f, 0 - TOP_VIEW_HEIGHT, self.frame.size.width, TOP_VIEW_HEIGHT) tbkWhich:tbkTop];
        
        _cttbRefresh = [[CustomTableTopBottomView alloc] initWithFrame:
                             CGRectMake(0.0f, 0.0f-480,
                                        self.frame.size.width, 480) withStyle:HeaderViewStyleBlack];
		[self addSubview:_cttbRefresh];
		
		//[self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)setFrame:(CGRect)rect {
	[super setFrame:rect];
}

- (void) reloadData {
	[super reloadData];
	
	//[_cttbRefresh setHidden:_cttbNext.psWhich == psLoadding || !_topShow];
     
}

- (void) layoutSubviews {
	[super layoutSubviews];
    
    
	_cttbRefresh.frame = CGRectMake(0.0f, 
									0- 480, 
									self.frame.size.width, 
									480);
	
	
	//[_cttbRefresh setHidden:_cttbNext.psWhich == psLoadding || !_topShow];
     
     
}

- (void)dealloc {
	[_cttbRefresh release];
	
    [super dealloc];
}

- (void) setBottomHidden:(BOOL)value {
	//[_cttbNext setHidden:value];
}

- (CGFloat) getBottomHeight {
	return 10;//_cttbNext.frame.size.height;
}

#pragma mark -
#pragma mark 外部调用的函数

- (void) showReloadAnimationAnimated:(BOOL)animated
{
	reloading = YES;
	[_cttbRefresh toggleActivityView:YES];
	
	if (animated)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
		self.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
		[UIView commitAnimations];
	}
	else
	{
		self.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
	}
}

- (void) forceShowRefreshHeaderView:(BOOL)animated{
	reloading = YES;
	[_cttbRefresh toggleActivityView:YES];
	
	if (animated)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
		self.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);//首先将inset设到60
		[self scrollRectToVisible:CGRectMake(0, 0.0f, 1, 1) animated:NO];//还需滚动到新的(0, 0.0f, 1, 1)区域
		[UIView commitAnimations];
	}
	else
	{
		self.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
		[self scrollRectToVisible:CGRectMake(0, 0.0f, 1, 1) animated:NO];
	}
	[_cttbRefresh flipImageAnimated:YES];
	[_cttbRefresh setStatus:kLoadingStatus];
}

-(void)bottomScrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    if (!_topShow) {
        _cttbRefresh.alpha = 0.0;
        return;
    }
    
    if (!reloading)
	{
		checkForRefresh = YES;  //  only check offset when dragging
	}
}


- (void)bottomScrollViewDidScroll:(UIScrollView *)scrollView {
	
	if (reloading) return;
	
	if (checkForRefresh) {
		if (_cttbRefresh.isFlipped
			&& scrollView.contentOffset.y > -65.0f
			&& scrollView.contentOffset.y < 0.0f
			&& !reloading) {
			[_cttbRefresh flipImageAnimated:YES];
			[_cttbRefresh setStatus:kPullToReloadStatus];
			//[popSound play];
			
		} else if (!_cttbRefresh.isFlipped
				   && scrollView.contentOffset.y < -65.0f) {
			[_cttbRefresh flipImageAnimated:YES];
			[_cttbRefresh setStatus:kReleaseToReloadStatus];
			//[psst1Sound play];
		}
	}
}

- (void)bottomScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (!_topShow) {
        _cttbRefresh.alpha = 0.0;
        return;
    }
    
	if (reloading) return;
	
	if (scrollView.contentOffset.y <= - 65.0f) {
        [self showReloadAnimationAnimated:YES];
		if([self.dataSource respondsToSelector:
			@selector(getDataFromInternetFromOffset:)]){
			[self showReloadAnimationAnimated:YES];
			//[psst2Sound play];
			//if ([CommonFuncs checkNetworkIsValid]) {
                //[self clearData];
            //}
			//[self getDataFromInternetFromOffset:0];
		}
	}
	checkForRefresh = NO;
    if ([_parentDelegate conformsToProtocol:@protocol(CustomTableViewDelegate)]) {
        [_parentDelegate refreshDataList:self];
        [_cttbRefresh setLastUpdatedDate:[NSDate date]];
    }
}


- (void) loaddingComplete {
	self.contentInset = UIEdgeInsetsZero;
	reloading = NO;
	[_cttbRefresh flipImageAnimated:YES];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.3];
	[self setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
	[_cttbRefresh setStatus:kPullToReloadStatus];
	[_cttbRefresh toggleActivityView:NO];
	[UIView commitAnimations];
    [_cttbRefresh setLastUpdatedDate:[NSDate date]];
}

- (void) setUpdateTime:(NSString *)value {
	//_cttbRefresh.isShowUpdateTime = ![value isEqualToString:@""];
	//[_cttbRefresh setUpdateTime:value];
}

@end
