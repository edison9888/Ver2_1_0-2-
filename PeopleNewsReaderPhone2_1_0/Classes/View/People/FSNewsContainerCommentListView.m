//
//  FSNewsContainerCommentListView.m
//  PeopleNewsReaderPhone
//
//  Created by Xu dandan on 12-10-26.
//
//

#import "FSNewsContainerCommentListView.h"
#import "FSNewsCommentListCell.h"
#import "FSCommentObject.h"

@implementation FSNewsContainerCommentListView

@synthesize moreButtonisShow =_moreButtonisShow;
@synthesize withOutSection = _withOutSection;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _moreButtonisShow = NO;
        _withOutSection = NO;
        _moreCommentBT = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_moreCommentBT setTitle:NSLocalizedString(@"查看全部评论", nil) forState:UIControlStateNormal];
        [_moreCommentBT addTarget:self action:@selector(moreComment:) forControlEvents:UIControlEventTouchUpInside];
        [_moreCommentBT setTintColor:COLOR_NEWSLIST_DESCRIPTION];
        [self addSubview:_moreCommentBT];
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


-(void)dealloc{
    
    [super dealloc];
}


-(UITableViewStyle)initializeTableViewStyle{
    return UITableViewStylePlain;
}

-(NSString *)cellIdentifierStringWithIndexPath:(NSIndexPath *)indexPath{
        return [NSString stringWithFormat:@"CommentListCell_%d",[indexPath row]];
}

-(Class)cellClassWithIndexPath:(NSIndexPath *)indexPath{
   
    return [FSNewsCommentListCell class];
}





-(void)initializeCell:(UITableViewCell *)cell withData:(NSObject *)data withIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"initializeCellinitializeCell");
    
}



-(void)layoutSubviews{
    NSLog(@"%@",self);
    
    if (self.withOutSection) {
         _tvList.assistantViewFlag = FSTABLEVIEW_ASSISTANT_BOTTOM_BUTTON_VIEW | FSTABLEVIEW_ASSISTANT_TOP_VIEW;
    }
    
    if (self.moreButtonisShow) {
        _moreCommentBT.alpha = 1.0f;
        _moreCommentBT.frame = roundToRect(CGRectMake(6.0f, self.frame.size.height-44.0f, self.frame.size.width-12, 34.0f));
        _tvList.frame = roundToRect(CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height));
        _tvList.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height-64.0f);
    }
    else{
        _moreCommentBT.alpha = 0.0f;
        _tvList.frame = roundToRect(CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height));
    }
    
    
	if (!CGSizeEqualToSize(_tvSize, _tvList.frame.size)) {
		_tvSize = _tvList.frame.size;
		//防止不重新装载数据
		[_tvList reloadData];
	}
    _tvList.delegate = self;
    //_tvList.separatorStyle = YES;
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [[self cellClassWithIndexPath:indexPath]
            computCellHeight:[self cellDataObjectWithIndexPath:indexPath]
            cellWidth:tableView.frame.size.width];
    
    
    return COMMENT_LIEST_CELL_HEIGHT;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (_withOutSection) {
        return 0;
    }
    return  40;
}

-(void)moreComment:(id)sender{
    if ([(id)_parentDelegate respondsToSelector:@selector(tableViewTouchPicture:index:)]) {
		[(id)_parentDelegate tableViewTouchPicture:self index:-1];
	}
}


@end
