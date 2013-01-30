//
//  UIImage+Extras.h
//  DaRenXiu
//
//  Created by pai hong on 12-4-25.
//  Copyright (c) 2012年 
//-------洪湃--------------
//---qq:  454077256-------
//---tel: 186 2159 2830---
//------------------------. . All rights reserved.
//

@interface UIImage (Extras)


- (id)initWithContentsOfResolutionIndependentFile:(NSString *)path;
+ (UIImage*)imageWithContentsOfResolutionIndependentFile:(NSString *)path;

- (UIImage*)imageScale_to_Width:(CGFloat)width height:(CGFloat)height;

+ (UIImage *) image: (UIImage *) image fitInSize: (CGSize) viewsize;

@end

