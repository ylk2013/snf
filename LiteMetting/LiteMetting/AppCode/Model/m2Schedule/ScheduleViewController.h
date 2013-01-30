//
//  ScheduleViewController.h
//  LiteMetting
//
//  Created by hong pai on 13-1-9.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PModal.h"
#import "EGORefreshTableHeaderView.h"

@interface ScheduleViewController :  PModal<EGORefreshTableHeaderDelegate,UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITableView *dataTableView;
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    
    NSMutableArray *allScheduleArray;
    
}

@property(nonatomic,retain)IBOutlet UITableView *dataTableView;

@end
