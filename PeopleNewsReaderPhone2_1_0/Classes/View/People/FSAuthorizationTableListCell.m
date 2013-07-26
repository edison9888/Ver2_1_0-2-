//
//  FSAuthorizationTableListCell.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-9-18.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSAuthorizationTableListCell.h"

@implementation FSAuthorizationTableListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = COLOR_NEWSLIST_TITLE_WHITE;
    }
    return self;
}


-(void)doSomethingAtDealloc{
    [_lab_title release];
}

-(void)doSomethingAtInit{
    
//    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CellBackground.png"]];
//    self.backgroundView = image;
//    [image release];
    
    _lab_title = [[UILabel alloc] init];
    _lab_title.textAlignment = UITextAlignmentLeft;
    
    _bt_SwichSelect = [[UILabel alloc] init];
    _bt_SwichSelect.textAlignment = UITextAlignmentRight;
    _bt_SwichSelect.textColor = COLOR_NEWSLIST_TITLE;
    _isSelect = YES;
    
    [self.contentView addSubview:_lab_title];
    [self.contentView addSubview:_bt_SwichSelect];
    //self.contentView.backgroundColor = COLOR_NEWSLIST_TITLE_WHITE;
}


-(void)doSomethingAtLayoutSubviews{
    
    NSMutableDictionary *obj = (NSMutableDictionary *)self.data;
    NSString *title = [obj valueForKey:@"title"];
    
    NSString *key = [obj valueForKey:@"key"];
    
    if ([key isEqualToString:@"1"]) {
        _bt_SwichSelect.text = @"解除";
        _isSelect = YES;
    }
    else{
        _bt_SwichSelect.text = @"绑定";
        _isSelect = NO;
    }
    
    
    _lab_title.textColor = COLOR_NEWSLIST_TITLE;
    _lab_title.frame = CGRectMake(6, 0, self.frame.size.width, self.frame.size.height);
    _lab_title.text = title;
    _lab_title.backgroundColor = COLOR_CLEAR;
    
    _bt_SwichSelect.frame = CGRectMake(self.frame.size.width - 85, 7, 45, self.frame.size.height - 16);
    _bt_SwichSelect.backgroundColor = COLOR_CLEAR;
    //_bt_SwichSelect = COLOR_CLEAR;
}


-(void)SwichBtSelect:(id)sender{
    return;
    UIButton *o = (UIButton *)sender;
    if (_isSelect) {
        [o setTitle:@"绑定" forState:UIControlStateNormal];
        _isSelect = NO;
    }
    else{
        [o setTitle:@"解除" forState:UIControlStateNormal];
        _isSelect = YES;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
