//
//  FSSettingView.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-16.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSSettingView.h"


@implementation FSSettingView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        _tvList.sectionHeaderHeight = 16.0f;
		_tvList.sectionFooterHeight = 16.0f;
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (UITableViewStyle)initializeTableViewStyle {
	return UITableViewStyleGrouped;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 32.0f;
}

- (Class)cellClassWithIndexPath:(NSIndexPath *)indexPath {
	return [FSSettingCell class];
}

- (NSString *)cellIdentifierStringWithIndexPath:(NSIndexPath *)indexPath {
	return @"CellIdentifierPeopleSetting_String";
}

@end
