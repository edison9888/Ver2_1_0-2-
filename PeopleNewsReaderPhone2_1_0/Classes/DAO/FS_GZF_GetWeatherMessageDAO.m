//
//  FS_GZF_GetWeatherMessageDAO.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-11-12.
//
//

/*
 <?xml version="1.0" encoding="utf-8" ?>
 <root>
 <cityname>北京</cityname>
 <update_date>北京时间03月18日08:00更新</update_date>
 <weathers>
 <weather>
 <day>0</day>
 <day_icon>http://mobile.app.people.com.cn:81/news/large_duoyun_0.png</day_icon>
 <day_tp>11℃</day_tp>
 <day_meteorology>多云</day_meteorology>
 <day_wind_direction>北风</day_wind_direction>
 <day_wind_power>3-4级</day_wind_power>
 <night_icon>http://mobile.app.people.com.cn:81/news/large_yin_1.png</night_icon>
 <night_tp>0℃</night_tp>
 <night_meteorology>阴</night_meteorology>
 <night_wind_direction>无持续风向</night_wind_direction>
 <night_wind_power>≤3级</night_wind_power>
 
 <day_mini_icon>http://mobile.app.people.com.cn:81/news/weatherpic/mini_ing_0.png</day_mini_icon>
 <night_mini_icon>http://mobile.app.people.com.cn:81/news/weatherpic/mini_iaoyu_1.png</night_mini_icon>
 </weather>
 
 <index>
 <title>污染物扩散条件</title>
 <value>一般</value>
 <desc>对空气污染物扩散无明显影响</desc>
 </index>
 
 */


#import "FS_GZF_GetWeatherMessageDAO.h"
#import "FSWeatherObject.h"
#import "FSUserSelectObject.h"


#define  WEATHER_WITH_IP @"http://mobile.app.people.com.cn:81/news2/news.php?act=weather_detail&rt=xml&cityname=%@"

#define  WEATHER_WITH_CITYID @"http://mobile.app.people.com.cn:81/news2/news.php?act=weather&rt=xml&cityid=%@"

#define  WEATHER_WITH_CITYNAME @"http://mobile.app.people.com.cn:81/news2/news.php?act=weather&rt=xml&cityname=%@"

#define fs_cityname @"cityname"
#define fs_update_date @"update_date"
#define fs_weather @"weather"
#define fs_day @"day"
#define fs_day_icon @"day_icon"
#define fs_day_tp @"day_tp"
#define fs_day_meteorology @"day_meteorology"
#define fs_day_wind_direction @"day_wind_direction"
#define fs_day_wind_power @"day_wind_power"
#define fs_night_icon @"night_icon"
#define fs_night_tp @"night_tp"
#define fs_night_meteorology @"night_meteorology"
#define fs_night_wind_direction @"night_wind_direction"
#define fs_night_wind_power @"night_wind_power"
#define fs_day_mini_icon @"day_mini_icon"
#define fs_night_mini_icon @"night_mini_icon"

#define fs_index @"index"
#define fs_title @"title"
#define fs_value @"value"
#define fs_desc @"desc"



@implementation FS_GZF_GetWeatherMessageDAO

@synthesize  group = _group;
@synthesize cityID = _cityID;

- (id)init {
	self = [super init];
	if (self) {
        _group = @"";
        _cityName = @"";
	}
    
	return self;
}

-(void)dealloc{
    [super dealloc];
}


- (NSString *)timestampFlag {
    NSString *flag = [NSString stringWithFormat:@"weather_%@",self.group];
    return flag;
}

-(NSString *)entityName{
    return @"FSWeatherObject";
}

-(NSTimeInterval)bufferDataExpireTimeInterval{
    return 60*60*1;
}


-(NSString *)readDataURLStringFromRemoteHostWithGETDataKind:(GET_DataKind)getDataKind{
   
    _cityName = @"";
    _UpdataDate = @"";
    NSString *url = [NSString stringWithFormat:@"%@&cityname=%@",WEATHER_WITH_IP,self.group];
    return [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //return WEATHER_WITH_IP;
}



-(NSString *)predicateStringWithQueryDataKind:(Query_DataKind)dataKind{
            
    return [NSString stringWithFormat:@"group='%@' AND bufferFlag!='3'",self.group];
        
    //return [NSString stringWithFormat:@"group='%@'",self.group];
    return nil;
}

- (void)initializeSortDescriptions:(NSMutableArray *)descriptions {
	[self addSortDescription:descriptions withSortFieldName:@"day" withAscending:YES];
}

#pragma mark -
#pragma mark NSCMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    _currentElementName = elementName;
	if ([_currentElementName isEqualToString:fs_weather]) {
        _obj = (FSWeatherObject *)[self insertNewObjectTomanagedObjectContext];
        _obj.group = self.group;
        _obj.updata_date = dateToString_YMD([NSDate dateWithTimeIntervalSinceNow:0.0f]);
        _obj.cityname = _cityName;
        _obj.updataMessage = _UpdataDate;
        _obj.bufferFlag = @"1";
    }
    
    if ([_currentElementName isEqualToString:fs_index]) {
        _Uobj = (FSUserSelectObject *)[self insertNewObjectTomanagedObjectContextN:@"FSUserSelectObject"];
        _Uobj.kind = [NSString stringWithFormat:@"weather_%@",self.group];
        _Uobj.bufferFlag = @"1";
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:fs_weather]) {
        
        //[self.objectList addObject:_obj];
        //[_obj release];
        //_obj = nil;
    }
    if ([elementName isEqualToString:fs_index]) {
        if ([_Uobj.keyValue1 length]==0) {
            [self.managedObjectContext deleteObject:_Uobj];
            _Uobj = nil;
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	//NSLog(@"foundCharacters:%@",string);
    
    
    NSString *strUnion = nil;
    if ([self.currentElementName isEqualToString:fs_cityname]) {
        strUnion = stringCat(_cityName, trimString(string));
        _cityName = strUnion;
    }else if([self.currentElementName isEqualToString:fs_update_date]){
        strUnion = stringCat(_UpdataDate, trimString(string));
        _UpdataDate = strUnion;
    }else if([self.currentElementName isEqualToString:fs_day]){
        strUnion = stringCat(_obj.day, trimString(string));
        _obj.day = strUnion;
    }else if([self.currentElementName isEqualToString:fs_day_icon]){
        strUnion = stringCat(_obj.day_icon, trimString(string));
        _obj.day_icon = strUnion;
    }else if([self.currentElementName isEqualToString:fs_day_mini_icon]){
        strUnion = stringCat(_obj.day_mini_icon, trimString(string));
        _obj.day_mini_icon = strUnion;
    }else if([self.currentElementName isEqualToString:fs_day_tp]){
        strUnion = stringCat(_obj.day_tp, trimString(string));
        _obj.day_tp = strUnion;
    }else if([self.currentElementName isEqualToString:fs_day_meteorology]){
        strUnion = stringCat(_obj.day_meteorology, trimString(string));
        _obj.day_meteorology = strUnion;
    }else if([self.currentElementName isEqualToString:fs_day_wind_direction]){
        strUnion = stringCat(_obj.day_wind_direction, trimString(string));
        _obj.day_wind_direction = strUnion;
    }else if([self.currentElementName isEqualToString:fs_day_wind_power]){
        strUnion = stringCat(_obj.day_wind_power, trimString(string));
        _obj.day_wind_power = strUnion;
    }else if([self.currentElementName isEqualToString:fs_night_icon]){
        strUnion = stringCat(_obj.night_icon, trimString(string));
        _obj.night_icon = strUnion;
    }else if([self.currentElementName isEqualToString:fs_night_mini_icon]){
        strUnion = stringCat(_obj.night_mini_icon, trimString(string));
        _obj.night_mini_icon = strUnion;
    }else if([self.currentElementName isEqualToString:fs_night_tp]){
        strUnion = stringCat(_obj.night_tp, trimString(string));
        _obj.night_tp = strUnion;
    }else if([self.currentElementName isEqualToString:fs_night_meteorology]){
        strUnion = stringCat(_obj.night_meteorology, trimString(string));
        _obj.night_meteorology = strUnion;
    }else if([self.currentElementName isEqualToString:fs_night_wind_direction]){
        strUnion = stringCat(_obj.night_wind_direction, trimString(string));
        _obj.night_wind_direction = strUnion;
    }else if([self.currentElementName isEqualToString:fs_night_wind_power]){
        strUnion = stringCat(_obj.night_wind_power, trimString(string));
        _obj.night_wind_power = strUnion;
    }else if([self.currentElementName isEqualToString:fs_title]){
        strUnion = stringCat(_Uobj.keyValue1, trimString(string));
        _Uobj.keyValue1 = strUnion;
    }else if([self.currentElementName isEqualToString:fs_value]){
        strUnion = stringCat(_Uobj.keyValue2, trimString(string));
        _Uobj.keyValue2 = strUnion;
    }else if([self.currentElementName isEqualToString:fs_desc]){
        strUnion = stringCat(_Uobj.keyValue3, trimString(string));
        _Uobj.keyValue3 = strUnion;
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock {
    
    ;
}


- (void)executeFetchRequest:(NSFetchRequest *)request {
	NSError *error = nil;
	NSArray *resultSet = [self.managedObjectContext executeFetchRequest:request error:&error];
	if (!error) {
        
		if ([resultSet count]>0) {
            //NSLog(@"[resultSet count]:%d",[resultSet count]);
            self.objectList = (NSMutableArray *)resultSet;
            self.isRecordListTail = [self.objectList count] < [self.fetchRequest fetchLimit];
            [self setBufferFlag];
        }
	}
}

-(void)setBufferFlag{
    
    NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:[self entityName] key:@"group" value:self.group];
    
    for (FSWeatherObject *o in array) {
        if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"2"]) {
            o.bufferFlag = @"3";
        }else if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"1"]){
            o.bufferFlag = @"2";
        }
    }
    
    NSArray *Uarray = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:@"FSUserSelectObject" key:@"kind" value:[NSString stringWithFormat:@"weather_%@",self.group]];
    
    for (FSUserSelectObject *o in Uarray) {
        if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"2"]) {
            o.bufferFlag = @"3";
        }else if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"1"]){
            o.bufferFlag = @"2";
        }
    }
    
    [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext].managedObjectContext save:nil];
}


-(void)operateOldBufferData{
    if (self.currentGetDataKind == GET_DataKind_Refresh) {
		
        NSInteger mark = 0;
        if (_isRefreshToDeleteOldData == YES) {
            NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:[self entityName] key:@"group" value:self.group];
            for (FSWeatherObject *o in array) {
                if ([o.bufferFlag isEqualToString:@"3"]) {
                    [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] deleteObjectByObject:o];
                    //[self.managedObjectContext deleteObject:o];
                    
                }
                else if(![o.updata_date isEqualToString:dateToString_YMD([NSDate dateWithTimeIntervalSinceNow:0.0f])]){
                    [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] deleteObjectByObject:o];
                    mark = 1;
                }
            }
            
            NSArray *Uarray = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:@"FSUserSelectObject" key:@"kind" value:[NSString stringWithFormat:@"weather_%@",self.group]];
            for (FSUserSelectObject *o in Uarray) {
                if ([o.bufferFlag isEqualToString:@"3"] || mark) {
                    [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] deleteObjectByObject:o];
                }
                
            }
            
        }
	}
}



@end
