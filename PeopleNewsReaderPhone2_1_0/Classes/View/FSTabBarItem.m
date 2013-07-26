//
//  FSTabBarItem.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-6.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSTabBarItem.h"

#define FSTABBARITEM_ROW_SPACE 2.0f
#define FSTABBARITEM_TOP_BOTTOM_SPACE 2.0f
#define FSTABBARITEM_LEFT_RIGHT_SPACE 6.0f
#define FSTABBARITEM_TEXT_FONTSIZE 14.0f

@interface FSTabBarItem(PrivateMethod)
- (void)inner_LayoutSubviews;
@end


@implementation FSTabBarItem
@synthesize tabBarHeight = _tabBarHeight;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		_ivPicture = [[UIImageView alloc] initWithFrame:CGRectZero];
		[self addSubview:_ivPicture];
		
		_lblText = [[UILabel alloc] initWithFrame:CGRectZero];
		[_lblText setTextColor:[UIColor colorWithRed:102.0f / 255.0f green:102.0f / 255.0f blue:102.0f / 255.0f alpha:1.0f]];
		[_lblText setBackgroundColor:[UIColor clearColor]];
		[_lblText setTextAlignment:UITextAlignmentCenter];
		[_lblText setFont:[UIFont boldSystemFontOfSize:FSTABBARITEM_TEXT_FONTSIZE]];
		//[self addSubview:_lblText];
		
    }
    return self;
}

- (void)dealloc {
	[_normalImage release];
	[_selectedImage release];
	[_lblText release];
	[_ivPicture release];
    [super dealloc];
}

- (void)setSelected:(BOOL)value {
	BOOL oldValue = self.selected;
	[super setSelected:value];
	//
	if (oldValue != self.selected) {
		//
		if (value) {
			[_lblText setTextColor:[UIColor colorWithRed:255.0f / 255.0f green:255.0f / 255.0f blue:255.0f / 255.0f alpha:1.0f]];
            
            UIColor *colorBG = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"tabItemBG_Sel.png"]];
			//self.backgroundColor = colorBG;// [UIColor colorWithRed:205.0f / 255.0f green:102.0f / 255.0f blue:103.0f / 255.0f alpha:1.0f];
            [colorBG release];
            self.backgroundColor = [UIColor clearColor];
		} else {
			[_lblText setTextColor:[UIColor colorWithRed:102.0f / 255.0f green:102.0f / 255.0f blue:102.0f / 255.0f alpha:1.0f]];
			self.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:205.0f / 255.0f green:205.0f / 255.0f blue:205.0f / 255.0f alpha:1.0f];
		}
		[self inner_LayoutSubviews];
	}
}


- (void)setTabBarItemWithNormalImage:(UIImage *)normalImage withSelectedImage:(UIImage *)selectedImage withText:(NSString *)text {
	_normalImage = [normalImage retain];
	_selectedImage = [selectedImage retain];
	_lblText.text = text;
	[self inner_LayoutSubviews];
}

- (void)inner_LayoutSubviews {
	if (_selectedImage == nil || _normalImage == nil) {
		return;
	}
	
	if (self.selected) {
		_ivPicture.image = _selectedImage;
	} else {
		_ivPicture.image = _normalImage;
	}
    
    
    
    _ivPicture.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
    
    return;
    
	
	CGSize sizeText = [_lblText.text sizeWithFont:_lblText.font];
	CGFloat clientHeight = self.frame.size.height - FSTABBARITEM_ROW_SPACE - FSTABBARITEM_TOP_BOTTOM_SPACE * 2.0f;
	CGFloat maxImageHeight = clientHeight - sizeText.height;
	CGSize sizeImage = _ivPicture.image.size;
    
	if (_ivPicture.image.size.height > maxImageHeight) {
		sizeImage.height = maxImageHeight;
		sizeImage.width = sizeImage.height * _ivPicture.image.size.width / _ivPicture.image.size.height;
	}
	
	if (_ivPicture.image.size.width > self.frame.size.width - FSTABBARITEM_LEFT_RIGHT_SPACE * 2.0f) {
		sizeImage.width = self.frame.size.width - FSTABBARITEM_LEFT_RIGHT_SPACE * 2.0f;
		sizeImage.height = sizeImage.width * _ivPicture.image.size.height / _ivPicture.image.size.width;
	}
	
	CGFloat top = (self.frame.size.height - sizeImage.height - sizeText.height) / 3.0f;
	
	CGRect rPicture = CGRectMake((self.frame.size.width - sizeImage.width) / 2.0f, 
								 top, 
								 sizeImage.width, 
								 sizeImage.height);
	
	_ivPicture.frame = rPicture;
	top += (sizeImage.height + top);
	
	_lblText.frame = CGRectMake((self.frame.size.width - sizeText.width) / 2.0f, 
								top, 
								sizeText.width, 
								sizeText.height);
#ifdef MYDEBUG
	NSLog(@"tabBarItem.frame:%@", NSStringFromCGRect(_ivPicture.frame));
#endif

}

- (void)layoutSubviews {
	[super layoutSubviews];
	[self inner_LayoutSubviews];
}

@end
