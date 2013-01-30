//
//  AppListViewController.m
//  EENews
//
//  Created by hong pai on 12-10-21.
//  Copyright (c) 2012年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "AppListViewController.h"
#import "UIView+EEExtras.h"
#import "AppListView.h"
#import "LiteMettingViewController.h"
#import "FocusViewController.h"


@interface AppListViewController ()

@end

@implementation AppListViewController

@synthesize topbar;

@synthesize btn_left,btn_right,rootTabBar,btn_back;

@synthesize tabbar_btn1,tabbar_btn2,tabbar_btn3,tabbar_btn4;

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
    
    //btn_left.ee_moveEventTarget = self.view;
    //btn_right.ee_moveEventTarget = self.view;
    
    [self managerGestureRecongnizer];
    
    [self initTableViewController];
    
    //设置程序可以滑动的方向
    [self ee_setAppCanMoveDirections:AppListPanDirect_OnlyShowLeft];
    
    [self addShadow];
//    [rootTabBar.tabBar setFrame:CGRectMake(0, 0, 320, 45)];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [rootTabBar.view setFrame:CGRectMake(0, 44, ee_AppSize.width, ee_AppSize.height-20-44)];
}

-(void)initTableViewController{
    [self.view addSubview:rootTabBar.view];
    
    [self.view sendSubviewToBack:rootTabBar.view];
}

-(void)addShadow{
    UIImageView *imageShadow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topbar_shadow.png"]];
    imageShadow.contentMode = UIViewContentModeScaleToFill;
    [imageShadow setFrame:CGRectMake(0, topbar.frame.size.height, ee_AppSize.width, 3)];
    [self.view addSubview:imageShadow];
}
-(void)suofang{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 手势控制 
-(void)managerGestureRecongnizer{
    
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handelPan:)];
    trace(@"%d",panGes.state);
    
    [self.view addGestureRecognizer:panGes];
    [panGes release];
}

-(void)handelPan:(UIPanGestureRecognizer *)gestureRecognizer{
    //获取平移手势对象在self.view的位置点，并将这个点作为self.aView的center,这样就实现了拖动的效果
    //CGPoint curPoint = [gestureRecognizer locationInView:[self.view viewWithTag:11]];
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        lastRemenberPanPosition = [gestureRecognizer locationInView:[Global shareGlobel].rootController.view];
    }else if(gestureRecognizer.state == UIGestureRecognizerStateChanged){
        CGPoint curPoint = [gestureRecognizer locationInView:[Global shareGlobel].rootController.view];
        
        [(AppListView *)self.view ee_resetPositionByLastPosition:lastRemenberPanPosition curPosition:curPoint appDirection:ee_appPanDirect];
        
        lastRemenberPanPosition = curPoint;
    }else if(gestureRecognizer.state == UIGestureRecognizerStateEnded){
        [(AppListView *)self.view ee_dragOver];
    }
    // [self.view setCenter:curPoint];
}

#pragma mark - 运动控制

//设置程序界面可运动的方向
-(void)ee_setAppCanMoveDirections:(AppListPanDirect)panDirect{
    ee_appPanDirect = panDirect;
}

//进入其他view下面，被遮挡住
-(void)ee_StateChangedToBackGroud{
    UIView *blackmaskview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    blackmaskview.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:blackmaskview];
    [blackmaskview setBackgroundColor:[UIColor blackColor]];
    blackmaskview.alpha = 0;
    blackmaskview.tag = 20;
    [blackmaskview release];
    [blackmaskview ee_tween:0.3 to:@"alpha:0.7"];

    float scaleValue = 0.8;
    int lastWith   = (int)ee_AppSize.width*scaleValue;
    int lastHeight = (int)(ee_AppSize.height-20)*scaleValue;
    int lastx = (int)((ee_AppSize.width - lastWith) * 0.5);
    int lasty = (int)(((ee_AppSize.height-20) - lastHeight) * 0.5);
    
    [self.view ee_tween:0.3 to:([NSString stringWithFormat:@"x:%d,y:%d,width:%d,height:%d",lastx,lasty,lastWith,lastHeight])];
    
}
//进入顶层
-(void)ee_StateChangedToFront{
    
    
    [self.view ee_tween:0.3 to:([NSString stringWithFormat:@"x:%d,y:%d,width:%f,height:%f",0,0,ee_AppSize.width,ee_AppSize.height-20]) delegate:self sel:@selector(moveOverOk)];
    
}

-(void)moveOverOk{
    
    trace(@"____%@",[NSValue valueWithCGRect:self.view.frame]);
    UIView *blackmaskview = [self.view viewWithTag:20];
    [blackmaskview removeFromSuperview];
    [self.view setFrame:CGRectMake(0, 0, ee_AppSize.width, ee_AppSize.height-20)];
    
    NSValue *n = [NSValue valueWithCGRect:self.view.frame];
    trace(@"%@",n);
}


//由暗变亮 value 0-1
-(void)ee_StepScale_betweenShowAndHide:(float)value{
    //trace(@"%f",value);
    UIView *blackmaskview = [self.view viewWithTag:20];
    
    float scaleValue = 0.85+0.15*value;
    int lastWith   = (int)ee_AppSize.width*scaleValue;
    int lastHeight = (int)ee_AppSize.height*scaleValue;
    
    int lastx = (int)((ee_AppSize.width - lastWith) * 0.5);
    int lasty = (int)((ee_AppSize.height - lastHeight) * 0.5);
    
    [self.view setFrame:CGRectMake(lastx, lasty, lastWith, lastHeight)];
    
    trace(@"lastwidth:%d",lastWith);
    trace(@"lastheight:%d",lastHeight);
    
    [self.view bringSubviewToFront:blackmaskview];
    blackmaskview.alpha = 0.7-value*0.7;
    
    [blackmaskview setFrame:CGRectMake(0, 0, 1000  , 2000)];
}

#pragma mark - 点击按钮移动
-(IBAction)clickLeftTypeBtn{
    [(AppListView *)self.view ee_showLeftCtr];
}

-(IBAction)clickRightTypeBtn{
    [(AppListView *)self.view ee_showRightCtr];
}

-(IBAction)click1111:(id)sender{
//    trace(@"%f",self.view.transform.a);
    NSValue *n = [NSValue valueWithCGRect:self.view.frame];
    trace(@"%@",n);
    
    trace(@"%@",[NSValue valueWithCGRect:[self.view viewWithTag:11].frame]);
    trace(@"%@",[NSValue valueWithCGRect:rootTabBar.view.frame]);
}



#pragma mark - 显示 modal controller 控制
-(void)ee_openModalByModalConfig:(NSMutableDictionary *)modalConfig{
    track();
    int markID = [[modalConfig objectForKey:@"MarkID"] intValue];
    
    
    if (markID == MarkID_News) {
        trace(@"点击了  news");
        [[Global shareGlobel].focusViewController clickShowNews:nil];
        [rootTabBar setSelectedIndex:0];
        [self setTabBarSelectIndex:0];
    }else if(markID == MarkID_MeetSchedul){
        trace(@"点击了  MeetSchedule");
        [rootTabBar setSelectedIndex:1];
        [self setTabBarSelectIndex:1];
    }else if(markID == MarkID_Expert){
        trace(@"点击了  Expert");
        [rootTabBar setSelectedIndex:2];
        [self setTabBarSelectIndex:2];
    }else if(markID == MarkID_MySchedul){
        trace(@"点击了  MySchedul");
        [rootTabBar setSelectedIndex:3];
        [self setTabBarSelectIndex:3];
    }else if(markID == MarkID_Map){
        trace(@"点击了  Map");
        [[Global shareGlobel].focusViewController clickShowMaps:nil];
        [rootTabBar setSelectedIndex:0];
        [self setTabBarSelectIndex:0];
    }else if(markID == MarkID_Notice){
        trace(@"点击了  Notice");
        [[Global shareGlobel].focusViewController clickShowNotice:nil];
        [rootTabBar setSelectedIndex:0];
        [self setTabBarSelectIndex:0];
    }else if(markID == MarkID_ImageWall){
        trace(@"点击了  ImageWall");
        [[Global shareGlobel].focusViewController clickShowImagesWall:nil];
        [rootTabBar setSelectedIndex:0];
        [self setTabBarSelectIndex:0];
    }else if(markID == MarkID_Partners){
        trace(@"点击了  Partners");
        [[Global shareGlobel].focusViewController clickShowPartners:nil];
        [rootTabBar setSelectedIndex:0];
        [self setTabBarSelectIndex:0];
    }else if(markID == MarkID_Around){
        trace(@"点击了  Around");
        [[Global shareGlobel].focusViewController clickShowAround:nil];
        [rootTabBar setSelectedIndex:0];
        [self setTabBarSelectIndex:0];
    }else if(markID == MarkID_TableModal1){
        trace(@"点击了  focu");
        [[Global shareGlobel].focusViewController ee_ShowAllNavigationDefaultView];
        [rootTabBar setSelectedIndex:0];
        [self setTabBarSelectIndex:0];
    }
}


#pragma mark - 返回控制 -

-(IBAction)clickReturnBtn:(id)sender{
    //清空focus
    [[Global shareGlobel].focusViewController ee_ShowAllNavigationDefaultView];
}

-(void)ee_setBackButtonVisible:(BOOL)isShow{
    if (isShow) {
        btn_back.hidden = NO;
    }else{
        btn_back.hidden = YES;
    }
}

#pragma mark - UITabBar State Control -

-(void)allTabBarChangedToNormal{
    tabbar_btn1.selected = NO;
    tabbar_btn2.selected = NO;
    tabbar_btn3.selected = NO;
    tabbar_btn4.selected = NO;
    
}

-(IBAction)clickTabBarIndex:(UIButton *)btn{
    //changed current btn to highLight state
    [self allTabBarChangedToNormal];
    btn.selected = YES;
    
    //change UITabBarViewController to click index
    if (btn==tabbar_btn1) {
        rootTabBar.selectedIndex = 0;
    }else if(btn==tabbar_btn2){
        rootTabBar.selectedIndex = 1;
    }else if(btn==tabbar_btn3){
        rootTabBar.selectedIndex = 2;
    }else if(btn==tabbar_btn4){
        rootTabBar.selectedIndex = 3;
    }
}


-(void)setTabBarSelectIndex:(int)index{
    [self allTabBarChangedToNormal];
    
    if (index==0) {
        tabbar_btn1.selected = YES;
    }else if(index==1){
        tabbar_btn2.selected = YES;
    }else if(index==2){
        tabbar_btn3.selected = YES;
    }else if(index==3){
        tabbar_btn4.selected = YES;
    }
}

















@end
