//
//  FSDeepPageContainerController.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-1.
//
//

#import <UIKit/UIKit.h>
#import "FSPageControlViewController.h"
#import "FSDeepPageListDAO.h"


@class FS_GZF_DeepPageListDAO;

@interface FSDeepPageContainerController : FSPageControlViewController {
@private
    //FSDeepPageListDAO *_deepPageListData;
    
    FS_GZF_DeepPageListDAO *_fs_GZF_DeepPageListDAO;
    NSString *_Deep_title;
    NSString *_deepid;
}

@property (nonatomic, retain) NSString *deepid;
@property (nonatomic, retain) NSString *Deep_title;

@end
