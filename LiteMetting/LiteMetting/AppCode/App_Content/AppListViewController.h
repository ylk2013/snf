//
//  AppListViewController.h
//  EENews
//
//  Created by hong pai on 12-10-21.
//  Copyright (c) 2012年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EEEventUIButton.h"


//定义是否可以左右滑动


@interface AppListViewController : UIViewController{
    
    IBOutlet EEEventUIButton *btn_left;
    IBOutlet EEEventUIButton *btn_right;
    
    IBOutlet UIButton *btn_back;
    
    IBOutlet UITabBarController *rootTabBar;
    
    CGPoint lastRemenberPanPosition;
    
    AppListPanDirect ee_appPanDirect;
    
    IBOutlet UIButton *tabbar_btn1;
    IBOutlet UIButton *tabbar_btn2;
    IBOutlet UIButton *tabbar_btn3;
    IBOutlet UIButton *tabbar_btn4;
    
    IBOutlet UIImageView *topbar;
}
@property(nonatomic,retain)IBOutlet UIImageView *topbar;

@property(nonatomic,retain)IBOutlet UIButton *tabbar_btn1;
@property(nonatomic,retain)IBOutlet UIButton *tabbar_btn2;
@property(nonatomic,retain)IBOutlet UIButton *tabbar_btn3;
@property(nonatomic,retain)IBOutlet UIButton *tabbar_btn4;

@property(nonatomic,retain)IBOutlet UITabBarController *rootTabBar;

@property(nonatomic,retain)IBOutlet EEEventUIButton *btn_right;
@property(nonatomic,retain)IBOutlet EEEventUIButton *btn_left;

@property(nonatomic,retain)IBOutlet UIButton *btn_back;

//设置程序可以滑动的方向
-(void)ee_setAppCanMoveDirections:(AppListPanDirect)panDirect;

-(void)ee_StateChangedToBackGroud;
-(void)ee_StateChangedToFront;

-(void)ee_StepScale_betweenShowAndHide:(float)value;

-(void)ee_openModalByModalConfig:(NSMutableDictionary *)modalConfig;

-(IBAction)clickTabBarIndex:(UIButton *)btn;

#pragma mark - 返回控制
-(void)ee_setBackButtonVisible:(BOOL)isShow;
-(IBAction)clickReturnBtn:(id)sender;













@end
