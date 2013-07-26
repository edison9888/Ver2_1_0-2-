//
//  FSBaseShareViewController.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-11-7.
//
//

#import <UIKit/UIKit.h>
#import "FSBaseDataViewController.h"
#import "FSBlogShareContentView.h"
#import "FSShareNoticView.h"

#define SHARE_SUCCESSFUL_NOTICE @"SHARE_SUCCESSFUL_NOTICE"

@interface FSBaseShareViewController : FSBaseDataViewController<FSBaseContainerViewDelegate>{
@protected
    FSBlogShareContentView *_fsBlogShareContentView;
    
    NSString *_shareContent;
    NSData *_dataContent;
    FSShareNoticView *_fsShareNoticView;
    
    UINavigationBar *_navTopBar;
    BOOL _withnavTopBar;
}

@property (nonatomic,retain)NSString *shareContent;
@property (nonatomic,retain)NSData *dataContent;
@property (nonatomic,assign) BOOL withnavTopBar;


-(void)postShareMessage;
-(void)returnToParentView;

@end
