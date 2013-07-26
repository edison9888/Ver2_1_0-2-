//
//  FSDeepPriorViewController.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-2.
//
//

#import <UIKit/UIKit.h>
#import "FSDeepBaseViewController.h"
#import "FSDeepPriorDAO.h"
#import "FSDeepPriorListDAO.h"
#import "FSHorizontalScrollPageContainerView.h"
#import "FSDeepPriorPictureView.h"
#import "FSDeepPriorListView.h"
#import "FSTableView.h"
#import "FSDeepPriorListCell.h"




@class FS_GZF_DeepPriorListDAO,FS_GZF_DeepPriorDAO,FSDeepPriorTOPpageControllView;

@interface FSDeepPriorViewController : FSDeepBaseViewController <FSHorizontalScrollPageContainerViewDelegate, UITableViewDataSource, UITableViewDelegate> {
@private
    //FSDeepPriorDAO *_deepTopPriorData;
    FSHorizontalScrollPageContainerView *_topContainerView;
    UILabel *_lblTopInfo;
    
   //FSDeepPriorListDAO *_deepBottomPriorData;
//    FSHorizontalScrollPageContainerView *_bottomContainerView;
    
    FS_GZF_DeepPriorListDAO *_fs_GZF_DeepPriorListDAO;
    FS_GZF_DeepPriorDAO *_fs_GZF_DeepPriorDAO;
    
    FSTableView *_tvList;
    
    FSDeepPriorTOPpageControllView *_fsDeepPriorTOPpageControllView;
}

@end
