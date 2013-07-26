//
//  FS_GZF_CommentListDAO.h
//  PeopleNewsReaderPhone
//
//  Created by Xu dandan on 12-11-1.
//
//

#import <Foundation/Foundation.h>
#import "FS_GZF_BaseGETXMLDataListDAO.h"


@class FSCommentObject;


@interface FS_GZF_CommentListDAO : FS_GZF_BaseGETXMLDataListDAO{
@protected
    FSCommentObject *_obj;
    
    NSString *_count;
    NSString *_newsid;
    NSString *_lastCommentid;
}

@property (nonatomic,retain) NSString *count;
@property (nonatomic,retain) NSString *newsid;
@property (nonatomic,retain) NSString *lastCommentid;

@end
