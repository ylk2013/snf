//
//  AppListView.m
//  EENews
//
//  Created by hong pai on 12-10-22.
//  Copyright (c) 2012年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "AppListView.h"
#import "UIView+EEExtras.h"
#import "AppListViewController.h"
#import "RIghtFiterCtr.h"
#import "LeftModalCtr.h"
#import "Reachability.h"


@implementation AppListView

#define ToLeftCtrPoint 200
#define TorightCtrPoint -160

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
//        UISwipeGestureRecognizer *swipGesture2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipToLeft:)];
//        swipGesture2.direction = UISwipeGestureRecognizerDirectionLeft;
//        swipGesture2.numberOfTouchesRequired = 1;
//        [self addGestureRecognizer:swipGesture2];
//        
//        UISwipeGestureRecognizer *swipGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipToRight:)];
//        swipGesture.direction = UISwipeGestureRecognizerDirectionRight;
//        swipGesture.numberOfTouchesRequired = 1;
//        [self addGestureRecognizer:swipGesture];
        
        //查看网络状态
//        if([[Reachability reachabilityWithHostName:@"www.apple.com"] currentReachabilityStatus] == kNotReachable){
//            [self checkOffLineLogin];
//        }else{
        
         
        
    }
    return self;
}

-(void)swipToLeft:(UISwipeGestureRecognizer *)recong{
    trace(@"left");
}

-(void)swipToRight:(UISwipeGestureRecognizer *)recong{
    trace(@"right");    
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    // NSLog(@"sdf");
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    float difx = [[touches anyObject] locationInView:self].x - [[touches anyObject] previousLocationInView:self].x;
//    
//    CGAffineTransform newTransform1 = CGAffineTransformTranslate(self.transform, difx, 0);
//    
//    self.transform = newTransform1;
//    
//    float curx = self.frame.origin.x;
//    
//    if (curx<=0) {
//        [Global shareGlobel].rightfiterctr.view.hidden = NO;
//        [Global shareGlobel].leftmodalctr.view.hidden  = YES;
//    }else{
//        [Global shareGlobel].rightfiterctr.view.hidden = YES;
//        [Global shareGlobel].leftmodalctr.view.hidden  = NO;
//    }
    
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"释放");
    [self ee_dragOver];
    //
}
-(void)ee_resetPositionByLastPosition:(CGPoint )lastRemenberPanPosition curPosition:(CGPoint)curPoint appDirection:(AppListPanDirect)apppandirection{

    float difx =  (curPoint.x - lastRemenberPanPosition.x);
    
    CGAffineTransform newTransform1 = CGAffineTransformTranslate(self.transform, difx, 0);
    
    
    
    {
        if (apppandirection == AppListPanDirect_None) {
            
        }else if(apppandirection == AppListPanDirect_OnlyShowLeft){
            
            self.transform = newTransform1;
            
            if (self.frame.origin.x <0) {
                
                CGRect rect = self.frame;
                rect.origin.x = 0;
                [self setFrame:rect];
            }
            
        }else if(apppandirection == AppListPanDirect_OnlyShowRight){
            self.transform = newTransform1;
            if ((self.frame.origin.x + newTransform1.tx) >0) {
                
                CGRect rect = self.frame;
                rect.origin.x = 0;
                [self setFrame:rect];
            }
            
        }else if(apppandirection == AppListPanDirect_LeftAndRight){
            self.transform = newTransform1;
        }
        
        //            if ((self.view.frame.origin.x + newTransform1.tx) <0) {
        //                CGRect rect = self.view.frame;
        //                rect.origin.x = 0;
        //                [self.view setFrame:rect];
        //            }else{
        //
        //                lastRemenberPanPosition = curPoint;
        //                [self.view setTransform:newTransform1];
        //            }
    }
    
    
    
    float curx = self.frame.origin.x;
    
    if (curx<=0) {
        [Global shareGlobel].rightfiterctr.view.hidden = NO;
        [Global shareGlobel].leftmodalctr.view.hidden  = YES;
    }else{
        [Global shareGlobel].rightfiterctr.view.hidden = YES;
        [Global shareGlobel].leftmodalctr.view.hidden  = NO;
    }
}

-(void)ee_dragOver{
    float  curx = self.frame.origin.x;
    
    if (isShowingState) {
        if (curx<=-30) {
            [self ee_showRightCtr];
        }else if(curx>=60){
            [self ee_showLeftCtr];
        }else if(curx<60 && curx>-30){
            [self selfViewReset];
        }
    }else{
        if (curx>=100) {//大于60距离就有效 显示 LeftModalCtr
            [self ee_showLeftCtr];
            //applist 恢复原型
            //[[Global shareGlobel].applistviewcontroller ee_StateChangedToFront];
        }else if(curx<=-60){
            [self ee_showRightCtr];
            
        }else {//否则无效
            [self ee_tween:0.3 to:@"x:0,y:0"];
        }
    }
}

-(void)selfViewReset{
    [self ee_tween:0.3 to:([NSString stringWithFormat:@"x:0,y:0"])];
}

-(void)ee_showLeftCtr{
    [Global shareGlobel].rightfiterctr.view.hidden = YES;
    [Global shareGlobel].leftmodalctr.view.hidden  = NO;
    
    [self ee_tween:0.3 to:([NSString stringWithFormat:@"x:%d,y:0",ToLeftCtrPoint])];
}

-(void)ee_showRightCtr{
    [Global shareGlobel].rightfiterctr.view.hidden = NO;
    [Global shareGlobel].leftmodalctr.view.hidden  = YES;
    
    [self ee_tween:0.3 to:([NSString stringWithFormat:@"x:%d,y:0",TorightCtrPoint])];
}


@end
