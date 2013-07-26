//
//  FSMoreContainerView.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-24.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSMoreContainerView.h"
#import "FSMoreTableListTopCell.h"
#import "FSMoreTablePeopleAPPCell.h"
#import "FSRecommendListCell.h"
#import "FSMoreTableListSectionView.h"

#import "FSWithSwitchButtonCell.h"
#import "FSAuthorizationTableListCell.h"



@implementation FSMoreContainerView

@synthesize flag = _flag;
@synthesize data = _data;

@synthesize currentIndex = _currentIndex;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _flag = 0;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


-(UITableViewStyle)initializeTableViewStyle{
    return UITableViewStyleGrouped;
}

-(NSString *)cellIdentifierStringWithIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = [indexPath section];
    if (section == 0) {
        return @"moreApp0"; 
    }
    if (section == 1) {
        return @"moreApp1";
    }
    if (section == 2) {
        return @"moreApp2";
    }
    if (section == 3) {
        return @"moreApp3";
    }
    return @"moreRem";
}

-(Class)cellClassWithIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = [indexPath section];
    
//    if (section == 0) {
//        return [FSMoreTablePeopleAPPCell class];
//        
//    }
    if (section==1) {
        //set the switch button
        return [FSWithSwitchButtonCell class];
    }
    if (_flag == 2) {
        return [FSAuthorizationTableListCell class];
    }
    return [UITableViewCell class];
    
}

-(void)initializeCell:(UITableViewCell *)cell withData:(NSObject *)data withIndexPath:(NSIndexPath *)indexPath{
    
    //NSLog(@"MoreListCell");
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    
    if (_flag == 0) {
        
//        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CellBackground"]];
//        cell.backgroundView =imgView;
//        [imgView release];
        
        if (section == 0) {
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            switch (row) {
                case 0:
                    cell.textLabel.text = @"正文字号";
                    cell.textLabel.textColor = COLOR_NEWSLIST_TITLE;//[UIColor colorWithRed:204.0/255.0 green:204/255.0 blue:204.0/255.0 alpha:1];
                    break;
                    //                case 1:
                    //                    cell.textLabel.text = @"环境语言";
                    //                    cell.textLabel.textColor = [UIColor colorWithRed:204.0/255.0 green:204/255.0 blue:204.0/255.0 alpha:1];
                    //                    break;
                case 1:
                    cell.textLabel.text = @"订阅我的头条";
                    cell.textLabel.textColor = COLOR_NEWSLIST_TITLE;//[UIColor colorWithRed:204.0/255.0 green:204/255.0 blue:204.0/255.0 alpha:1];
                    break;
                case 2:
                    cell.textLabel.text = @"账号绑定";
                    cell.textLabel.textColor = COLOR_NEWSLIST_TITLE;//[UIColor colorWithRed:204.0/255.0 green:204/255.0 blue:204.0/255.0 alpha:1];
                    break;
                    
                default:
                    break;
            }
        }
        
        if (section == 2) {
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            switch (row) {
                case 0:
                    cell.textLabel.text = @"意见反馈";
                    cell.textLabel.textColor = COLOR_NEWSLIST_TITLE;//[UIColor colorWithRed:204.0/255.0 green:204/255.0 blue:204.0/255.0 alpha:1];
                    break;
                    //                case 1:
                    //                    cell.textLabel.text = @"环境语言";
                    //                    cell.textLabel.textColor = [UIColor colorWithRed:204.0/255.0 green:204/255.0 blue:204.0/255.0 alpha:1];
                    //                    break;
                case 1:
                    cell.textLabel.text = @"为我打分";
                    cell.textLabel.textColor = COLOR_NEWSLIST_TITLE;//[UIColor colorWithRed:204.0/255.0 green:204/255.0 blue:204.0/255.0 alpha:1];
                    break;
                case 2:
                    cell.textLabel.text = @"关于我们";
                    cell.textLabel.textColor = COLOR_NEWSLIST_TITLE;//[UIColor colorWithRed:204.0/255.0 green:204/255.0 blue:204.0/255.0 alpha:1];
                    break;
                    
                default:
                    break;
            }
        }
    }
    
    if (_flag == 1){
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        
//        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CellBackgroundMark.png"]];
//        cell.backgroundView =imgView;
//        [imgView release];
        
        NSNumber *n = [[GlobalConfig shareConfig] readFontSize];
        if (row == [n integerValue]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            oldIndexPath = [indexPath retain];
        }
        switch (row) {
            case 0:
                cell.textLabel.text = @"小号";
                cell.textLabel.textColor = [UIColor colorWithRed:204.0/255.0 green:204/255.0 blue:204.0/255.0 alpha:1];
                break;
            case 1:
                cell.textLabel.text = @"中号";
                cell.textLabel.textColor = [UIColor colorWithRed:204.0/255.0 green:204/255.0 blue:204.0/255.0 alpha:1];
                break;
            case 2:
                cell.textLabel.text = @"大号";
                cell.textLabel.textColor = [UIColor colorWithRed:204.0/255.0 green:204/255.0 blue:204.0/255.0 alpha:1];
                break;
            case 3:
                cell.textLabel.text = @"超大号";
                cell.textLabel.textColor = [UIColor colorWithRed:204.0/255.0 green:204/255.0 blue:204.0/255.0 alpha:1];
                break;
                
            default:
                break;
        }
        
    }
    
    //    if (_flag == 2){
    //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //        cell.accessoryType = UITableViewCellAccessoryNone;
    //
    //        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CellBackgroundMark"]];
    //        cell.backgroundView =imgView;
    //        [imgView release];
    //
    //        switch (row) {
    //            case 0:
    //                oldIndexPath = [indexPath retain];
    //                cell.accessoryType = UITableViewCellAccessoryCheckmark;
    //                cell.textLabel.text = @"中文简体";
    //                cell.textLabel.textColor = [UIColor colorWithRed:204.0/255.0 green:204/255.0 blue:204.0/255.0 alpha:1];
    //                break;
    //            case 1:
    //                cell.textLabel.text = @"中文繁體";
    //                cell.textLabel.textColor = [UIColor colorWithRed:204.0/255.0 green:204/255.0 blue:204.0/255.0 alpha:1];
    //                break;
    //            case 2:
    //                cell.textLabel.text = @"English";
    //                cell.textLabel.textColor = [UIColor colorWithRed:204.0/255.0 green:204/255.0 blue:204.0/255.0 alpha:1];
    //                break;
    //            default:
    //                break;
    //        }
    //        
    //    }
    
}




-(void)layoutSubviews{
    _tvList.frame = roundToRect(CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height));
    UIImageView *bgimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chunbai.png"]];
	_tvList.backgroundView = bgimage;
    [bgimage release];
    
	if (!CGSizeEqualToSize(_tvSize, _tvList.frame.size)) {
		_tvSize = _tvList.frame.size;
		//防止不重新装载数据
		[_tvList reloadData];
	} 
    
    _tvList.delegate = self;
    _tvList.separatorStyle = YES;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSInteger section = [indexPath section];
//    NSInteger row = [indexPath row];
//    if (section == 0 && row == 0){
//        return MORE_LIST_PEOPLEAPP_CELL_HEIGHT;
//        //return MORE_LIST_TOP_CELL_HEIGHT;
//    }
////    if (section == 1 && row == 0) {
////        return MORE_LIST_PEOPLEAPP_CELL_HEIGHT;
////    }
    return 40.0f;
}  

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return MORE_LIST_PEOPLEAPP_CELL_HEIGHT;
    }
	return 32.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        
        FSRecommendSectView *sectionView = [[FSRecommendSectView alloc] init];
        sectionView.parentDelegate = self;
        sectionView.frame = CGRectMake(0, 0, 320, MORE_LIST_PEOPLEAPP_CELL_HEIGHT);
        if (section == 0 && self.data!=nil) {
            sectionView.data = self.data;
        }
        
        return [sectionView autorelease];
        
//        FSMoreTableListSectionView *sectionView = [[FSMoreTableListSectionView alloc] init];
//        sectionView.frame = CGRectMake(0, 0, 32, 320);
//        if (section == 0) {
//            sectionView.data = @"应用推荐";
//        }
//        return [sectionView autorelease];
    }
    return nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView { 
	[_tvList bottomScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	[_tvList bottomScrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}


-(void)tableCellselect:(NSIndexPath *)indexPath{
    
    if (oldIndexPath == indexPath) {
        return;
    }
    else{
        UITableViewCell *oldcell = [_tvList cellForRowAtIndexPath:oldIndexPath];
        oldcell.accessoryType = UITableViewCellAccessoryNone;
        UITableViewCell *cell = [_tvList cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [oldIndexPath release];
        oldIndexPath = [indexPath retain];
    }
    
    
}


//+++++++++++++++++++++++++++++

-(void)fsBaseContainerViewTouchEvent:(FSBaseContainerView *)sender{
    NSLog(@"fsBaseContainerViewTouchEvent FSMoreContainerView");
    
    FSRecommendSectView *obj = (FSRecommendSectView *)sender;
    self.currentIndex = obj.currentIndex;
    if ([(id)_parentDelegate respondsToSelector:@selector(tableViewTouchEvent:cell:)]) {
        [(id)_parentDelegate tableViewTouchEvent:self cell:nil];
    }
}


-(void)dealloc{
    [oldIndexPath release];
    [super dealloc];
}



@end
