//
//  PContent.h
//  LiteMetting
//
//  Created by hong pai on 13-1-12.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDetail : UIViewController{
    
    NSDictionary *modalConfig;
    NSDictionary *cellConfig;
}

-(void)disponse;
-(void)ee_questDetail_ByCellConfig:(NSDictionary *)_cellConfig  modalconfig:(NSDictionary *)_modalconfig;


@end
