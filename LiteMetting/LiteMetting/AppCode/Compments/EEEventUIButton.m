//
//  EEEventUIButton.m
//  EENews
//
//  Created by hong pai on 12-10-22.
//  Copyright (c) 2012年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "EEEventUIButton.h"

@implementation EEEventUIButton

@synthesize ee_moveEventTarget;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [ee_moveEventTarget touchesMoved:touches withEvent:event];
    [super touchesMoved:touches withEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [ee_moveEventTarget touchesEnded:touches withEvent:event];  
    [super touchesEnded:touches withEvent:event];  
}

-(void)dealloc{
    ee_moveEventTarget = nil;
    
    [super dealloc];
}

@end
