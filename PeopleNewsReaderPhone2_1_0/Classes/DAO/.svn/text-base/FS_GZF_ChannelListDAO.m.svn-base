//
//  FS_GZF_ChannelListDAO.m
//  PeopleNewsReaderPhone
//
//  Created by Xu dandan on 12-10-28.
//
//

/*
<item>
<channelid>diqu</channelid>
<channelname><![CDATA[时政]]></channelname>
<channelpics>
<channel_normal><![CDATA[http://mobile.app.peonormal/1_6.png]]></channel_normal>
<channel_highlight><![CDATA[http://mobile.app.peopghlight/1_6.png]]></channel_highlight>
<channel_selected><![CDATA[http://mobile.app.people.cted/1_6.png]]></channel_selected>
 </channelpics>
<channel_request><![CDATA[http://mobile.app.people.com.cn=1_6]]></channel_request>
</item>
*/



#import "FS_GZF_ChannelListDAO.h"
#import "FSChannelObject.h"

#define CHANNEL_LIST_URL @"http://mobile.app.people.com.cn:81/news2/news.php?act=channellist&rt=xml&type=%@"



#define channellist_item @"item"
#define channellist_channelid @"channelid"
#define channellist_channelname @"channelname"
#define channellist_index @"index"
#define channellist_channel_normal @"channel_normal"
#define channellist_channel_highlight @"channel_highlight"
#define channellist_channel_selected @"channel_selected"
#define channellist_channel_request @"channel_request"


@implementation FS_GZF_ChannelListDAO

@synthesize type = _type;


- (id)init {
	self = [super init];
	if (self) {
		
	}
	return self;
}

- (void)dealloc {
	
	[super dealloc];
}

- (NSString *)readDataURLStringFromRemoteHostWithGETDataKind:(GET_DataKind)getDataKind {
    NSString *urlString = [NSString stringWithFormat:CHANNEL_LIST_URL,self.type];
	return urlString;
}

- (NSTimeInterval)bufferDataExpireTimeInterval {
	return 60 * 30;
}

//查询数据
- (NSString *)predicateStringWithQueryDataKind:(Query_DataKind)dataKind {
    return [NSString stringWithFormat:@"type='%@' AND bufferFlag!='3'", self.type];
}



- (NSString *)entityName {
	return @"FSChannelObject";
}

- (NSString *)timestampFlag {
    return [NSString stringWithFormat:@"channel_list_%@", self.type];
    return @"channel_list";
}

- (void)initializeSortDescriptions:(NSMutableArray *)descriptions {
	[self addSortDescription:descriptions withSortFieldName:@"channelindex" withAscending:YES];
}



#pragma mark -
#pragma mark NSCMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    _currentElementName = elementName;
	if ([_currentElementName isEqualToString:channellist_item]) {
        _obj = (FSChannelObject *)[self insertNewObjectTomanagedObjectContext];
        _obj.type = self.type;
        _obj.bufferFlag = @"1";
        
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
	if ([elementName isEqualToString:channellist_item]) {
        
        //[_objectList addObject:_obj];
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
    
    if ([_currentElementName isEqualToString:channellist_channelid]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        _obj.channelid = content;
		[content release];
	} else if ([_currentElementName isEqualToString:channellist_channelname]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.channelname = trimString(content);
        //NSLog(@"_obj.channelname:%@",_obj.channelname);
		[content release];
	}else if ([_currentElementName isEqualToString:channellist_index]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        NSString *temp = trimString(content);
        NSNumber *tempNumber = [[NSNumber alloc] initWithInt:[temp intValue]];
		_obj.channelindex = tempNumber;
        //NSLog(@"_obj.channelindex:%d",[_obj.channelindex intValue]);
		[content release];
        [tempNumber release];
	}
    else if ([_currentElementName isEqualToString:channellist_channel_normal]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.channel_normal = trimString(content);
		[content release];
	}
    else if ([_currentElementName isEqualToString:channellist_channel_highlight]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.channel_highlight = trimString(content);
		[content release];
	}
    else if ([_currentElementName isEqualToString:channellist_channel_selected]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.channel_selected = trimString(content);
		[content release];
	}
    else if ([_currentElementName isEqualToString:channellist_channel_request]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.channel_request = trimString(content);
		[content release];
	}
    
}


- (void)executeFetchRequest:(NSFetchRequest *)request {
	NSError *error = nil;
	NSArray *resultSet = [self.managedObjectContext executeFetchRequest:request error:&error];
	if (!error) {
        
		if ([resultSet count]>0) {
            //NSLog(@"[resultSet count]:%d",[resultSet count]);
            NSMutableArray *idArray = [[NSMutableArray alloc] init];
            NSMutableArray *ChannelObjectArray = [[NSMutableArray alloc] init];
            NSInteger mark = 0;
            for (FSChannelObject *o in resultSet) {
                mark = 0;
                for (NSString *channelid in idArray) {
                    if ([channelid isEqualToString:o.channelid]) {
                        mark = 1;
                        break;
                    }
                }
                if (mark == 0) {
                    [ChannelObjectArray addObject:o];
                    [idArray addObject:o.channelid];
                }
            }

            self.objectList = ChannelObjectArray;//(NSMutableArray *)resultSet;
            self.isRecordListTail = [self.objectList count] < [self.fetchRequest fetchLimit];
            [self setBufferFlag];
            [ChannelObjectArray release];
            [idArray release];
        }
	}
}

-(void)setBufferFlag{
    
   NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:[self entityName] key:@"type" value:self.type];
    
    if (self.currentGetDataKind == GET_DataKind_Next){
        for (FSChannelObject *o in array) {
            if ([o.bufferFlag isEqualToString:@"1"]) {
                o.bufferFlag = @"2";
            }
        }
        [self saveCoreDataContext];
        return;
    }
   
    for (FSChannelObject *o in array) {
        if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"2"]) {
            ;//o.bufferFlag = @"3";
        }else if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"1"]){
            o.bufferFlag = @"2";
        }
    }
    [self saveCoreDataContext];
}


-(void)setBufferFlag3{
    NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:[self entityName] key:@"type" value:self.type];
    
    for (FSChannelObject *o in array) {
        if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"2"]) {
            o.bufferFlag = @"3";
        }
    }
    [self saveCoreDataContext];
}

-(void)operateOldBufferData{
    if (self.currentGetDataKind == GET_DataKind_Refresh) {
		
        if (_isRefreshToDeleteOldData == YES) {
            NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:[self entityName] key:@"type" value:self.type];
            for (FSChannelObject *o in array) {
                if ([o.bufferFlag isEqualToString:@"3"]) {
                    [self.managedObjectContext deleteObject:o];
                    
                }
            }
            [self saveCoreDataContext];
            
        }
	}
}

@end
