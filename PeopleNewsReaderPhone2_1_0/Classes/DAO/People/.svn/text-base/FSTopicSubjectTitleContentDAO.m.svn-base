//
//  FSTopicSubjectTitleContentDAO.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-24.
//
//

#import "FSTopicSubjectTitleContentDAO.h"
#import "FSTopicSubjectContentObject.h"

#define FSTOPICSUBJECTTITLECONTENT_URL @"http://mobile.app.people.com.cn:81/news2/news.php?act=text&rt=xml&newsid=%@"

#define FSTOPICSUBJECTTITLECONTENT_ENTITYNODE @"root"

#define FSTOPICSUBJECTTITLECONTENT_ENTITYNAME @"FSTopicSubjectContentObject"

#define FSTOPICSUBJECTTITLECONTENT_PICENTITYNODE @"item"

@implementation FSTopicSubjectTitleContentDAO
@synthesize topic_newsid = _topic_newsid;

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (NSString *)entityName {
    return FSTOPICSUBJECTTITLECONTENT_ENTITYNAME;
}

- (void)GETData {
    dispatch_queue_t queue = dispatch_queue_create(NULL, NULL);
    dispatch_async(queue, ^(void) {
        static dispatch_once_t onceToken_TopicSubjectContent;
        dispatch_once(&onceToken_TopicSubjectContent, ^{
            [self readDataFromCoreData];
        });
        
        if (self.contentObject == nil) {
            [FSHTTPWebExData HTTPGetDataWithURLString:[NSString stringWithFormat:FSTOPICSUBJECTTITLECONTENT_URL, _topic_newsid]
                                      blockCompletion:^(NSData *data, BOOL success) {
                                          FSXMLParserObject *parserObj = [[FSXMLParserObject alloc] init];
                                          FSStoreObject *storeObj = [[FSStoreObject alloc] init];
                                          __block BOOL parserSuccess = NO;
                                          [parserObj parserData:data
                                                     completion:^(FSXMLParserResult result) {
                                                         if (result == FSXMLParserResult_Success) {
                                                             parserSuccess = YES;
                                                         }
                                                     }
                                           elementOperationFunc:^(NSString *elementName, NSString *parentElementName, NSDictionary *attributes, NSString *value, ElementOperationKind operationKind) {
                                               if (operationKind == ElementOperationKind_Begin) {
                                                   if ([elementName isEqualToString:FSTOPICSUBJECTTITLECONTENT_ENTITYNODE]) {
                                                       
                                                   } else if ([elementName isEqualToString:FSTOPICSUBJECTTITLECONTENT_PICENTITYNODE]) {
                                                       //pictures
                                                   }
                                               } else if (operationKind == ElementOperationKind_End) {
                                                   if ([parentElementName isEqualToString:FSTOPICSUBJECTTITLECONTENT_ENTITYNODE]) {
                                                       
                                                   } else if ([parentElementName isEqualToString:FSTOPICSUBJECTTITLECONTENT_PICENTITYNODE]) {
                                                       //picture
                                                       
                                                   }
                                               }
                                           }];
                                          
                                          [storeObj release];
                                          [parserObj release];
                                      }];
        }
    });
    dispatch_release(queue);
}

- (NSString *)contentPrimaryKeyName {
    return @"newsid";
}

- (NSObject *)contentPrimaryValue {
    return _topic_newsid;
}

@end
