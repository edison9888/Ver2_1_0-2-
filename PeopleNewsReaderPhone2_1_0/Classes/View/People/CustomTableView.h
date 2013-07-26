//
//  CustomTableView.h
//  PeopleMicroBlogClient
//
//  Created by chen guoshuang on 11-2-7.
//  Copyright 2011 People. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomTableTopBottomView;

@interface CustomTableView : UITableView {
@private
	//CustomTableTopBottomView *_cttbNext;
	CustomTableTopBottomView *_cttbRefresh;
	BOOL _bottomShow;
	BOOL _topShow;
	id _parentDelegate;
    BOOL reloading;
    BOOL checkForRefresh;
}

@property (nonatomic) BOOL bottomShow;
@property (nonatomic) BOOL topShow;
@property (nonatomic, assign) id parentDelegate;

- (void) setBottomHidden:(BOOL)value;

- (void) loaddingComplete;

- (CGFloat) getBottomHeight;

- (void)bottomScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)bottomScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)bottomScrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void) setUpdateTime:(NSString *)value;

@end

@protocol CustomTableViewDelegate
- (void) getNextDataList:(CustomTableView *)sender;
- (void) refreshDataList:(CustomTableView *)sender;

@end

