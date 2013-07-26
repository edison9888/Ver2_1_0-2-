//
//  FSLocalNewsCityListController.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-14.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSLocalNewsCityListController.h"
#import "FSCityObject.h"

#import "FSUserSelectObject.h"
#import "FSBaseDB.h"


#define FSSETTING_VIEW_NAVBAR_HEIGHT 44.0f
#define KIND_CITY_SELECTED @"KIND_CITY_SELECTED"

@implementation FSLocalNewsCityListController

@synthesize cityName = _cityName;
@synthesize localCity = _localCity;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;   
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/


-(void)dealloc{
    NSLog(@"dealloc:%@",self);
    [_localNewsCityListView release];
    [_titleView release];
    [_navTopBar release];
    _fsCityListData.parentDelegate = NULL;
    [_fsCityListData release];
    [_sectionArrary removeAllObjects];
    [_sectionArrary release];
    [_sectionNumberArrary removeAllObjects];
    [_sectionNumberArrary release];
    [super dealloc];
}


-(void)loadChildView{
    
    _titleView = [[FSTitleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    _titleView.hidRefreshBt = YES;
    _titleView.toBottom = YES;
    _titleView.parentDelegate = self;
    _navTopBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, FSSETTING_VIEW_NAVBAR_HEIGHT)];
#ifdef __IPHONE_5_0
    [_navTopBar setBackgroundImage:[UIImage imageNamed: @"navigatorBar.png"] forBarMetrics:UIBarMetricsDefault];
#endif
    [_navTopBar addSubview:_titleView];
    //[_titleView reSetFrame];
    
    UIButton *returnBT = [[UIButton alloc] init];
    [returnBT setBackgroundImage:[UIImage imageNamed:@"returnbackBT.png"] forState:UIControlStateNormal];
    [returnBT addTarget:self action:@selector(returnBack:) forControlEvents:UIControlEventTouchUpInside];
    returnBT.frame = CGRectMake(0, (FSSETTING_VIEW_NAVBAR_HEIGHT-34)/2, 65, 34);
    
    [_navTopBar addSubview:returnBT];
    [returnBT release];
    
    
    _titleView.data = self.cityName;
	[self.view addSubview:_navTopBar];
    
    _localNewsCityListView = [[FSLocalNewsCityListView alloc] init];
    _localNewsCityListView.parentDelegate = self;
    [self.view addSubview:_localNewsCityListView];
}

-(void)initDataModel{
    _fsCityListData = [[FS_GZF_CityListDAO alloc] init];
    _fsCityListData.parentDelegate = self;
    _sectionArrary = [[NSMutableArray alloc] init];
    _sectionNumberArrary = [[NSMutableArray alloc] init];
}


-(void)layoutControllerViewWithRect:(CGRect)rect{
    _localNewsCityListView.frame = CGRectMake(0, 44, rect.size.width, rect.size.height-44);
    [_fsCityListData HTTPGetDataWithKind:GET_DataKind_Unlimited];
}

-(void)returnBack:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//    NSInteger k = [self retainCount];
//    for (NSInteger i=0; i<k-1; i++) {
//        [self release];
//    }
    NSLog(@"%@.viewDidDisappear:%d",self,[self retainCount]);
}




#pragma mark - 
#pragma FSTableContainerViewDelegate mark


-(NSInteger)tableViewSectionNumber:(FSTableContainerView *)sender{
    return [_sectionArrary count]+1;
}

-(NSInteger)tableViewNumberInSection:(FSTableContainerView *)sender section:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    if (section-1<[_sectionNumberArrary count]) {
        NSInteger numb = [[_sectionNumberArrary objectAtIndex:section-1] integerValue];
        return numb;
    }
    return 0;
    
}

-(NSString *)tableViewSectionTitle:(FSTableContainerView *)sender section:(NSInteger)section{
    if (section == 0) {
        return  @"您当前的位置可能是";
    }
    if (section-1<[_sectionArrary count]) {
        NSString *kind = [_sectionArrary objectAtIndex:section-1];
        return kind;
    }
    return @"";
}

-(NSObject *)tableViewCellData:(FSTableContainerView *)sender withIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    
    if (section ==0) {
        if ([self.localCity length]==0) {
            return [NSString stringWithFormat:@"未知位置"];
        }
        return self.localCity;
    }
    
    NSInteger index = 0;
    
    for (int i=0; i<section-1; i++) {
        index = index+[[_sectionNumberArrary objectAtIndex:i] integerValue];
    }
    index = index + row;
    FSCityObject *o = [_fsCityListData.objectList objectAtIndex:index];
    return o.cityName;
}


-(void)tableViewDataSourceDidSelected:(FSTableContainerView *)sender withIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    if (section ==0) {
        NSMutableDictionary *obj = [[NSMutableDictionary alloc] init];
        [obj setObject:self.localCity forKey:NSNOTIF_LOCALNEWSLIST_CITYSELECTED_KEY];
        [[NSNotificationCenter defaultCenter] postNotificationName:NSNOTIF_LOCALNEWSLIST_CITYSELECTED object:self userInfo:obj];
        [obj release];
        
        //NSLog(@"dismissModalViewControllerAnimated 11112222");
        
        [self dismissModalViewControllerAnimated:YES];
        return;
    }
    
    NSInteger index = 0;
    
    for (int i=0; i<section-1; i++) {
        index = index+[[_sectionNumberArrary objectAtIndex:i] integerValue];
    }
    index = index + row;
    FSCityObject *o = [_fsCityListData.objectList objectAtIndex:index];
    
    NSMutableDictionary *obj = [[NSMutableDictionary alloc] init];
    [obj setObject:o.cityName forKey:NSNOTIF_LOCALNEWSLIST_CITYSELECTED_KEY];
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNOTIF_LOCALNEWSLIST_CITYSELECTED object:self userInfo:obj];
    [obj release];
    
    [self dismissModalViewControllerAnimated:YES];
}



-(void)tableViewTouchPicture:(FSTableContainerView *)sender withImageURLString:(NSString *)imageURLString withImageLocalPath:(NSString *)imageLocalPath imageID:(NSString *)imageID{
    NSLog(@"channel did selected!!");
    
}

-(void)doSomethingWithDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status{
    if ([sender isEqual:_fsCityListData]) {
        if (status == FSBaseDAOCallBack_SuccessfulStatus || status == FSBaseDAOCallBack_BufferSuccessfulStatus) {
            //NSLog(@"_fsCityListData count:%d",[_fsCityListData.objectList count]);
            
            [self getSectionsTitle];
            //NSLog(@"12112");
            [_localNewsCityListView loadData];
            if (status == FSBaseDAOCallBack_BufferSuccessfulStatus) {
                [_fsCityListData operateOldBufferData];
            }
        }
    }
}




-(FSUserSelectObject *)insertCityselectedObject:(FSCityObject *)obj{
    
    NSArray *array = [[FSBaseDB sharedFSBaseDB] getObjectsByKeyWithName:@"FSUserSelectObject" key:@"kind" value:KIND_CITY_SELECTED];
    
    if ([array count]>0) {
        FSUserSelectObject *sobj = [array objectAtIndex:0];
        
        if (obj == nil) {
            return sobj;
        }
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:0];
        NSString *nsstringdate = dateToString_YMD(date);
        sobj.keyValue1 = obj.cityName;
        sobj.keyValue2 = obj.cityId;
        sobj.keyValue3 = obj.provinceId;
        sobj.keyValue4 = nsstringdate;
        [[FSBaseDB sharedFSBaseDB].managedObjectContext save:nil];
        return sobj;
    }
    else{
        if (obj == nil) {
            return nil;
        }
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:0];
        NSString *nsstringdate = dateToString_YMD(date);
        FSUserSelectObject *sobj = (FSUserSelectObject *)[[FSBaseDB sharedFSBaseDB] insertObject:@"FSUserSelectObject"];
        sobj.kind = KIND_CITY_SELECTED;
        sobj.keyValue1 = obj.cityName;
        sobj.keyValue2 = obj.cityId;
        sobj.keyValue3 = obj.provinceId;
        sobj.keyValue4 = nsstringdate;
        [[FSBaseDB sharedFSBaseDB].managedObjectContext save:nil];
        return sobj;
    }
    
}



-(void)getSectionsTitle{
    [_sectionArrary removeAllObjects];
    
    NSString *kind = @"";
    NSInteger number = 0;
    for (FSCityObject *o in  _fsCityListData.objectList) {
        NSString *temp = [o.kind substringToIndex:1];
        if (![kind isEqualToString:temp]) {
            [_sectionArrary addObject:temp];
            kind = temp;
            if (number!=0) {
                [_sectionNumberArrary addObject:[NSNumber numberWithInteger:number]];
                number = 0;
            }
        }
        number++;
    }
    [_sectionNumberArrary addObject:[NSNumber numberWithInteger:number]];
    [_localNewsCityListView setRightList:_sectionArrary];
    
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //[_localNewsCityListView loadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark -
#pragma FSTitleViewDelegate mark

-(void)FSTitleViewTouchEvent:(FSTitleView *)titleView{
    [self dismissModalViewControllerAnimated:YES];
}

@end
