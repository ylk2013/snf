//
//  EEAnimationManager.h
//  DaRenXiu
//
//  Created by pai hong on 12-4-25.
//  Copyright (c) 2012年 
//-------洪湃--------------
//---qq:  454077256-------
//---tel: 186 2159 2830---
//------------------------. . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EEAnimationManager : NSObject{
    NSMutableDictionary *animationDiction;
    NSMutableDictionary *heroDiction;
}

+(EEAnimationManager *)shareInstance;

-(void)registHero:(UIView *)hero byName:(NSString *)heroname;
-(void)registAnimation:(NSArray *)imgArray byName:(NSString *)animatName;
-(void)playhero:(NSString *)heroName playAnimation:(NSString *)animation playDuring:(NSTimeInterval)during playCount:(NSInteger)count playScale:(float)scalenum;

@end
