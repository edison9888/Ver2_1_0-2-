//
//  FSDeepSubjectCell.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-9-11.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSTableViewCell.h"
//
@interface FSDeepSubjectCell : FSTableViewCell {
@private
	UILabel *_lblTitle;
	UILabel *_lblEditorNote;
	NSMutableArray *_commentLinks;
}

@end
