//
//  FSDeepChildSubjectCell.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-9-11.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSDeepChildSubjectCell.h"


@implementation FSDeepChildSubjectCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		_lblTitle = [[UILabel alloc] initWithFrame:CGRectZero];
		[_lblTitle setBackgroundColor:[UIColor clearColor]];
		[self addSubview:_lblTitle];
		
		_lblAbstract =[[UILabel alloc] initWithFrame:CGRectZero];
		[_lblAbstract setBackgroundColor:[UIColor clearColor]];
		[self addSubview:_lblAbstract];
		
		_ivDeepImage = [[FSAsyncImageView alloc] initWithFrame:CGRectZero];
		[self addSubview:_ivDeepImage];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
	[_lblTitle release];
	[_lblAbstract release];
	[_ivDeepImage release];
    [super dealloc];
}

-(void)doSomethingAtLayoutSubviews {
	
}


@end
