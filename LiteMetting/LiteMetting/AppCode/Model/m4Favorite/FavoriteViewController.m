//
//  FavoriteViewController.m
//  LiteMetting
//
//  Created by hong pai on 13-1-9.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "FavoriteViewController.h"
#import "PModal.h"
#import "EEUIFactory.h"

@interface FavoriteViewController ()

@end

@implementation FavoriteViewController

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
    NSMutableDictionary *modalConfig = [NSMutableDictionary dictionary];
    [modalConfig setValue:([NSNumber numberWithInt:MarkID_Favorite]) forKey:@"MarkID"];//标记
    [modalConfig setValue:([NSNumber numberWithInt:Modal_Type_Favorite]) forKey:@"modalType"];//modalController 的类型
    [modalConfig setValue:([NSNumber numberWithInt:Cell_Type_General]) forKey:@"cellType"]; //表格cell
    [modalConfig setValue:([NSNumber numberWithInt:DataResource_Type_News]) forKey:@"dataSourceType"];//数据源头
    [modalConfig setValue:([NSNumber numberWithBool:NO]) forKey:@"cellAccessory"];//指示符
    self.modalConfig = modalConfig;
    
    //从工厂里面的到modalController
    PModal *pModalController = [[EEUIFactory getFactory] ee_getModalControllerByModalConfig:modalConfig];
    
    //吧得到的modalController 加入场景
    NSAssert(pModalController!=nil,([NSString stringWithFormat:@"得到二级列表控件为空，请查阅UIFactory类。 InFavorite 传入的config：%@",modalConfig]));
    [pModalController.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:pModalController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
