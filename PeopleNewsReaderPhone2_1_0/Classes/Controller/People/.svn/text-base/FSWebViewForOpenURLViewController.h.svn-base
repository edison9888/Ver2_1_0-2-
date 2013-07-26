//
//  FSWebViewForOpenURLViewController.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-1-10.
//
//

#import <UIKit/UIKit.h>
#import "FSBaseDataViewController.h"

@interface FSWebViewForOpenURLViewController : FSBaseDataViewController<UIWebViewDelegate>{
@protected
    UIWebView *_webView;
	NSString *_urlString;
	
	UINavigationBar *_navTopBar;
	UIBarButtonItem *_backBrowserButton;
	UIBarButtonItem *_goBrowserButton;
	UIBarButtonItem *_refreshButton;
	UIBarButtonItem *_moreButton;
    
    BOOL _withOutToolbar;
    BOOL _firstShow;
}

@property (nonatomic, retain) NSString *urlString;
@property (nonatomic, assign) BOOL withOutToolbar;

@end
