//
//  SliderView.h
//  LiteMetting
//
//  Created by hong pai on 13-1-17.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageControl.h"

@interface SliderView : UIView<UIScrollViewDelegate>{
    NSMutableArray *sliderImages;
    
    
    UIScrollView *targetScrollView;
    UIView *txtBgGroundView;
    PageControl *sliderPageControl;
    
    UILabel *sliderTxtLabel;
}

@property(nonatomic,retain)NSMutableArray *sliderImages;

-(id)initWithFrame:(CGRect)frame withData:(NSMutableArray *)_sliderImage;

-(void)ee_refreshContent;
-(void)ee_refreshLabel:(int)index;

@end
