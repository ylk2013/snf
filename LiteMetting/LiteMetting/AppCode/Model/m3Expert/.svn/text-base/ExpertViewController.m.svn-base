//
//  ExpertViewController.m
//  LiteMetting
//
//  Created by hong pai on 13-1-9.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "ExpertViewController.h"
#import "ExpertCell.h"
#import "EETools_Infor.h"
#import "AppListViewController.h"
#import "DetailArticle.h"



@interface ExpertViewController ()

@end

@implementation ExpertViewController

@synthesize dataTableView,allExpertsArray;

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
    
    //初始化modalConfig modal类型
    NSMutableDictionary *dictionaryConfig = [NSMutableDictionary dictionary];
    [dictionaryConfig setValue:([NSNumber numberWithInt:MarkID_Expert]) forKey:@"MarkID"];//标记
    [dictionaryConfig setValue:[NSString stringWithFormat:@"%d",Modal_Type_Expert] forKey:@"modalType"];
    self.modalConfig = dictionaryConfig;
    
    //创建下拉刷新控件
    EGORefreshTableHeaderView *EGOView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0-self.dataTableView.bounds.size.height, self.dataTableView.bounds.size.width, self.dataTableView.bounds.size.height)];
    EGOView.delegate = self;
    [self.dataTableView addSubview:EGOView];
    _refreshHeaderView = EGOView;
    [EGOView release];
    
    //获取数据
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"experts" ofType:@"plist"];
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    self.allExpertsArray = array;
    
    if(allExpertsArray==nil || [allExpertsArray count]<=0){
        [EETools_Infor tools_alert:@"专家页面信息为空"];
    }
    trace(@"%d",[allExpertsArray count]);
    
    //设置delegate
    self.dataTableView.delegate = self;
    self.dataTableView.dataSource = self;
    [self.dataTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    track();
    trace(@"%d",[allExpertsArray count]);
    return [allExpertsArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 81;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    track();
    
    NSMutableDictionary *dictionary = [self.allExpertsArray objectAtIndex:indexPath.row];
    
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ExpertCell" owner:nil options:nil];
    ExpertCell *cell = [array objectAtIndex:0];
    [cell ee_setContentdata:dictionary];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
//    SettingCell *cell = (SettingCell *)[tableView cellForRowAtIndexPath:indexPath];
//    [cell ee_setDidSelectState];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    track();
//    if(tableView.isEditing){
//        return;
//    }
    
    ExpertCell *cell = (ExpertCell *)[tableView cellForRowAtIndexPath:indexPath];
//    NSString *name = [cell.dataDictionary objectForKey:@"settingName"];
    trace(@"%@",cell.dataDictionary);
    
    //创建内容详细页面
    trace(@"%@",self.modalConfig);
    [self ee_createDetailContent:self.modalConfig contentConfig:cell.dataDictionary];
    
//    [[EEContentFactory getFactory] ee_createContentAndInsertInToRootViewController:self.modalConfig contentConfig:cell.dataDictionary];
}





//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return [allExpertsArray count];
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
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}



#pragma mark - 显示详细页面 -
-(void)showDetail{
    
}

-(void)dealloc{
    self.allExpertsArray = nil;
    
    [super dealloc];
}
@end
