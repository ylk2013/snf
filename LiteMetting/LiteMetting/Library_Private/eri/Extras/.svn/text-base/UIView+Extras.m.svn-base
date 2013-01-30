//
//  UIView+Extras.m
//  Signature
//
//  Created by pai hong on 12-6-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIView+Extras.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (Extras)


#pragma mark ---把整个UIView 转换成图片UIImage---
//返回view的UIImage
-(UIImage *)imageRenderingInView{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *resultimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultimage;
}

@end
