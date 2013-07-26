//
//  FSContentToolBar.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-9-25.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum _FSContentToolBarItemStyle {
	FSContentToolBarItemStyle_UnFavorite,
	FSContentToolBarItemStyle_Favorited,
	FSContentToolBarItemStyle_Font,
	FSContentToolBarItemStyle_WriteComment,
	FSContentToolBarItemStyle_Share
} FSContentToolBarItemStyle;

typedef enum _FSContentToolBarItemActionStyle {
	FSContentToolBarItemActionStyle_UnFavorite,
	FSContentToolBarItemActionStyle_Favorited,
	FSContentToolBarItemActionStyle_SmallFont,
	FSContentToolBarItemActionStyle_MiddleFont,
	FSContentToolBarItemActionStyle_LargeFont,
	FSContentToolBarItemActionStyle_SuperLargeFont,
	FSContentToolBarItemActionStyle_WriteComment,
	FSContentToolBarItemActionStyle_Share
} FSContentToolBarItemActionStyle;

/*****************************************************************
 
 base
 
 *****************************************************************/

@interface FSContentPopBaseView : UIView {
@private
	UIImageView *_ivBackground;
	CGSize _arrowOffset;
	CGPoint _arrowPosition;
}

- (id)initWithBackgroundImage:(UIImage *)image withArrowPosition:(CGPoint)arrowPosition withArrowOffset:(CGSize)arrowOffset;

- (void)adjustmentArrowPosition:(CGPoint)value;

@end


/*****************************************************************
 
 font
 
 *****************************************************************/
@interface FSContentFontSizeView : FSContentPopBaseView {
@private
	UIButton *_btnSmallFont;
	UIButton *_btnMiddleFont;
	UIButton *_btnLargeFont;
	UIButton *_btnSuperLargeFont;
}

@end


/*****************************************************************
 
 message
 
 *****************************************************************/
@interface FSContentFavoriteMessageView : FSContentPopBaseView {
@private
	UILabel *_lblMessage;
}



@end



@protocol FSContentToolBarDelegate;

@interface FSContentToolBar : FSContentPopBaseView {
@private
	UIImageView *_bgImage;
	NSMutableArray *_itemButtons;
	CGFloat _toolBarClientHeight;
	id<FSContentToolBarDelegate> _parentDelegate;
}

@property (nonatomic, readonly) CGFloat toolBarClientHeight;
@property (nonatomic, assign) id<FSContentToolBarDelegate> parentDelegate;

@end

@protocol FSContentToolBarDelegate
@optional
- (BOOL)contentToolBarItemTouched:(FSContentToolBar *)sender withBarItemActionStyle:(FSContentToolBarItemActionStyle)barItemActionStyle;
@end




