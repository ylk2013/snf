//
//  EELabelAtlas.m
//  DaRenXiu
//
//  Created by pai hong on 12-4-25.
//  Copyright (c) 2012年 
//-------洪湃--------------
//---qq:  454077256-------
//---tel: 186 2159 2830---
//------------------------. . All rights reserved.
//

/*
 use:
 1:declare
 EELabelAtlas *e = [[EELabelAtlas alloc] initAtlasWithImageSource:@"label_数字1.png" letterCount:10 letterspace:5];
 [self.view addSubview:e];

 2:use
 [e setText:@"34"];
 
 */

#import "EELabelAtlas.h"

#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

@interface EELabelAtlas (private)

-(void)getImageData;

@end


@implementation EELabelAtlas

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//alloc 初始化的时候用
-(id)initAtlasWithImageSource:(NSString *)imgname letterCount:(NSInteger)count letterspace:(NSInteger)space{
    self = [super init];
    if (self) {
        [self atlasWithImageSource:imgname letterCount:count letterspace:space];
    }
    return self;
}

//xib初始化的时候用
-(void)atlasWithImageSource:(NSString *)imgname letterCount:(NSInteger)count letterspace:(NSInteger)space{
    [self setBackgroundColor:[UIColor clearColor]];
    
    imagesource = [NSString stringWithString:imgname];
    lettercount = count;
    letterspace = space;
    
    [self getImageData];
    
    textImage = [[UIImageView alloc] init];
    [self addSubview:textImage];
    [textImage release];
}


#pragma mark ----getImageData---
-(void)getImageData{
    UIImage *source = [UIImage imageNamed:imagesource];
    
    int allwidth  = source.size.width;
    int allheight = source.size.height;
    
    letterWidth = allwidth/lettercount;
    letterHeight = allheight;
    
    //兼容retina屏幕
    if (isRetina) {
        letterWidth = letterWidth*2;
        letterHeight= letterHeight*2;
    }else{
        
    }
    NSLog(@"from 'EELabelAtlas' 单个图片长度：%d",letterWidth);
}

-(NSInteger)getLetterIndexInImage:(NSString *)let{
    NSString *allT = @"0123456789/.";
    NSRange range = [allT rangeOfString:let];
    NSInteger index = range.location;
    return index;
}

-(void)setText:(NSString *)text{
    UIImage *source = [UIImage imageNamed:imagesource];
    //[textImage removeFromSuperview];
    
    //字体长度
    int textLength = [text length];
    //画布大小
    float canvasWidth = textLength * letterWidth-((textLength-1)*letterspace);//减去了间隙的长度
    //建立画布
    UIGraphicsBeginImageContext(CGSizeMake(canvasWidth, letterHeight));
    
    CGImageRef cgref = source.CGImage;
    
    for (int i=0; i<textLength; i++) {
        NSRange rang = NSMakeRange(i, 1);
        NSString *letter = [text substringWithRange:rang];
        
        NSInteger index = [self getLetterIndexInImage:letter];//0-11
        
        CGImageRef ref = CGImageCreateWithImageInRect(cgref, CGRectMake(index*letterWidth, 0, letterWidth, letterHeight));//从source里面截取所需要的ImageRef
        
        UIImage *letterImage = [UIImage imageWithCGImage:ref];//生成UIImage
        
        if (i==0) {
            [letterImage drawAtPoint:CGPointMake(0, 0)];
        }else {
            [letterImage drawAtPoint:CGPointMake(i*letterWidth-i*letterspace, 0)];
        }
        
        CGImageRelease(ref);
    }   
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    if (isRetina) {//兼容retina屏幕
        float x = (self.frame.size.width-resultImage.size.width*0.5)*0.5;//居中对其
        x = x<=0?0:x;
        
        [textImage setFrame:CGRectMake(x, 0, resultImage.size.width*0.5, resultImage.size.height*0.5)];
    }else{
        float x = (self.frame.size.width-resultImage.size.width)*0.5;//居中对其
        x = x<=0?0:x;
        
        [textImage setFrame:CGRectMake(x, 0, resultImage.size.width, resultImage.size.height)];
    }
    
    textImage.image = resultImage;
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
