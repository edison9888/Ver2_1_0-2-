//
//  FSSettingCell.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-16.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSSettingCell.h"

#define FSOPTION_DESC_FONT_SIZE 16.0f
#define FSOPTION_VALUE_FONT_SIZE 16.0f

#define FSOPTION_SWITCH_WIDTH 95.0f
#define FSOPTION_SWITCH_HEIGHT 28.0f

#define FSOPTION_LEFT_RIGHT_SPACE 16.0f
#define FSOPTION_COL_SPACE 6.0f
#define FSOPTION_TOP_BOTTOM_SPACE 12.0f

@interface FSSettingCell(PrivateMethod)
- (void)setSettingKind:(FSSettingKind)val;
@end


@implementation FSSettingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		
		_lblDesc = [[UILabel alloc] initWithFrame:CGRectZero];
		[_lblDesc setBackgroundColor:[UIColor clearColor]];
		[_lblDesc setFont:[UIFont boldSystemFontOfSize:FSOPTION_DESC_FONT_SIZE]];
		[_lblDesc setNumberOfLines:2];
		[self addSubview:_lblDesc];
		
		[pool release];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
	[_optionSwitch removeTarget:self action:@selector(optionSwitchChange:) forControlEvents:UIControlEventValueChanged];
	[_optionSwitch release];
	[_lblDesc release];
	[_lblValue release];
	
    [super dealloc];
}

- (void)setSettingKind:(FSSettingKind)val {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	if (val != FSSetting_Switch && _optionSwitch != nil) {
		[_optionSwitch removeFromSuperview];
		[_optionSwitch removeTarget:self action:@selector(optionSwitchChange:) forControlEvents:UIControlEventValueChanged];
		[_optionSwitch release];
		_optionSwitch = nil;
	}
	
	if (val != FSSetting_Value && _lblValue != nil) {
		[_lblValue removeFromSuperview];
		[_lblValue release];
		_lblValue = nil;
	}
	
	if (val == FSSetting_Switch && _optionSwitch == nil) {
		_optionSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
		[_optionSwitch addTarget:self action:@selector(optionSwitchChange:) forControlEvents:UIControlEventValueChanged];
		[self addSubview:_optionSwitch];
	}
	
	if (val == FSSetting_Value && _lblValue == nil) {
		_lblValue = [[UILabel alloc] initWithFrame:CGRectZero];
		[_lblValue setTextColor:[UIColor colorWithRed:133.0f / 255.0f green:133.0f / 255.0f blue:133.0f / 255.0f alpha:1.0f]];
		[_lblValue setBackgroundColor:[UIColor clearColor]];
		[_lblValue setTextAlignment:UITextAlignmentRight];
		[_lblValue setFont:[UIFont boldSystemFontOfSize:FSOPTION_VALUE_FONT_SIZE]];
		[self addSubview:_lblValue];
	}
	
	[pool release];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	if (_data == nil || ![_data isKindOfClass:[FSSettingObject class]]) {
		return;
	}
	
	FSSettingObject *obj = (FSSettingObject *)_data;
	[self setSettingKind:obj.settingKind];
	
	CGSize sizeTmp = CGSizeZero;
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	self.accessoryType = obj.accessoryType;
	
	if (self.accessoryType == UITableViewCellAccessoryCheckmark) {
		[_lblDesc setTextColor:[UIColor colorWithRed:50.0f / 255.0f green:79.0f / 255.0f blue:133.0f / 255.0f alpha:1.0f]];
	} else {
		[_lblDesc setTextColor:[UIColor blackColor]];
	}
	
	[pool release];
	

	
	if (obj.settingKind == FSSetting_Value) {
		_lblValue.text = obj.value;
		sizeTmp = [_lblValue.text sizeWithFont:_lblValue.font];
		CGFloat valueWidth = sizeTmp.width;
		CGFloat valueHeight = sizeTmp.height;
		_lblDesc.text = obj.description;
		sizeTmp = [_lblDesc.text sizeWithFont:_lblDesc.font
							constrainedToSize:CGSizeMake(self.frame.size.width - valueWidth - FSOPTION_LEFT_RIGHT_SPACE * 2.0f, 
														 512.0f) 
								lineBreakMode:_lblDesc.lineBreakMode];
		
		_lblDesc.frame = roundToRect(CGRectMake(FSOPTION_LEFT_RIGHT_SPACE, 
												(self.frame.size.height - sizeTmp.height) / 2.0f, 
												sizeTmp.width, 
												sizeTmp.height));
		
		_lblValue.frame = roundToRect(CGRectMake(self.frame.size.width - FSOPTION_LEFT_RIGHT_SPACE - valueWidth, 
												 (self.frame.size.height - valueHeight) / 2.0f, 
												 valueWidth, 
												 valueHeight));
	} else if (obj.settingKind == FSSetting_Switch) {
		_lblDesc.text = obj.description;
		sizeTmp = [_lblDesc.text sizeWithFont:_lblDesc.font
							constrainedToSize:CGSizeMake(self.frame.size.width - FSOPTION_SWITCH_WIDTH - FSOPTION_LEFT_RIGHT_SPACE * 2.0f, 
														 512.0f) 
								lineBreakMode:_lblDesc.lineBreakMode];
		_lblDesc.frame = roundToRect(CGRectMake(FSOPTION_LEFT_RIGHT_SPACE, 
												(self.frame.size.height - sizeTmp.height) / 2.0f, 
												sizeTmp.width, 
												sizeTmp.height));
		_optionSwitch.frame = CGRectMake(self.frame.size.width - FSOPTION_SWITCH_WIDTH - FSOPTION_LEFT_RIGHT_SPACE, 
										 (self.frame.size.height - FSOPTION_SWITCH_HEIGHT) / 2.0f, 
										 FSOPTION_SWITCH_WIDTH, 
										 FSOPTION_SWITCH_HEIGHT);
		_optionSwitch.on = obj.switchValue;
	} else {
		_lblDesc.text = obj.description;
		sizeTmp = [_lblDesc.text sizeWithFont:_lblDesc.font
							constrainedToSize:CGSizeMake(self.frame.size.width - FSOPTION_LEFT_RIGHT_SPACE * 2.0f, 
														 512.0f) 
								lineBreakMode:_lblDesc.lineBreakMode];
		_lblDesc.frame = roundToRect(CGRectMake(FSOPTION_LEFT_RIGHT_SPACE, 
												(self.frame.size.height - sizeTmp.height) / 2.0f, 
												sizeTmp.width, 
												sizeTmp.height));
		//_lblDesc.textColor = self.textLabel.textColor;
	}
	
}

- (void)optionSwitchChange:(id)sender {
	if ([sender isKindOfClass:[UISwitch class]]) {
		UISwitch *optionSwi = (UISwitch *)sender;
		if ([_parentDelegate respondsToSelector:@selector(optionCell:withSwitchValue:)]) {
			[_parentDelegate optionCell:self withSwitchValue:optionSwi.on];
		}
	}
}

+ (CGFloat)computCellHeight:(NSObject *)cellData cellWidth:(CGFloat)cellWidth {
	CGFloat rst = FSOPTION_TOP_BOTTOM_SPACE;
	
	if ([cellData isKindOfClass:[FSSettingObject class]]) {
		
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		
		FSSettingObject *obj = (FSSettingObject *)cellData;
		CGSize sizeTmp = CGSizeZero;
		
		if (obj.settingKind == FSSetting_Value) {
			CGSize valueSize = [obj.value sizeWithFont:[UIFont boldSystemFontOfSize:FSOPTION_VALUE_FONT_SIZE]];
			sizeTmp = [obj.description sizeWithFont:[UIFont boldSystemFontOfSize:FSOPTION_DESC_FONT_SIZE] 
					   constrainedToSize:CGSizeMake(cellWidth - FSOPTION_LEFT_RIGHT_SPACE * 2.0f - valueSize.width, 
													512.0f) 
						   lineBreakMode:UILineBreakModeTailTruncation];
		} else if (obj.settingKind == FSSetting_Switch) {
			sizeTmp = [obj.description sizeWithFont:[UIFont boldSystemFontOfSize:FSOPTION_DESC_FONT_SIZE] 
					   constrainedToSize:CGSizeMake(cellWidth - FSOPTION_LEFT_RIGHT_SPACE * 2.0f - FSOPTION_SWITCH_WIDTH, 
													512.0f) 
						   lineBreakMode:UILineBreakModeTailTruncation];
		} else {
			sizeTmp = [obj.description sizeWithFont:[UIFont boldSystemFontOfSize:FSOPTION_DESC_FONT_SIZE] 
					   constrainedToSize:CGSizeMake(cellWidth - FSOPTION_LEFT_RIGHT_SPACE * 2.0f , 
													512.0f) 
						   lineBreakMode:UILineBreakModeTailTruncation];
		}
		
		rst += (sizeTmp.height + FSOPTION_TOP_BOTTOM_SPACE);
		
		[pool release];
	}

	
	return rst;
}


@end

@implementation FSSettingObject
@synthesize description = _description;
@synthesize value = _value;
@synthesize switchValue = _switchValue;
@synthesize settingKind = _settingKind;
@synthesize accessoryType = _accessoryType;

- (id)init {
	if (self = [super init]) {
		self.description = @"";
		self.value = @"";
		self.switchValue = NO;
		self.settingKind = FSSetting_None;
		self.accessoryType = UITableViewCellAccessoryNone;
	}
	return self;
}
@end
