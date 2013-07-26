//
//  FS_GZF_AppRecommendDAO.m
//  PeopleNewsReaderPhone
//
//  Created by Qin,Zhuoran on 12-12-13.
//
//

#import "FS_GZF_AppRecommendDAO.h"
#import "FSRecommentAPPObject.h"

/*
<item>
<appLogo>
    <![CDATA[...]]>
</appLogo>
<appName>
    <![CDATA[ 人民日报 ]]>
</appName>
<appDesc>
    <![CDATA[人民日报是一张...]]>
</appDesc>
<appLink>
    <![CDATA[ http://itunes.apple.com/cn/app/id401642180?mt=8 ]]>
</appLink>
<appType>1</appType>
</item>
 
 
 <ITEM>
 <APPID><![CDATA[29]]></APPID>
 <APPNAME><![CDATA[人民日报]]></APPNAME>
 <APPORDER><![CDATA[1]]></APPORDER>
 <APPDESCRIPTION><![CDATA[手机看原版报纸]]></APPDESCRIPTION>
 <APPLINK><![CDATA[]]></APPLINK>
 <APPLINK_ID><![CDATA[424180337]]></APPLINK_ID>
 <APPICON><![CDATA[http://58.68.130.168/original/125/125/data/newsimages/client/130328/F201303281364451593215083.jpg]]></APPICON>
 </ITEM>
 
*/



#define app_item @"ITEM"
#define app_logo @"APPICON"
#define app_name @"APPNAME"
#define app_desc @"APPDESCRIPTION"
#define app_link @"APPLINK"
#define app_type @"appType"
#define app_order @"APPORDER"
#define app_id @"APPID"
#define app_linkid @"APPLINK_ID"

#define FS_AppRem_URL @"http://mobile.app.people.com.cn:81/paper_ipad/paper.php?act=app&type=list&appid=6&iswp=0"

@implementation FS_GZF_AppRecommendDAO

- (id)init {
    self = [super init];
	if (self) {
		
	}
	return self;
}


- (NSString *)readDataURLStringFromRemoteHostWithGETDataKind:(GET_DataKind)getDataKind{
    
	return FS_AppRem_URL;
    
}

- (NSTimeInterval)bufferDataExpireTimeInterval {
	//1 week 
    return 60 * 2;
}

//the object name
-(NSString *)entityName{
    return @"FSRecommentAPPObject";
}


-(NSString *)predicateStringWithQueryDataKind:(Query_DataKind)dataKind{
    return @"bufferFlag!='3'";
    return nil;
}

- (void)initializeSortDescriptions:(NSMutableArray *)descriptions {
	[self addSortDescription:descriptions withSortFieldName:@"apporder" withAscending:YES];
}

#pragma mark -
#pragma mark NSCMLParserDelegate


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    _currentElementName = elementName;
	if ([_currentElementName isEqualToString:app_item]) {
        _obj = (FSRecommentAPPObject *)[self insertNewObjectTomanagedObjectContext];
        _obj.bufferFlag = @"1";
        
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:app_item]) {
        
        [_objectList addObject:_obj];
        //[_obj release];
        //_obj = nil;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	//NSLog(@"foundCharacters:%@",string);
    
    /*
     NSString *strUnion = nil;
     if ([self.currentElementName isEqualToString:NEWS_COMMENT_CREATE_TIME]) {
     strUnion = [CommonFuncs strCat:_obj.create_time TwoStr:[CommonFuncs trimString:string]];
     _obj.create_time = strUnion;
     }else if([self.currentElementName isEqualToString:NEWS_COMMENT_CREATE_TIMEINSECONDS]){
     strUnion = [CommonFuncs strCat:_obj.time_inSeconds TwoStr:[CommonFuncs trimString:string]];
     _obj.time_inSeconds = strUnion;
     }
     [strUnion release];
     */
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock {
	
    if ([_currentElementName isEqualToString:app_logo]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        _obj.appLogo = trimString(content);
		[content release];
	}
    else if ([_currentElementName isEqualToString:app_name]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.appName = trimString(content);
		[content release];
	}
    else if ([_currentElementName isEqualToString:app_desc]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.appDesc = trimString(content);
		[content release];
	}
    else if ([_currentElementName isEqualToString:app_link]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.appLink = trimString(content);
		[content release];
	}
    else if ([_currentElementName isEqualToString:app_type]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.appType = trimString(content);
		[content release];
	}
    else if ([_currentElementName isEqualToString:app_order]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        NSString *temp = trimString(content);
        
        NSNumber *tempNumber = [[NSNumber alloc] initWithInt:[temp intValue]];
		_obj.apporder = tempNumber;
		[content release];
        [tempNumber release];
	}
    else if ([_currentElementName isEqualToString:app_id]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.appid = trimString(content);
		[content release];
	}else if ([_currentElementName isEqualToString:app_linkid]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.applinkid = trimString(content);
		[content release];
	}
    
}



- (void)executeFetchRequest:(NSFetchRequest *)request {
	NSError *error = nil;
	NSArray *resultSet = [self.managedObjectContext executeFetchRequest:request error:&error];
	if (!error) {
		NSMutableArray *tempResultSet = [[NSMutableArray alloc] initWithArray:resultSet];
		self.objectList = (NSMutableArray *)tempResultSet;
        NSLog(@"self.objectList:%d",[self.objectList count]);
		self.isRecordListTail = NO;
		[tempResultSet release];
        [self setBufferFlag];
	}
}


-(void)setBufferFlag{
    
    NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getAllObjectsSortByKey:[self entityName] key:@"appType" ascending:YES];
    
    for (FSRecommentAPPObject *o in array) {
        if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"2"]) {
            ;//o.bufferFlag = @"3";
        }else if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"1"]){
            o.bufferFlag = @"2";
        }
    }
    [self saveCoreDataContext];
}


-(void)setBufferFlag3{
    NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getAllObjectsSortByKey:[self entityName] key:@"appType" ascending:YES];
    
    for (FSRecommentAPPObject *o in array) {
        if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"2"]) {
            
            o.bufferFlag = @"3";
        }
    }
    [self saveCoreDataContext];
}

-(void)operateOldBufferData{
    if (self.currentGetDataKind == GET_DataKind_Refresh || self.currentGetDataKind == GET_DataKind_Unlimited) {
		
        if (_isRefreshToDeleteOldData == YES) {
            NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getAllObjectsSortByKey:[self entityName] key:@"appType" ascending:YES];
            for (FSRecommentAPPObject *o in array) {
                if ([o.bufferFlag isEqualToString:@"3"]) {
                    //[self.managedObjectContext deleteObject:o];
                    [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] deleteObjectByObject:o];
                    
                }
            }
            //[self saveCoreDataContext];
            
        }
	}
}

@end

