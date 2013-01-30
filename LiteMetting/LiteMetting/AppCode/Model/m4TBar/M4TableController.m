//
//  M4TableController.m
//  LiteMetting
//
//  Created by hong pai on 13-1-22.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "M4TableController.h"
#import "Tools_GetAllModalListConfig.h"
#import "EEUIFactory.h"

@interface M4TableController ()

@end

@implementation M4TableController

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
    
    self.modalConfig = [[Tools_GetAllModalListConfig shareInstance] ee_getOneConfigByMarkID:MarkID_MySchedul];
    
    [self factory_createTwoLevelViewControllerByConfig:self.modalConfig];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




//从工厂方法里面取到modalController，加入相应的场景
-(void)factory_createTwoLevelViewControllerByConfig:(NSMutableDictionary *)config{
    track();
    
    PModal *pModalController = [[EEUIFactory getFactory] ee_getModalControllerByModalConfig:config];
    
    //吧得到的modalController 加入场景
    NSAssert(pModalController!=nil,([NSString stringWithFormat:@"得到二级列表控件为空，请查阅UIFactory类。传入的config：%@",config]));
    [pModalController.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [self.view addSubview:pModalController.view];
}

@end
