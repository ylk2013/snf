//
//  LiteMettingViewController.m
//  LiteMetting
//
//  Created by hong pai on 13-1-9.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "LiteMettingViewController.h"

#import "AppListViewController.h"
#import "LeftModalCtr.h"
#import "RIghtFiterCtr.h"
#import "LookQuickCtr.h"
#import "UIView+EEExtras.h"
#import "Tools_AppInitConfig.h"



@interface LiteMettingViewController ()

@end

@implementation LiteMettingViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [Global shareGlobel].rootController = self;
    
    [self initStage];
    
    [self initAppConfigFromWeb];
    
    [self initDataBase];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)initStage{
    //左边菜单
    LeftModalCtr *leftCtr = [[LeftModalCtr alloc] initWithNibName:@"LeftModalCtr" bundle:nil];
    [self.view addSubview:leftCtr.view];
    [Global shareGlobel].leftmodalctr = leftCtr;
    
    //右边菜单
    RIghtFiterCtr *rightCtr = [[RIghtFiterCtr alloc] initWithNibName:@"RIghtFiterCtr" bundle:nil];
    [self.view addSubview:rightCtr.view];
    [Global shareGlobel].rightfiterctr = rightCtr;
    
    //列表
    AppListViewController *applist = [[AppListViewController alloc] initWithNibName:@"AppListViewController" bundle:nil];
    [self.view addSubview:applist.view];
    [Global shareGlobel].applistviewcontroller = applist;
    
    //LookQuick
    //LookQuickCtr *lookquickctr = [[LookQuickCtr alloc] initWithNibName:@"LookQuickCtr" bundle:nil];
    //[self.view addSubview:lookquickctr.view];
    //[Global shareGlobel].lookquickstr = lookquickctr;
    
    [self ee_setAllContrllerToInitState];
}


//恢复默认 显示视野试图
-(void)ee_setAllContrllerToInitState{
//    [[Global shareGlobel].applistviewcontroller ee_StateChangedToBackGroud];
    
    [Global shareGlobel].leftmodalctr.view.hidden = YES;
    [Global shareGlobel].rightfiterctr.view.hidden = YES;
    
    //[[Global shareGlobel].lookquickstr.view ee_tween:0.3 to:@"x:0,y:0"];
}



#pragma mark - 程序初始化数据 -
-(void)initAppConfigFromWeb{
    [[Tools_AppInitConfig alloc] init];
}


-(void)initDataBase{
    BOOL isexist = [[NSFileManager defaultManager] fileExistsAtPath:EE_SqlitePath];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"litemeeting" ofType:@"sqlite"];
    if (!isexist) {
        BOOL isSuccess =[[NSFileManager defaultManager] copyItemAtPath:filePath toPath:EE_SqlitePath error:nil];
        trace(@"%@",isSuccess?@"成功":@"失败");
    }
    //#define EE_SqlitePath 
//#define EE_SqlitePath [NSString stringWithFormat:@"%@/Library/Caches/litemeeting.sqlite",NSHomeDirectory()]
}
@end
