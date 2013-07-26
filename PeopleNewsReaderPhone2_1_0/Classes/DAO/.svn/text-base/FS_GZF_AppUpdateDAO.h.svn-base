//
//  FS_GZF_AppUpdateDAO.h
//  PeopleNewsReaderPhone
//
//  Created by Qin,Zhuoran on 12-12-19.
//
//

#import <Foundation/Foundation.h>
#import "FSHTTPGetWebData.h"

@interface FS_GZF_AppUpdateDAO : NSObject<FSHTTPWebDataDelegate>{

@protected
    NSString *version;
    NSString *updataURL;
    NSString *updataNote;
    NSData *_dataBuffer;
    BOOL isManualUpdata;
    BOOL isShow;
    
    NSURLConnection *_connection;
    
}

@property (nonatomic, assign)NSString *version;
@property (nonatomic, assign)BOOL isManualUpdata;
@property (nonatomic, assign)BOOL isShow;

-(void)getVersion;
@end
