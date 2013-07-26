//
//  FSDeepInvestigatePOSTDAO.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-6.
//
//

#import <Foundation/Foundation.h>
#import "FSPostDAO.h"

@interface FSDeepInvestigatePOSTDAO : FSPostDAO {
@private
    NSString *_investigateid;
    NSArray *_investigateOptions;
}

@property (nonatomic, retain) NSString *investigateid;
@property (nonatomic, retain) NSArray *investigateOptions;

@end
