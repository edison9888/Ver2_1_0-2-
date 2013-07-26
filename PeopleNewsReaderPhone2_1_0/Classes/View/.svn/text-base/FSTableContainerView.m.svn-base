//
//  FSTableContainerView.m
//  PeopleDailyReader
//
//  Created by people.com.cn on 12-3-14.
//  Copyright 2012 people.com.cn. All rights reserved.
///////////////////////////////////////////////////////////////////
//	自定义表格容器类
///////////////////////////////////////////////////////////////////
//	日期				做成者			版本
///////////////////////////////////////////////////////////////////
//	2012-03-14		chen.gsh		1.0.0
//－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－

#import "FSTableContainerView.h"

#define BOUNCE_TOP_FLAG (1)
#define BOUNCE_BOTTOM_FLAG (1 << 2)

@interface FSTableContainerView(PrivateMethod)
- (UIImage *)drawDefaultBoundceImageWithRect:(CGRect)rect withDirection:(NSInteger)direction;
@end


@implementation FSTableContainerView
@synthesize parentDelegate = _parentDelegate;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		
		[self setMultipleTouchEnabled:YES];
		[self setUserInteractionEnabled:YES];
		
		[self setBackgroundColor:[UIColor colorWithRed:239.0f / 255.0f green:239.0f / 255.0f blue:239.0f / 255.0f alpha:1.0f]];
		
		_tvList = [[FSTableView alloc] initWithFrame:CGRectZero style:[self initializeTableViewStyle]];
		_tvList.separatorStyle = UITableViewCellSeparatorStyleNone;
		[_tvList setSectionFooterHeight:0.0f];
		[_tvList setSectionHeaderHeight:0.0f];
		[_tvList setDelegate:self];
		[_tvList setDataSource:self];
		[_tvList setParentDelegate:self];
		_tvSize = CGSizeZero;
		[self addSubview:_tvList];
		
		_config = [GlobalConfig shareConfig];
		[pool release];
    }
    return self;
}

- (void)dealloc {	
	[_tvList release];
    [super dealloc];
}

-(void)reSetAssistantViewFlag:(NSInteger)arrayCount{
    ;
}

- (UITableViewStyle)initializeTableViewStyle {
	return UITableViewStylePlain;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"bottomScrollViewDidScroll bottomScrollViewDidScroll");
	[_tvList bottomScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	[_tvList bottomScrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (NSObject *)cellDataObjectWithIndexPath:(NSIndexPath *)indexPath {
	return [(id)_parentDelegate tableViewCellData:self withIndexPath:indexPath];
}

-(UITableViewCellSelectionStyle)cellSelectionStyl:(NSIndexPath *)indexPath{
    if ([(id)_parentDelegate respondsToSelector:@selector(tableViewCellSelectionStyl:withIndexPath:)]) {
		return [(id)_parentDelegate tableViewCellSelectionStyl:self withIndexPath:indexPath];
	} else {
		return UITableViewCellSelectionStyleBlue;
	}
    
}

- (NSString *)cellIdentifierStringWithIndexPath:(NSIndexPath *)indexPath {
	return @"cellIdentifierString";
}

- (void)initializeCell:(UITableViewCell *)cell withData:(NSObject *)data withIndexPath:(NSIndexPath *)indexPath{

}

- (Class)cellClassWithIndexPath:(NSIndexPath *)indexPath {
	return nil;
}

- (void)loadData {
    
    [_tvList loaddingComplete];
	[_tvList reloadData];
	
}

-(void)loadDataWithOutCompelet{
    [_tvList reloadData];
}

- (void)layoutSubviews {
	[super layoutSubviews];	
	
	_tvList.frame = roundToRect(CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height));
	
	if (!CGSizeEqualToSize(_tvSize, _tvList.frame.size)) {
		_tvSize = _tvList.frame.size;
		//防止不重新装载数据
		[_tvList reloadData];
	}
}

- (NSInteger)getSelectedRow {
	NSIndexPath *indexPath = [_tvList indexPathForSelectedRow];
	if (indexPath != nil) {
		return [indexPath row];
	} else {
		return -1;
	}
}

- (NSInteger)getSelectedSection {
	NSIndexPath *indexPath = [_tvList indexPathForSelectedRow];
	if (indexPath != nil) {
		return [indexPath section];
	} else {
		return -1;
	}
}

#pragma mark -
#pragma mark Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if ([(id)_parentDelegate respondsToSelector:@selector(tableViewSectionNumber:)]) {
		return [(id)_parentDelegate tableViewSectionNumber:self];
	} else {
		return 1;
	}

}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if ([(id)_parentDelegate respondsToSelector:@selector(tableViewSectionTitle:section:)]) {
		return [(id)_parentDelegate tableViewSectionTitle:self section:section];
	} else {
		return @"";
	}

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return [(id)_parentDelegate tableViewNumberInSection:self section:section];
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	NSString *cellIdentifierString = [self cellIdentifierStringWithIndexPath:indexPath];
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierString];
    
    //cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CellBackground"]];
    
	if (cell == nil) {
		cell = (UITableViewCell *)[[[self cellClassWithIndexPath:indexPath] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierString];
	}
	
	if ([cell isKindOfClass:[FSTableViewCell class]]) {
        
		FSTableViewCell *fsCell = (FSTableViewCell *)cell;
        //fsCell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CellBackground"]];
		[fsCell setParentDelegate:self];
		[fsCell setRowIndex:[indexPath row]];
		[fsCell setSectionIndex:[indexPath section]];
		[fsCell setCellShouldWidth:tableView.frame.size.width];
		[fsCell setData:[self cellDataObjectWithIndexPath:indexPath]];
        [fsCell setSelectionStyle:[self cellSelectionStyl:indexPath]];
        [fsCell doSomethingAtLayoutSubviews];
	} else {
		[self initializeCell:cell withData:[self cellDataObjectWithIndexPath:indexPath] withIndexPath:indexPath];
	}
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return [[self cellClassWithIndexPath:indexPath] 
			computCellHeight:[self cellDataObjectWithIndexPath:indexPath] 
			cellWidth:tableView.frame.size.width];	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath	animated:YES];
	if ([(id)_parentDelegate respondsToSelector:@selector(tableViewDataSourceDidSelected:withIndexPath:)]) {
		[(id)_parentDelegate tableViewDataSourceDidSelected:self withIndexPath:indexPath];
	}
}

#pragma mark -
#pragma mark PublicMethod
- (UIImage *)topBounceAreaImageWithRect:(CGRect)rect {
	return [self drawDefaultBoundceImageWithRect:rect withDirection:BOUNCE_TOP_FLAG];
}

- (UIImage *)bottomBounceAreaImageWithRect:(CGRect)rect {
	return [self drawDefaultBoundceImageWithRect:rect withDirection:BOUNCE_BOTTOM_FLAG];
}

- (NSString *)bounceGrainFileName:(NSInteger)direction{
    if (direction == BOUNCE_BOTTOM_FLAG) {
        return [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"pulltorefresh_background2.png"];
    }
	return [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"pulltorefresh_background1.png"];
}

- (UIImage *)drawDefaultBoundceImageWithRect:(CGRect)rect withDirection:(NSInteger)direction {
	UIImage *image = nil;
	
	CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(NULL, 
												 rect.size.width, 
												 rect.size.height, 
												 8,
												 0,
												 rgb, 
												 (kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Little));
	

	
	//STEP 1.平铺图片
	CGContextSaveGState(context);
	UIImage *grainImage = [[UIImage alloc] initWithContentsOfFile:[self bounceGrainFileName:direction]];
	drawImageWithRect(context, rect, grainImage);
	[grainImage release];
	CGContextRestoreGState(context);
	
	
	//STEP 2.边缘梯形
	CGContextSaveGState(context);
	CGFloat clientHeight = 2.0f;
	CGRect rClient = CGRectMake(0.0f, 0.0f, rect.size.width, clientHeight);
	if (direction == BOUNCE_TOP_FLAG) {
		
	} else if (direction == BOUNCE_BOTTOM_FLAG) {
		rClient.origin.y = rect.size.height - clientHeight;
	}
	
	buildPathForRect(context, rClient, 0.0f, FS_DRAW_REGION_RECT);
	CGContextClosePath(context);
	CGContextClip(context);
    
    CGFloat colors[] =
	{
		35.0f / 255.0f, 35.0f / 255.0f, 35.0f / 255.0f, 0.0f,
		35.0f / 255.0f, 35.0f / 255.0f, 35.0f / 255.0f, 0.1f,
		35.0f / 255.0f, 35.0f / 255.0f, 35.0f / 255.0f, 0.2f,
		35.0f / 255.0f, 35.0f / 255.0f, 35.0f / 255.0f, 0.3f,
		35.0f / 255.0f, 35.0f / 255.0f, 35.0f / 255.0f, 0.4f,
		35.0f / 255.0f, 35.0f / 255.0f, 35.0f / 255.0f, 0.5f,
		35.0f / 255.0f, 35.0f / 255.0f, 35.0f / 255.0f, 0.6f,
		35.0f / 255.0f, 35.0f / 255.0f, 35.0f / 255.0f, 0.7f,
	};
	CGGradientRef gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors) / (4 * sizeof(CGFloat)));
	if (direction == BOUNCE_TOP_FLAG) {
		CGContextDrawLinearGradient(context, 
									gradient, 
									CGPointMake(CGRectGetMidX(rClient), CGRectGetMaxY(rClient)), 
									CGPointMake(CGRectGetMidX(rClient), CGRectGetMinY(rClient)), 
									0);
	} else if (direction == BOUNCE_BOTTOM_FLAG) {
		CGContextDrawLinearGradient(context, 
									gradient, 
									CGPointMake(CGRectGetMidX(rClient), CGRectGetMinY(rClient)), 
									CGPointMake(CGRectGetMidX(rClient), CGRectGetMaxY(rClient)), 
									0);
	}

	CGGradientRelease(gradient);
	CGContextRestoreGState(context);
	
	CGImageRef imageRef = CGBitmapContextCreateImage(context);
	image = [UIImage imageWithCGImage:imageRef];
	CGImageRelease(imageRef);
	
	CGContextRelease(context);
	CGColorSpaceRelease(rgb);
	
	return image;
}
////////////////////////////////////////////////////
//	刷新数据源
////////////////////////////////////////////////////
- (void)refreshDataSource {
	[_tvList refreshDataSource];
}

- (void)loaddingComplete {
	[_tvList loaddingComplete];
}

////////////////////////////////////////////////////
//	FSTableViewDelegate
////////////////////////////////////////////////////
- (void)tableViewNextDataSource:(FSTableView *)sender {
	if ([(id)_parentDelegate respondsToSelector:@selector(tableViewDataSource:withTableDataSource:)]) {
		[(id)_parentDelegate tableViewDataSource:self withTableDataSource:tdsNextSection];
	}
}

- (void)tableViewRefreshDataSource:(FSTableView *)sender {
	if ([(id)_parentDelegate respondsToSelector:@selector(tableViewDataSource:withTableDataSource:)]) {
		[(id)_parentDelegate tableViewDataSource:self withTableDataSource:tdsRefreshFirst];
	}
}

- (NSString *)tableViewDataSourceUpdateInformation:(FSTableView *)sender {
	NSString *rst = @"";
	if ([(id)_parentDelegate respondsToSelector:@selector(tableViewDataSourceUpdateMessage:)]) {
		rst = [(id)_parentDelegate tableViewDataSourceUpdateMessage:self];
	}
	return rst;
}
- (UIImage *)tableViewTopBounceAreaWithRect:(CGRect)rect {
	return [self topBounceAreaImageWithRect:rect];
}

- (UIImage *)tableViewBottomBounceAreaWithRect:(CGRect)rect {
	return [self bottomBounceAreaImageWithRect:rect];
}

////////////////////////////////////////////////////
//	FSTableViewCellDelegate
////////////////////////////////////////////////////

-(void)tableViewCellPictureTouched:(NSInteger)index{
    if ([(id)_parentDelegate respondsToSelector:@selector(tableViewTouchPicture:index:)]) {
		[(id)_parentDelegate tableViewTouchPicture:self index:index];
	}
}

-(void)tableViewCellTouchEvent:(FSTableViewCell *)sender{
    if ([(id)_parentDelegate respondsToSelector:@selector(tableViewTouchEvent:cell:)]) {
        [(id)_parentDelegate tableViewTouchEvent:self cell:sender];
    }
}

@end
