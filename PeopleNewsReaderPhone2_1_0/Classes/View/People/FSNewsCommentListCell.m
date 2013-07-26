//
//  FSNewsCommentListCell.m
//  PeopleNewsReaderPhone
//
//  Created by Xu dandan on 12-11-2.
//
//

#import "FSNewsCommentListCell.h"
#import "FSCommentObject.h"
#import "FSCommonFunction.h"


@implementation FSNewsCommentListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)doSomethingAtDealloc{
    [_cellBackground release];
    [_talkimage release];
    [_commViewBGR release];
    
    [_lab_Admin release];
    [_lab_AdminContent release];
    [_lab_AdminTimestamp release];
    [_lab_content release];
    [_lab_nickname release];
    [_lab_timestamp release];
}


-(void)doSomethingAtInit{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _cellBackground = [[UIImageView alloc] init];
    _cellBackground.image = [UIImage imageNamed:@"Comment_beijing.png"];
    _talkimage = [[UIImageView alloc] init];
    _talkimage.image = [UIImage imageNamed:@"Comment_talk.png"];
    
    _commViewBGR = [[UIImageView alloc] init];
    _commViewBGR.image = [UIImage imageNamed:@"Comment_kuang.png"];
    _commViewBGR.alpha = 0.88f;
    
    
    _lab_Admin = [[UILabel alloc] init];
    _lab_Admin.textColor = COLOR_NEWSLIST_DESCRIPTION;
    _lab_Admin.backgroundColor = COLOR_CLEAR;
    _lab_Admin.font = [UIFont systemFontOfSize:10];
    
    _lab_AdminContent = [[UILabel alloc] init];
    _lab_AdminContent.textColor = COLOR_NEWSLIST_TITLE;
    _lab_AdminContent.backgroundColor = COLOR_CLEAR;
    _lab_AdminContent.font = [UIFont systemFontOfSize:12];
    
    _lab_AdminTimestamp = [[UILabel alloc] init];
    _lab_AdminTimestamp.textColor = COLOR_NEWSLIST_DESCRIPTION;
    _lab_AdminTimestamp.textAlignment = UITextAlignmentRight;
    _lab_AdminTimestamp.backgroundColor = COLOR_CLEAR;
    _lab_AdminTimestamp.font = [UIFont systemFontOfSize:10];
    
    
    
    
    _lab_nickname = [[UILabel alloc] init];
    _lab_nickname.textColor = COLOR_NEWSLIST_DESCRIPTION;
    _lab_nickname.backgroundColor = COLOR_CLEAR;
    _lab_nickname.font = [UIFont systemFontOfSize:10];
    
    _lab_content = [[UILabel alloc] init];
    _lab_content.textColor = COLOR_NEWSLIST_TITLE;
    _lab_content.backgroundColor = COLOR_CLEAR;
    _lab_content.font = [UIFont systemFontOfSize:12];
    
    _lab_timestamp = [[UILabel alloc] init];
    _lab_timestamp.textColor = COLOR_NEWSLIST_DESCRIPTION;
    _lab_timestamp.textAlignment = UITextAlignmentRight;
    _lab_timestamp.backgroundColor = COLOR_CLEAR;
    _lab_timestamp.font = [UIFont systemFontOfSize:10];
    
    
    
    
    
    self.backgroundView = _cellBackground;
    
    [self addSubview:_commViewBGR];
    [self addSubview:_lab_Admin];
    [self addSubview:_lab_AdminContent];
    [self addSubview:_lab_AdminTimestamp];
    
    [self addSubview:_lab_nickname];
    [self addSubview:_lab_content];
    [self addSubview:_lab_timestamp];
    
    [self addSubview:_talkimage];
    
}


-(void)doSomethingAtLayoutSubviews{
    
    FSCommentObject *o = (FSCommentObject *)self.data;
    
    _lab_nickname.text = o.nickname;
    _lab_content.text = o.content;
    
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:[o.timestamp doubleValue]];
    
    _lab_timestamp.text = timeIntervalStringSinceNow(date);
    [date release];
    
    _commViewBGR.frame = CGRectMake(8, 6, self.frame.size.width-12, 60);
    _talkimage.frame = CGRectMake(18, 10, 22, 22);
    
    _lab_nickname.frame = CGRectMake(44, 8, self.frame.size.width-50, 16);
    _lab_content.frame = CGRectMake(44, 28, self.frame.size.width - 50, 26);
    _lab_timestamp.frame = CGRectMake(44, 8, self.frame.size.width-54, 16);
    
    if ([o.adminContent length]>0) {
        _lab_Admin.alpha = 1.0f;
        _lab_AdminContent.alpha = 1.0f;
        _lab_AdminTimestamp.alpha = 1.0f;
        
        
        _lab_Admin.text = o.adminNickname;
        _lab_AdminContent.text = o.adminContent;
        
        NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:[o.adminTimestamp doubleValue]];
        
        _lab_AdminTimestamp.text = timeIntervalStringSinceNow(date);
        
        [date release];
        
        _lab_Admin.frame = CGRectMake(44, 8+70, self.frame.size.width-50, 16);
        _lab_AdminContent.frame = CGRectMake(44, 28+70, self.frame.size.width - 50, 26);
        _lab_AdminTimestamp.frame = CGRectMake(44, 8+70, self.frame.size.width-54, 16);
    }
    else{
        _lab_Admin.alpha = 0.0f;
        _lab_AdminContent.alpha = 0.0f;
        _lab_AdminTimestamp.alpha = 0.0f;
    }
}


//*****************************
+(CGFloat)computCellHeight:(NSObject *)cellData cellWidth:(CGFloat)cellWidth{
    
    FSCommentObject *o = (FSCommentObject *)cellData;
    if ([o.adminContent length]>0) {
        return COMMENT_LIEST_CELL_HEIGHT * 2;
    }
    
    
    return COMMENT_LIEST_CELL_HEIGHT;
}


@end
