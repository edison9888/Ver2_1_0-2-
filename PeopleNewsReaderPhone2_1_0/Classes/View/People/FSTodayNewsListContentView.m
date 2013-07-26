//
//  FSTodayNewsListContentView.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-3.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSTodayNewsListContentView.h"
#import "FSTodayNewsListCell.h"
#import "FSTodayNewsListTopBigImageCell.h"
#import "FSTimerView.h"


@implementation FSTodayNewsListContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _controllerViewOffset = 44.0f;
    }
    return self;
}


-(void)doSomethingAtInit{
    
    _tableView.parentDelegate = self;
    _tableView.frame = CGRectMake(_controllerViewOffset, 0, self.frame.size.width - _controllerViewOffset, self.frame.size.height);
    _timerView = [[FSTimerView alloc] initWithFrame:CGRectMake(self.frame.size.width-100, 0, TIMERVIEW_WIDTH, TIMERVIEW_HEIGHT)];
    _timerView.alpha = 1.0;
    
    _image_topIcon = [[UIImageView alloc] init];
    _image_ChannelIcon = [[UIImageView alloc] init];
    
    [self addSubview:_timerView];
    [self addSubview:_image_topIcon];
    [self addSubview:_image_ChannelIcon];
}


-(void)doSomethingAtDealloc{
   [_timerView release]; 
}

-(void)layoutSubviews{
    
    _image_topIcon.frame = CGRectMake(3, 6, 35, 35);
    _image_ChannelIcon.frame = CGRectMake(3, self.frame.size.height/2-17, 35, 35);
    _tableView.frame = CGRectMake(_controllerViewOffset, 0, self.frame.size.width - _controllerViewOffset, self.frame.size.height);
    [FSTodayNewsListCell setCellWidth:_tableView.frame.size.width];
    //_timerView.frame = CGRectMake(self.frame.size.width-100, 0, TIMERVIEW_WIDTH, TIMERVIEW_HEIGHT);
    
}


-(void)reLoadData{
    
    
    NSLog(@"_tableView:%@",NSStringFromCGRect(_tableView.frame));
    [FSTodayNewsListCell setCellWidth:_tableView.frame.size.width];
    [_tableView reloadData];
    //[_tableView performSelector:@selector(reLoadData) withObject:nil afterDelay:1];
    _image_topIcon.image = [UIImage imageNamed:@"F201208071344309378553653.jpg"];
    _image_ChannelIcon.image = [UIImage imageNamed:@"F201208071344309378553653.jpg"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/




#pragma -mark
#pragma UITableViewDelegate -mark

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath row] == 0) {
        [FSTodayNewsListTopBigImageCell getCellHeight];
        return TODAYNEWSLIST_TOP_CELL_HEIGHT;
    }
    else{
        [FSTodayNewsListCell getCellHeight];
        return TODAYNEWSLIST_CELL_WITHOUT_HEIGHT;
        return TODAYNEWSLIST_CELL_HEIGHT;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *UITableViewCellsign = @"todayNewsCell";
    
    if ([indexPath row] == 0) {
        UITableViewCellsign = @"todayNewsTopCell";
    }
    else{
        UITableViewCellsign = @"todayNewsCell";
    }
    
    NSLog(@"indexPath:%d",[indexPath row]);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCellsign];
    if ([UITableViewCellsign isEqualToString:@"todayNewsTopCell"]) {
        
        if (cell == nil) {
            cell = [[[FSTodayNewsListTopBigImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:UITableViewCellsign]autorelease];
        }
        FSTodayNewsListTopBigImageCell *_cell = (FSTodayNewsListTopBigImageCell*)cell;
        _cell.selectionStyle = UITableViewCellSelectionStyleNone;
        _cell.parentDelegate = self;
        _cell.ViewKind = TopCellViewKind_ForTodayNews;
        [_cell reSetFrame];
        return _cell;
    }
    else{
        if (cell == nil) {
            cell = [[[FSTodayNewsListCell alloc]initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:UITableViewCellsign]autorelease];
        }
        FSTodayNewsListCell *_cell = (FSTodayNewsListCell*)cell;
        _cell.withoutImage = YES;
        [_cell reSetFrame];  
        return _cell;
    }
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma -mark
#pragma UIScorllerDelegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_tableView bottomScrollViewWillBeginDragging:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView { 
	[_tableView bottomScrollViewDidScroll:scrollView];
    
    
    
    _timerView.alpha = 1.0;
    CGFloat timeButyonY = scrollView.contentOffset.y*self.frame.size.height/scrollView.contentSize.height;
    
    if (timeButyonY < 0) {
        timeButyonY = 0;
    }
    if (timeButyonY>self.frame.size.height-TIMERVIEW_HEIGHT) {
        timeButyonY = self.frame.size.height-TIMERVIEW_HEIGHT;
    }
    
    CGFloat moveDistent = scrollView.contentOffset.y + timeButyonY;
    
    NSInteger i=0;
    CGFloat cellHeight = 0;
    NSInteger index=0;
    for (i=0; i<20; i++) {
        
        switch (i) {
            case 0:
                cellHeight = cellHeight + TODAYNEWSLIST_TOP_IMAGESIZE_HEIGHT;
                break;
            default:
                cellHeight = cellHeight + TODAYNEWSLIST_CELL_HEIGHT;
                break;
        }
        if (cellHeight<moveDistent) {
            index = i+1;
        }
        if (cellHeight>moveDistent) {
            break;
        }
    }
    [_timerView setTimer:index];
    
    _timerView.frame = CGRectMake(self.frame.size.width-100, timeButyonY, TIMERVIEW_WIDTH, TIMERVIEW_HEIGHT);
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2];
    _timerView.alpha = 0.0;
    [UIView commitAnimations];
    

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {

	[_tableView bottomScrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}


#pragma -mark
#pragma CellContentImagesTouchEventDelegate

-(void)CellContentImagesTouchInside:(FSBaseCell *)Cell{
    NSLog(@"CellContentImagesTouchInside FSTodayNewsListContentView");
    [FSTodayNewsListCell setCellWidth:_tableView.frame.size.width];
    [_tableView reloadData];
}

#pragma -mark
#pragma CustomTableViewDelegate

-(void)refreshDataList:(CustomTableView *)sender{
    
}

-(void)getNextDataList:(CustomTableView *)sender{
    
}

@end
