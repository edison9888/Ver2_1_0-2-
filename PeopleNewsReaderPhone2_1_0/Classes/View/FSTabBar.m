//
//  FSTabBar.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-6.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSTabBar.h"




@interface FSTabBar(PrivateMethod)
- (void)inner_releaseItems;
- (void)inner_layoutSubviews;
@end


@implementation FSTabBar
@synthesize fsItems = _fsItems;
@synthesize fsSelectedIndex = _fsSelectedIndex;
@synthesize parentDelegate = _parentDelegate;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        _fsSelectedIndex = -1;
		_currentSelectedItem = nil;
		
        UIColor *colorBG = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"tabBarBG.png"]];
		self.backgroundColor = colorBG;// [UIColor colorWithRed:205.0f / 255.0f green:205.0f / 255.0f blue:205.0f / 255.0f alpha:1.0f];
        [colorBG release];
        
        self.layer.shadowOffset = CGSizeMake(0.0f, -2.0f);
        self.layer.shadowOpacity = 0.45f;
        self.layer.shadowColor = [UIColor colorWithRed:45.0f / 255.0f green:45.0f / 255.0f blue:45.0f / 255.0f alpha:1.0].CGColor;
    }
    return self;
}

- (void)dealloc {
	[self inner_releaseItems];
	[_fsItems release];
    [super dealloc];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	[self inner_layoutSubviews];
}

- (void)setFsItems:(NSArray *)value {
	[self inner_releaseItems];
	[_fsItems release];
	_fsItems = [[NSArray alloc] initWithArray:value];
	
	for (int i = 0; i < [_fsItems count]; i++) {
		//FSTabBarItem *fsItem = [[FSTabBarItem alloc] initWithFrame:CGRectZero];
		FSTabBarItem *fsItem = [_fsItems objectAtIndex:i];
		fsItem.tabBarHeight = self.frame.size.height;
		fsItem.tag = i;
		[fsItem addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:fsItem];
		//[fsItem release];
	}
	[self inner_layoutSubviews];
}

- (void)setFsSelectedIndex:(NSInteger)value {
	_fsSelectedIndex = value;
	//
	for (FSTabBarItem *fsItem in _fsItems) {
		if (fsItem.tag == _fsSelectedIndex) {
			[fsItem sendActionsForControlEvents:UIControlEventTouchUpInside];
			break;
		}
	}
}

#pragma mark -
#pragma mark PrivateMethod
- (void)inner_releaseItems {
	for (FSTabBarItem *item in _fsItems) {
		[item removeFromSuperview];
		[item removeTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
	}
}

- (void)itemAction:(id)sender {
	if ([sender isKindOfClass:[FSTabBarItem class]]) {
		FSTabBarItem *fsItem = (FSTabBarItem *)sender;
		if (![fsItem isEqual:_currentSelectedItem]) {
			[fsItem setSelected:YES];
			[_currentSelectedItem setSelected:NO];
			
			_currentSelectedItem = fsItem;
			_fsSelectedIndex = fsItem.tag;
			
			if ([_parentDelegate respondsToSelector:@selector(fsTabBarDidSelected:withFsTabIndex:)]) {
				[_parentDelegate fsTabBarDidSelected:self withFsTabIndex:_fsSelectedIndex];
			}
		}
		//搞
	}
}


- (void)inner_layoutSubviews {
	NSInteger fsTabCount = MIN([_fsItems count], 5);
	
	if (fsTabCount == 0) {
		return;
	}
	
	CGFloat left = 0.0f;
	CGFloat width = self.frame.size.width / fsTabCount;
	for (int i = 0; i < fsTabCount; i++) {
		FSTabBarItem *fsItem = [_fsItems objectAtIndex:i];
		fsItem.frame = CGRectMake(left, 0.0f, width, self.frame.size.height);
		fsItem.tabBarHeight = self.frame.size.height;
		left += width;
	}
	
}

@end
