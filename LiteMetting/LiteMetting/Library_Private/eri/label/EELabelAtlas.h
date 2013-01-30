//
//  EELabelAtlas.h
//  DaRenXiu
//
//  Created by pai hong on 12-4-25.
//  Copyright (c) 2012年 
//-------洪湃--------------
//---qq:  454077256-------
//---tel: 186 2159 2830---
//------------------------. . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EELabelAtlas : UIView{
    NSString *imagesource;
    UIImageView *textImage;
    
    NSInteger lettercount;
    NSInteger letterspace;
    
    NSInteger letterWidth;
    NSInteger letterHeight;
}

-(id)initAtlasWithImageSource:(NSString *)imgname letterCount:(NSInteger)count letterspace:(NSInteger)space;
-(void)atlasWithImageSource:(NSString *)imgname letterCount:(NSInteger)count letterspace:(NSInteger)space;
-(void)setText:(NSString *)text;
@end
