//
//  FSChannelListForNewsController.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-17.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSChannelListForNewsController.h"
#import "FSUserSelectObject.h"
#import "FSChannelObject.h"
#import "FSBaseDB.h"

#import "FS_GZF_ChannelListDAO.h"


#define KIND_USERCHANNEL_SELECTED @"KIND_USERCHANNEL_SELECTED"

@implementation FSChannelListForNewsController

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
    
    [_titleView release];
    [_fsChannelListForNewsContentView release];
    [_fsChannelIconsView release];
    [_fs_GZF_ChannelListDAO release];
    [super dealloc];
}

-(void)loadChildView{
    
    _titleView = [[FSTitleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    _titleView.hidRefreshBt = YES;
    _titleView.toBottom = YES;
    _titleView.parentDelegate = self;
    self.navigationItem.titleView = _titleView;
    
    _fsChannelListForNewsContentView = [[FSChannelListForNewsContentView alloc] init];
    _fsChannelListForNewsContentView.parentDelegate = self;
    //[self.view addSubview:_fsChannelListForNewsContentView];
    
    _fsChannelIconsView = [[FSChannelIconsView alloc] init];
    _fsChannelIconsView.parentDelegate = self;
    _fsChannelIconsView.isForOrdinnews = YES;
    
    
    _fs_GZF_ChannelListDAO = [[FS_GZF_ChannelListDAO alloc] init];
    _fs_GZF_ChannelListDAO.parentDelegate = self;
    _fs_GZF_ChannelListDAO.type = @"news";
    
    [self.view addSubview:_fsChannelIconsView];
    
    [self.view bringSubviewToFront:_fsChannelIconsView];
    
}


-(void)layoutControllerViewWithRect:(CGRect)rect{
    _titleView.frame = CGRectMake(0, 0, rect.size.width, 44);
    _fsChannelListForNewsContentView.frame = CGRectMake(0, 0.0f, rect.size.width, rect.size.height-0.50f);
    
    _fsChannelIconsView.frame = CGRectMake(0, 0.0f, rect.size.width, rect.size.height);//-50.0f);
}

-(void)doSomethingForViewFirstTimeShow{
    [_titleView reSetFrame];
    
    [_fs_GZF_ChannelListDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
}


-(void)doSomethingWithDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status{
    if ([sender isEqual:_fs_GZF_ChannelListDAO]) {
        if (status == FSBaseDAOCallBack_BufferSuccessfulStatus || status == FSBaseDAOCallBack_SuccessfulStatus) {
            [self getUserChannelSelectedObject];
            _fsChannelIconsView.IconsInOneLine = 3;
            _fsChannelIconsView.objectList = _fs_GZF_ChannelListDAO.objectList;
        }
    }
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

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//    NSInteger k = [self retainCount];
//    for (NSInteger i=0; i<k-2; i++) {
//        [self release];
//    }
    NSLog(@"%@.viewDidDisappear:%d",self,[self retainCount]);
}





#pragma mark -
#pragma FSTitleViewDelegate
-(void)FSTitleViewTouchEvent:(FSTitleView *)titleView{
    
    [self dismissModalViewControllerAnimated:YES];
    
    //[self.navigationController popViewControllerAnimated:YES];
}


-(void)fsBaseContainerViewTouchEvent:(FSBaseContainerView *)sender{
    NSLog(@"fsChannelListSelectFinish fsChannelListSelectFinish");
    
    FSChannelIconsView *Vobj = (FSChannelIconsView *)sender;
    
    [self insertUserSelected:Vobj.channelForNewsList];
    
    NSMutableDictionary *obj = [[NSMutableDictionary alloc] init];
    [obj setObject:Vobj.channelForNewsList forKey:NSNOTIF_NEWSCHANNEL_SELECTED_KEY];
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNOTIF_NEWSCHANNEL_SELECTED object:self userInfo:obj];
    [obj release];
    
    [self dismissModalViewControllerAnimated:YES];
    //[self.navigationController popViewControllerAnimated:YES];
}


-(void)fsChannelListSelectFinish:(FSChannelListForNewsContentView *)sender{
    
    NSLog(@"sender:%@",sender.selected_channelID);
    
    [self insertUserSelected:sender.selected_channelID];
    
    NSMutableDictionary *obj = [[NSMutableDictionary alloc] init];
    [obj setObject:sender.selected_channelID forKey:NSNOTIF_NEWSCHANNEL_SELECTED_KEY];
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNOTIF_NEWSCHANNEL_SELECTED object:self userInfo:obj];
    [obj release];
    
    
    
    [self dismissModalViewControllerAnimated:YES];
    //[self.navigationController popViewControllerAnimated:YES];
}


///______-----------------------------------------------
-(FSUserSelectObject *)getUserChannelSelectedObject{
    NSArray *array = [[FSBaseDB sharedFSBaseDB] getObjectsByKeyWithName:@"FSUserSelectObject" key:@"kind" value:KIND_USERCHANNEL_SELECTED];
    
    if ([array count]>0) {
        FSUserSelectObject *sobj = [array objectAtIndex:0];
        _titleView.data = sobj.keyValue1;
        _fsChannelIconsView.selectChannelid = sobj.keyValue2;
        return sobj;
    }
    else{
        if ([_fs_GZF_ChannelListDAO.objectList count]==0) {
            return nil;
        }
        FSChannelObject *CObject = [_fs_GZF_ChannelListDAO.objectList objectAtIndex:0];
        
        FSUserSelectObject *sobj = (FSUserSelectObject *)[[FSBaseDB sharedFSBaseDB] insertObject:@"FSUserSelectObject"];
        
        sobj.kind = KIND_USERCHANNEL_SELECTED;
        sobj.keyValue1 = CObject.channelname;
        sobj.keyValue2 = CObject.channelid;
        sobj.keyValue3 = nil;
        _fsChannelIconsView.selectChannelid = CObject.channelid;
        _titleView.data = CObject.channelname;
        [[FSBaseDB sharedFSBaseDB].managedObjectContext save:nil];
        return sobj;
    }
    
}


-(void)insertUserSelected:(NSString *)channelid{
    
     NSArray *array = [[FSBaseDB sharedFSBaseDB] getObjectsByKeyWithName:@"FSUserSelectObject" key:@"kind" value:KIND_USERCHANNEL_SELECTED];
   
    
    for (FSChannelObject *o in _fs_GZF_ChannelListDAO.objectList) {
        if ([channelid isEqualToString:o.channelid] ) {
            FSUserSelectObject *sobj = [array objectAtIndex:0];
            sobj.kind = KIND_USERCHANNEL_SELECTED;
            sobj.keyValue1 = o.channelname;
            sobj.keyValue2 = o.channelid;
            sobj.keyValue3 = nil;
            _titleView.data = o.channelname;
            [[FSBaseDB sharedFSBaseDB].managedObjectContext save:nil];
            return;
        }
    }
    
}



@end
