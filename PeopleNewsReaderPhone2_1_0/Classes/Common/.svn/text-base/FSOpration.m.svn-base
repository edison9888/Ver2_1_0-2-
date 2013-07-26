//
//  FSOpration.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-1-30.
//
//

#import "FSOpration.h"

#define FSNETWORKDATA_MANAGER_BEGIN_DOWNLOADING_NOTIFICATION @"FSNETOWRKDATA_MANAGER_BEGIN_DOWNLOADING_NOTIFICATION_STRING"
#define FSNETWORKDATA_MANAGER_END_DOWNLOADING_COMPLETE_NOTIFICATION @"FSNETWORKDATA_MANAGER_END_DOWNLOADING_NOTIFICATION_STRING"
#define FSNETWORKDATA_MANAGER_END_DOWNLOADING_ERROR_NOTIFICATION @"FSNETWORKDATA_MANAGER_END_DOWNLOADING_ERROR_NOTIFICATION_STRING"

#define FSNETWORKDATA_MANAGER_URLSTRING_KEY @"FSNETWORKDATA_MANAGER_URLSTRING_KEY_STRING"
#define FSNETWORKDATA_MANAGER_LOCALFILEPATH_KEY @"FSNETWORKDATA_MANAGER_LOCALFILEPATH_KEY_STRING"

@implementation FSOpration

-(id)initWithURL:(NSString *)URLString withLocalFilePath:(NSString *)localFilePath withDelegate:(id)delegate{
    if (self = [self init]){
        _delegate = delegate;
        _urlString = [URLString retain];
        _localFile = [localFilePath retain];
        
    }
    return self;
}

-(void)dealloc{
    [_urlString release];
    [_localFile release];
    [super dealloc];
}

-(void)main{
    if (![self isCancelled]) {
        
        NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
        [userInfo setObject:_urlString forKey:FSNETWORKDATA_MANAGER_URLSTRING_KEY];
        [userInfo setObject:_localFile forKey:FSNETWORKDATA_MANAGER_LOCALFILEPATH_KEY];
        [[NSNotificationCenter defaultCenter] postNotificationName:FSNETWORKDATA_MANAGER_BEGIN_DOWNLOADING_NOTIFICATION object:self userInfo:userInfo];
        [userInfo release];
        //NSLog(@"FSOpration  start:%@ [%f]",_urlString,[[NSDate date] timeIntervalSince1970]);
        [FSNetworkData oprationNetworkDataWithURLString:_urlString withLocalStoreFileName:_localFile withDelegate:self];
        //NSLog(@"FSOpration  end:%@ [%f]",_localFile,[[NSDate date] timeIntervalSince1970]);
        
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        NSMutableDictionary *userInfo1 = [[NSMutableDictionary alloc] init];
        [userInfo1 setObject:_urlString forKey:FSNETWORKDATA_MANAGER_URLSTRING_KEY];
        [userInfo1 setObject:_localFile forKey:FSNETWORKDATA_MANAGER_LOCALFILEPATH_KEY];
        [[NSNotificationCenter defaultCenter] postNotificationName:FSNETWORKDATA_MANAGER_END_DOWNLOADING_COMPLETE_NOTIFICATION object:self userInfo:userInfo1];
        [userInfo1 release];
    });
        
    }
}

//-(void)start{
//    if (![self isCancelled]) {
//        NSLog(@"FSOpration  start ");
//        [FSNetworkData oprationNetworkDataWithURLString:_urlString withLocalStoreFileName:_localFile withDelegate:_delegate oprationDelegate:self];
//        NSLog(@"FSOpration  start end");
//    }
//}


-(void)networkDataDownloadDataComplete:(FSNetworkData *)sender isError:(BOOL)isError data:(NSData *)data{
    
//    if (!isError) {
//        NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
//        [userInfo setObject:_urlString forKey:FSNETWORKDATA_MANAGER_URLSTRING_KEY];
//        [userInfo setObject:_localFile forKey:FSNETWORKDATA_MANAGER_LOCALFILEPATH_KEY];
//        [[NSNotificationCenter defaultCenter] postNotificationName:(isError ? FSNETWORKDATA_MANAGER_END_DOWNLOADING_ERROR_NOTIFICATION : FSNETWORKDATA_MANAGER_END_DOWNLOADING_COMPLETE_NOTIFICATION) object:self userInfo:userInfo];
//        [userInfo release];
//            
//    }
}

@end
