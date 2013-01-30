//
//  LeftModalCtr.m
//  EENews
//
//  Created by hong pai on 12-10-21.
//  Copyright (c) 2012年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "LeftModalCtr.h"
#import "LiteMettingViewController.h"
#import "AppListViewController.h"
#import "UIView+EEExtras.h"
#import "LeftNavButton.h"
#import "Tools_GetAllModalListConfig.h"
#import "LeftModalCtr.h"
#import "LeftMenuCell.h"

@interface LeftModalCtr ()

@end


@implementation LeftModalCtr

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
    AllModalMenuArray = [[[Tools_GetAllModalListConfig shareInstance] eeModalListConfig_leftMenus] retain];
    
    listtableview.delegate = self;
    listtableview.dataSource = self;
    listtableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [listtableview reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - 选择一个选项卡

//选中一个NavButton
-(void)ee_selectOneItem:(MarkID)clickMarkID{
    int targetNavBtn = clickMarkID + 9;
    
    LeftNavButton *curClick = (LeftNavButton *)[self.view viewWithTag:targetNavBtn];
    
    NSArray *_subViews = [self.view subviews];
    [_subViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[LeftNavButton class]]) {
            LeftNavButton *find = (LeftNavButton *)obj;
            [find setSelected:NO];
            
            [curClick setSelected:YES];
        }
    }];
}



-(void)ee_ChangedMenuBarState_ByMarkID:(MarkID)markID{

//    [listtableview selectRowAtIndexPath:(NSIndexPath *) animated:<#(BOOL)#> scrollPosition:<#(UITableViewScrollPosition)#>]

    if (lastClickCell!=nil) {
        NSIndexPath *curPath = [listtableview indexPathForCell:lastClickCell];
        [listtableview deselectRowAtIndexPath:curPath animated:YES];
        lastClickCell = nil;
    }

    NSArray *allCells =  [listtableview  subviews];

    __block LeftMenuCell *findCell ;
    __block BOOL isfinded = NO;
    [allCells enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[LeftMenuCell class]]) {
            LeftMenuCell *cell = (LeftMenuCell *)obj;
            MarkID curMarkID = [[cell.dataDictionary objectForKey:@"MarkID"] intValue];
            
            if (curMarkID == markID) {
                findCell = cell;
                isfinded = YES;
            }
        }
    }];
    
    if (isfinded) {
        
        NSIndexPath *curPath = [listtableview indexPathForCell:findCell];
        [listtableview selectRowAtIndexPath:curPath animated:YES scrollPosition:nil];
        
        lastClickCell = findCell;
    }
    
}

//显示视野试图
-(void)showShiye{
    //[[Global shareGlobel].rootController ee_setAllContrllerToInitState];
}



#pragma mark - 
#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    track();
    trace(@"%d",[AllModalMenuArray count]);
    return [AllModalMenuArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 51;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    track();
    
    NSMutableDictionary *dictionary = [AllModalMenuArray objectAtIndex:indexPath.row];
    
    //bg_menu_cell_selected.png
    //创建相应的cell
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"LeftMenuCell" owner:nil options:nil];
    LeftMenuCell *cell = [array objectAtIndex:0];

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
    
    LeftMenuCell *cell = (LeftMenuCell *)[tableView cellForRowAtIndexPath:indexPath];
    trace(@"%@",cell.dataDictionary);
    
    if(lastClickCell == cell){
        
    }else{
        [lastClickCell ee_setSelected:NO];
        lastClickCell = cell;
        [lastClickCell ee_setSelected:YES];
        //
    }
    
    [[Global shareGlobel].applistviewcontroller.view ee_tween:0.3 to:([NSString stringWithFormat:@"x:0,y:0,width:%d,height:%d",(int)[Global shareGlobel].applistviewcontroller.view.frame.size.width,(int)[Global shareGlobel].applistviewcontroller.view.frame.size.height]) delegate:self sel:@selector(showShiye)];
    
    [[Global shareGlobel].applistviewcontroller ee_openModalByModalConfig:cell.dataDictionary];
}








@end
