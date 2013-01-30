
//
//  EE_HorizontalMenuBar.m
//  LiteMetting
//
//  Created by hong pai on 13-1-20.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//



/*
 how use:
 
 EE_HorizontalMenuBar *horizontal = [[EE_HorizontalMenuBar alloc] initWithFrame:CGRectMake(0, 0, 320, 35) withMenus:([NSMutableArray arrayWithObjects:@"聚焦",@"资讯",@"通知",@"交通出行",@"天气", nil])];
 horizontal.delegate = self;
 [horizontal ee_setSelectedItem:0];//设置默认选择
 [self.view addSubview:horizontal];

 */

#import "EE_HorizontalMenuBar.h"
#import "EETools_Infor.h"
#import "UIColor+expanded.h"
#import "UIView+EEExtras.h"

@implementation EE_HorizontalMenuBar

@synthesize delegate,itemsArray,horizontalType;



- (id)initWithFrame:(CGRect)frame withMenus:(NSMutableArray *)menuArray imageSources:(NSMutableDictionary *)sources horizontalType:(HorizontalType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        edge = UIEdgeInsetsMake(7, 8, 8, 7);
        horizontalType = type;
        imagesSource = [sources retain];
        
        
        if (imagesSource==nil) {
            imagesSource = [NSMutableDictionary dictionary];
            
            [imagesSource setValue:@"HorizontalMenuBar.bundle/HorizontalMenuBarBg.png" forKey:@"image_bg"];
            [imagesSource setValue:@"HorizontalMenuBar.bundle/HorizontalMenuBarBgbtn.png" forKey:@"image_BtnSelected"];
            if (horizontalType == HorizontalType_BGMoving) {
                [imagesSource setValue:@"" forKey:@"image_BtnSelected"];
                [imagesSource setValue:@"HorizontalMenuBar.bundle/HorizontalMenuBarBgbtn.png" forKey:@"image_Moving"];
            }
        }
        
        self.itemsArray = menuArray;
        fontSize = 14;
        
        if (horizontalType == HorizontalType_BGMoving) {
            UIImage *movingImg = [UIImage imageNamed:([imagesSource objectForKey:@"image_Moving"])];
            movingImg = [movingImg resizableImageWithCapInsets:edge];
            
            imageMovingBG = [[[UIImageView alloc] initWithImage:movingImg] autorelease];
            imageMovingBG.center = CGPointMake(-imageMovingBG.frame.size.width, self.frame.size.height * 0.5f);
            [self addSubview:imageMovingBG];
        }
        
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[imagesSource objectForKey:@"image_bg"]]]];
        
        [self ee_refreshMenus:menuArray];
        //
    }
    return self;
}

-(void)ee_refreshMenus:(NSMutableArray *)menuArray{
    self.itemsArray = menuArray;
    
//    UIImage *topbtnbg = [UIImage imageNamed:@"topbtnbg.png"];
//    topbtnbg = [topbtnbg resizableImageWithCapInsets:UIEdgeInsetsMake(7, 8, 8, 7)];
    
    UIImage *topbtnbgselect = [UIImage imageNamed:[imagesSource objectForKey:@"image_BtnSelected"]] ;
    topbtnbgselect = [topbtnbgselect resizableImageWithCapInsets:edge];
    
    int len = [menuArray count];
    int allLength = 0;
    int startx = 10;
    int space = 5;
    
    int maxLength;
    for (int i=0; i<len; i++) {
        NSString *strName = [menuArray objectAtIndex:i];
        
        CGSize constraintSize= CGSizeMake(MAXFLOAT,fontSize);
        UIFont *font = [UIFont systemFontOfSize:fontSize];
        CGSize expectedSize = [strName sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
        
        //UIImageView *imageView = [[UIImageView alloc] initWithImage:topbtnbg];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(0, 0, expectedSize.width+22, expectedSize.height + 10)];
        button.tag = 11+i;
        
//        [button setBackgroundImage:topbtnbg forState:UIControlStateNormal];
        [button setBackgroundImage:topbtnbgselect forState:UIControlStateHighlighted];
        [button setBackgroundImage:topbtnbgselect forState:UIControlStateSelected];
        [[button titleLabel] setFont:[UIFont systemFontOfSize:fontSize]];
        [button setTitleColor:[UIColor colorWithRGBHex:0x545557] forState:UIControlStateNormal];

        [button addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [button setTitle:strName forState:UIControlStateNormal];
        allLength += button.frame.size.width;
        
        button.center = CGPointMake(startx+(int)(allLength-button.frame.size.width*0.5f)+i*space, (int)self.frame.size.height*0.5f);
        
        [self addSubview:button];
        
        
        maxLength = button.center.x + button.frame.size.width *0.5 + startx;
    }
    
//    [targetScrollView setContentSize:CGSizeMake(len*selfSize.width, selfSize.height)];
//    [targetScrollView setPagingEnabled:YES];
//    targetScrollView.showsHorizontalScrollIndicator = NO;
//    targetScrollView.delegate = self;
    if (maxLength<self.frame.size.width) {
        maxLength = 320;
    }
    [self setContentSize:CGSizeMake(maxLength, self.frame.size.height)];
//    [self setPagingEnabled:YES];
    
}

-(void)clickBtn:(UIButton *)btn{
    int btntag = btn.tag - 11;
    trace(@"%s %d",__FUNCTION__,btntag);
    if (delegate) {
        [delegate ee_HorizontalMenuBar_clickBarIndex:btntag];
    }

    [self ee_refreshMenuStateByClickTag:btntag];
}


//设置选中状态
-(void)ee_refreshMenuStateByClickTag:(int)bTag{
    int btntag = bTag + 11;
    NSArray *childs = self.subviews;
    
    [childs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            [(UIButton *)obj setSelected:NO];
        }
    }];
    
    
    UIButton *findBtn = (UIButton *)[self viewWithTag:btntag];
    if (findBtn!=nil) {
        [findBtn setSelected:YES];
    }else{
        [EETools_Infor tools_alert:([NSString stringWithFormat:@"%s bTag:%d",__FUNCTION__,bTag])];
    }

    //移动背景
    if(horizontalType == HorizontalType_BGMoving){
        NSString *tweenString = [NSString stringWithFormat:@"x:%f,y:%f,width:%f,height:%f",findBtn.frame.origin.x,findBtn.frame.origin.y,findBtn.frame.size.width,findBtn.frame.size.height];
        [imageMovingBG ee_tween:0.15 to:tweenString];
    }
}


//设置选择状态
//selIndex:序号
//isClickEvent:是否触发点击事件 (NO:只改变状态，不触发点击时间)（YES：既改变状态也触发点击时间）
-(void)ee_setSelectedItem:(int)selIndex clicked:(BOOL)isClickEvent{
    if (isClickEvent) {
        if (delegate) {
            [delegate ee_HorizontalMenuBar_clickBarIndex:selIndex];
        }
        [self ee_refreshMenuStateByClickTag:selIndex];
    }else{
        [self ee_refreshMenuStateByClickTag:selIndex];
    }
}


-(void)dealloc{
    self.itemsArray = nil;
    self.delegate = nil;
    
    [imagesSource release];
    imagesSource = nil;
    
    [super dealloc];
}





@end
