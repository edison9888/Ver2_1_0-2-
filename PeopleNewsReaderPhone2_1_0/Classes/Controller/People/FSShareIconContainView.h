//
//  FSShareIconContainView.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-12-13.
//
//

#import <UIKit/UIKit.h>
#import "FSBaseContainerView.h"


typedef enum _ShareSelectEvent{
    ShareSelectEvent_return = 0,//返回
    ShareSelectEvent_sina,//新浪
    ShareSelectEvent_netease,//网易
    ShareSelectEvent_weixin,//微信
    ShareSelectEvent_peopleBlog,//人民微博
    ShareSelectEvent_mail,//邮件
    ShareSelectEvent_message//短信
}ShareSelectEvent;


@interface FSShareIconContainView : FSBaseContainerView{
@protected
    
    UILabel *_lab_title;
    UIButton *_bt_return;
    
    ShareSelectEvent _shareSelectEvent;
    
    BOOL _isShow;
}

@property (nonatomic,assign ) ShareSelectEvent shareSelectEvent;
@property (nonatomic,assign ) BOOL isShow;


-(void)layoutIcons;
-(CGFloat)getHeight;

@end
