//
//  FS_GZF_PushTokenPOSTXMLDAO.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-3-26.
//
//

#import <Foundation/Foundation.h>
#import "FS_GZF_BasePOSTXMLDAO.h"

@interface FS_GZF_PushTokenPOSTXMLDAO : FS_GZF_BasePOSTXMLDAO{
    NSString *_token;
}


@property (nonatomic,retain) NSString *token;


@end
