//
//  FS_GZF_ForLoadingImageDAO.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-3-5.
//
//

#import "FS_GZF_ForLoadingImageDAO.h"
#import "FSLoadingImageObject.h"

#define DEEPPICTURE_IMAGESIZE_4 @"640/940"
#define DEEPPICTURE_IMAGESIZE_5 @"640/1136"


#define FSLOADING_IMAGEVIEW_URL @"http://mobile.app.people.com.cn:81/paper_ipad/paper.php?act=headpic&type=4&&count=5&resolution=%@"




#define Loading_item @"ITEM"
#define Loading_newsid @"NSID"
#define Loading_title @"TITLE"
#define Loading_browserCount @"browserCount"
#define Loading_type @"type"
#define Loading_channelid @"channelid"
#define Loading_timestamp @"NSDATE"
#define Loading_picture @"PICURL"
#define Loading_link @"LINK"
#define Loading_flag @"FLAG"


@implementation FS_GZF_ForLoadingImageDAO


- (id)init {
	self = [super init];
	if (self) {
	}
    
	return self;
}

-(void)dealloc{
    [super dealloc];
}


- (NSString *)timestampFlag {
    NSString *flag = [NSString stringWithFormat:@"LoadingImage"];
    return flag;
}

-(NSString *)entityName{
    return @"FSLoadingImageObject";
}


-(NSTimeInterval)bufferDataExpireTimeInterval{
    return 60*10;
    
}



-(NSString *)readDataURLStringFromRemoteHostWithGETDataKind:(GET_DataKind)getDataKind{
    NSString *_url;
    if (ISIPHONE5) {
        _url = [NSString stringWithFormat:FSLOADING_IMAGEVIEW_URL,@"640x1136"];
    }
    else{
        _url = [NSString stringWithFormat:FSLOADING_IMAGEVIEW_URL,@"640x960"];
    }
    
    return _url;
}










-(NSString *)predicateStringWithQueryDataKind:(Query_DataKind)dataKind{
    
    return [NSString stringWithFormat:@"bufferFlag!='3'"];
    
}


- (void)initializeSortDescriptions:(NSMutableArray *)descriptions {
	[self addSortDescription:descriptions withSortFieldName:@"newsid" withAscending:NO];
}

#pragma mark -
#pragma mark NSCMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    _currentElementName = elementName;
	if ([_currentElementName isEqualToString:Loading_item]) {
        _obj = (FSLoadingImageObject *)[self insertNewObjectTomanagedObjectContext];
        _obj.bufferFlag = @"1";
        
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:Loading_item]) {

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
    
    if ([_currentElementName isEqualToString:Loading_newsid]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        _obj.newsid = trimString(content);;
		[content release];
	} else if ([_currentElementName isEqualToString:Loading_title]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.title = trimString(content);
		[content release];
        
	}
    else if ([_currentElementName isEqualToString:Loading_browserCount]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		NSString *temp = trimString(content);
        NSNumber *tempNumber = [[NSNumber alloc] initWithInt:[temp intValue]];
        _obj.browserCount = tempNumber;
		[content release];
        [tempNumber release];
	}
    else if ([_currentElementName isEqualToString:Loading_type]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.type = trimString(content);
		[content release];
	}
    else if ([_currentElementName isEqualToString:Loading_channelid]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.channelid = trimString(content);
		[content release];
	}
    else if ([_currentElementName isEqualToString:Loading_timestamp]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        NSString *temp = trimString(content);
        NSNumber *tempNumber = [[NSNumber alloc] initWithInt:[temp intValue]];
		_obj.timestamp = tempNumber;
		[content release];
        [tempNumber release];
	}
    else if ([_currentElementName isEqualToString:Loading_picture]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        
       // NSString *picURL = [trimString(content) stringByReplacingOccurrencesOfString:DEEPPICTURE_IMAGESIZE_OLD withString:DEEPPICTURE_IMAGESIZE];
        
		_obj.picture = content;
		[content release];
	}
    else if ([_currentElementName isEqualToString:Loading_link]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.link = trimString(content);
		[content release];
	}
    else if ([_currentElementName isEqualToString:Loading_flag]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.flag = trimString(content);
		[content release];
	}
}




- (void)executeFetchRequest:(NSFetchRequest *)request {
	NSError *error = nil;
	NSArray *resultSet = [self.managedObjectContext executeFetchRequest:request error:&error];
	if (!error) {
        
		if ([resultSet count]>0) {
            //NSLog(@"loading[resultSet count]:%d",[resultSet count]);
            self.objectList = (NSMutableArray *)resultSet;
            self.isRecordListTail = [self.objectList count] < [self.fetchRequest fetchLimit];
            [self setBufferFlag];
            [[NSNotificationCenter defaultCenter] postNotificationName:LOADINGIMAGE_LOADING_XML_COMPELECT object:nil];
        }
	}
}

-(void)setBufferFlag{
    
    NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getAllObjectsSortByKey:[self entityName] key:nil ascending:YES];
    
    if (self.currentGetDataKind == GET_DataKind_Next){
        for (FSLoadingImageObject *o in array) {
            if ([o.bufferFlag isEqualToString:@"1"]) {
                o.bufferFlag = @"2";
            }
        }
        [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext].managedObjectContext save:nil];
        return;
    }
    
    for (FSLoadingImageObject *o in array) {
        if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"2"]) {
            ;//o.bufferFlag = @"3";
        }else if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"1"]){
            o.bufferFlag = @"2";
        }
    }
    [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext].managedObjectContext save:nil];
}


-(void)setBufferFlag3{
    NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getAllObjectsSortByKey:[self entityName] key:nil ascending:YES];
    
        
    for (FSLoadingImageObject *o in array) {
        if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"2"]) {
            o.bufferFlag = @"3";
        }
    }
    [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext].managedObjectContext save:nil];
}



-(void)operateOldBufferData{
    if (self.currentGetDataKind == GET_DataKind_Refresh) {
		
        if (_isRefreshToDeleteOldData == YES) {
            NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getAllObjectsSortByKey:[self entityName] key:nil ascending:YES];
            for (FSLoadingImageObject *o in array) {
                if ([o.bufferFlag isEqualToString:@"3"]) {
                    [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] deleteObjectByObject:o];
                    //[self.managedObjectContext deleteObject:o];
                    
                }
            }
            //[self saveCoreDataContext];
            
        }
	}
}


@end
