//
//  DragView.m
//  EENews
//
//  Created by hong pai on 12-10-21.
//  Copyright (c) 2012年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "LookQuickView.h"
#import "AppListViewController.h"
#import "UIView+EEExtras.h"

@implementation LookQuickView

@synthesize delegate;

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
    
    // float difx = [[touches anyObject] locationInView:self].x - [[touches anyObject] previousLocationInView:self].x;
    
    float dify = [[touches anyObject] locationInView:self].y - [[touches anyObject] previousLocationInView:self].y;
    
    //CGAffineTransform newTransform1 = CGAffineTransformTranslate(self.transform, difx, dify);
    CGAffineTransform newTransform1 = CGAffineTransformTranslate(self.transform, 0, dify);
    
    self.transform = newTransform1;
    
    float cury = self.frame.origin.y;
    float bili = cury / self.frame.size.height;;
    
    //改变颜色
    [[Global shareGlobel].applistviewcontroller ee_StepScale_betweenShowAndHide:bili];
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    //NSLog(@"释放");
    [self ee_dragOver];
}

-(void)ee_dragOver{
    float cury = self.frame.origin.y;
    
    if (cury>=60) {//大于60距离就有效
        float height = self.frame.size.height;
        [self ee_tween:0.3 to:([NSString stringWithFormat:@"x:0,y:%f",height])];
        
        //applist 恢复原型
        [[Global shareGlobel].applistviewcontroller ee_StateChangedToFront];
    }else {//否则无效
        [self ee_tween:0.3 to:@"x:0,y:0"];
    }
}






@end
