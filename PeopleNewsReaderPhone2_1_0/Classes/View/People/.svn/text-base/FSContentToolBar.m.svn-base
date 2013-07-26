//
//  FSContentToolBar.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-9-25.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSContentToolBar.h"

#define FSCONTENT_TOOLBAR_HEIGHT 44.0f
#define FSCONTENT_POP_HEIGHT 160.0f

#define FS_TOOL_BUTTON_WIDTH 32.0f
#define FS_TOOL_BUTTON_HEIGHT 32.0f

@interface FSContentToolBar(PrivateMethod)
- (void)reLayoutButtonsWithRect:(CGRect)rect;
@end


@implementation FSContentToolBar
@synthesize toolBarClientHeight = _toolBarClientHeight;
@synthesize parentDelegate = _parentDelegate;

- (id)initWithFrame:(CGRect)frame {
    frame.size.height = FSCONTENT_TOOLBAR_HEIGHT + FSCONTENT_POP_HEIGHT;
    self = [super initWithFrame:frame];
    if (self) {
		self.userInteractionEnabled = NO;
        _bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - FSCONTENT_TOOLBAR_HEIGHT, frame.size.width, FSCONTENT_TOOLBAR_HEIGHT)];
		_bgImage.image = [UIImage imageNamed:@"content_tool_bg.png"];
		_itemButtons = [[NSMutableArray alloc] init];
		
		NSArray *imageNames = [NSArray arrayWithObjects:@"content_tool_unfavorite.png", @"content_tool_font.png", @"content_tool_writecomment.png", @"content_tool_share.png", nil];
		NSInteger itemTag = FSContentToolBarItemStyle_UnFavorite;
		for (NSString *imgName in imageNames) {
			UIImage *backgroundBTNImage = [UIImage imageNamed:imgName];			
			UIButton *btnItem = [[UIButton alloc] initWithFrame:CGRectZero];
			[btnItem addTarget:self action:@selector(toolItemAction:) forControlEvents:UIControlEventTouchUpInside];
			btnItem.highlighted = YES;
			[btnItem setBackgroundImage:backgroundBTNImage forState:UIControlStateNormal];
			btnItem.tag = itemTag;
			if (itemTag == FSContentToolBarItemStyle_UnFavorite) {
				itemTag += 2;
			} else {
				itemTag++;
			}
			[_itemButtons addObject:btnItem];
			[self addSubview:btnItem];
			[btnItem release];
		}
		
		[self reLayoutButtonsWithRect:_bgImage.frame];
		_toolBarClientHeight = FSCONTENT_TOOLBAR_HEIGHT;
		
		[self addSubview:_bgImage];
    }
    return self;
}

- (void)dealloc {
	[_itemButtons removeAllObjects];
	[_itemButtons release];
	[_bgImage release];
    [super dealloc];
}

- (void)setFrame:(CGRect)value {
	value.size.height = FSCONTENT_TOOLBAR_HEIGHT + FSCONTENT_POP_HEIGHT;
	[super setFrame:value];
	_bgImage.frame = CGRectMake(0.0f, value.size.height - FSCONTENT_TOOLBAR_HEIGHT, value.size.width, FSCONTENT_TOOLBAR_HEIGHT);
	[self reLayoutButtonsWithRect:_bgImage.frame];
}

- (void)reLayoutButtonsWithRect:(CGRect)rect {

	CGFloat colSpace = (rect.size.width - [_itemButtons count] * FS_TOOL_BUTTON_WIDTH) / ([_itemButtons count] + 1);
	CGFloat left = colSpace;
	for (UIButton *btnItem in _itemButtons) {
		btnItem.frame = CGRectMake(left, 
								   (rect.size.height - FS_TOOL_BUTTON_HEIGHT) / 2.0f + rect.origin.y, 
								   FS_TOOL_BUTTON_WIDTH, 
								   FS_TOOL_BUTTON_HEIGHT);
		left += (FS_TOOL_BUTTON_WIDTH + colSpace);
	}
}

- (void)toolItemAction:(id)sender {
	if ([sender isKindOfClass:[UIBarButtonItem class]]) {
		UIBarButtonItem *item = (UIBarButtonItem *)sender;
		NSInteger itemTag = item.tag;
		if (itemTag == FSContentToolBarItemStyle_Font) {
			//pop 
		} else if (itemTag == FSContentToolBarItemStyle_UnFavorite) {
			
		} else if (itemTag == FSContentToolBarItemStyle_Favorited) {
			
		} else if (itemTag == FSContentToolBarItemStyle_WriteComment) {
			
		} else if (itemTag == FSContentToolBarItemStyle_Share) {
			
		}
	}
}

@end


/*****************************************************************
 
 font
 
 *****************************************************************/
@implementation FSContentFontSizeView

- (id)initWithBackgroundImage:(UIImage *)image withArrowPosition:(CGPoint)arrowPosition withArrowOffset:(CGSize)arrowOffset {
	self = [super initWithBackgroundImage:image withArrowPosition:arrowPosition withArrowOffset:arrowOffset];
	if (self) {
		/* width:226 height:56 arrow:x.113 y.47 */
//		_bgImage = [[UIImageView alloc] initWithFrame:CGRectZero];
//		_bgImage.image = [UIImage imageNamed:@"content_tool_pop_font.png"];
//		[self addSubview:_bgImage];
		
		_btnSmallFont = [[UIButton alloc] initWithFrame:CGRectZero];
		[_btnSmallFont setTitle:NSLocalizedString(@"小字", nil) forState:UIControlStateNormal];
		[_btnSmallFont setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[_btnSmallFont.titleLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
		[self addSubview:_btnSmallFont];
		
		_btnMiddleFont = [[UIButton alloc] initWithFrame:CGRectZero];
		[_btnMiddleFont setTitle:NSLocalizedString(@"中字", nil) forState:UIControlStateNormal];
		[_btnMiddleFont setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[_btnMiddleFont.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
		[self addSubview:_btnMiddleFont];
		
		_btnLargeFont = [[UIButton alloc] initWithFrame:CGRectZero];
		[_btnLargeFont setTitle:NSLocalizedString(@"大字", nil) forState:UIControlStateNormal];
		[_btnLargeFont setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[_btnLargeFont.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
		[self addSubview:_btnLargeFont];
		
		_btnSuperLargeFont = [[UIButton alloc] initWithFrame:CGRectZero];
		[_btnSuperLargeFont setTitle:NSLocalizedString(@"超大字", nil) forState:UIControlStateNormal];
		[_btnSuperLargeFont setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[_btnSuperLargeFont.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
		[self addSubview:_btnSuperLargeFont];

	}
	return self;
}

- (void)dealloc {
	[_btnSmallFont release];
	[_btnMiddleFont release];
	[_btnLargeFont release];
	[_btnSuperLargeFont release];
	[super dealloc];
}

- (void)layoutSubviews {
	[super layoutSubviews];
}

- (void)fontSizeSelectedAction:(id)sender {
}

@end

/*****************************************************************
 
 message
 
 *****************************************************************/
@interface FSContentFavoriteMessageView(PrivateMethod)
- (void)setMessage:(NSString *)value;
@end

#define FSCONTENT_FAVORITE_MESSAGE_WIDTH 110.0f
#define FSCONTENT_FAVORITE_MESSAGE_HEIGHT 56.0f

@implementation FSContentFavoriteMessageView

- (id)initWithBackgroundImage:(UIImage *)image withArrowPosition:(CGPoint)arrowPosition withArrowOffset:(CGSize)arrowOffset {
	self = [super initWithBackgroundImage:image withArrowPosition:arrowPosition withArrowOffset:arrowOffset];
	if (self) {
		/* width:111 height:56 arraow:x.35 y.47 */
//		_bgImage = [[UIImageView alloc] initWithFrame:CGRectZero];
//		_bgImage.image = [UIImage imageNamed:@"content_tool_pop_favorited.png"];
//		[self addSubview:_bgImage];
		
		_lblMessage = [[UILabel alloc] initWithFrame:CGRectZero];
		[_lblMessage setBackgroundColor:[UIColor clearColor]];
		[_lblMessage setTextColor:[UIColor whiteColor]];
		[_lblMessage setFont:[UIFont boldSystemFontOfSize:16.0f]];
		
		_lblMessage.frame = CGRectMake(8.0f, 6.0f, 92.0f, 26.0f);
		[self addSubview:_lblMessage];
	}
	return self;
}

- (void)dealloc {
	[_lblMessage release];
	[super dealloc];
}

- (void)layoutSubviews {
	[super layoutSubviews];
}

- (void)setMessage:(NSString *)value {
	_lblMessage.text = value;
	
}

@end


@implementation FSContentPopBaseView


- (id)initWithBackgroundImage:(UIImage *)image withArrowPosition:(CGPoint)arrowPosition withArrowOffset:(CGSize)arrowOffset {
	CGRect rect = CGRectZero;
	rect.origin.x = arrowPosition.x - arrowOffset.width;
	rect.origin.y = arrowPosition.y - arrowOffset.height;
	rect.size.width = image.size.width;
	rect.size.height = image.size.height;
	_arrowOffset = arrowOffset;
	_arrowPosition = arrowPosition;
	
	self = [super initWithFrame:rect];
	if (self) {
		_ivBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, image.size.width, image.size.height)];
		_ivBackground.image = image;
		[self addSubview:_ivBackground];
	}
	return self;
}

- (void)setFrame:(CGRect)value {
	CGRect rect = CGRectZero;
	rect.origin.x = _arrowPosition.x - _arrowOffset.width;
	rect.origin.y = _arrowPosition.y - _arrowOffset.height;
	rect.size.width = _ivBackground.image.size.width;
	rect.size.height = _ivBackground.image.size.height;
	_ivBackground.frame = CGRectMake(0.0f, 0.0f, _ivBackground.image.size.width, _ivBackground.image.size.height);
	[super setFrame:rect];
}

- (void)adjustmentArrowPosition:(CGPoint)value {
	if (!CGPointEqualToPoint(value, _arrowPosition)) {
		_arrowPosition = value;
		[self setFrame:self.frame];
	}
}

- (void)dealloc {
	[_ivBackground release];
	[super dealloc];
}

@end




