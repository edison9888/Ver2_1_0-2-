//
//  FS_GZF_NewsContainerDAO.h
//  PeopleNewsReaderPhone
//
//  Created by Xu dandan on 12-10-25.
//
//

#import <Foundation/Foundation.h>
#import "FS_GZF_BaseGETDitailDAO.h"

typedef enum _NewsSourceKind{
    NewsSourceKind_ShiKeNews = 0,
    NewsSourceKind_PuTongNews,
    NewsSourceKind_DiFangNews,
    NewsSourceKind_PushNews
} NewsSourceKind;


@class FSNewsDitailObject,FSNewsDitailPicObject;


@interface FS_GZF_NewsContainerDAO : FS_GZF_BaseGETDitailDAO{
@protected
    FSNewsDitailObject *_cobj;
    FSNewsDitailPicObject *_pobj;
    NSInteger _picCount;
    NSString *_newsid;
    NewsSourceKind _newsSourceKind;
}

@property (nonatomic,retain) FSNewsDitailObject *cobj;
@property (nonatomic,retain) FSNewsDitailPicObject *pobj;
@property (nonatomic,retain) NSString *newsid;
@property (nonatomic,assign) NewsSourceKind newsSourceKind;

@end
