//
//  FSGetListDAO.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-23.
//
//

#import <Foundation/Foundation.h>
#import "FSGetDAO.h"

@interface FSGetListDAO : FSGetDAO {
@private
    NSFetchedResultsController *_fetchedResultsController;
}

@property (nonatomic, retain, readonly) NSFetchedResultsController *fetchedResultsController;

- (NSString *)sectionName;

- (NSString *)cacheName;

- (void)sortFieldName:(NSString **)fieldName ascending:(BOOL *)ascending;

- (NSUInteger)listLimited;

- (void)initializeBufferData;

@end
