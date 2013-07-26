//
//  FSPerferenceSettingView.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-7.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSPerferenceSettingView.h"
#import "FSTodayNewsListTopBigImageCell.h"


@implementation FSPerferenceSettingView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _ok_button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_ok_button setTitle:@"完成" forState:UIControlStateNormal];
        [_ok_button addTarget:self action:@selector(okButtonsel:) forControlEvents:UIControlEventTouchUpInside];
        [_tvList addSubview:_ok_button];
        
        
        _lab_text = [[UILabel alloc] init];
        _lab_text.backgroundColor = COLOR_CLEAR;
        _lab_text.textAlignment = UITextAlignmentLeft;
        _lab_text.text = @"请您选择喜爱的栏目类别";
        
        [_tvList addSubview:_lab_text];
    }
    return self;
}



-(UITableViewStyle)initializeTableViewStyle{
    return UITableViewStylePlain;
}



-(NSString *)cellIdentifierStringWithIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath section] == 0) {
        return @"PerferenceTopCell";
    }
    
    if ([indexPath section] == 1) {
        return @"PerferenceOKCell";
    }
    else{
        return @"PerferenceCell";
    }
}

-(Class)cellClassWithIndexPath:(NSIndexPath *)indexPath{
    if([indexPath section]==1){
        return [UITableViewCell class];
    }
   return [FSTodayNewsListTopBigImageCell class];   
}

-(void)initializeCell:(UITableViewCell *)cell withData:(NSObject *)data withIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"initializeCellinitializeCell");
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}



-(void)layoutSubviews{
    _tvList.frame = roundToRect(CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height)); 
	_ok_button.frame = CGRectMake(self.frame.size.width-65, PERFERENCESINTTING_LIST_TOP_HEIGHT+10, 50, 30);
    _lab_text.frame = CGRectMake(10, PERFERENCESINTTING_LIST_TOP_HEIGHT+10, self.frame.size.width, 30);
    
	if (!CGSizeEqualToSize(_tvSize, _tvList.frame.size)) {
		_tvSize = _tvList.frame.size;
		//防止不重新装载数据
		[_tvList reloadData];
	} 
    
    _tvList.delegate = self;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath section]==0) {
        return PERFERENCESINTTING_LIST_TOP_HEIGHT;
    }
    if ([indexPath section]==1) {
        return 50;
    }
    return  PERFERENCESINTTING_CHANNEL_CELL_HEIGHT;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView { 
	[_tvList bottomScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	[_tvList bottomScrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}


-(void)dealloc{
    [_lab_text release];
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


-(void)okButtonsel:(id)sender{
    //[self removeFromSuperview]; 
	if ([(id)_parentDelegate respondsToSelector:@selector(fsPerferenceSettingViewDidFinish:withChanels:)]) {
		[(id)_parentDelegate fsPerferenceSettingViewDidFinish:self withChanels:nil];
	}
}

@end
