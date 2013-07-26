//
//  FSMoreTableListSectionView.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-10-9.
//
//

#import "FSMoreTableListSectionView.h"

@implementation FSMoreTableListSectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)doSomethingAtDealloc{
    [_lab_sectionTitle release];
    [_sectionBGR release];
}


-(void)doSomethingAtInit{
    _lab_sectionTitle = [[UILabel alloc] init];
    _lab_sectionTitle.textAlignment = UITextAlignmentLeft;
    _lab_sectionTitle.backgroundColor = COLOR_CLEAR;
    
    
    _sectionBGR = [[UIImageView alloc] init];
    _sectionBGR.image = [UIImage imageNamed:@"more_section.png"];
    
    [self addSubview:_sectionBGR];
    [self addSubview:_lab_sectionTitle];
}


-(void)doSomethingAtLayoutSubviews{
    
    _lab_sectionTitle.text = (NSString *)_data;
    _lab_sectionTitle.textColor = COLOR_NEWSLIST_TITLE;
    
    _sectionBGR.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _lab_sectionTitle.frame = CGRectMake(20, 0, self.frame.size.width, self.frame.size.height-3);
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
