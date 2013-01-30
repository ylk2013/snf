//
//  UIView+convenience.m
//
//  Created by Tjeerd in 't Veen on 12/1/11.
//  Copyright (c) 2011 Vurig Media. All rights reserved.
//

#import "UIView+Extras.h"

@implementation UIView (EEExtras)

-(BOOL) ee_containsSubView:(UIView *)subView
{
    for (UIView *view in [self subviews]) {
        if ([view isEqual:subView]) {
            return YES;
        }
    }
    return NO;
}

-(BOOL) ee_containsSubViewOfClassType:(Class)class {
    for (UIView *view in [self subviews]) {
        if ([view isMemberOfClass:class]) {
            return YES;
        }
    }
    return NO;
}

- (CGPoint)frameOrigin {
	return self.frame.origin;
}

- (void)setFrameOrigin:(CGPoint)newOrigin {
	self.frame = CGRectMake(newOrigin.x, newOrigin.y, self.frame.size.width, self.frame.size.height);
}

- (CGSize)frameSize {
	return self.frame.size;
}

- (void)setFrameSize:(CGSize)newSize {
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,
							newSize.width, newSize.height);
}

- (CGFloat)frameX {
	return self.frame.origin.x;
}

- (void)setFrameX:(CGFloat)newX {
	self.frame = CGRectMake(newX, self.frame.origin.y,
							self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameY {
	return self.frame.origin.y;
}

- (void)setFrameY:(CGFloat)newY {
	self.frame = CGRectMake(self.frame.origin.x, newY,
							self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameRight {
	return self.frame.origin.x + self.frame.size.width;
}

- (void)setFrameRight:(CGFloat)newRight {
	self.frame = CGRectMake(newRight - self.frame.size.width, self.frame.origin.y,
							self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameBottom {
	return self.frame.origin.y + self.frame.size.height;
}

- (void)setFrameBottom:(CGFloat)newBottom {
	self.frame = CGRectMake(self.frame.origin.x, newBottom - self.frame.size.height,
							self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameWidth {
	return self.frame.size.width;
}

- (void)setFrameWidth:(CGFloat)newWidth {
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,
							newWidth, self.frame.size.height);
}

- (CGFloat)frameHeight {
	return self.frame.size.height;
}

- (void)setFrameHeight:(CGFloat)newHeight {
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,
							self.frame.size.width, newHeight);
}


#pragma mark -
#pragma mark ----常见的动画----


-(void)ee_fadeIn:(NSTimeInterval)dur {
    self.alpha = 0;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:dur];
    self.alpha = 1;
    [UIView commitAnimations];
}   
-(void)ee_fadeOut:(NSTimeInterval)dur {
    self.alpha = 1;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:dur];
    self.alpha = 0;
    [UIView commitAnimations];
}   


-(void)ee_fadeIn:(NSTimeInterval)dur delegate:(id)dgate sel:(SEL)function{
    self.alpha = 0;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:dur];
    [UIView setAnimationDelegate:dgate];
    [UIView setAnimationDidStopSelector:function];
    self.alpha = 1;
    [UIView commitAnimations];
} 


-(void)ee_fadeOut:(NSTimeInterval)dur delegate:(id)dgate sel:(SEL)function{
    self.alpha = 1;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:dur];
    [UIView setAnimationDelegate:dgate];
    [UIView setAnimationDidStopSelector:function];
    self.alpha = 0;
    [UIView commitAnimations];
} 

/* * 
 simple tweener
 
 create by hongpai qq:454077256   date: 10.17 2012
 
 support view property: x, y, alpha, sx(scalex), sy(scaley)
 
 example:
 [v ee_tween:1.5 from:@"x:100,y:100,alpha:0,sx:1.5,sy:1.5" to:@"x:300,y:200,alpha:1,sx:2,sy:3"];
 */
-(void)ee_tween:(NSTimeInterval)dur from:(NSString *)paramFrom to:(NSString *)paramTo{
    [self ee_tween:dur from:paramFrom to:paramTo delegate:nil sel:nil];
}

-(void)ee_tween:(NSTimeInterval)dur from:(NSString *)paramFrom to:(NSString *)paramTo delegate:(id)dgate sel:(SEL)function{
    NSRange rangeFrom   = [paramFrom rangeOfString:@"，"];
    NSRange rangeto     = [paramTo rangeOfString:@"，"];
    NSRange rangeFrom2   = [paramFrom rangeOfString:@"："];
    NSRange rangeto2     = [paramTo rangeOfString:@"："];
    NSAssert(rangeFrom.length==0&&rangeto.length==0&&rangeFrom2.length==0&&rangeto2.length==0, @"Full-width letter be found in post params ，：(参数中，有全角字符 ，：)");
    
    NSArray *fromarray  = [paramFrom componentsSeparatedByString:@","];
    NSArray *toarray    = [paramTo componentsSeparatedByString:@","];
    
    //set starting property
    for (int i=0; i<[fromarray count]; i++) {
        NSString *oneParam = [fromarray objectAtIndex:i];
        NSArray *onearray = [oneParam componentsSeparatedByString:@":"];
        NSAssert(onearray!=nil && [onearray count]>0,@"null param be found  (发现空的参数)");
        NSAssert([onearray count]==2,@"param is not complete  (参数不完整)");
        
        NSString *property = [onearray objectAtIndex:0];
        NSString *value    = [onearray objectAtIndex:1];
        
        [self setViewTweenBeginProperty:[property lowercaseString] value:value];
    }
    
    //set end property
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:dur];
    [UIView setAnimationDelegate:dgate];
    [UIView setAnimationDidStopSelector:function];
    
    for (int i=0; i<[toarray count]; i++) {
        NSString *oneParam = [toarray objectAtIndex:i];
        NSArray *onearray = [oneParam componentsSeparatedByString:@":"];
        NSAssert(onearray!=nil && [onearray count]>0,@"null param be found  (发现空的参数)");
        NSAssert([onearray count]==2,@"param is not complete  (参数不完整)");
        
        NSString *property = [onearray objectAtIndex:0];
        NSString *value    = [onearray objectAtIndex:1];
        
        [self setViewTweenBeginProperty:[property lowercaseString] value:value];
    }
    
    [UIView commitAnimations];
}

//set property
-(void)setViewTweenBeginProperty:(NSString *)prop value:(NSString *)val{
    if ([prop isEqualToString:@"x"]) {
        CGRect rect = self.frame;
        rect.origin.x = [val floatValue];
        [self setFrame:rect];
    }else if([prop isEqualToString:@"y"]){
        CGRect rect = self.frame;
        rect.origin.y = [val floatValue];
        [self setFrame:rect];
    }else if([prop isEqualToString:@"width"]){
        CGRect rect = self.frame;
        rect.size.width = [val floatValue];
        [self setFrame:rect];
    }else if([prop isEqualToString:@"height"]){
        CGRect rect = self.frame;
        rect.size.height = [val floatValue];
        [self setFrame:rect];
    }else if([prop isEqualToString:@"alpha"]){
        self.alpha = [val floatValue];
    }else if([prop isEqualToString:@"sx"]){
        CGAffineTransform trans = self.transform;
        [self setTransform:CGAffineTransformMakeScale([val floatValue], trans.d)];
    }else if([prop isEqualToString:@"sy"]){
        CGAffineTransform trans = self.transform;
        [self setTransform:CGAffineTransformMakeScale(trans.a, [val floatValue])];
    }else{//waiting for develop
        
    }
}



-(void)ee_tween:(NSTimeInterval)dur to:(NSString *)paramTo{
    [self ee_tween:dur to:paramTo delegate:nil sel:nil];
}

-(void)ee_tween:(NSTimeInterval)dur  to:(NSString *)paramTo delegate:(id)dgate sel:(SEL)function{
    NSRange rangeto     = [paramTo rangeOfString:@"，"];
    NSRange rangeto2     = [paramTo rangeOfString:@"："];
    NSAssert(rangeto.length==0&&rangeto2.length==0, @"Full-width letter be found in post params ，：(参数中，有全角字符 ，：)");
    
    NSArray *toarray    = [paramTo componentsSeparatedByString:@","];
    
    //set end property
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:dur];
    [UIView setAnimationDelegate:dgate];
    [UIView setAnimationDidStopSelector:function];
    
    CGAffineTransform trans = self.transform;
    CGRect rect = self.frame;
    float alpha = self.alpha;
    
    for (int i=0; i<[toarray count]; i++) {
        NSString *oneParam = [toarray objectAtIndex:i];
        NSArray *onearray = [oneParam componentsSeparatedByString:@":"];
        NSAssert(onearray!=nil && [onearray count]>0,@"null param be found  (发现空的参数)");
        NSAssert([onearray count]==2,@"param is not complete  (参数不完整)");
        
        NSString *property = [onearray objectAtIndex:0];
        NSString *val    = [onearray objectAtIndex:1];
        
        //[self setViewTweenBeginProperty:[property lowercaseString] value:value];
        NSString *prop = [property lowercaseString];
        
        if ([prop isEqualToString:@"x"]) {
            rect.origin.x = [val floatValue];
        }
        if([prop isEqualToString:@"y"]){
            rect.origin.y = [val floatValue];
        }
        if([prop isEqualToString:@"width"]){
            rect.size.width = [val floatValue];
        }
        if([prop isEqualToString:@"height"]){
            rect.size.height = [val floatValue];
        }
        if([prop isEqualToString:@"alpha"]){
            alpha = [val floatValue];
        }
        if([prop isEqualToString:@"sx"]){
            trans.a = [val floatValue];
//            [self setTransform:CGAffineTransformMakeScale([val floatValue], trans.d)];
        }if([prop isEqualToString:@"sy"]){
            trans.d = [val floatValue];
//            [self setTransform:CGAffineTransformMakeScale(trans.a, [val floatValue])];
        }
        if(true){//waiting for develop
            
        }
    }
    [self setFrame:rect];
    self.alpha = alpha;
    self.transform = trans;
    
    [UIView commitAnimations];
}


#pragma mark - simple set frame -

-(void)ee_viewToUp:(int)space{
    CGRect rect = self.frame;
    rect.origin.y -= space;
    [self setFrame:rect];
}

-(void)ee_viewToDown:(int)space{
    CGRect rect = self.frame;
    rect.origin.y += space;
    [self setFrame:rect];
}

-(void)ee_viewToLeft:(int)space{
    CGRect rect = self.frame;
    rect.origin.x -= space;
    [self setFrame:rect];
}

-(void)ee_viewToRight:(int)space{
    CGRect rect = self.frame;
    rect.origin.x += space;
    [self setFrame:rect];
}






@end
