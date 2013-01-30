//
//  EETouchScrollView.m
//  EENews
//
//  Created by hong pai on 12-12-31.
//  Copyright (c) 2012年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "EETouchScrollView.h"

@implementation EETouchScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    trace(@"ds");
    [super touchesMoved:touches withEvent:event];
}








@end
