//
//  EEAnimationManager.m
//  DaRenXiu
//
//  Created by pai hong on 12-4-25.
//  Copyright (c) 2012年 
//-------洪湃--------------
//---qq:  454077256-------
//---tel: 186 2159 2830---
//------------------------. . All rights reserved.
//

#import "EEAnimationManager.h"
#import "UIImage+Extras.h"

@implementation EEAnimationManager


+(EEAnimationManager *)shareInstance{
    static EEAnimationManager *instance = nil;
    @synchronized(self){
        if (!instance) {
            instance = [[EEAnimationManager alloc] init];
        }
    }
    return instance;
}

-(id)init{
    if (self = [super init]) {
        heroDiction = [[NSMutableDictionary alloc] init];
        animationDiction = [[NSMutableDictionary alloc] init];
    }
    return self;
}

//加入hero
-(void)registHero:(UIView *)hero byName:(NSString *)heroname{
    //如果有背景的话，则设置透明
    [hero setBackgroundColor:[UIColor clearColor]];
    
    [heroDiction setValue:hero forKey:heroname];
}

//加入动画
-(void)registAnimation:(NSArray *)imgArray byName:(NSString *)animatName{
    NSMutableArray *animateArr = [NSMutableArray array];
    
    //记录长度和宽度，以动画的最后一张图片长宽为准
    float tempwidth;
    float tempheight;
    
    for (int i=0; i<[imgArray count]; i++) {
        NSString *filePath = [imgArray objectAtIndex:i];
        UIImage *img = [UIImage imageWithContentsOfResolutionIndependentFile:filePath];
        [animateArr addObject:img];
        
        tempwidth = img.size.width;
        tempheight = img.size.height;
    }
    
    UIImageView *animateView = [[UIImageView alloc] init];
    animateView.animationImages = animateArr;
    animateView.animationDuration = 1.0;
    animateView.animationRepeatCount = 1;
    
    [animateView setFrame:CGRectMake(0, 0, tempwidth, tempheight)];
    
    //加入dictionary
    [animationDiction setValue:animateView forKey:animatName];
    
    [animateView release];
}

//播放动画  
-(void)playhero:(NSString *)heroName playAnimation:(NSString *)animation playDuring:(NSTimeInterval)during playCount:(NSInteger)count playScale:(float)scalenum{ 
    
    UIView *hero = [heroDiction objectForKey:heroName];
    if (hero==nil) {
        NSLog(@"容器为nil，不能播放动画");
        return;
    }
    
    UIImageView *playimgview = [animationDiction objectForKey:animation];
    if (playimgview==nil) {
        NSLog(@"找不到动画，不能播放动画");
        return;
    }
    

    //清空容器
    for (id a in [hero subviews]) {
        [a removeFromSuperview];
    }
    playimgview.animationDuration = during;
    playimgview.animationRepeatCount = count;
    
    //开始动画    
    [hero addSubview:playimgview];
    //设置缩放大小
    [playimgview setTransform:CGAffineTransformMakeScale(scalenum, scalenum)];
    
    CGRect r = [playimgview frame];
    r.origin.x = 0;
    r.origin.y = 0;
    [playimgview setFrame:r];
    
    [playimgview startAnimating];
}




























@end
