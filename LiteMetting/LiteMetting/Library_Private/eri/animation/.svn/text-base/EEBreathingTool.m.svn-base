//
//  EEBreathingTool.m
//  DaRenXiu
//
//  Created by pai hong on 12-5-2.
//  Copyright (c) 2012年 
//-------洪湃--------------
//---qq:  454077256-------
//---tel: 186 2159 2830---
//------------------------. . All rights reserved.
//
/*
 
 How use:
 
 -(void)showRightAnswer_bytools{
    [[EEBreathingTool shareInstance] breathingWithBoolValue_times:4 delay:0.20 delegate:self selIng:@selector(changedState:) selOver:nil];
 }
 -(void)changedState:(NSNumber*)ob{
    trace(@"fff");
    NSInteger resint = [result intValue];
    UIButton *btn = (UIButton *)[self.view viewWithTag:resint];
    BOOL b = [ob boolValue];
    if (b) {
        [btn setSelected:YES] ;
    }else {
        [btn setSelected:NO] ;
    }
 }
 
 */


#import "EEBreathingTool.h"

@implementation EEBreathingTool

+(EEBreathingTool *)shareInstance{
    static EEBreathingTool *instance = nil;
    @synchronized(self){
        if (!instance) {
            instance = [[EEBreathingTool alloc] init];
        }
    }
    return instance;
}

-(id)init{
    if (self = [super init]) {
        
    }
    return self;
}

-(void)breathingWithBoolValue{
    NSLog(@"breathing");
    isBreathOut = !isBreathOut;
    if (boolCount>=totalCount) {
        if (boolSELend!=nil) {
            [boolDelegate performSelector:boolSELend withObject:[NSNumber numberWithBool:isBreathOut]];   
        }
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [boolTimer invalidate];
        boolTimer = nil;
        boolSELend = nil;
        boolSELing = nil;
        boolDelegate = nil;
        return;
    }
    
    [boolDelegate performSelector:boolSELing withObject:[NSNumber numberWithBool:isBreathOut]];
    boolCount ++;
}

//做布尔呼吸
-(void)breathingWithBoolValue_times:(NSInteger)count delay:(NSTimeInterval)_delay delegate:(id)_delegate selIng:(SEL)_selIng selOver:(SEL)_selOver{
    //trace(@"breathing232323");
    boolCount = 0;
    boolDelegate = _delegate;
    boolSELing = _selIng;
    boolSELend = _selOver;
    totalCount = count;
    
    boolTimer = [NSTimer scheduledTimerWithTimeInterval:_delay target:self selector:@selector(breathingWithBoolValue) userInfo:nil repeats:YES];
}

//做递增，递减，呼吸
-(void)breathingWithIncrease_During:(NSTimeInterval)during step:(NSTimeInterval)_step delegate:(id)_delegate _inCrease:(NSInteger)inCrease  func:(SEL)_func{
}



























@end
