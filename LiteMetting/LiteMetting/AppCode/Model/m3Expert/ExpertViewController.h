//
//  ExpertViewController.h
//  LiteMetting
//
//  Created by hong pai on 13-1-9.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "PModal.h"

@interface ExpertViewController : PModal<EGORefreshTableHeaderDelegate,UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITableView *dataTableView;
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    
    NSMutableArray *allExpertsArray;
    
}

@property(nonatomic,retain)NSMutableArray *allExpertsArray;

@property(nonatomic,retain)IBOutlet UITableView *dataTableView;

@end
