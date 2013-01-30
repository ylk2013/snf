//
//  EELabelLink.m
//  Libaray
//
//  Created by pai hong on 12-6-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


/*
 
 用法：
 
 MyLabel *webSite = [[MyLabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
 [webSite setText:@"http://www.google.com"];
 [webSite  setDelegate:self];
 [self.view addSubview:webSite];
 [webSite  release];
 #pragma mark MyLabel Delegate Methods
 // myLabel是你的MyLabel委托的实例, tag是该实例的tag值, 有点多余, 哈哈
 - (void)myLabel:(MyLabel *)myLabel touchesWtihTag:(NSInteger)tag {
 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:webSite.text]];
 }
 
 */

#import "EELabelLink.h"

#define FONTSIZE 13
#define COLOR(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

@implementation EELabelLink

@synthesize delegate;

// 设置换行模式,字体大小,背景色,文字颜色,开启与用户交互功能,设置label行数,0为不限制
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame])
    {
        [self setLineBreakMode:UILineBreakModeWordWrap|UILineBreakModeTailTruncation];
        [self setFont:[UIFont systemFontOfSize:FONTSIZE]];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setTextColor:COLOR(59,136,195,1.0)];
        [self setUserInteractionEnabled:YES];
        [self setNumberOfLines:0];
    }
    return self;
}
// 点击该label的时候, 来个高亮显示
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self setTextColor:[UIColor whiteColor]];
}
// 还原label颜色,获取手指离开屏幕时的坐标点, 在label范围内的话就可以触发自定义的操作
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self setTextColor:COLOR(59,136,195,1.0)];
    UITouch *touch = [touches anyObject];
    CGPoint points = [touch locationInView:self];
    if (points.x >= self.frame.origin.x && points.y >= self.frame.origin.x && points.x <= self.frame.size.width && points.y <= self.frame.size.height)
    {
        [delegate eelabel:self touchesWtihTag:self.tag];
    }
}
- (void)dealloc {
    [super dealloc];
}
@end

