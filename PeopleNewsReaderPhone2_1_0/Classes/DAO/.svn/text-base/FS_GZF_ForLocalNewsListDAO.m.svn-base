//
//  FS_GZF_ForLocalNewsListDAO.m
//  PeopleNewsReaderPhone
//
//  Created by Xu dandan on 12-11-5.
//
//


#import "FS_GZF_ForLocalNewsListDAO.h"

#import "FSOneDayNewsObject.h"


#define FSLOCAL_NEWS_URL @"http://mobile.app.people.com.cn:81/news2/news.php?act=citynews&rt=xml&provinceid=%@&newsid=%@"


#define FSLOCAL_NEWS_PAGECOUNT 20




@implementation FS_GZF_ForLocalNewsListDAO


@synthesize  provinceid = _provinceid;
@synthesize lastnewsid = _lastnewsid;

- (id)init {
	self = [super init];
	if (self) {
		_count = 1;
        self.getNextOnline = YES;
	}
    
	return self;
}

- (void)dealloc {
	
	[super dealloc];
}

- (NSString *)readDataURLStringFromRemoteHostWithGETDataKind:(GET_DataKind)getDataKind {
    
	if (getDataKind == GET_DataKind_Refresh) {
		return [NSString stringWithFormat:FSLOCAL_NEWS_URL, self.provinceid, @""];
	} else {
        
        return [NSString stringWithFormat:FSLOCAL_NEWS_URL,  self.provinceid, self.lastnewsid];
	}
}

- (NSTimeInterval)bufferDataExpireTimeInterval {
	return 60*10;
}

//查询数据
- (NSString *)predicateStringWithQueryDataKind:(Query_DataKind)dataKind {
        return [NSString stringWithFormat:@"group='%@' AND bufferFlag!='3'", self.provinceid];
}

- (NSInteger)fetchLimitWithGETDDataKind:(GET_DataKind)getDataKind {
	if (getDataKind == GET_DataKind_Refresh) {
		return FSLOCAL_NEWS_PAGECOUNT;
	} else {
		return [self.objectList count] + FSLOCAL_NEWS_PAGECOUNT;
	}
}

- (NSString *)entityName {
	return @"FSOneDayNewsObject";
}

- (NSString *)timestampFlag {
    return self.provinceid;
}

-(NSString *)getGroupName{
    return self.provinceid;
}

- (void)initializeSortDescriptions:(NSMutableArray *)descriptions {
	[self addSortDescription:descriptions withSortFieldName:@"timestamp" withAscending:NO];
}



//******************************************************************************************



@end
