//
//  FSNetEaseBlogShareViewController.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-11-7.
//
//

#import <UIKit/UIKit.h>
#import "FSBaseShareViewController.h"
#import "NetEaseEngine.h"
#import "FSNetEaseBlogShareLoginViewController.h"


@interface FSNetEaseBlogShareViewController : FSBaseShareViewController<NetEaseEngineDelegate,FSBaseLoginViewControllerDelegate>{
@protected
    
    NetEaseEngine *_engine;
    
}

@property (nonatomic,retain)NSString *shareContent;
@property (nonatomic,retain)NSData *dataContent;


@end
