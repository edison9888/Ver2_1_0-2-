//
//  FS_GZF_AppUpdateDAO.m
//  PeopleNewsReaderPhone
//
//  Created by Qin,Zhuoran on 12-12-19.
//
//

#import "FS_GZF_AppUpdateDAO.h"
#import "FSConst.h"

@implementation FS_GZF_AppUpdateDAO

@synthesize version, isManualUpdata, isShow;

- (id)init {
    self = [super init];
	if (self) {
        _dataBuffer = [[NSData alloc] init];
    }
	return self;
}


-(void)getVersion{
    
    if (isShow == 1) {
        return;
    }
    
    NSString *updateKey = [[NSUserDefaults standardUserDefaults] objectForKey:SETTING_UPDATA_KEY];
    
    if (updateKey == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@"打开" forKey:SETTING_UPDATA_KEY];
    }
    else{
        if ([updateKey isEqualToString:@"关闭"] && !isManualUpdata) {
            return;
        }
    }
    
    NSString *url = APP_CHACK_UPDATE_URL;
    [FSHTTPGetWebData HTTPGETDataWithURLString:url withDelegate:self];
    
   // NSLog(@"  _dataBuffer%@",_dataBuffer);
}

#pragma mark - FSHTTPWebDataDelegate

- (void)fsHTTPWebDataDidFinished:(FSHTTPWebData *)sender withData:(NSData *)data{
    
    _dataBuffer = data;
    NSString *temp = [[[NSString alloc] initWithData:_dataBuffer encoding:NSUTF8StringEncoding] autorelease];
    
    NSArray *tsAdrListtmp = [temp componentsSeparatedByString:@","];
    
    for (int i=0; i<tsAdrListtmp.count; i++) {
       // NSLog(@"tsAdrListtmp :%@",[tsAdrListtmp objectAtIndex:i]);
        if (i==0) {
            version = [[NSString alloc] initWithString:[tsAdrListtmp objectAtIndex:i]];
        }
        if (i== 1) {
            updataURL = [[NSString alloc] initWithString:[tsAdrListtmp objectAtIndex:i]];
        }
        
        if (i== 3) {
            updataNote = [[NSString alloc] initWithString:[tsAdrListtmp objectAtIndex:i]];
        }
    }
    NSLog(@"version %@, updataURL:%@, updateNote %@",version,updataURL,updataNote);
    
    //isManualUpdate 区别是手动更新还是系统自动更新！
    if (isManualUpdata) {
        
        if ([version isEqualToString:SETTING_VERSION]) {
           
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"通知"
                                        message:@"已经是最新版本!"
                                        delegate:self
                                        cancelButtonTitle:@"返回"
                                        otherButtonTitles: nil];
                                            [alert show];
            return;
            
        }else{
            NSURL *url = [[NSURL alloc] initWithString:updataURL];
            [[UIApplication sharedApplication] openURL:url];
            [url release];
            return;
            //exit(0);
        }
        
    }
    
    //当程序是由系统自动更新！！！
    if (![version isEqualToString:SETTING_VERSION]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"升级提示"
                                                        message:[NSString stringWithFormat:@"%@",updataNote]
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"取消", @"暂不更新",@"前往更新", nil];
        alert.tag = 120;
        [alert show];
        isShow = 1;
    }

}


//optional
- (void)fsHTTPWebDataStart:(FSHTTPWebData *)sender withTotalBytes:(long long)totalBytes{
}
- (void)fsHTTPWebDataProgress:(FSHTTPWebData *)sender withCurrentBytes:(long long)currentBytes{
}


- (void)fsHTTPWebDataDidFail:(FSHTTPWebData *)sender withError:(NSError *)error{
    NSLog(@"fsHTTPWebDataDidFail %@",error);
}


#pragma mark -
#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    isShow = 0;
	NSInteger flag = alertView.tag;
	[alertView release];
	if (flag == 120 && buttonIndex == 0) {
        return;
	}
    
    if (flag == 120 && buttonIndex == 1) {
        
//        [[NSUserDefaults standardUserDefaults] setObject:@"关闭" forKey:SETTING_UPDATA_KEY];
//        return;
        
        //需要系统提示的情况下
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:APP_TITLE
                                                        message:@"是否提示有新版本？"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"是", @"否", nil];
        alert.tag = 130;
        [alert show];
        return;
    }
    
    if (flag == 120 && buttonIndex == 2) {
        NSLog(@"updataURL:%@",updataURL);
		NSURL *url = [[NSURL alloc] initWithString:updataURL];
        [[UIApplication sharedApplication] openURL:url];
        [url release];
        //exit(0);
        return;
	}
    
    if (flag == 130 && buttonIndex == 0) {
        return;
    }
    if (flag == 130 && buttonIndex == 1) {
        [[NSUserDefaults standardUserDefaults] setObject:@"关闭" forKey:SETTING_UPDATA_KEY];
        return;
    }
    
}





@end
