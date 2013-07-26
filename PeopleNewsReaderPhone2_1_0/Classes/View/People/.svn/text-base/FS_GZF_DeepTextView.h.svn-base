//
//  FS_GZF_DeepTextView.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-1-7.
//
//

#import <UIKit/UIKit.h>
#import "FSBaseContainerView.h"
#import "FSDeepContentObject.h"
#import "FSDeepContent_ChildObject.h"
#import "FSNetworkData.h"

@interface FS_GZF_DeepTextView : FSBaseContainerView<FSNetworkDataDelegate,UIScrollViewDelegate>{
@protected
    
    UIScrollView *_scrollView;
    
    FSDeepContentObject *_contentObject;
    NSInteger _pictureFlag;
    NSInteger _textFlag;
    //NSMutableDictionary *_picURLs;
    
    NSArray *_ChildObjects;
    
    CGFloat _clientHeight;
    
    NSString *_title;

}

@property (nonatomic, retain) FSDeepContentObject *contentObject;
@property (nonatomic) NSInteger pictureFlag;
@property (nonatomic) NSInteger textFlag;
@property (nonatomic,retain) NSString *title;

-(void)inner_Layout;

-(UIImage *)setImageWithURL:(NSString *)URL;




@end



