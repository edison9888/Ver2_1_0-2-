//
//  FSMoreAPPRecommendView.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-3-21.
//
//

#import "FSMoreAPPRecommendView.h"
#import "FSRecommendListCell.h"

@implementation FSMoreAPPRecommendView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(UITableViewStyle)initializeTableViewStyle{
    return UITableViewStylePlain;
}



-(NSString *)cellIdentifierStringWithIndexPath:(NSIndexPath *)indexPath{
    return @"moreAPPList";
}

-(Class)cellClassWithIndexPath:(NSIndexPath *)indexPath{
    return [FSRecommendListCell class];
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



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return MORE_LIST_RECOMMEND_CELL_HEIGHT;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	[_tvList bottomScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	[_tvList bottomScrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}


-(void)dealloc{
    
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

@end
