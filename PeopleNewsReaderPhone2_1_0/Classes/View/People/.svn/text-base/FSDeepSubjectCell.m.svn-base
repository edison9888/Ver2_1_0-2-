//
//  FSDeepSubjectCell.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-9-11.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSDeepSubjectCell.h"


@implementation FSDeepSubjectCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		_lblTitle = [[UILabel alloc] initWithFrame:CGRectZero];
		[_lblTitle setBackgroundColor:[UIColor clearColor]];
		[self addSubview:_lblTitle];
		
		_lblEditorNote = [[UILabel alloc] initWithFrame:CGRectZero];
		[_lblEditorNote setBackgroundColor:[UIColor clearColor]];
		[self addSubview:_lblEditorNote];
		
		_commentLinks = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
	[_lblTitle release];
	[_lblEditorNote release];
	[_commentLinks removeAllObjects];
	[_commentLinks release];
    [super dealloc];
}

-(void)doSomethingAtLayoutSubviews {
	
}

@end
