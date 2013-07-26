//
//  FSOneDayNewsListContainerView.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-20.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSOneDayNewsListContainerView.h"
#import "FSTimerView.h"
#import "FSTodayNewsListTopBigImageCell.h"
#import "FSOneDayTableListCell.h"
#import "FSSectionObject.h"
#import "FSTimeViewForSection.h"

@implementation FSOneDayNewsListContainerView

@synthesize timeArray = _timeArray;
@synthesize sectionArray = _sectionArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _timerView = [[FSTimerView alloc] initWithFrame:CGRectMake(self.frame.size.width-68, 0, TIMERVIEW_WIDTH, TIMERVIEW_HEIGHT)];
        _timerView.alpha = 0.0;
        _oldCount = 0;
        _tvList.assistantViewFlag = FSTABLEVIEW_ASSISTANT_BOTTOM_BUTTON_VIEW | FSTABLEVIEW_ASSISTANT_TOP_VIEW;
        _heightArray = [[NSMutableArray alloc] init];
        [self addSubview:_timerView];
        
    }
    return self;
}


-(void)dealloc{
    [_timerView release];
    [_heightArray release];
    
    [super dealloc];
}

-(UITableViewStyle)initializeTableViewStyle{
    return UITableViewStylePlain;
}

-(NSString *)cellIdentifierStringWithIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath row] == 0 && [indexPath section]==0) {
        return @"todayNewsTopCell";
    }
    else{
        return [NSString stringWithFormat:@"onedaynewslist_%d",[indexPath row]];
    }
}

-(Class)cellClassWithIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath row]==0 && [indexPath section]==0) {
        return [FSTodayNewsListTopBigImageCell class];   
    }
    else{
        return [FSOneDayTableListCell class];
    }
    
}

-(void)reSetAssistantViewFlag:(NSInteger)arrayCount{
    NSLog(@"arrayCount:%d  %d",arrayCount,_oldCount);
    if (_oldCount==arrayCount && arrayCount!=0) {
        _tvList.assistantViewFlag = FSTABLEVIEW_ASSISTANT_TOP_VIEW;
    }
    else{
        _tvList.assistantViewFlag = FSTABLEVIEW_ASSISTANT_BOTTOM_BUTTON_VIEW | FSTABLEVIEW_ASSISTANT_TOP_VIEW | FSTABLEVIEW_ASSISTANT_BOTTOM_VIEW;
        _oldCount=arrayCount;
    }
}



-(void)initializeCell:(UITableViewCell *)cell withData:(NSObject *)data withIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"initializeCellinitializeCell");
    
}



-(void)layoutSubviews{
    self.backgroundColor = COLOR_CLEAR;
    NSLog(@"%@",self);
    _tvList.frame = roundToRect(CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height)); 
	if (!CGSizeEqualToSize(_tvSize, _tvList.frame.size)) {
		_tvSize = _tvList.frame.size;
		//防止不重新装载数据
        [_heightArray removeAllObjects];
		[_tvList reloadData];
	} 
    _tvList.delegate = self;
    //_tvList.separatorStyle = YES;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([indexPath row] == 0 && [indexPath section]==0) {
        return TODAYNEWSLIST_TOP_CELL_HEIGHT;
    }
    else{
        
        CGFloat height = [[self cellClassWithIndexPath:indexPath]
                          computCellHeight:[self cellDataObjectWithIndexPath:indexPath]
                          cellWidth:tableView.frame.size.width];
        
        [_heightArray addObject:[NSNumber numberWithFloat:height]];
        
        return height;
        
        //return TODAYNEWSLIST_CELL_HEIGHT;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0;
    }
    
    return 37;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section != 0) {
        FSTimeViewForSection *sectionView = [[FSTimeViewForSection alloc] init];
        
//        sectionView.layer.shadowColor = [UIColor darkGrayColor].CGColor;
//        sectionView.layer.shadowOffset = CGSizeMake(0, 2);
//        sectionView.layer.shadowOpacity = 0.5;
        sectionView.frame = CGRectMake(0, 0, 320, 37);
        NSMutableArray *o = (NSMutableArray *)_sectionArray;
        if (section<=[o count]) {
            sectionView.data = [o objectAtIndex:section-1];
        }
        return [sectionView autorelease];
    }
    return nil;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView { 
	[_tvList bottomScrollViewDidScroll:scrollView];
    [self timerViewMove:scrollView];
    
    if (!_tvList.isRefreshing) {
        return;
    }
    
    CGFloat sectionHeaderHeight;
    if (scrollView.contentOffset.y<=0) {
        sectionHeaderHeight= 0;
    }
    else{
        sectionHeaderHeight= 37;

    }
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        if (_tvList.isRefreshing) {
            scrollView.contentInset = UIEdgeInsetsMake(64.0f, 0, 0, 0);
        }
        else{
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        }
        
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	[_tvList bottomScrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.5];
    _timerView.alpha = 0.0;
    [UIView commitAnimations];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.5];
    _timerView.alpha = 0.0;
    [UIView commitAnimations];
}




-(void)timerViewMove:(UIScrollView *)scrollView{
    
    CGFloat timeButyonY = scrollView.contentOffset.y*self.frame.size.height/scrollView.contentSize.height;
    //NSLog(@"timeButyonY:%f  :%f",timeButyonY,self.frame.size.height);
    if (timeButyonY < 0) {
        timeButyonY = 0;
    }
    if (timeButyonY>self.frame.size.height-TIMERVIEW_HEIGHT) {
        timeButyonY = self.frame.size.height-TIMERVIEW_HEIGHT;
    }
    
    CGFloat moveDistent = scrollView.contentOffset.y + timeButyonY;
    NSMutableArray *CellArray = (NSMutableArray *)_timeArray;
    NSMutableArray *CellsectionArray = (NSMutableArray *)_sectionArray;
    NSInteger i=0;
    CGFloat cellHeight = 0;
    NSInteger mark = 0;
    NSInteger index=0;
    CGFloat Heigh = 0;
    for (i=0; i<[CellArray count]+1+[CellsectionArray count]; i++) {
        if (i==0) {
            cellHeight = cellHeight + TODAYNEWSLIST_TOP_IMAGESIZE_HEIGHT;
        }else{
            NSNumber *num = [_heightArray objectAtIndex:i-mark-1];
            Heigh = num.floatValue;
        }
        for (int j = 0; j<[CellsectionArray count]; j++) {
            FSSectionObject *o = [CellsectionArray objectAtIndex:j];
            if (i==o.sectionBeginIndex + j+1) {
                Heigh = 37;
                mark = j+1;
                break;
            }
        }
        cellHeight = cellHeight + Heigh;
        if (cellHeight<moveDistent) {
            index = i+1;
        }
        if (cellHeight>moveDistent) {
            break;
        }
    }
    
    if (index-1-mark>=0 && index-1-mark<[CellArray count]) {
        //NSLog(@"000000:%d :%d",index-1-mark,[CellArray count]);
        [_timerView setTimer:[CellArray objectAtIndex:index-1-mark]];
        _timerView.alpha = 1.0;
    }
    else{
        //NSLog(@"000000:%d :%d",index-1-mark,[CellArray count]);
    }
    
    _timerView.frame = CGRectMake(self.frame.size.width-50, timeButyonY, TIMERVIEW_WIDTH, TIMERVIEW_HEIGHT);
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
