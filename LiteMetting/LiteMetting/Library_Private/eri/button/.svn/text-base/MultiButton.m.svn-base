//
//  MultiButton.m
//  DaRenXiu
//
//  Created by pai hong on 12-4-22.
//  Copyright (c) 2012年 
//-------洪湃--------------
//---qq:  454077256-------
//---tel: 186 2159 2830---
//------------------------. . All rights reserved.
//

/*
 
 How:
 把button的class映射成MultiButton
 把button的title设置成“big”、“down”即可，
 
 */


#import "MultiButton.h"

@implementation MultiButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//缩放
-(void)scale_to_big:(BOOL)b{
    if (b) {
        currentState = ButtonState_big;
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.1];
        [self setTransform:CGAffineTransformMakeScale(1.1, 1.1)];
        [UIView commitAnimations];   
    }else {
        currentState = ButtonState_normal;
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.1];
        [self setTransform:CGAffineTransformMakeScale(1, 1)];
        [UIView commitAnimations];   
    }
}

//移动
-(void)move_to_dowm:(BOOL)b{
    if (b) {
        currentState = ButtonState_down;
        
        CGRect rect = self.frame;
        rect.origin.y += 5;
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.1];
        [self setFrame:rect];
        [UIView commitAnimations];  
    }else {
        currentState = ButtonState_normal;
        
        CGRect rect = self.frame;
        rect.origin.y -= 5;
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.1];
        [self setFrame:rect];
        [UIView commitAnimations];  
        
    }
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (currentState == ButtonState_normal) {
        if ([self.titleLabel.text isEqualToString:@"big"]) {//放大模式
            [self scale_to_big:YES];
        }else if([self.titleLabel.text isEqualToString:@"down"]){//下移模式
            [self move_to_dowm:YES];
        }
    }
    [super touchesBegan:touches withEvent:event];
    //吧label 隐藏
    self.titleLabel.hidden = YES;
}

/*
 -(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    trace(@"%@",self);
    if (currentState == ButtonState_normal) {
        if ([self.titleLabel.text isEqualToString:@"big"]) {//放大模式
            [self scale_to_big:YES];
        }else if([self.titleLabel.text isEqualToString:@"down"]){//下移模式
            [self move_to_dowm:YES];
        }
    }
    [super touchesMoved:touches withEvent:event];
}
 */

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if ([self.titleLabel.text isEqualToString:@"big"]) {//放大模式
        [self scale_to_big:NO];
    }else if([self.titleLabel.text isEqualToString:@"down"]){//下移模式
        [self move_to_dowm:NO];
    }
    [super touchesEnded:touches withEvent:event];
    //吧label 隐藏
    self.titleLabel.hidden = YES;
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    //吧label 隐藏
    self.titleLabel.hidden = YES;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
