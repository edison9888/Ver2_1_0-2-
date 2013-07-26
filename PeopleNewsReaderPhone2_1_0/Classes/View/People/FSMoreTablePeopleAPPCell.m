//
//  FSMoreTablePeopleAPPCell.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-28.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSMoreTablePeopleAPPCell.h"
#import "FSAsyncCheckImageView.h"

#import "FSRecommentAPPObject.h"

@implementation FSMoreTablePeopleAPPCell

@synthesize currentIndex = _currentIndex;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)doSomethingAtDealloc{
    
}


-(void)doSomethingAtInit{
    
//    UIImageView *bgr = [[UIImageView alloc] init];
//    bgr.image = [UIImage imageNamed:@"moreCellBGR.png"];
//    self.backgroundView = bgr;
//    [bgr release];
    
    self.backgroundColor = COLOR_NEWSLIST_TITLE_WHITE;
    
    _scrollView = [[UIScrollView alloc] init];
    //_scrollView.delegate = self;
    [self addSubview:_scrollView];
     
}


-(void)doSomethingAtLayoutSubviews{ 
    _scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    //_scrollView.backgroundColor = [UIColor yellowColor];
    _scrollView.backgroundColor = COLOR_CLEAR;
    NSArray *v = [_scrollView subviews];
    for (UIView *o in v) {
        [o removeFromSuperview];
    }
    
    CGFloat space = 85;
    CGFloat left_right = 19.0f;
    CGFloat Mspace = 13.0f;
    NSInteger i = 0;
    
    
    
    NSMutableArray *array = (NSMutableArray *)self.data;
    
    //NSLog(@"array:%d",[array count]);
    
    for (FSRecommentAPPObject *o in array) {
        
        //set the image
        
        UIImageView *imageBackGR = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"more_PeopleApp.png"]];
        imageBackGR.frame = CGRectMake( left_right + (space+Mspace) * i, 16, space, space+4);
        [_scrollView addSubview:imageBackGR];
        [imageBackGR release];
        
        
        FSAsyncCheckImageView *imageView = [[FSAsyncCheckImageView alloc] initWithFrame:CGRectMake( 36 + (MORE_LIST_PEOPLEAPP_ICON_HEIGHT+48) * i, 26, MORE_LIST_PEOPLEAPP_ICON_HEIGHT, MORE_LIST_PEOPLEAPP_ICON_HEIGHT)];
        // NSString *defaultDBPath = [getDocumentPath() stringByAppendingPathComponent:[o.channel_normal lastPathComponent]];
        imageView.normalURLString = o.appLogo;
        imageView.heighlightURLString = o.appLogo;
        imageView.selectedURLString = o.appLogo;
        imageView.imageCheckType = ImageCheckType_normal;//
        imageView.tag = i;
        [_scrollView addSubview:imageView];
        [imageView updataCheckImageView];
        
        
        
        //set the label
        UILabel *lab_title = [[UILabel alloc] init];
        lab_title.backgroundColor = COLOR_CLEAR;
        lab_title.font = [UIFont systemFontOfSize:14];
        lab_title.textColor = COLOR_NEWSLIST_TITLE;
        lab_title.textAlignment = UITextAlignmentCenter;
        lab_title.text = o.appName;
        //lab_title.frame = CGRectMake(space+(MORE_LIST_PEOPLEAPP_ICON_HEIGHT+space)*i+3, MORE_LIST_PEOPLEAPP_ICON_HEIGHT+5, MORE_LIST_PEOPLEAPP_ICON_HEIGHT, 20);
        lab_title.frame = CGRectMake( left_right + (space+Mspace) * i, 28+MORE_LIST_PEOPLEAPP_ICON_HEIGHT, space, 18);
        [_scrollView addSubview:lab_title];
        [lab_title release];
        
        //set the button under the image
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake( left_right + (space+Mspace) * i, 16, space, space+4);
        button.alpha = 0.05;
        button.tag = i;
        [button addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:button];
        [button release];
        i++;
        [imageView release];
    }
    
    [_scrollView setContentSize:CGSizeMake(left_right + (space+Mspace) * i+6, self.frame.size.height)];
    
}


-(void)buttonSelected:(id)sender{
    UIButton *o = (UIButton *)sender;
    _currentIndex = o.tag;
    if ([(id)_parentDelegate respondsToSelector:@selector(tableViewCellTouchEvent:)]) {
        [(id)_parentDelegate tableViewCellTouchEvent:self];
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
