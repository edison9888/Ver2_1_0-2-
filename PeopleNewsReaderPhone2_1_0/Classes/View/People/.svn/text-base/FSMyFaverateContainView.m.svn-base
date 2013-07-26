//
//  FSMyFaverateContainView.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-12-12.
//
//

#import "FSMyFaverateContainView.h"
#import "FSNewsListCell.h"
#import "FSBaseDB.h"
#import "FSMyFaverateObject.h"

@implementation FSMyFaverateContainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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


-(void)doSomethingAtInit{
}


-(void)doSomethingAtDealloc{
    
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSArray *array = [[FSBaseDB sharedFSBaseDB] getAllObjectsSortByKey:@"FSMyFaverateObject" key:@"UPDATE_DATE" ascending:NO];
        
        FSMyFaverateObject *o = [array objectAtIndex:[indexPath row]];
        
        [[FSBaseDB sharedFSBaseDB].managedObjectContext deleteObject:o];
        
        [[FSBaseDB sharedFSBaseDB].managedObjectContext save:nil];
        
        [_tvList reloadData];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}


-(UITableViewStyle)initializeTableViewStyle{
    return UITableViewStylePlain;
}



-(NSString *)cellIdentifierStringWithIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath row] == 0) {
        return @"RoutineNewsListTopCell";
    }
    return @"RoutineNewsListCell";
}

-(Class)cellClassWithIndexPath:(NSIndexPath *)indexPath{
    return [FSNewsListCell class];
}

-(void)initializeCell:(UITableViewCell *)cell withData:(NSObject *)data withIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"initializeCellinitializeCell");
}


-(void)layoutSubviews{
    _tvList.frame = roundToRect(CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height));
	
	if (!CGSizeEqualToSize(_tvSize, _tvList.frame.size)) {
		_tvSize = _tvList.frame.size;
		//防止不重新装载数据
		[_tvList reloadData];
	}
    
    _tvList.delegate = self;
    _tvList.separatorStyle = YES;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height = [[self cellClassWithIndexPath:indexPath]
                      computCellHeight:[self cellDataObjectWithIndexPath:indexPath]
                      cellWidth:tableView.frame.size.width];
    
    return height;
    
    return ROUTINE_NEWS_LIST_HEIGHT;
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

@end
