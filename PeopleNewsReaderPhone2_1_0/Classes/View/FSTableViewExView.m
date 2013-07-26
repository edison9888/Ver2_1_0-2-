//
//  FSTableViewExView.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-12.
//
//

#import "FSTableViewExView.h"

@implementation FSTableViewExView


- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style 
{
    self = [super initWithFrame:frame style:style];
    if (self) {

    }
    return self;
}

- (void)dealloc {
    [_topAssistantView release];
    [_bottomAssistantView release];
    [super dealloc];
}

#pragma -
#pragma UITableViewDelegate

@end
