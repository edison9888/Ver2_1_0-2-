//
//  FS_GZF_PeopleBlogSharePOSTXMLDAO.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-11-9.
//
//

#import <Foundation/Foundation.h>
#import "FS_GZF_BasePOSTXMLDAO.h"

@interface FS_GZF_PeopleBlogSharePOSTXMLDAO : FS_GZF_BasePOSTXMLDAO{
@protected
    NSData *_imagedata;
    NSString *_username;
    NSString *_userpassword;
    NSString *_message;
    NSString *_result;
    NSString *_userid;
}

@property (nonatomic,retain) NSString *message;

@property (nonatomic,retain) NSData *imagedata;

-(void)getUserMessage;

@end
