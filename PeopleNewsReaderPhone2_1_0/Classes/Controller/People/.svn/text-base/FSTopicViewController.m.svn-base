    //
//  FSTopicViewController.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-13.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSTopicViewController.h"

#import "FSTopicObject.h"
#import "FSTopicListDAO.h"

#import "FS_GZF_DeepListDAO.h"

#import "FSDeepPageContainerController.h"

#define FLOATTING_HEIGHT 52.0f

#define FSLEFT_RIGHT_SPACE 38.0f

@interface FSTopicViewController()
- (void)ownerPicture;
- (void)ownerNonPicture;
@end

@implementation FSTopicViewController


- (id)init {
	self = [super init];
	if (self) {
        NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
        _TimeInterval = [date timeIntervalSince1970];
		[date release];
	}
	return self;
}

- (void)dealloc {
    [_scrollPageView release];
    [_deepFloattingTitleView release];
    [_fs_GZF_DeepListDAO release];
    [super dealloc];
}

- (void)ownerPicture {
    //有图模式
    _scrollPageView = [[FSScrollPageView alloc] initWithFrame:CGRectMake(FSLEFT_RIGHT_SPACE, 20.0f, self.view.frame.size.width - FSLEFT_RIGHT_SPACE * 2.0f, self.view.frame.size.height-40)];
    _scrollPageView.parentDelegate = self;
    _scrollPageView.clipsToBounds = NO;
    _scrollPageView.leftRightSpace = 10.0f;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [_scrollPageView addGestureRecognizer:tapGes];
    [tapGes release];
    
    [self.view addSubview:_scrollPageView];
    
    _deepFloattingTitleView = [[FSDeepFloatingTitleView alloc] initWithFrame:CGRectMake(0.0f, self.view.frame.size.height - FLOATTING_HEIGHT-20, self.view.frame.size.width, FLOATTING_HEIGHT)];
    //_deepFloattingTitleView.backgroundColor = [UIColor whiteColor];
    
    if ([UIScreen mainScreen].applicationFrame.size.height>480.0f) {
        [self.view addSubview:_deepFloattingTitleView];
    }

}

- (void)ownerNonPicture {
    
}

- (void)loadChildView {
	[super loadChildView];
    
    self.view.backgroundColor = COLOR_NEWSLIST_TITLE_WHITE;

//    _ivBackground = [[UIImageView alloc] initWithFrame:CGRectZero];
//    _ivBackground.image = [UIImage imageNamed:@"Deep_listbeijing2222.png"];
//    [self.view addSubview:_ivBackground];
    
    
    BOOL hasPicture = [[GlobalConfig shareConfig] isDownloadPictureUseing2G_3G];
    if (!hasPicture && checkNetworkIsOnlyMobile()) {
        [self ownerNonPicture];
    } else {
        [self ownerPicture];
    }
	
	//标签栏设置
	//[self.fsTabBarItem setTabBarItemWithNormalImage:[UIImage imageNamed:@"deepSubject.png"] withSelectedImage:[UIImage imageNamed:@"deepSubject.png"] withText:NSLocalizedString(@"深度", nil)];
}

-(void)initDataModel{
//    _topicListData = [[FSTopicListDAO alloc] init];
//    _topicListData.parentDelegate = self;
    
    _fs_GZF_DeepListDAO = [[FS_GZF_DeepListDAO alloc] init];
    _fs_GZF_DeepListDAO.parentDelegate = self;
}

-(void)doSomethingForViewFirstTimeShow{
   // NSLog(@"doSomethingForViewFirstTimeShow:%@",self);
    //[_fs_GZF_DeepListDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
    //[_topicListData GETData];
}

- (void)layoutControllerViewWithInterfaceOrientation:(UIInterfaceOrientation)willToOrientation {
	[super layoutControllerViewWithInterfaceOrientation:willToOrientation];
	//NSLog(@"layoutControllerViewWithInterfaceOrientation 111");
    
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    NSTimeInterval currentTimeInterval = [date timeIntervalSince1970];
    [date release];
    
    if ([_fs_GZF_DeepListDAO.objectList count] == 0 || currentTimeInterval - _TimeInterval>60*2) {
        NSLog(@"刷新1111");
        _TimeInterval = currentTimeInterval;
        [_fs_GZF_DeepListDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
    }
    else{
        NSLog(@"时间过短");
        //[_scrollPageView loadPageData];
    }
    [self updataWeatherMessage];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
}

-(void)viewDidDisappear:(BOOL)animated{
   
    
}

- (UIImage *)tabBarItemNormalImage {
	return [UIImage imageNamed:@"deep.png"];
}

- (NSString *)tabBarItemText {
	return NSLocalizedString(@"深度", nil);
}

- (UIImage *)tabBarItemSelectedImage {
	return [UIImage imageNamed:@"deep_sel.png"];
}

- (void)layoutControllerViewWithRect:(CGRect)rect {
    
//    NSLog(@"layoutControllerViewWithRect11:%@",self);
//    _ivBackground.frame = CGRectMake(0.0f, 0.0f, rect.size.width, rect.size.height);
    
    if (rect.size.height>450) {
         _scrollPageView.frame = CGRectMake(FSLEFT_RIGHT_SPACE, 25.0f, rect.size.width - FSLEFT_RIGHT_SPACE * 2.0f, (rect.size.width - FSLEFT_RIGHT_SPACE * 2.0f)/2*3-18);
    }
    else{
         _scrollPageView.frame = CGRectMake(FSLEFT_RIGHT_SPACE, 10.0f, rect.size.width - FSLEFT_RIGHT_SPACE * 2.0f, (rect.size.width - FSLEFT_RIGHT_SPACE * 2.0f)/2*3-18);
    }
   
    //NSLog(@"layoutControllerViewWithRect:%f  h:%f",_scrollPageView.frame.size.width,rect.size.height);
    _deepFloattingTitleView.frame= CGRectMake(FSLEFT_RIGHT_SPACE+12, 18.0f + _scrollPageView.frame.size.height, rect.size.width - FSLEFT_RIGHT_SPACE * 2.0f -24,rect.size.height- 18.0f - _scrollPageView.frame.size.height);
}


#pragma mark -
-(void)doSomethingWithDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status{
//    if ([sender isEqual:_topicListData]) {
//        if (status == FSBaseDAOCallBack_SuccessfulStatus || status == FSBaseDAOCallBack_BufferSuccessfulStatus) {
//#ifdef MYDEBUG
//            id <NSFetchedResultsSectionInfo> sectionInfo = [[_topicListData.fetchedResultsController sections] objectAtIndex:0];
//            NSLog(@"Deep.section.count:%d", [sectionInfo numberOfObjects]);
//            
//#endif
//            [_scrollPageView loadPageData];
//        }
//    }
    
    if ([sender isEqual:_fs_GZF_DeepListDAO]) {
        if (status == FSBaseDAOCallBack_SuccessfulStatus || status == FSBaseDAOCallBack_BufferSuccessfulStatus) {
            NSLog(@"_fs_GZF_DeepListDAO:%d",[_fs_GZF_DeepListDAO.objectList count]);
            
            [_scrollPageView loadPageData];
            
            if (status == FSBaseDAOCallBack_SuccessfulStatus) {
                [_fs_GZF_DeepListDAO operateOldBufferData];
            }
            
        }
    }
}

- (void)handleGesture:(UIGestureRecognizer *)gest {
    if ([gest isKindOfClass:[UITapGestureRecognizer class]]) {
        CGPoint pt = [gest locationInView:_scrollPageView];
        UIView *touchView = [_scrollPageView hitTest:pt withEvent:nil];
        if ([touchView isKindOfClass:[FSDeepView class]]) {
            FSDeepView *deepView = (FSDeepView *)touchView;

            //FSTopicObject *topicObj = [_topicListData.fetchedResultsController objectAtIndexPath:deepView.indexPath];
            if ([_fs_GZF_DeepListDAO.objectList count]>[deepView.indexPath row]) {
                FSTopicObject *topicObj = [_fs_GZF_DeepListDAO.objectList objectAtIndex:[deepView.indexPath row]];
                //FSTopicListViewController *topicListCtrl = [[FSTopicListViewController alloc] init];
#ifdef  MYDEBUG
                //NSLog(@"indexPath.touch:%@", topicObj.deepid);
                
#endif
                FSDeepPageContainerController *pageContainerCtrl = [[FSDeepPageContainerController alloc] init];
                pageContainerCtrl.deepid = topicObj.deepid;
                pageContainerCtrl.Deep_title = topicObj.title;
                [self.navigationController pushViewController:pageContainerCtrl animated:YES];
                [pageContainerCtrl release];
            }
           
        }
        //UIView *touchView = [gest ];
        //[gest ];
    }
}

#pragma -
#pragma FSScrollPageViewDelegate
//返回页数
- (NSInteger)pageCountInScrollPageView:(FSScrollPageView *)sender {
    NSInteger result = 0;
//    NSArray *sections = [_topicListData.fetchedResultsController sections];
//    if ([sections count] > 0) {
//        id <NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:0];
//        result = [sectionInfo numberOfObjects];
//    }
    
    result = [_fs_GZF_DeepListDAO.objectList count];
    
    return result;
}
//每页的视图元类
- (Class)pageViewClassForScrollPageView:(FSScrollPageView *)sender {
    return [FSDeepView class];
}
//可选的填充页视图的代理方法
- (void)fillPageViewInScrollPageView:(FSScrollPageView *)sender withPageView:(UIView *)pageView withCurrentPageNumber:(NSInteger)currentPageNumber {
    if ([pageView isKindOfClass:[FSDeepView class]]) {
        FSDeepView *deepView = (FSDeepView *)pageView;
        NSIndexPath *indexPath = [sender indexPathWithPageNumber:currentPageNumber];
        deepView.indexPath = indexPath;
        
        //FSTopicObject *topicObject = [_topicListData.fetchedResultsController objectAtIndexPath:indexPath];
        if ([_fs_GZF_DeepListDAO.objectList count]>currentPageNumber) {
            FSTopicObject *topicObject = [_fs_GZF_DeepListDAO.objectList objectAtIndex:currentPageNumber];
            // NSLog(@"topicObject:%@",topicObject);
            deepView.deep_Title = topicObject.title;
            [deepView setPictureURL:topicObject.pictureLink];
        }
        
        
//        NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:[topicObject.timestamp doubleValue]];
//        [_deepFloattingTitleView setTitle:topicObject.title withDateTime:dateToString_YMD(date)];
//        [date release];
    }
}

- (void)pageViewDidSelected:(FSScrollPageView *)sender withPageView:(UIView *)pageView withPageNum:(NSInteger)pageNum {
    //NSIndexPath *indexPath = [sender indexPathWithPageNumber:pageNum];
    
    //FSTopicObject *topicObject = [_topicListData.fetchedResultsController objectAtIndexPath:indexPath];
    
    if ([_fs_GZF_DeepListDAO.objectList count]>pageNum) {
        FSTopicObject *topicObject = [_fs_GZF_DeepListDAO.objectList objectAtIndex:pageNum];
        
        NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:[topicObject.timestamp doubleValue]];
        [_deepFloattingTitleView setTitle:topicObject.title withDateTime:dateToString_YMD(date)];
        [date release];
    }
   
}

- (void)releasePageViewFromScrollPageView:(FSScrollPageView *)sender withPageView:(UIView *)pageView withCurrentPageNumber:(NSInteger)currentPageNumber {
    
}

@end
