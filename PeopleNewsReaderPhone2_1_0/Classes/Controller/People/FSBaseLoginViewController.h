//
//  FSBaseLoginViewController.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-11-8.
//
//

#import <UIKit/UIKit.h>
#import "FSBaseDataViewController.h"


@interface FSBaseLoginViewController : FSBaseDataViewController{
@protected
    UITextField *_tfUser;
	UITextField *_tfPWD;
	UILabel *_lblUser;
	UILabel *_lblPWD;
	UIButton *_btnLogin;
    UILabel *_lblDescription;
	UIImageView *_ivDescription;
    
    CGSize _keyboardSize;
	CGFloat _clientHeight;
	
    
	CGFloat _topHeight;
	NSInteger _sendCount;
    
    id _parentDelegate;
    
    BOOL _isnavTopBar;
    
    UINavigationBar *_navTopBar;
}

@property (nonatomic,assign) id parentDelegate;
@property (nonatomic,assign) BOOL isnavTopBar;


-(NSString *)inputUserNamnePrompt;
-(NSString *)bagroundImageName;
- (void)loginServer:(FSBaseLoginViewController *)sender;

-(void)returnToParentView;

@end


@protocol FSBaseLoginViewControllerDelegate

-(void)loginSuccesss:(BOOL)isSuccess;

@end