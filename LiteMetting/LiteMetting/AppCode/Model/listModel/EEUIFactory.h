//
//  EEUIFactory.h
//  LiteMetting
//
//  Created by hong pai on 13-1-14.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PModal.h"
#import "PDetail.h"
#import "PCell.h"

@interface EEUIFactory : NSObject{
    NSMutableArray *modalControllerArray;
    
}

@property(nonatomic,retain)NSMutableArray *modalControllerArray;

+(EEUIFactory *)getFactory;

//是否已经通过工厂创建了modalController
-(PModal *)ee_isCreateModalController:(NSMutableDictionary *)modalConfig;
    
//得到二级列表 工厂方法
-(PModal *)ee_getModalControllerByModalConfig:(NSMutableDictionary *)modalConfig;

//得到cell 工厂方法
-(PCell *)ee_getTableCellViewByModalConfig:(NSDictionary *)modalConfig;

//得到三级内容页 工厂方法
-(PDetail *)ee_getDetailControllerByModalConfig:(NSDictionary *)modalConfig;

@end
