//
//  PModal.h
//  LiteMetting
//
//  Created by hong pai on 13-1-12.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PModal : UIViewController{
    
    NSMutableDictionary *modalConfig;
}

@property(nonatomic,retain)NSMutableDictionary *modalConfig;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil modalConfig:(NSMutableDictionary *)mconfig;

-(void)ee_createDetailContent:(NSMutableDictionary *)mconfig contentConfig:(NSMutableDictionary *)cconfig;

@end
