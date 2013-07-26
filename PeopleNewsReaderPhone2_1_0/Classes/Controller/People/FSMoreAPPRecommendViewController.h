//
//  FSMoreAPPRecommendViewController.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-3-21.
//
//

#import <UIKit/UIKit.h>
#import "FSBaseDataViewController.h"
#import "FSMoreAPPRecommendView.h"

#import <StoreKit/StoreKit.h>


@class FS_GZF_AppRecommendDAO,FSRecommentAPPObject;

@interface FSMoreAPPRecommendViewController : FSBaseDataViewController<FSTableContainerViewDelegate,SKStoreProductViewControllerDelegate>{
@protected
    
    FSMoreAPPRecommendView *_fsMoreAPPRecommendView;
    UINavigationBar *_navTopBar;
    
    FS_GZF_AppRecommendDAO *_fs_GZF_AppRecommendDAO;
}

-(void)addMyWebView:(FSRecommentAPPObject *)obj;

@end
