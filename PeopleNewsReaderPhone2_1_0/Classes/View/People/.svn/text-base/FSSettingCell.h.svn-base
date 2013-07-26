//
//  FSSettingCell.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-16.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSTableViewCell.h"
#import "FSCommonFunction.h"

typedef enum _FSSettingKind {
	FSSetting_None,
	FSSetting_Switch,
	FSSetting_Value
} FSSettingKind;


@interface FSSettingCell : FSTableViewCell {
@protected
	UISwitch *_optionSwitch;
	UILabel *_lblDesc;
	UILabel *_lblValue;

}

@end

@protocol FSOptionCellDelegate
@optional
- (void)optionCell:(FSSettingCell *)sender withSwitchValue:(BOOL)switchVal;
@end


@interface FSSettingObject : NSObject {
@private
	NSString *_description;
	NSString *_value;
	BOOL _switchValue;
	FSSettingKind _settingKind;
	UITableViewCellAccessoryType _accessoryType;
}

@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *value;
@property (nonatomic) BOOL switchValue;
@property (nonatomic) FSSettingKind settingKind;
@property (nonatomic) UITableViewCellAccessoryType accessoryType;

@end

