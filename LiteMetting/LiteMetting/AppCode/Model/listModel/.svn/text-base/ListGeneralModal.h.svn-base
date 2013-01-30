//
//  ListGeneralModal.h
//  LiteMetting
//
//  Created by hong pai on 13-1-14.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PModal.h"
#import "EGORefreshTableHeaderView.h"
#import "WebServiceTools.h"

@interface ListGeneralModal : PModal<EGORefreshTableHeaderDelegate,UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITableView *dataTableView;
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    
    NSMutableArray *allListArray;
    
    WebServiceTools *webServiceRequest;
    
    //数据为空时候
    UILabel *toolInfor;
    UIButton *btn_refresh;
}

@property(nonatomic,retain) NSMutableArray *allListArray;

@property(nonatomic,retain)IBOutlet UITableView *dataTableView;

-(void)ee_readWebServerData;
-(void)disponse;

-(BOOL)ee_isNeedToRquestWebDataAgain;






//继承
-(void)refreshAllListArray:(NSMutableArray *)array;




@end
