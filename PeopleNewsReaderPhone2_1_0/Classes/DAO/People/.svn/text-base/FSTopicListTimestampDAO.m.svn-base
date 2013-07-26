//
//  FSTopicListTimestampDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-18.
//
//

#import "FSTopicListTimestampDAO.h"

/*
 20、深度（专题）列表
 地址
 http://mobile.app.people.com.cn:81/news2/topic.php?act=list&rt=xml&type=list&iswp=1
 参数说明：
 act:跳转url对应PHP地址，不可修改
 rt:返回文件格式,xml，不可修改
 type:获取类别，list或默认返回 主题列表，timestamp返回时间戳。根据具体应用调用。
 iswp:返回时间戳类别，可不传此参数。当type=timestamp时有效。 不填写返回为时间戳，1为返回日期
 */

#define TOPICLIST_TIMESTAMP_URL @"http://mobile.app.people.com.cn:81/news2/topic.php?act=list&rt=xml&type=timestamp"

@implementation FSTopicListTimestampDAO

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (NSString *)readDataURLStringFromRemoteHostWithGETDataKind:(GETDataKind)getDataKind {
    return TOPICLIST_TIMESTAMP_URL;
}

- (void)baseXMLParserFinishXMLObjectNode:(FSBaseXMLParserObject *)sender withXMLResultObject:(id)resultObject {
#ifdef MYDEBUG
    NSLog(@"topicList.timestamp:%@", resultObject);
#endif
}

@end
