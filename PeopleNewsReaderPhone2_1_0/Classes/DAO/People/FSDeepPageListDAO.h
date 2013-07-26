//
//  FSDeepPageListDAO.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-2.
//
//

#import <Foundation/Foundation.h>
#import "FSGetListDAO.h"

@interface FSDeepPageListDAO : FSGetListDAO {
@private
    NSString *_deepid;
}

@property (nonatomic, retain) NSString *deepid;

@end
