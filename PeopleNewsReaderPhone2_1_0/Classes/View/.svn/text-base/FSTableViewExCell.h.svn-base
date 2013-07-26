//
//  FSTableViewExCell.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-12.
//
//

#import <UIKit/UIKit.h>

@interface FSTableViewExCell : UITableViewCell {
@protected
    NSIndexPath *_indexPath;
    id _parentDelegate;
	NSObject *_data;
	CGSize _layoutSize;
}

@property (nonatomic, retain) NSIndexPath *indexPath;
@property (nonatomic, retain, setter = setData:) NSObject *data;

- (CGSize)layoutCellSubviews:(BOOL)isLayout;
- (CGFloat)cellWidth;
- (CGFloat)cellHeight;
@end
