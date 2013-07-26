//
//  FSCellContainerObject.h
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-22.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FSBaseObject.h"

typedef enum _CellListKind {
    CellListKind_ForOneDayChannelSetting,
    CellListKind_ForOneDayNewsList,
    CellListKind_ForWeatherNewsList,
    CellListKind_ForNewsList,
}CellListKind;

 
/*

@interface FSImageObject : FSBaseObject{
@protected
    NSString *_image_id;
	NSString *_image_name;
	NSString *_image_url;
    BOOL _isSelect;
    BOOL _canShowCover;
}
@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, assign) BOOL canShowCover;
@property (nonatomic, retain) NSString *image_id;
@property (nonatomic, retain) NSString *image_name;
@property (nonatomic, retain) NSString *image_url;
@end



@interface FSCellImagesObject : FSBaseObject{
@protected
    NSString *_channel_id;
	NSString *_channel_name;
	NSString *_channel_en;
	NSString *_channel_url;
    NSString *_news_id;
    NSString *_title;
    NSString *_descreption;
    NSString *_visitCount;
    NSString *_news_kind;
	NSMutableArray *_imagesArray;
    NSString *_cell_kind;
}

@property (nonatomic, retain) NSString *channel_id;
@property (nonatomic, retain) NSString *channel_name;
@property (nonatomic, retain) NSString *channel_en;
@property (nonatomic, retain) NSString *channel_url;
@property (nonatomic, retain) NSString *news_id;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *descreption;
@property (nonatomic, retain) NSString *visitCount;
@property (nonatomic, retain) NSString *news_kind;
@property (nonatomic, retain) NSMutableArray *imagesArray;
@property (nonatomic, retain) NSString *cell_kind;

@end
 
 */

@interface FSCellContainerObject : FSBaseObject {
@protected
    NSObject *_obj;
    NSMutableArray *_array;
    CellListKind _kind;
    
}

@property (nonatomic,retain) NSObject *obj;
@property (nonatomic,retain) NSMutableArray *array;
@property (nonatomic,assign) CellListKind kind;

@end



