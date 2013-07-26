//
//  FSLocalNewsCityListView.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-14.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSLocalNewsCityListView.h"
//#import <QuartzCore/QuartzCore.h>


@implementation FSLocalNewsCityListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _fsSectionListForTouch = [[FSSectionListForTouch alloc] initWithFrame:CGRectZero];
        //_fsSectionListForTouch.backgroundColor = COLOR_CLEAR;
        _fsSectionListForTouch.parentDelegate = self;
        //_fsSectionListForTouch.layer.borderWidth = 8.0f;
        //_fsSectionListForTouch.layer.borderColor = COLOR_BLACK_8.CGColor;
        [self addSubview:_fsSectionListForTouch];
    }
    return self;
}





-(UITableViewStyle)initializeTableViewStyle{
    return UITableViewStyleGrouped;
}



-(NSString *)cellIdentifierStringWithIndexPath:(NSIndexPath *)indexPath{
    return @"citylistCell";
}

-(Class)cellClassWithIndexPath:(NSIndexPath *)indexPath{
    return [UITableViewCell class];   
}

-(void)initializeCell:(UITableViewCell *)cell withData:(NSObject *)data withIndexPath:(NSIndexPath *)indexPath{
    
    
    cell.textLabel.text = (NSString *)data;
    
    
    cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width-90, cell.frame.size.height);
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}




-(void)layoutSubviews{
    _tvList.frame = roundToRect(CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height));
	
	if (!CGSizeEqualToSize(_tvSize, _tvList.frame.size)) {
		_tvSize = _tvList.frame.size;
		//防止不重新装载数据
		[_tvList reloadData];
	} 
    _tvList.separatorStyle = YES;
    _tvList.delegate = self;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0f;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView { 
	[_tvList bottomScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	[_tvList bottomScrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}


-(void)dealloc{
    [_fsSectionListForTouch release];
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


-(void)setRightList:(NSArray *)array{
    _fsSectionListForTouch.frame = CGRectMake(self.frame.size.width - 44, 4, 40, self.frame.size.height-8);
    _fsSectionListForTouch.data = array;
}


-(void)fsBaseContainerViewTouchEvent:(FSBaseContainerView *)sender{
    if ([sender isEqual:_fsSectionListForTouch]) {
        FSSectionListForTouch *o = (FSSectionListForTouch *)sender;
        //NSLog(@"o.currentIdex:%d",o.currentIdex);
        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:o.currentIdex+1];
        [_tvList scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    }
}


@end
