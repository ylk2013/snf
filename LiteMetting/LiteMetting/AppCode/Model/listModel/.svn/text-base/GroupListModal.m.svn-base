//
//  GroupListModal.m
//  LiteMetting
//
//  Created by hong pai on 13-1-23.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "GroupListModal.h"
#import "EETools_Array.h"
#import "PCell.h"
#import "EEUIFactory.h"

@interface GroupListModal ()

@end

@implementation GroupListModal

@synthesize keyArray;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return [[allListArray objectAtIndex:section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableDictionary *dictionary = [[[self.allListArray objectAtIndex:indexPath.section] objectForKey:@"items"] objectAtIndex:indexPath.row];
    
    //创建相应的cell
    PCell *cell = [[EEUIFactory getFactory] ee_getTableCellViewByModalConfig:self.modalConfig];
    
    //设置数据
    [cell ee_setContentdata:dictionary];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

	return [self.keyArray objectAtIndex:section];
    
}

#pragma mark - allListArray 操作 -
#pragma mark 覆盖
-(void)refreshAllListArray:(NSMutableArray *)array{
    track();
    
    [super refreshAllListArray:array];
    
    NSMutableArray *keys = [EETools_Array ee_getGroupNames:allListArray key:@"ScheduleGroupName"];
    
    NSMutableArray *newkeys = [EETools_Array ee_sortArray_String:keys isDesc:NO];
    
    self.keyArray = newkeys;
    
    NSMutableArray *newAllListArray = [EETools_Array ee_groupArrays:allListArray keys:self.keyArray key:@"ScheduleGroupName"];
    
    self.allListArray = newAllListArray;
    
}
















@end
