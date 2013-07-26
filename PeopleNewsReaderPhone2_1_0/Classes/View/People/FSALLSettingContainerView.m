//
//  FSALLSettingContainerView.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-31.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSALLSettingContainerView.h"
#import "FSSettingWithSwitchButtonCell.h"
#import "FSAuthorizationTableListCell.h"

@implementation FSALLSettingContainerView

@synthesize flag = _flag;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _flag = 0;
    }
    return self;
}


-(UITableViewStyle)initializeTableViewStyle{
    return UITableViewStyleGrouped;
}



-(NSString *)cellIdentifierStringWithIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = [indexPath section];
    if (section == 0) {
        return @"moreTop";
    }
    if (section == 1) {
        return @"moreApp";
    }
    return @"moreRem";
}

-(Class)cellClassWithIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath section]==1) {
        //set the switch button
        return [FSSettingWithSwitchButtonCell class];
    }
    if (_flag == 3) {
        return [FSAuthorizationTableListCell class];
    }
    return [UITableViewCell class];
}

-(void)initializeCell:(UITableViewCell *)cell withData:(NSObject *)data withIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"MoreListCell");
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = COLOR_NEWSLIST_TITLE_WHITE;
    
    if (_flag == 0) {
        
//        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CellBackground"]];
//        cell.backgroundView =imgView;
//        [imgView release];

        if (section == 0) {
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            switch (row) {
                case 0:
                    cell.textLabel.text = @"正文字号";
                    cell.textLabel.textColor = COLOR_NEWSLIST_TITLE;
                    break;
//                case 1:
//                    cell.textLabel.text = @"环境语言";
//                    cell.textLabel.textColor = [UIColor colorWithRed:204.0/255.0 green:204/255.0 blue:204.0/255.0 alpha:1];
//                    break;
                case 1:
                    cell.textLabel.text = @"订阅我的头条";
                    cell.textLabel.textColor = COLOR_NEWSLIST_TITLE;
                    break;
                case 2:
                    cell.textLabel.text = @"账号绑定";
                    cell.textLabel.textColor = COLOR_NEWSLIST_TITLE;
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
                cell.textLabel.textColor = COLOR_NEWSLIST_TITLE;
                break;
            case 1:
                cell.textLabel.text = @"中号";
                cell.textLabel.textColor = COLOR_NEWSLIST_TITLE;
                break;
            case 2:
                cell.textLabel.text = @"大号";
                cell.textLabel.textColor = COLOR_NEWSLIST_TITLE;
                break;
            case 3:
                cell.textLabel.text = @"超大号";
                cell.textLabel.textColor = COLOR_NEWSLIST_TITLE;
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
    //_tvList.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SettingBackground.png"]];
	_tvList.backgroundColor = COLOR_NEWSLIST_TITLE_WHITE;
	if (!CGSizeEqualToSize(_tvSize, _tvList.frame.size)) {
		_tvSize = _tvList.frame.size;
		//防止不重新装载数据
		[_tvList reloadData];
	} 
    
    _tvList.delegate = self;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
	return 32.0f;
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


-(void)dealloc{
    [oldIndexPath release];
    [super dealloc];
}

@end
