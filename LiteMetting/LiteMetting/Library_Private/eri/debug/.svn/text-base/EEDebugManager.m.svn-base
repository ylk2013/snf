//
//  DebugManager.m
//  GETExceptionTest
//
//  Created by pai hong on 12-10-21.
//  Copyright (c) 2012年 eri hongpai 454077256. All rights reserved.
//


/**
how to use:
 
 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
 {
    .......
    
    [[[EEDebugManager alloc] init] initDebugManager:self.window];
    return YES;
 }
 */

#import "EEDebugManager.h"
#import "UncaughtExceptionHandler.h"
#import "JHNotificationManager.h"

@implementation EEDebugManager


#pragma mark - 
#pragma mark ------- 添加异常捕获提示窗口 -------
-(void)initDebugManager:(UIWindow *)mainWindow{
    _mainWindow = mainWindow;
    
    [self addOneStep];
}

-(void)addOneStep{
    recog1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(getFingerStep1Infor:)];
    recog1.direction = UISwipeGestureRecognizerDirectionUp;
    recog1.numberOfTouchesRequired = 2;
    [_mainWindow addGestureRecognizer:recog1];
    [recog1 release];
}

-(void)getFingerStep1Infor:(id)sender{
    [_mainWindow removeGestureRecognizer:sender];
    [self addTwoStep];
    
    [self performSelector:@selector(reset) withObject:nil afterDelay:2];
}

//2秒后如果没有执行twostep的话，则reset
-(void)reset{
    if(!isSuccess){
        [self addOneStep];
        [_mainWindow removeGestureRecognizer:recog2];
    }   
}

-(void)addTwoStep{
    recog2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(getFingerStep2Infor:)];
    recog2.direction = UISwipeGestureRecognizerDirectionRight;
    recog2.numberOfTouchesRequired = 2;
    [_mainWindow addGestureRecognizer:recog2];
    [recog2 release];
}

-(void)getFingerStep2Infor:(id)sender{
    isSuccess = YES;
    
    [_mainWindow removeGestureRecognizer:sender];
    NSLog(@"--------------添加异常捕获提示窗口-------------");
    //添加异常捕获提示窗口
    InstallUncaughtExceptionHandler();
    [JHNotificationManager notificationWithMessage:@"程序进入了 调试捕捉模式"];
}










@end