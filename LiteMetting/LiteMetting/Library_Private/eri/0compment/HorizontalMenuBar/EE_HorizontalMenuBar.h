//
//  HorizontalMenuBar.h
//  LiteMetting
//
//  Created by hong pai on 13-1-20.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EE_HorizontalMenuBarDelegate <NSObject>

-(void)ee_HorizontalMenuBar_clickBarIndex:(int)index;

@end

typedef enum{
    HorizontalType_Normal,
    HorizontalType_BGMoving,
}HorizontalType;

@interface EE_HorizontalMenuBar : UIScrollView{
    
    id<EE_HorizontalMenuBarDelegate> delegate;
    
    NSMutableArray *itemsArray;
    
    int fontSize;
    
    HorizontalType horizontalType;
    
    NSMutableDictionary *imagesSource;
    UIImageView *imageMovingBG;
    
    UIEdgeInsets edge;
}

@property(nonatomic,assign)HorizontalType horizontalType;

@property(nonatomic,retain)NSMutableArray *itemsArray;

@property(nonatomic,assign) id delegate;

- (id)initWithFrame:(CGRect)frame withMenus:(NSMutableArray *)menuArray imageSources:(NSMutableDictionary *)sources horizontalType:(HorizontalType)type;

-(void)ee_refreshMenus:(NSMutableArray *)menuArray;

-(void)ee_setSelectedItem:(int)selIndex clicked:(BOOL)isClickEvent;











@end
