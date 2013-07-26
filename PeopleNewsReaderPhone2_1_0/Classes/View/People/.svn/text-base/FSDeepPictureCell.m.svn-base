//
//  FSDeepPictureCell.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-30.
//
//

#import "FSDeepPictureCell.h"

@implementation FSDeepPictureCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _asyncImage = [[FSAsyncImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_asyncImage];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _lblContent = [[UILabel alloc] initWithFrame:CGRectZero];
        [_lblContent setBackgroundColor:[UIColor clearColor]];
        [_lblContent setFont:[UIFont boldSystemFontOfSize:18.0f]];
        [_lblContent setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:_lblContent];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_asyncImage release];
    [_lblContent release];
    [super dealloc];
}

- (void)doSomethingAtLayoutSubviews {
    
}

@end
