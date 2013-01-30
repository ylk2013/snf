//
//  SliderView.m
//  LiteMetting
//
//  Created by hong pai on 13-1-17.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "SliderView.h"
#import "UIImage+Extras.h"
#import <QuartzCore/QuartzCore.h>


@implementation SliderView

@synthesize sliderImages;

int txtBgGroundheight = 23;

- (id)initWithFrame:(CGRect)frame withData:(NSMutableArray *)_sliderImages
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.sliderImages = _sliderImages;
        
        //创建targetScrollView
        CGSize selfSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
        targetScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, selfSize.width, selfSize.height)];
        [self addSubview:targetScrollView];
        
        //刷新内容
        [self ee_refreshContent];
        
        //创建下方文字背景
        txtBgGroundView = [[[UIView alloc] initWithFrame:CGRectMake(0, selfSize.height-txtBgGroundheight, selfSize.width, txtBgGroundheight)] autorelease];
        //[txtBgGroundView setBackgroundColor:[UIColor whiteColor]];
        [txtBgGroundView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"slides_text_bg.png"]]];
        //txtBgGroundView.alpha = 0.85;
        [self addSubview:txtBgGroundView];
        
        //创建PageControl
        sliderPageControl = [[[PageControl alloc] initWithFrame:CGRectMake(0, 0, 15*self.sliderImages.count, txtBgGroundheight)] autorelease];
        [sliderPageControl setBackgroundColor:[UIColor clearColor]];
        sliderPageControl.userInteractionEnabled = NO;
        sliderPageControl.numberOfPages = [self.sliderImages count];
        sliderPageControl.layer.anchorPoint = CGPointMake(1, 0.5);
        sliderPageControl.center = CGPointMake(selfSize.width-10, txtBgGroundView.center.y);
        [self addSubview:sliderPageControl];
        
        //创建显示文字  UILabel
        sliderTxtLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 220, txtBgGroundheight)] autorelease];
        sliderTxtLabel.layer.anchorPoint = CGPointMake(0, 0.5);
        [sliderTxtLabel setTextColor:[UIColor whiteColor]];
        [sliderTxtLabel setFont:[UIFont systemFontOfSize:12]];
        [sliderTxtLabel setBackgroundColor:[UIColor clearColor]];
        sliderTxtLabel.center = CGPointMake(10, txtBgGroundView.center.y);
        sliderTxtLabel.text = @"放大飞的放大";
        [self addSubview:sliderTxtLabel];
            
        //刷新文字
        [self ee_refreshLabel:0];
    }
    return self;
}

#pragma mark - 刷新

-(void)ee_refreshContent{
    //清空
    [self clearAllSlider];
    
    //设置图片
    int len = [self.sliderImages count];
    
    CGSize selfSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    
    [self.sliderImages enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        //imgWidth
        //得到UIImage
        NSString *filePath = [[self.sliderImages objectAtIndex:idx] objectForKey:@"posterURL"];
        UIImage *showImg = [UIImage imageWithContentsOfFile:filePath];
        UIImage *newImage = [showImg imageScale_to_Width:320 height: (320*showImg.size.height / showImg.size.width)];
        
        
        //转换UIImage尺寸
        UIImageView *imageView = [[[UIImageView alloc] initWithImage:newImage] autorelease];
        imageView.center = CGPointMake(selfSize.width * 0.5f + selfSize.width * idx, selfSize.height*0.5f);
        [targetScrollView addSubview:imageView];
        
    }];
    
    [targetScrollView setContentSize:CGSizeMake(len*selfSize.width, selfSize.height)];
    [targetScrollView setPagingEnabled:YES];
    targetScrollView.showsHorizontalScrollIndicator = NO;
    targetScrollView.delegate = self;
    
}

-(void)ee_refreshLabel:(int)index{
    sliderTxtLabel.text = [[self.sliderImages objectAtIndex:index] objectForKey:@"summary"];
}

#pragma mark - 清空所有
-(void)clearAllSlider{
    //sliderImages
}



#pragma mark - UIScrollView label -

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
  
    trace(@"%f  %f",scrollView.contentOffset.x, scrollView.frame.size.width);
    int index = fabs((scrollView.contentOffset.x) / scrollView.frame.size.width);   //当前是第几个视图
    
    sliderPageControl.currentPage = index;
    
    [self ee_refreshLabel:index];
}

-(void)dealloc{
    [targetScrollView release];
    targetScrollView = nil;
    
    
    
    [super dealloc];
}


@end

















