//
//  FS_GZF_ForNewsListDAO.h
//  PeopleNewsReaderPhone
//
//  Created by Xu dandan on 12-11-5.
//
//

#import <Foundation/Foundation.h>
#import "FS_GZF_ForOneDayNewsListDAO.h"



@interface FS_GZF_ForNewsListDAO : FS_GZF_ForOneDayNewsListDAO{
@protected
    NSString *_channelid;
}


@property (nonatomic,retain) NSString *channelid;



@end
