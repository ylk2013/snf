//
//  EEBreathingTool.h
//  DaRenXiu
//
//  Created by pai hong on 12-5-2.
//  Copyright (c) 2012年 
//-------洪湃--------------
//---qq:  454077256-------
//---tel: 186 2159 2830---
//------------------------. . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EEBreathingTool : NSObject{
    BOOL isBreathOut;//breathout breathin
    NSTimer *boolTimer;
    SEL boolSELing;
    SEL boolSELend;
    id  boolDelegate;
    NSInteger totalCount;
    NSInteger boolCount;
    
    //韩伟  说说你的游戏构思
}

+(EEBreathingTool *)shareInstance;

-(void)breathingWithBoolValue_times:(NSInteger)count delay:(NSTimeInterval)_delay delegate:(id)_delegate selIng:(SEL)_selIng selOver:(SEL)_selOver;

@end
