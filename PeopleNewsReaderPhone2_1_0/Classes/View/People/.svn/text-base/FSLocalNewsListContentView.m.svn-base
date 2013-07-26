//
//  FSLocalNewsListContentView.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-10.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSLocalNewsListContentView.h"
#import "FSWeatherInformationCell.h"
#import "FSOneDayTableListCell.h"
#import "FSLocalNewsListCell.h"


@implementation FSLocalNewsListContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _controllerViewOffset = 0.0f;
         _tvList.assistantViewFlag = FSTABLEVIEW_ASSISTANT_BOTTOM_BUTTON_VIEW | FSTABLEVIEW_ASSISTANT_TOP_VIEW;
        _oldCount = 0;
    }
    return self;
}




-(UITableViewStyle)initializeTableViewStyle{
    return UITableViewStylePlain;
}



-(void)reSetAssistantViewFlag:(NSInteger)arrayCount{
    if (_oldCount==arrayCount && arrayCount!=0) {
        _tvList.assistantViewFlag = FSTABLEVIEW_ASSISTANT_TOP_VIEW;
    }
    else{
        _tvList.assistantViewFlag = FSTABLEVIEW_ASSISTANT_BOTTOM_BUTTON_VIEW | FSTABLEVIEW_ASSISTANT_TOP_VIEW | FSTABLEVIEW_ASSISTANT_BOTTOM_VIEW;
        _oldCount=arrayCount;
    }
}



-(NSString *)cellIdentifierStringWithIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath row] == 0) {
        return @"localnewsTopCell";
    }
    return [NSString stringWithFormat:@"localnewslistCell_%d",[indexPath row]];
}

-(Class)cellClassWithIndexPath:(NSIndexPath *)indexPath{
    if([indexPath row]==0){
        return [FSWeatherInformationCell class];
    }
    return [FSLocalNewsListCell class];   
}

-(void)initializeCell:(UITableViewCell *)cell withData:(NSObject *)data withIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"initializeCellinitializeCell");
}

-(void)layoutSubviews{
    _tvList.frame = roundToRect(CGRectMake(0.0f, 44.0f, self.frame.size.width, self.frame.size.height-44));
	
	if (!CGSizeEqualToSize(_tvSize, _tvList.frame.size)) {
		_tvSize = _tvList.frame.size;
		//防止不重新装载数据
		[_tvList reloadData];
	}
    _tvList.delegate = self;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath row] == 0) {
        
        return WEATHER_TOP_CELL_HEIGHT;
    }
    else{
        _tvList.separatorStyle = YES;
        return ROUTINE_NEWS_LIST_HEIGHT;
    }
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
