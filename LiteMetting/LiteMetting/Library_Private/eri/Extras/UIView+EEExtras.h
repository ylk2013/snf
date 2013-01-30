//
//  UIView+convenience.h
//
//  Created by Tjeerd in 't Veen on 12/1/11.
//  Copyright (c) 2011 Vurig Media. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (EEExtras)

@property (nonatomic) CGPoint frameOrigin;
@property (nonatomic) CGSize frameSize;

@property (nonatomic) CGFloat frameX;
@property (nonatomic) CGFloat frameY;

// Setting these modifies the origin but not the size.
@property (nonatomic) CGFloat frameRight;
@property (nonatomic) CGFloat frameBottom;

@property (nonatomic) CGFloat frameWidth;
@property (nonatomic) CGFloat frameHeight;

-(BOOL) ee_containsSubView:(UIView *)subView;
-(BOOL) ee_containsSubViewOfClassType:(Class)class;



-(void)ee_fadeIn:(NSTimeInterval)dur;
-(void)ee_fadeOut:(NSTimeInterval)dur;
-(void)ee_fadeIn:(NSTimeInterval)dur delegate:(id)dgate sel:(SEL)function;
-(void)ee_fadeOut:(NSTimeInterval)dur delegate:(id)dgate sel:(SEL)function;

-(void)ee_tween:(NSTimeInterval)dur to:(NSString *)paramTo;
-(void)ee_tween:(NSTimeInterval)dur to:(NSString *)paramTo delegate:(id)dgate sel:(SEL)function;
-(void)ee_tween:(NSTimeInterval)dur from:(NSString *)paramFrom to:(NSString *)paramTo;
-(void)ee_tween:(NSTimeInterval)dur from:(NSString *)paramFrom to:(NSString *)paramTo delegate:(id)dgate sel:(SEL)function;
//[v ee_tween:1 from:@"{x:100,y:100,alpha:0}" to:@"{x:300,y:300,alpha:1}"];







-(void)ee_viewToUp:(int)space;
-(void)ee_viewToDown:(int)space;
-(void)ee_viewToLeft:(int)space;
-(void)ee_viewToRight:(int)space;
    
    
@end
