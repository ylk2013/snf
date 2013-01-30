//
//  FocusViewController.m
//  LiteMetting
//
//  Created by hong pai on 13-1-9.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "FocusViewController.h"
#import "ListGeneralModal.h"
#import "EEUIFactory.h"
#import "SliderView.h"
#import "Tools_GetAllModalListConfig.h"
#import "AppListViewController.h"
#import "EETools_Web.h"
#import "LeftModalCtr.h"
#import "SqliteTools.h"
#import "WebServiceTools.h"
#import "ASIHTTPRequest.h"


@interface FocusViewController ()

@end

@implementation FocusViewController

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
    
    //初始化
    [Global shareGlobel].focusViewController = self;
    
    //初始化modalConfig modal类型
//    NSMutableDictionary *dictionaryConfig = [NSMutableDictionary dictionary];
//    [dictionaryConfig setValue:[NSString stringWithFormat:@"%d",Modal_Type_Focus] forKey:@"modalType"];
//    self.modalConfig = dictionaryConfig;
    
    //创建上面的菜单
    topMenuArray = [[[Tools_GetAllModalListConfig shareInstance] eeModalListConfig_topMenus] retain];
    NSMutableArray *namesarray = [[Tools_GetAllModalListConfig shareInstance] eeModalListConfig_topMenus_StringEntiry];
    //NSMutableArray *menuArray = [NSMutableArray arrayWithObjects:@"聚焦",@"资讯",@"通知",@"交通出行",@"天气",@"交通出行",@"天气", nil];
    horizontal = [[EE_HorizontalMenuBar alloc] initWithFrame:CGRectMake(0, 0, 320, 35) withMenus:namesarray imageSources:nil horizontalType:HorizontalType_BGMoving];
    horizontal.delegate = self;
    [horizontal ee_setSelectedItem:0 clicked:NO];
    [self.view addSubview:horizontal];
    
    //创建幻灯片
    NSMutableDictionary *dictionary1 = [NSMutableDictionary dictionary];
    NSMutableDictionary *dictionary2 = [NSMutableDictionary dictionary];
    NSMutableDictionary *dictionary3 = [NSMutableDictionary dictionary];
    NSMutableDictionary *dictionary4 = [NSMutableDictionary dictionary];
    NSMutableDictionary *dictionary5 = [NSMutableDictionary dictionary];
    
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"slides_img_demo111" ofType:@"png"];
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"m2" ofType:@"png"];
    NSString *path3 = [[NSBundle mainBundle] pathForResource:@"m3" ofType:@"png"];
    NSString *path4 = [[NSBundle mainBundle] pathForResource:@"m4" ofType:@"png"];
    NSString *path5 = [[NSBundle mainBundle] pathForResource:@"m5" ofType:@"png"];
    
    [dictionary1 setValue:path1 forKey:@"posterURL"];
    [dictionary2 setValue:path2 forKey:@"posterURL"];
    [dictionary3 setValue:path3 forKey:@"posterURL"];
    [dictionary4 setValue:path4 forKey:@"posterURL"];
    [dictionary5 setValue:path5 forKey:@"posterURL"];
    
    [dictionary1 setValue:@"2013赛诺菲中国糖尿病创新高峰论坛" forKey:@"summary"];
    [dictionary2 setValue:@"幽幽深山" forKey:@"summary"];
    [dictionary3 setValue:@"自然之美" forKey:@"summary"];
    [dictionary4 setValue:@"宁静梦境" forKey:@"summary"];
    [dictionary5 setValue:@"碧水荡漾" forKey:@"summary"];
    
    NSMutableArray *sliderData = [NSMutableArray arrayWithObjects:
                                  dictionary1 ,dictionary2,dictionary3,dictionary4,dictionary5,
                                  nil];
    
    SliderView *sliderview = [[SliderView alloc] initWithFrame:CGRectMake(0, horizontal.frame.size.height, 320, 160) withData:sliderData];
    [self.view addSubview:sliderview];
    
    
    [self getWebRequest_Slider];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 工厂 创建二级 modal controller -
//从工厂方法里面取到modalController，加入相应的场景
-(void)factory_createTwoLevelViewControllerByConfig:(NSMutableDictionary *)config{
    track();
    
    PModal *pModalController = [[EEUIFactory getFactory] ee_getModalControllerByModalConfig:config];
    
    //吧得到的modalController 加入场景
    NSAssert(pModalController!=nil,([NSString stringWithFormat:@"得到二级列表控件为空，请查阅UIFactory类。传入的config：%@",config]));
    [pModalController.view setFrame:CGRectMake(0, horizontal.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-horizontal.frame.size.height)];
    [self.view addSubview:pModalController.view];
    [self.view bringSubviewToFront:horizontal];
    
    //移出上一个viewcontroller
    [self removeLastModalController];
    lastModalController = pModalController;
    
    //切换horiznal的显示状态
    [self ee_ChangedHorizontalMenuBarState_ByMarkID:[[config objectForKey:@"MarkID"] intValue]];
    
    //切换leftMenu的选中状态
    [[Global shareGlobel].leftmodalctr ee_ChangedMenuBarState_ByMarkID:[[config objectForKey:@"MarkID"] intValue]];
}


#pragma mark - 点击按钮  显示modal -
-(void)showModalViews:(NSMutableDictionary *)_modalConfig{
    track();
    //创建view
    [self factory_createTwoLevelViewControllerByConfig:_modalConfig];
    
}   
    
    
-(IBAction)clickShowNews:(id)sender{
    track();
        
    
    
    
    
    
    
    NSMutableDictionary *config = [[Tools_GetAllModalListConfig shareInstance] ee_getOneConfigByMarkID:MarkID_News];
    trace(@"点击打开 config:%@",config);
    
    [self factory_createTwoLevelViewControllerByConfig:config];
}

-(IBAction)clickShowMaps:(id)sender{
    track();
    
    NSMutableDictionary *config = [[Tools_GetAllModalListConfig shareInstance] ee_getOneConfigByMarkID:MarkID_Map];
    trace(@"点击打开 config:%@",config);
    
    [self factory_createTwoLevelViewControllerByConfig:config];
}

-(IBAction)clickShowNotice:(id)sender{
    track();
    
    NSMutableDictionary *config = [[Tools_GetAllModalListConfig shareInstance] ee_getOneConfigByMarkID:MarkID_Notice];
    trace(@"点击打开 config:%@",config);
    
    [self factory_createTwoLevelViewControllerByConfig:config];
}

-(IBAction)clickShowImagesWall:(id)sender{
    track();
    
    NSMutableDictionary *config = [[Tools_GetAllModalListConfig shareInstance] ee_getOneConfigByMarkID:MarkID_ImageWall];
    trace(@"点击打开 config:%@",config);
    
    [self factory_createTwoLevelViewControllerByConfig:config];
}

-(IBAction)clickShowPartners:(id)sender{
    track();
    
    NSMutableDictionary *config = [[Tools_GetAllModalListConfig shareInstance] ee_getOneConfigByMarkID:MarkID_Partners];
    trace(@"点击打开 config:%@",config);
    
    [self factory_createTwoLevelViewControllerByConfig:config];
}

-(IBAction)clickShowAround:(id)sender{
    track();
    
    
    NSMutableDictionary *config = [[Tools_GetAllModalListConfig shareInstance] ee_getOneConfigByMarkID:MarkID_Around];
    trace(@"点击打开 config:%@",config);
    
    [self factory_createTwoLevelViewControllerByConfig:config];
}




#pragma mark - 返回控制 -
//删除所有的view controller 从FocusViewController里面
-(void)ee_ShowAllNavigationDefaultView{
//    [[EEUIFactory getFactory].modalControllerArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        PModal *curModal = [[EEUIFactory getFactory].modalControllerArray objectAtIndex:idx];
//        if(curModal.view.superview == self.view){
//            [curModal.view removeFromSuperview];
//        }
//    }];
    [self removeLastModalController];
}

//移出上一个viewController
-(void)removeLastModalController{
    if (lastModalController!=nil) {
        [lastModalController.view removeFromSuperview];
        [lastModalController release];
        lastModalController = nil;
    }
    
    
}


#pragma mark - horizontal bar delegate - 
-(void)ee_HorizontalMenuBar_clickBarIndex:(int)index{
    
    [self performSelector:@selector(delayJump:) withObject:[NSString stringWithFormat:@"%d",index] afterDelay:0.1];
    
}
-(void)delayJump:(NSString *)itemindex{
    int index = [itemindex intValue];
    if (index == 0) {
        [self ee_ShowAllNavigationDefaultView];
        
        //切换leftMenu的全部未选中状态,MarkID_None
        [[Global shareGlobel].leftmodalctr ee_ChangedMenuBarState_ByMarkID:MarkID_None];
        
    }else{
        NSMutableDictionary *config = [topMenuArray objectAtIndex:index];
        
        [[Global shareGlobel].applistviewcontroller ee_openModalByModalConfig:config];
    }
}

//切换horizontal的选中状态
-(void)ee_ChangedHorizontalMenuBarState_ByMarkID:(MarkID)markid{
    __block int index = 5564534;
    
    [topMenuArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        int curMarkID = [[obj objectForKey:@"MarkID"] intValue];
        if (markid == curMarkID) {
            index = idx;
        }
    }];
    
    if (index != 5564534) {
        [horizontal ee_setSelectedItem:index clicked:NO];
    }
}

#pragma mark - 请求网络 -
-(void)getWebRequest_Slider{
    
    WebServiceTools *webserv = [[WebServiceTools alloc] init];
    
    [webserv.request setPostValue:@"{\"method\":\"GetHomeList\",\"attachment\":{\"maxid\":\"9\",\"type\":\"3\"}}" forKey:@"paramter"];
    
    [webserv ee_execute_delegate:self finishSEL:@selector(success:) FailedSEL:@selector(failed:)];
}

-(void)success:(ASIHTTPRequest *)request{
    trace(@"%@",request.responseString);
}

-(void)failed:(ASIHTTPRequest *)request{
    trace(@"%@",request.responseString);
    
}


-(void)dealloc{
    [topMenuArray release];
    topMenuArray = nil;
    
    [horizontal release];
    horizontal = nil;
    
    
    [super dealloc];
}



@end
