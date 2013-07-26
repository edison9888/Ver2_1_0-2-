//
//  FSTableViewCell.m
//  PeopleDailyReader
//
//  Created by people.com.cn on 12-3-14.
//  Copyright 2012 people.com.cn. All rights reserved.
///////////////////////////////////////////////////////////////////
//	自定义单元格父类
///////////////////////////////////////////////////////////////////
//	日期				做成者			版本
///////////////////////////////////////////////////////////////////
//	2012-03-14		chen.gsh		1.0.0
//－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－

#import "FSTableViewCell.h"

#define FSTABLEVIEWCELL_BACK_IMAGE_FILE_NAME @"FSCellBackImage.png"
#define FSTABLEVIEWCELL_BACK_IMAGE_SELECTED_FILE_NAME @"FSCellBackImageSelected.png"

@interface FSTableViewCell(PrivateMethod)

@end


@implementation FSTableViewCell
@synthesize rowIndex = _rowIndex;
@synthesize sectionIndex = _sectionIndex;
@synthesize parentDelegate = _parentDelegate;
@synthesize data = _data;
@synthesize cellShouldWidth = _cellShouldWidth;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {		
		_clientSize = CGSizeZero;
		_rowIndex = -1;
		_sectionIndex = 0;
		_cellShouldWidth = self.frame.size.width;
        [self doSomethingAtInit];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

}

- (void)dealloc {
	[_data release];
    [self doSomethingAtDealloc];
    [super dealloc];
}

- (void)setData:(NSObject *)value {
	if (value != _data) {
		[_data release];
		_data = [value retain];
		_clientSize = CGSizeZero;
		[self setNeedsLayout];
	}
}

- (void)layoutSubviews {
	[super layoutSubviews];
	CGSize currentSize = CGSizeMake(_cellShouldWidth, self.frame.size.height);
	if (!CGSizeEqualToSize(_clientSize, currentSize)) {
		_clientSize = currentSize;
		[self doSomethingAtLayoutSubviews];
	}
}

-(void)doSomethingAtLayoutSubviews {
}

-(void)doSomethingAtInit{
    
}

-(void)doSomethingAtDealloc{}

+ (CGFloat)computCellHeight:(NSObject *)cellData cellWidth:(CGFloat)cellWidth {
	return 44.0f;
}

@end

