//
//  FS_GZF_BaseGETXMLDataListDAO.h
//  PeopleNewsReaderPhone
//
//  Created by Xu dandan on 12-10-19.
//
//

#import <Foundation/Foundation.h>
#import "FS_GZF_BaseGETXMLDAO.h"

@interface FS_GZF_BaseGETXMLDataListDAO : FS_GZF_BaseGETXMLDAO{
@protected
	NSMutableArray *_objectList;
	
}

@property (nonatomic, retain) NSMutableArray *objectList;

-(NSObject *)insertNewObjectTomanagedObjectContext;

-(NSObject *)insertNewObjectTomanagedObjectContextN:(NSString *)name;


@end
