//
//  FS_GZF_BaseDAO.m
//  PeopleNewsReaderPhone
//
//  Created by Xu dandan on 12-10-19.
//
//

#import "FS_GZF_BaseDAO.h"

@implementation FS_GZF_BaseDAO

@synthesize parentDelegate = _parentDelegate;

-(id)init{
    
    self = [super init];
	if (self) {
		
	}
	return self;
}

-(void)dealloc{
    [super dealloc];
}


-(void)baseXMLParserComplete:(FS_GZF_BaseDAO *)sender{
    
}


- (void)executeCallBackDelegateWithStatus:(FS_GZF_BaseDAOCallBackStatus)status {
	//GCD
	dispatch_async(dispatch_get_main_queue(), ^(void) {
		if ([_parentDelegate respondsToSelector:@selector(dataAccessObjectSync:withStatus:)]) {
			[_parentDelegate dataAccessObjectSync:self withStatus:status];
		}
	});
}

- (void)executeCallBackDelegateSyncBegin:(long long)totalBytes {
	dispatch_async(dispatch_get_main_queue(), ^(void) {
		if ([_parentDelegate respondsToSelector:@selector(dataAccessObjectSyncBegin:withTotalBytes:)]) {
			[_parentDelegate dataAccessObjectSyncBegin:self withTotalBytes:totalBytes];
		}
	});
}

- (void)executeCallBackDelegateSyncProgress:(long long)receiveBytes {
	dispatch_async(dispatch_get_main_queue(), ^(void) {
		if ([_parentDelegate respondsToSelector:@selector(dataAccessObjectSyncProgress:withReceiveBytes:)]) {
			[_parentDelegate dataAccessObjectSyncProgress:self withReceiveBytes:receiveBytes];
		}
	});
}

- (void)executeCallBackDelegateSyncEnd {
	dispatch_async(dispatch_get_main_queue(), ^(void) {
		if ([_parentDelegate respondsToSelector:@selector(dataAccessObjectSyncEnd:)]) {
			[_parentDelegate dataAccessObjectSyncEnd:self];
		}
	});
}


@end
