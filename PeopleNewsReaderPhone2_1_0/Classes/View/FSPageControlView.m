//
//  FSPageControlView.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-27.
//
//

#import "FSPageControlView.h"
#import "FSCommonFunction.h"
#import "FSGraphicsEx.h"

#define FSPAGECONTROL_NORMAL_IMAGE_FILE @"bai.png"
#define FSPAGECONTROL_SELECTED_IMAGE_FILE @"baihei.png"

#define BLACK_FSPAGECONTROL_NORMAL_IMAGE_FILE @"hei.png"
#define BLACK_FSPAGECONTROL_SELECTED_IMAGE_FILE @"heibai.png"

#define FSPAGECONTROL_SIDE (32)

#define FSPAGECONTROL_REAL_SIDE (12.0f)

@interface FSPageControlView()
- (void)initializePages;
- (UIImage *)drawImageWithRect:(CGRect)rect withSelected:(BOOL)selected;
- (void)initializeImages;
- (void)layoutImges;
- (void)setPageWithIndex:(NSInteger)index withSelected:(BOOL)selected;
@end

@implementation FSPageControlView

@synthesize isBlackGround = _isBlackGround;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _pageCount = 0;
        _pageIndex = 1;
        _isBlackGround = NO;
        self.userInteractionEnabled = NO;
        _pageControls = [[NSMutableDictionary alloc] init];
        [self initializeImages];
    }
    return self;
}

- (void)dealloc {
    [_pageControls removeAllObjects];
    [_pageControls release];
    
    [_selectedImage release];
    [_normalImage release];
    [super dealloc];
}

- (void)setFrame:(CGRect)value {
    BOOL reDraw = !CGSizeEqualToSize(value.size, self.frame.size);
    [super setFrame:value];
    if (reDraw) {
        [self layoutImges];
    }
}

- (void)initializeImages {
//    NSFileManager *fm = [NSFileManager defaultManager];
//    NSString *parentPath = getCustomDrawImagePath();
//    NSString *normalFile = [parentPath stringByAppendingPathComponent:[NSString stringWithFormat:FSPAGECONTROL_NORMAL_IMAGE_FILE]];
//    NSString *selectedFile = [parentPath stringByAppendingPathComponent:[NSString stringWithFormat:FSPAGECONTROL_SELECTED_IMAGE_FILE]];
//    
//    CGRect rPage = CGRectMake(0.0f, 0.0f, FSPAGECONTROL_SIDE, FSPAGECONTROL_SIDE);
//    [_normalImage release];
//    [_selectedImage release];
//    
//    if (![fm fileExistsAtPath:normalFile]) {
//        _normalImage = [[self drawImageWithRect:rPage withSelected:NO] retain];
//        [UIImagePNGRepresentation(_normalImage) writeToFile:normalFile atomically:YES];
//    } else {
//        _normalImage = [[UIImage alloc] initWithContentsOfFile:normalFile];
//    }
//    
//    if (![fm fileExistsAtPath:selectedFile]) {
//        _selectedImage = [[self drawImageWithRect:rPage withSelected:YES] retain];
//        [UIImagePNGRepresentation(_selectedImage) writeToFile:selectedFile atomically:YES];
//    } else {
//        _selectedImage = [[UIImage alloc] initWithContentsOfFile:selectedFile];
//    }
    
    if (!self.isBlackGround) {
        _normalImage = [UIImage imageNamed:FSPAGECONTROL_NORMAL_IMAGE_FILE];
        _selectedImage = [UIImage imageNamed:FSPAGECONTROL_SELECTED_IMAGE_FILE];

    }
    else{
        _normalImage = [UIImage imageNamed:BLACK_FSPAGECONTROL_NORMAL_IMAGE_FILE];
        _selectedImage = [UIImage imageNamed:BLACK_FSPAGECONTROL_SELECTED_IMAGE_FILE];

    }
 }

- (void)setPageCount:(NSInteger)value {
    if (value != _pageCount) {
        _pageCount = value;
        _pageIndex = -1;
        [self initializePages];
    }
}

- (void)setPageIndex:(NSInteger)value {
    if (value >= _pageCount) {
        return;
    }
    
    if (!self.isBlackGround) {
        _normalImage = [UIImage imageNamed:FSPAGECONTROL_NORMAL_IMAGE_FILE];
        _selectedImage = [UIImage imageNamed:FSPAGECONTROL_SELECTED_IMAGE_FILE];
        
    }
    else{
        _normalImage = [UIImage imageNamed:BLACK_FSPAGECONTROL_NORMAL_IMAGE_FILE];
        _selectedImage = [UIImage imageNamed:BLACK_FSPAGECONTROL_SELECTED_IMAGE_FILE];
        
    }
    
    [self initializePages];
    
    if (value != _pageIndex) {
        [self setPageWithIndex:_pageIndex withSelected:NO];
        [self setPageWithIndex:value withSelected:YES];
        
        _pageIndex = value;
    }
}

- (void)setPageWithIndex:(NSInteger)index withSelected:(BOOL)selected {
    NSNumber *pageIdx = [[NSNumber alloc] initWithInt:index];
    UIImageView *ivPage = [_pageControls objectForKey:pageIdx];
    FSLog(@"ivPage.frame:%@", NSStringFromCGRect(ivPage.frame));
    if (selected) {
        ivPage.image = _selectedImage;
    } else {
        ivPage.image = _normalImage;
    }
    [pageIdx release];
}

- (void)initializePages {
    NSArray *pageIdxs = [_pageControls allKeys];
    for (NSNumber *pageIdx in pageIdxs) {
        UIImageView *ivPage = [_pageControls objectForKey:pageIdx];
        if (ivPage) {
            [ivPage removeFromSuperview];
        }
    }
    
    [_pageControls removeAllObjects];
    
    for (int i = 0; i < _pageCount; i++) {
        UIImageView *ivPage = [[UIImageView alloc] initWithImage:_normalImage];
        [self addSubview:ivPage];
        NSNumber *pageIdx = [[NSNumber alloc] initWithInt:i];
        [_pageControls setObject:ivPage forKey:pageIdx];
        [pageIdx release];
        [ivPage release];
    }
    
    [self layoutImges];
}

- (void)layoutImges {
    NSArray *pageIdxs = [_pageControls allKeys];
    NSInteger imageCount = [pageIdxs count];
    CGFloat colSpace = (self.frame.size.width - imageCount * FSPAGECONTROL_REAL_SIDE) / (imageCount + 1);
    CGFloat left = colSpace;
    CGFloat top = (self.frame.size.height - FSPAGECONTROL_REAL_SIDE) / 2.0f;
    
    for (int i = 0; i < imageCount; i++) {
        NSNumber *pageIdx = [pageIdxs objectAtIndex:i];
        UIImageView *ivPage = (UIImageView *)[_pageControls objectForKey:pageIdx];
        NSInteger pageNum = [pageIdx intValue];
        ivPage.frame = CGRectMake(colSpace * (pageNum + 1) + FSPAGECONTROL_REAL_SIDE * pageNum, top, FSPAGECONTROL_REAL_SIDE, FSPAGECONTROL_REAL_SIDE);
        left += (FSPAGECONTROL_REAL_SIDE + colSpace);
    }
}

- (UIImage *)drawImageWithRect:(CGRect)rect withSelected:(BOOL)selected {
    rect.origin.x = 0;
    rect.origin.y = 0;
    CGFloat lineWith = 4.0f;
    
    CGRect rClient = rect;
    
    rClient.origin.x += lineWith;
    rClient.origin.y += lineWith;
    rClient.size.width -= (lineWith * 2.0f);
    rClient.size.height -= (lineWith * 2.0f);
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
    buildPathForRect(context, rClient, rClient.size.width / 2.0f, FS_DRAW_REGION_ROUND_RECT);
    CGContextSetRGBFillColor(context, 183.0f / 255.0f, 6.0f / 255.0f, 6.0f / 255.0f, 1.0f);
    CGContextSetRGBStrokeColor(context, 183.0f / 255.0f, 6.0f / 255.0f, 6.0f / 255.0f, 1.0f);
    CGContextSetLineWidth(context, lineWith);
    if (selected) {
        CGContextDrawPath(context, kCGPathFillStroke);
    } else {
        CGContextDrawPath(context, kCGPathStroke);
    }
	CGContextRestoreGState(context);
	
	CGImageRef imageRef = CGBitmapContextCreateImage(context);
	image = [UIImage imageWithCGImage:imageRef];
	CGImageRelease(imageRef);
	
	CGContextRelease(context);
	CGColorSpaceRelease(rgb);
	
	return image;
}

@end
