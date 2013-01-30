//
//  M3TableController.m
//  LiteMetting
//
//  Created by hong pai on 13-1-22.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "M3TableController.h"
#import "EEUIFactory.h"
#import "Tools_GetAllModalListConfig.h"
#import "ListGeneralModal.h"


@interface M3TableController ()

@end

@implementation M3TableController

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
    
    self.modalConfig = [[Tools_GetAllModalListConfig shareInstance] ee_getOneConfigByMarkID:MarkID_Expert];
    
    [self factory_createTwoLevelViewControllerByConfig:self.modalConfig];
    
    isFirstCreateView = YES;
    
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if (isFirstCreateView) {
        isFirstCreateView = NO;
        
    }else{
        NSArray *array = [(ListGeneralModal *)pModalController allListArray];
        if (array==nil || [array count]<=0) {
            [(ListGeneralModal *)pModalController ee_readWebServerData];
        }else{
            //是否需要读取网络文件
            if ([(ListGeneralModal *)pModalController ee_isNeedToRquestWebDataAgain]) {
                //读取网络文件
                [(ListGeneralModal *)pModalController ee_readWebServerData];
            }
        }
    }
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




//从工厂方法里面取到modalController，加入相应的场景
-(void)factory_createTwoLevelViewControllerByConfig:(NSMutableDictionary *)config{
    track();
    
    pModalController = [[EEUIFactory getFactory] ee_getModalControllerByModalConfig:config];
    
    //吧得到的modalController 加入场景
    NSAssert(pModalController!=nil,([NSString stringWithFormat:@"得到二级列表控件为空，请查阅UIFactory类。传入的config：%@",config]));
    [pModalController.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [self.view addSubview:pModalController.view];
    
}


@end
