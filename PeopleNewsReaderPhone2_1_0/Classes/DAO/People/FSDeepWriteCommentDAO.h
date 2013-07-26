//
//  FSDeepWriteCommentDAO.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-6.
//
//

#import <Foundation/Foundation.h>
#import "FSPostDAO.h"

@interface FSDeepWriteCommentDAO : FSPostDAO {
@private
    NSString *_deepid;
    NSString *_commentMsg;
    NSString *_commentid;
    NSString *_pubDateTime;
    NSTimeInterval _lastTimestamp;
    NSInteger _totalCount;
}

@property (nonatomic, retain) NSString *deepid;
@property (nonatomic, retain) NSString *commentMsg;
@property (nonatomic, retain) NSString *commentid;
@property (nonatomic, retain) NSString *pubDateTime;
@property (nonatomic) NSTimeInterval lastTimestamp;
@property (nonatomic) NSInteger totalCount;

@end
