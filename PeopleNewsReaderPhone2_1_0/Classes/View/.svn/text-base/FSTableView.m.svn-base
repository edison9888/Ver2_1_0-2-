//
//  FSTableView.m
//  PeopleDailyReader
//
//  Created by people.com.cn on 12-3-14.
//  Copyright 2012 people.com.cn. All rights reserved.
///////////////////////////////////////////////////////////////////
//	自定义单元格父类
///////////////////////////////////////////////////////////////////
//	日期				做成者			版本
///////////////////////////////////////////////////////////////////
//	2012-03-14		chen.gsh		1.0.0
//－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－

#import "FSTableView.h"

#define TOPINFO_VIEW_HEIGHT 64.0f
#define TOPINFO_VIEW_WIDTH MIN(260.0f, self.frame.size.width)

#define BOTTOMINFO_VIEW_HEIGHT 64.0f
#define BOTTOMINFO_VIEW_WIDTH MIN(260.0f, self.frame.size.width)
#define BOTTOMINFO_II_VIEW_HEIGHT 44.0f

#define BOTTOMINFO_II_VIEW_MOVE 30.0f

#define TOP_BOTTOM_BOUNCE_HEIGHT ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 320.0f : 160.0f)

#define BOTTOMBUTTON_SCALE_FACTOR 1.2f

@interface FSTableView(PrivateMethod)
- (void)setAssistantViewFlag_Inner:(NSUInteger)value;
@end


@implementation FSTableView
@synthesize parentDelegate = _parentDelegate;
@synthesize assistantViewFlag = _assistantViewFlag;
@synthesize isRefreshing = _isRefreshing;

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        _dragging = NO;
        _isRefreshing = NO;
        _isrefreshDataSource = NO;
		_oldSize = CGSizeZero;
		_assistantViewFlag = FSTABLEVIEW_ASSISTANT_NO_VIEW;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		_dragging = NO;
		_oldSize = CGSizeZero;
		_assistantViewFlag = FSTABLEVIEW_ASSISTANT_NO_VIEW;
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

- (void)dealloc {
	[_topLayer release];
	[_bottomLayer release];
	
	[_btnBottom release];
	[_topView release];
	[_bottomView release];
    [super dealloc];
}

- (void)setContentSize:(CGSize)value {
	if (value.height < self.frame.size.height) {
		value.height = self.frame.size.height;
	}
	[super setContentSize:value];
	if (_bottomView != nil) {
		_bottomView.frame = CGRectMake((self.frame.size.width - BOTTOMINFO_VIEW_WIDTH) / 2.0f, 
									   self.contentSize.height < self.frame.size.height ? self.frame.size.height+BOTTOMINFO_II_VIEW_MOVE : self.contentSize.height+BOTTOMINFO_II_VIEW_MOVE,
									   BOTTOMINFO_VIEW_WIDTH, 
									   BOTTOMINFO_VIEW_HEIGHT);
	}
	
	if (_btnBottom != nil) {
		_btnBottom.frame = CGRectMake(0.0f, 
									  self.contentSize.height < self.frame.size.height ? self.frame.size.height : self.contentSize.height, 
									  self.frame.size.width, 
									  BOTTOMINFO_II_VIEW_HEIGHT);
	}
	
	if (_bottomLayer != nil) {
		_bottomLayer.frame = CGRectMake(0.0f, 
										self.contentSize.height < self.frame.size.height ? self.frame.size.height : self.contentSize.height, 
										self.frame.size.width, 
										TOP_BOTTOM_BOUNCE_HEIGHT);
	}
}

////////////////////////////////////////////////////
//	布局控件
////////////////////////////////////////////////////
- (void)layoutSubviews {
	[super layoutSubviews];
	if (!CGSizeEqualToSize(self.frame.size, _oldSize)) {
		_oldSize = self.frame.size;
		if (_topView != nil) {
			_topView.frame = CGRectMake((self.frame.size.width - TOPINFO_VIEW_WIDTH) / 2.0f,
										0 - TOPINFO_VIEW_HEIGHT, 
										TOPINFO_VIEW_WIDTH, 
										TOPINFO_VIEW_HEIGHT);
		}
		
		if (_bottomView != nil) {
			_bottomView.frame = CGRectMake(0.0f, 
										   self.contentSize.height < self.frame.size.height ? self.frame.size.height+BOTTOMINFO_II_VIEW_MOVE : self.contentSize.height+BOTTOMINFO_II_VIEW_MOVE,
										   BOTTOMINFO_VIEW_WIDTH, 
										   BOTTOMINFO_VIEW_HEIGHT);
		}
		
		if (_btnBottom != nil) {
			_btnBottom.frame = CGRectMake(0.0f, 
										  self.contentSize.height < self.frame.size.height ? self.frame.size.height : self.contentSize.height, 
										  self.frame.size.width, 
										  BOTTOMINFO_II_VIEW_HEIGHT);
			
		}

		//顶部背景区域
		if ([_parentDelegate respondsToSelector:@selector(tableViewTopBounceAreaWithRect:)]) {
			NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
			
			UIImage *topImage = [_parentDelegate tableViewTopBounceAreaWithRect:CGRectMake(0.0f, 0.0, self.frame.size.width, TOP_BOTTOM_BOUNCE_HEIGHT*2)];
			if (topImage != nil) {
				if (_topLayer == nil) {
					_topLayer = [[CALayer alloc] init];
					[self.layer insertSublayer:_topLayer atIndex:0];
				}
				_topLayer.frame = CGRectMake(0.0f, 0 - TOP_BOTTOM_BOUNCE_HEIGHT*2, self.frame.size.width, TOP_BOTTOM_BOUNCE_HEIGHT*2);
				_topLayer.contents = (id)topImage.CGImage;
			}
			
			[pool release];
		}
		
		//底部背景区域
		if ([_parentDelegate respondsToSelector:@selector(tableViewBottomBounceAreaWithRect:)]) {
			NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
			
			UIImage *bottomImage = [_parentDelegate tableViewBottomBounceAreaWithRect:CGRectMake(0.0f, 0.0, self.frame.size.width, TOP_BOTTOM_BOUNCE_HEIGHT)];
			if (bottomImage != nil) {
				if (_bottomLayer == nil) {
					_bottomLayer = [[CALayer alloc] init];
					[self.layer insertSublayer:_bottomLayer atIndex:0];
				}
				
				_bottomLayer.frame = CGRectMake(0.0f, 
												self.contentSize.height < self.frame.size.height ? self.frame.size.height : self.contentSize.height, 
												self.frame.size.width, 
												TOP_BOTTOM_BOUNCE_HEIGHT);
				_bottomLayer.contents = (id)bottomImage.CGImage;
			}
			
			[pool release];
		}
	}
}

////////////////////////////////////////////////////
//	将效果复位
////////////////////////////////////////////////////
- (void)loaddingComplete {
    
    _isRefreshing = NO;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelay:0.2];
	if (_btnBottom != nil) {
		self.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, BOTTOMINFO_II_VIEW_HEIGHT * BOTTOMBUTTON_SCALE_FACTOR, 0.0f);
	} else {
		self.contentInset = UIEdgeInsetsZero;
	}
    [UIView commitAnimations];
	
	if (_topView != nil && _topView.dragState == dsLoadding) {
		_topView.dragState = dsNormal;
	} 
	
	if (_bottomView != nil && _bottomView.dragState == dsLoadding) {
		_bottomView.dragState = dsNormal;
	}
	
	if (_btnBottom != nil && _btnBottom.clickState == csLoadding) {
		_btnBottom.clickState = csNormal;
	}
}

////////////////////////////////////////////////////
//	刷新数据源
////////////////////////////////////////////////////
- (void)refreshDataSource {
	if (_topView != nil) {
		//以下代码有待商榷
		_dragging = YES;
        _isrefreshDataSource = YES;
		CGFloat offsetY = 0 - TOPINFO_VIEW_HEIGHT;
		
		if (self.contentOffset.y == offsetY) {
			[self bottomScrollViewDidScroll:self];
		} else {
			[self setContentOffset:CGPointMake(0.0f, 0 - TOPINFO_VIEW_HEIGHT) animated:YES];
		}
	}
}

////////////////////////////////////////////////////
//	UIScrollViewDelegate 实现过程
////////////////////////////////////////////////////
- (void)bottomScrollViewDidScroll:(UIScrollView *)scrollView {
    //NSLog(@"bottomScrollViewDidScroll:%@  :%d",_topView,_topView.hidden);
	if (_topView != nil && !_topView.hidden) {
        //NSLog(@"bottomScrollViewDidScroll 11");
		if (_topView.dragState == dsLoadding) {
			return;
		}
		//NSLog(@"bottomScrollViewDidScroll 22");
		if (scrollView.dragging || _dragging) {
			if (scrollView.contentOffset.y <= _topView.frame.origin.y) {
				_topView.dragState = dsPulling;
				//以下代码有待商榷
				if (_dragging) {
                    
					//_dragging = NO;
					[self bottomScrollViewDidEndDragging:self willDecelerate:YES];
					//[self performSelector:@selector(manualScrollViewDidEndDragging) withObject:nil afterDelay:0.0f];
				}
			} else {
				_topView.dragState = dsNormal;
			}
		} else {
			_topView.dragState = dsNormal;
		}
	}
	
	if (_bottomView != nil && !_bottomView.hidden) {
		if (_bottomView.dragState == dsLoadding) {
			return;
		}
		
		if (scrollView.dragging) {
            
			if (scrollView.contentOffset.y + scrollView.frame.size.height >= _bottomView.frame.origin.y + _bottomView.frame.size.height) {
				_bottomView.dragState = dsPulling;
                
			} else {
				_bottomView.dragState = dsNormal;
			}
		} else {
			_bottomView.dragState = dsNormal;
		}
	}
}


- (void)manualScrollViewDidEndDragging {
    //NSLog(@"manualScrollViewDidEndDragging");
	[self bottomScrollViewDidEndDragging:self willDecelerate:YES];
}

////////////////////////////////////////////////////
//	UIScrollViewDelegate 实现过程
////////////////////////////////////////////////////
- (void)bottomScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	//拖动停止，根据当前的y轴计算，是否loadding
	if (_topView != nil && !_topView.hidden) {
        //NSLog(@"bottomScrollViewDidEndDragging:%f  :%f",scrollView.contentOffset.y,_topView.frame.origin.y);
		if (scrollView.contentOffset.y <= _topView.frame.origin.y && _topView.dragState == dsPulling) {
#ifdef MYDEBUG
			//NSLog(@"刷新数据吧.....");
#endif
			_topView.dragState = dsLoadding;
			scrollView.contentInset = UIEdgeInsetsMake(_topView.frame.size.height, 0.0f, 0.0f, 0.0f);
			
                if (_dragging) {
                    _dragging = NO;
                    [self performSelector:@selector(refreshDataSource_Inner) withObject:nil afterDelay:0.002f];
                } else {
                    //回调进行刷新数据
                    if ([_parentDelegate respondsToSelector:@selector(tableViewRefreshDataSource:)]) {
                        _isRefreshing = YES;
                        [_parentDelegate tableViewRefreshDataSource:self];
                    }
                }
			
		}
	}
	
	if (_bottomView != nil && !_bottomView.hidden) {
        //NSLog(@"获取更多数据吧.....:%f",scrollView.contentOffset.y);
		if (scrollView.contentOffset.y + scrollView.frame.size.height >= _bottomView.frame.origin.y + _bottomView.frame.size.height && _bottomView.dragState == dsPulling) {
#ifdef MYDEBUG
			//NSLog(@"获取更多数据吧.....");
#endif		
			_bottomView.dragState = dsLoadding;
			scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, _bottomView.frame.size.height, 0.0f);
			
			//回调进行取更多数据
			if ([_parentDelegate respondsToSelector:@selector(tableViewNextDataSource:)]) {
                _btnBottom.clickState = csLoadding;
				[_parentDelegate tableViewNextDataSource:self];
			}
		}
	}
}

- (void)refreshDataSource_Inner {
	if ([_parentDelegate respondsToSelector:@selector(tableViewRefreshDataSource:)]) {
        _isRefreshing = YES;
		[_parentDelegate tableViewRefreshDataSource:self];
	}
}

////////////////////////////////////////////////////
//	是否拥有助手view的属性方法
////////////////////////////////////////////////////
- (void)setAssistantViewFlag:(NSUInteger)value {
	if (value != _assistantViewFlag) {
		_assistantViewFlag = value;
        //NSLog(@" 内部方法用于重新生成 _assistantViewFlag");
		[self setAssistantViewFlag_Inner:_assistantViewFlag];
	}
}

////////////////////////////////////////////////////
//	内部方法用于重新生成
////////////////////////////////////////////////////
- (void)setAssistantViewFlag_Inner:(NSUInteger)value {
	//TOP VIEW
	if ((value & FSTABLEVIEW_ASSISTANT_TOP_VIEW) == FSTABLEVIEW_ASSISTANT_TOP_VIEW) {
		//有TOPVIEW
       // NSLog(@"setAssistantViewFlag_Inner 有TOPVIEW");
		if (_topView == nil) {
			_topView = [[FSTableAssistantView alloc] initWithFrame:CGRectMake((self.frame.size.width - TOPINFO_VIEW_WIDTH) / 2.0f,
																			  0 - TOPINFO_VIEW_HEIGHT, 
																			  TOPINFO_VIEW_WIDTH, 
																			  TOPINFO_VIEW_HEIGHT)];
			_topView.parentDelegate = self;
			_topView.assistantArrowDirection = aadBottom;
			[self addSubview:_topView];
		}
        _topView.hidden = NO;
	} else {
		if (_topView != nil) {
			[_topView removeFromSuperview];
			[_topView release];
			_topView = nil;
		}
	}
	
	//BOTTOM VIEW
	if ((value & FSTABLEVIEW_ASSISTANT_BOTTOM_VIEW) == FSTABLEVIEW_ASSISTANT_BOTTOM_VIEW) {
        //NSLog(@"FSTABLEVIEW_ASSISTANT_BOTTOM_VIEW 有");
		if (_bottomView == nil) {
			_bottomView = [[FSTableAssistantView alloc] initWithFrame:CGRectMake(0.0f, 
																				 self.contentSize.height < self.frame.size.height ? self.frame.size.height+BOTTOMINFO_II_VIEW_MOVE : self.contentSize.height+BOTTOMINFO_II_VIEW_MOVE,
																				 BOTTOMINFO_VIEW_WIDTH, 
																				 BOTTOMINFO_VIEW_HEIGHT)];
			_bottomView.parentDelegate = self;
			_bottomView.assistantArrowDirection = aadTop;
			[self addSubview:_bottomView];
		}
	} else {
		if (_bottomView != nil) {
			[_bottomView removeFromSuperview];
			[_bottomView release];
			_bottomView = nil;
		}
	}
	
	//BOTTOM VIEW 优先级低，不能和 FSTABLEVIEW_ASSISTANT_BOTTOM_VIEW同时存在
	if (_bottomView == nil || 1) {
        //NSLog(@"FSTABLEVIEW_ASSISTANT_BOTTOM_BUTTON_VIEW 有");
		if ((value & FSTABLEVIEW_ASSISTANT_BOTTOM_BUTTON_VIEW) == FSTABLEVIEW_ASSISTANT_BOTTOM_BUTTON_VIEW) {
			if (_btnBottom == nil) {
				_btnBottom = [[FSTableAssistantIIView alloc] initWithFrame:CGRectMake(0.0f, 
																		self.contentSize.height < self.frame.size.height ? self.frame.size.height : self.contentSize.height, 
																		self.frame.size.width, 
																		BOTTOMINFO_II_VIEW_HEIGHT)];
				_btnBottom.parentDelegate = self;
				_btnBottom.clickState = csNormal;
				[self addSubview:_btnBottom];
				self.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, BOTTOMINFO_II_VIEW_HEIGHT * BOTTOMBUTTON_SCALE_FACTOR, 0.0f);
			}
		} else {
			if (_btnBottom != nil) {
				[_btnBottom removeFromSuperview];
				[_btnBottom release];
				_btnBottom = nil;
			}
		}
		
	}
}

////////////////////////////////////////////////////
//	数据源是否已经到达结尾
////////////////////////////////////////////////////
- (void)tableViewDataSourceIsEnding:(BOOL)value {
	if (value) {
		if (_bottomView != nil) {
			[_bottomView removeFromSuperview];
			[_bottomView release];
			_bottomView = nil;
		}
		
		if (_bottomView != nil) {
			[_bottomView removeFromSuperview];
			[_bottomView release];
			_bottomView = nil;
		}
	} else {
		[self setAssistantViewFlag_Inner:_assistantViewFlag];
	}
}

////////////////////////////////////////////////////
//	FSTableAssistantView 代理方法
////////////////////////////////////////////////////
- (NSString *)tableAssistantViewText:(FSTableAssistantView *)sender withDragState:(DragState)state {
	
	//STEP 1.根据状态来进行设置可见与不可见
	if (state == dsLoadding) {
		if ([sender isEqual:_topView]) {
			if (_bottomView != nil) {
				_bottomView.hidden = YES;
			}
			
			if (_btnBottom != nil) {
				_btnBottom.hidden = YES;
			}
		} else if ([sender isEqual:_bottomView]) {
			if (_topView != nil) {
				_topView.hidden = YES;
			}
		}
		
		
	} else {
		if (_topView != nil) {
			_topView.hidden = NO;
		}
		
		if (_bottomView != nil) {
			_bottomView.hidden = NO;
		}
		
		if (_btnBottom != nil) {
			_btnBottom.hidden = NO;
		}
	}

	//STEP 2.返回顶部字符串
	if ([sender isEqual:_topView] && _topView != nil) {
		/*
		 "下拉刷新"="下拉刷新";
		 "释放立即刷新"="释放立即刷新";
		 "正在获取数据..."="正在获取数据...";
		 "上拉获取更多数据"="上拉获取更多数据";
		 "释放立即获取更多数据"="释放立即获取更多数据";
		 "正在获取数据..."="正在获取数据...";
		 */
		if (state == dsNormal) {
			return NSLocalizedString(@"下拉刷新", nil);
		} else if (state == dsPulling) {
			return NSLocalizedString(@"松开立即刷新", nil);
		} else if (state == dsLoadding) {
			
			return  NSLocalizedString(@"正在获取数据...", nil);
		} else {
			return NSLocalizedString(@"下拉刷新", nil);
		}
	}
	
	//STEP 3.返回底部字符串
	if ([sender isEqual:_bottomView] && _bottomView != nil) {
		if (state == dsNormal) {
            _btnBottom.clickState = csNormal;
			return @"";//return NSLocalizedString(@"上拉获取更多数据", nil);
		} else if (state == dsPulling) {
            _btnBottom.clickState = csPulling;
			return @"";//return NSLocalizedString(@"释放立即获取更多数据", nil);
		} else if (state == dsLoadding) {
			
			return @"";//return NSLocalizedString(@"正在获取数据...", nil);
		} else {
			return @"";//return NSLocalizedString(@"上拉获取更多数据", nil);
		}
	}

	//不能走到这里，走到这里已经出错
	return @"";

}

- (NSString *)tableAssistantUpdateText:(FSTableAssistantView *)sender {
	if ([sender isEqual:_topView]) {
		if ([_parentDelegate respondsToSelector:@selector(tableViewDataSourceUpdateInformation:)]) {
			return [_parentDelegate tableViewDataSourceUpdateInformation:self];
		} else {
			return @"";
		}
	} else {
		return @"";
	}
}

////////////////////////////////////////////////////
//	FSTableAssistantIIView 代理方法
////////////////////////////////////////////////////
- (NSString *)tableAssistantIIViewMessage:(FSTableAssistantIIView *)sender withClickState:(ClickState)state {
	if (state == csLoadding) {
		if (_topView != nil) {
			_topView.hidden = YES;
		}	
		return NSLocalizedString(@"正在获取数据...", nil);
	} else if(state == csNormal){
		if (_topView != nil) {
			_topView.hidden = NO;
		}
		return NSLocalizedString(@"加载更多", nil);
	}else if(state == csPulling){
		if (_topView != nil) {
			_topView.hidden = NO;
		}
		return NSLocalizedString(@"释放立即获取更多数据", nil);
	}
    return @"";
}

- (void)tableAssistantIIViewAction:(FSTableAssistantIIView *)sender {
	//回调进行取更多数据
	if ([_parentDelegate respondsToSelector:@selector(tableViewNextDataSource:)]) {
		[_parentDelegate tableViewNextDataSource:self];
	}
}

@end



