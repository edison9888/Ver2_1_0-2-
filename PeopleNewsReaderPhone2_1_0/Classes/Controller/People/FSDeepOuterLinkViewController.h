//
//  FSDeepOuterLinkViewController.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-29.
//
//

#import <UIKit/UIKit.h>
#import "FSDeepBaseViewController.h"
#import "FSDeepOuterView.h"
#import "FSDeepOuterDAO.h"
#import "FSDeepOuterLinkListDAO.h"


@class FS_GZF_DeepOuterLinkListDAO,FS_GZF_DeepOuterLinkDAO;

@interface FSDeepOuterLinkViewController : FSDeepBaseViewController <UITableViewDataSource, UITableViewDelegate,FSBaseContainerViewDelegate> {
@private
    //FSDeepOuterDAO *_deepOuterData;
    FSDeepOuterView *_deepOuterView;
    
    //FSDeepOuterLinkListDAO *_deepOuterLinkListData;
    UITableView *_tvOutLinkList;
    
    FS_GZF_DeepOuterLinkListDAO *_fs_GZF_DeepOuterLinkListDAO;
    FS_GZF_DeepOuterLinkDAO *_fs_GZF_DeepOuterLinkDAO;
    
    NSString *_outerid;
}

@property (nonatomic, retain) NSString *outerid;

@end
