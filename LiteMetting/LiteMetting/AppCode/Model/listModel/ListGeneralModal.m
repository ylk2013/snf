//
//  ListGeneralModal.m
//  LiteMetting
//
//  Created by hong pai on 13-1-14.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "ListGeneralModal.h"
#import "EETools_Infor.h"
//#import "ExpertCell.h"
#import "PCell.h"
#import "EEUIFactory.h"
#import "Tools_DispatchWebRequest.h"
#import "SBJson.h"
#import "Tools_TableRefreshHistory.h"

@interface ListGeneralModal ()

@end

@implementation ListGeneralModal

@synthesize dataTableView,allListArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSMutableArray *listarray = [NSMutableArray array];
    self.allListArray  = listarray;
    
    //创建下拉刷新控件
    EGORefreshTableHeaderView *EGOView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0-self.dataTableView.bounds.size.height, self.dataTableView.bounds.size.width, self.dataTableView.bounds.size.height)];
    EGOView.delegate = self;
    [self.dataTableView addSubview:EGOView];
    _refreshHeaderView = EGOView;
    [EGOView release];
    
    
    //设置delegate
    self.dataTableView.delegate = self;
    self.dataTableView.dataSource = self;
    
    //先初始化本地临时已存数据
    [self readLocalSqliteData];
    
    //是否需要读取网络文件
    if ([self ee_isNeedToRquestWebDataAgain]) {
        //读取网络文件
        [self ee_readWebServerData];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //加入next20按钮
    [self refresh20NextBtn];

}
#pragma mark - 读取本地信息
-(void)readLocalSqliteData{
    //得到本地列表
    NSMutableArray *localList = [Tools_DispatchWebRequest ee_dispatchGetLocalSqliteList:self.modalConfig];
    
    //如果是空的话，则提示空信息
    if (localList == nil || localList.count == 0 ) {
        [self showNilDataInformation:YES];
    }else{
        [self showNilDataInformation:NO];
    }
    
    //刷新数据源头
    [self refreshAllListArray:localList];
    
    //刷新表格
    [self.dataTableView reloadData];
}

#pragma mark - 读取网络信息
-(void)ee_readWebServerData{
    //从分发控制器里面获取web请求
    webServiceRequest = [Tools_DispatchWebRequest ee_dispatchGetWebServerListRequest:self.modalConfig delegate:self finish:@selector(reqest_Success:) failed:@selector(reqest_Failed:)];
}

-(void)reqest_Success:(ASIHTTPRequest *)request{
    track();
    trace(@"request.responseString：%@",request.responseString);
    
    webServiceRequest = nil;
    
    if (![request.responseString hasPrefix:@"{"] && ![request.responseString hasPrefix:@"["]) {
        trace(@"返回的数据格式不正确");
    }else{   
        NSMutableArray *array = [request.responseString JSONValue];
        
        if (array!=nil && [array count]!=0) {
            //有新的数据，1、保存到本地，2、读取本地
            trace(@"返回 数据为空 %@",array);
            [self tableList_refresh_afterGetWebList:array];
        }
    }
    
    
    [self doneLoadingTableViewData];
    
    
    //如果是从点击刷新按钮进入的话，则执行此方法
    if (btn_refresh) {
        btn_refresh.enabled = YES;
    }
    
}

-(void)reqest_Failed:(ASIHTTPRequest *)request{
    trace(@"%@",request.responseString);
    
    
    webServiceRequest = nil;
        
    [self doneLoadingTableViewData];
    
    //如果是从点击刷新按钮进入的话，则执行此方法
    if (btn_refresh) {
        btn_refresh.enabled = YES;
    }
    
}


-(void)tableList_refresh_afterGetWebList:(NSMutableArray *)getArrayList{
    //保存到本地
    [Tools_DispatchWebRequest ee_dispatchInsertNewDataInToSqlite:getArrayList modalConfig:self.modalConfig];
    
    //读取本地
    [self readLocalSqliteData];
}

#pragma mark - 修改信息是否可读状态
-(void)ee_setToReadedState_cellConfig:(NSMutableDictionary *)config{
    if ([[config objectForKey:@"IsReaded"] boolValue]) {
        return;
    }
    
    int localId = [[config objectForKey:@"id"] intValue];
    
    //修改sqlite数据库为 可读状态
    [Tools_DispatchWebRequest ee_dispatchSetArticleReadState_modalconfig:self.modalConfig artID:localId];
    
    //修改当前内存数组数据为 已读状态
    [config setValue:@"1" forKey:@"IsReaded"];
}

#pragma mark - allListArray 操作 - 
#pragma mark 覆盖
-(void)refreshAllListArray:(NSMutableArray *)array{
    [self.allListArray removeAllObjects];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self.allListArray addObject:obj];
    }];
    
}
#pragma mark 追加  前？ 后？
-(void)appendAllListArray:(NSMutableArray *)array isBegin:(BOOL)isbegin{
    
}


#pragma mark - 刷新 数据
-(BOOL)ee_isNeedToRquestWebDataAgain{
    track();
    BOOL isneed =  [Tools_TableRefreshHistory ee_checkIsNeesToRefreshTable_ModalConfig:self.modalConfig];
    
    trace(@"ee_isNeedToRquestWebDataAgain %@",isneed?@"需要刷新 ":@"不需要刷新");

    return isneed;
}

#pragma mark -  刷新按钮  20page next
-(void)refresh20NextBtn{
    //TODO
}

#pragma mark - 提示，数据为空
-(void)showNilDataInformation:(BOOL)isNil{
    if (isNil) {
        if (toolInfor==nil) {
            toolInfor = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)] autorelease];
            toolInfor.textAlignment  = NSTextAlignmentCenter;
            toolInfor.text = @"数据为空";
            toolInfor.center = CGPointMake(self.view.frame.size.width * 0.5f, 145);
            [toolInfor setTextColor:[UIColor grayColor]];
            [toolInfor setBackgroundColor:[UIColor clearColor]];
            [self.view addSubview:toolInfor];
        }
        
        if (btn_refresh==nil) {
            btn_refresh = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [btn_refresh setFrame:CGRectMake(0, 0, 80, 40)];
            [btn_refresh setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [btn_refresh setTitle:@"刷新" forState:UIControlStateNormal];
            btn_refresh.center = CGPointMake(self.view.frame.size.width * 0.5f, 180);
            [btn_refresh addTarget:self action:@selector(clickRefreshNilDate) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btn_refresh];
            
        }
        btn_refresh.enabled = YES;
        
        self.dataTableView.hidden = YES;
    }else{
        if (toolInfor) {
            [toolInfor removeFromSuperview];
            toolInfor = nil;
        }
        if (btn_refresh) {
            [btn_refresh removeFromSuperview];
            btn_refresh = nil;
        }
        self.dataTableView.hidden = NO;
    }
}

-(void)clickRefreshNilDate{
    if (btn_refresh) {
        btn_refresh.enabled = NO;
    }

    //重新刷新
    [self ee_readWebServerData];
}

#pragma mark -
#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    track();
    trace(@"%d",[allListArray count]);
    return [allListArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 73;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    track();
    
    NSMutableDictionary *dictionary = [allListArray objectAtIndex:indexPath.row];
    
    //创建相应的cell
    PCell *cell = [[EEUIFactory getFactory] ee_getTableCellViewByModalConfig:self.modalConfig];
    
    //设置数据
    [cell ee_setContentdata:dictionary];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    SettingCell *cell = (SettingCell *)[tableView cellForRowAtIndexPath:indexPath];
    //    [cell ee_setDidSelectState];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    track();
    
    PCell *cell = (PCell *)[tableView cellForRowAtIndexPath:indexPath];
    trace(@"%@",cell.dataDictionary);
    
    [self ee_createDetailContent:self.modalConfig contentConfig:cell.dataDictionary];
    [cell ee_setCellContentColor_Readed];
    
    [self ee_setToReadedState_cellConfig:cell.dataDictionary];
    
    [dataTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}





//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return [allListArray count];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//
//	return [NSString stringWithFormat:@"Section %i", section];
//
//}


#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;
	
    //请求网络数据
   [self ee_readWebServerData];
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
    
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.dataTableView];
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
//	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
    [Tools_TableRefreshHistory ee_addOneRrefreshHistoryToLocal_ModalConfig:self.modalConfig];
    
	return [NSDate date]; // should return date data source was last changed
}

#pragma mark - 显示详细页面 -
-(void)showDetail{
    
}

#pragma mark - 回收 - 

-(void)disponse{
    [self release];
}

-(void)dealloc{
    track();
    
    if (webServiceRequest) {
        [webServiceRequest.request cancel];
        webServiceRequest._delegate = nil;
        webServiceRequest = nil;
    }
    
    self.allListArray = nil;
    
    [dataTableView release];
    dataTableView = nil;
    
    [super dealloc];
}

@end
