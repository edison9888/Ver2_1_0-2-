//
//  FSBaseGETJSONDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-9-12.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSBaseGETJSONDAO.h"


@implementation FSBaseGETJSONDAO

- (id)init {
	self = [super init];
	if (self) {
		
	}
	return self;
}

- (void)dealloc {
	[super dealloc];
}

- (void)doSomethingInDataReceiveComplete {
	[self operateOldBufferData];
	
	SBJSON *json = [[SBJSON alloc] init];
	NSString *jsonString = [[NSString alloc] initWithData:self.dataBuffer encoding:NSUTF8StringEncoding];
	id jsonResult = [json objectWithString:jsonString];
	[self doSomethingWithResult:jsonResult];
	[jsonString release];
	[json release];
	
	[self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_SuccessfulStatus];
}

- (void)doSomethingWithResult:(id)result {
}

@end
