//
//  ScheduleViewController.m
//  LiteMetting
//
//  Created by hong pai on 13-1-9.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "ScheduleViewController.h"
#import "EETools_Infor.h"
#import "ScheduleCell.h"

@interface ScheduleViewController ()

@end

@implementation ScheduleViewController


@synthesize dataTableView;



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
    [dictionaryConfig setValue:([NSNumber numberWithInt:MarkID_Schedul]) forKey:@"MarkID"];//标记
    [dictionaryConfig setValue:[NSString stringWithFormat:@"%d",Modal_Type_Schedul] forKey:@"modalType"];
    self.modalConfig = dictionaryConfig;
    
    //创建下拉刷新控件
    EGORefreshTableHeaderView *EGOView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0-self.dataTableView.bounds.size.height, self.dataTableView.bounds.size.width, self.dataTableView.bounds.size.height)];
    EGOView.delegate = self;
    [self.dataTableView addSubview:EGOView];
    _refreshHeaderView = EGOView;
    [EGOView release];
    
    //获取数据
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"eschedule" ofType:@"plist"];
    NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:filePath];
    allScheduleArray = [array retain];
    if(allScheduleArray==nil || [allScheduleArray count]<=0){
        [EETools_Infor tools_alert:@"专家页面信息为空"];
    }
    trace(@"%d",[allScheduleArray count]);
    
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
    
	return [[[allScheduleArray objectAtIndex:section] objectForKey:@"item"] count];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
   return [allScheduleArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
	return [[allScheduleArray objectAtIndex:section] objectForKey:@"selectioname"];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 81;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    track();
    trace(@"%d %d",indexPath.row,[allScheduleArray count]);
    
    NSMutableDictionary *dictionary = [[[allScheduleArray objectAtIndex:indexPath.section] objectForKey:@"item"]  objectAtIndex:indexPath.row];
    trace(@"%@",dictionary);
//    
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ScheduleCell" owner:nil options:nil];
    ScheduleCell *cell = [array objectAtIndex:0];
//    trace(@"%@",dictionary);
    [cell ee_setContentdata:dictionary];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    
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
    
    ScheduleCell *cell = (ScheduleCell *)[tableView cellForRowAtIndexPath:indexPath];
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
    [allScheduleArray release];
    
    [super dealloc];
}
@end