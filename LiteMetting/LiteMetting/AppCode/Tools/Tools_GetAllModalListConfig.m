//
//  Tools_GetAllModalListConfig.m
//  LiteMetting
//
//  Created by hong pai on 13-1-20.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "Tools_GetAllModalListConfig.h"

@implementation Tools_GetAllModalListConfig

@synthesize eeModalListConfig;

static Tools_GetAllModalListConfig *instance;



+(Tools_GetAllModalListConfig *)shareInstance{
    if(instance==nil){
        instance = [[Tools_GetAllModalListConfig alloc] init];
    }
    return instance;
}


- (id)init
{
    self = [super init];
    if (self) {
        NSString *strPath = [[NSBundle mainBundle] pathForResource:@"config_app_modal_types.plist" ofType:nil];
        NSMutableArray *AllModalMenuArray = [NSMutableArray arrayWithContentsOfFile:strPath];
        
        eeModalListConfig = [AllModalMenuArray retain];
    }
    return self;
}



//得到左边的菜单
-(NSMutableArray *)eeModalListConfig_leftMenus{
    NSMutableArray *array = [NSMutableArray array];
    [eeModalListConfig enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSMutableDictionary *config = [eeModalListConfig objectAtIndex:idx];
        BOOL isInLeft = [[config objectForKey:@"IsInLeft"] boolValue];
        if (isInLeft) {
            [array addObject:config];
        }
//        array
    }];
    return array;
}


//得到顶部的菜单
-(NSMutableArray *)eeModalListConfig_topMenus{
    NSMutableArray *array = [NSMutableArray array];
    
    NSArray *newOrderArray = [eeModalListConfig sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if ([[obj1 objectForKey:@"order"] intValue] < [[obj2 objectForKey:@"order"] intValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        if ([[obj1 objectForKey:@"order"] intValue] > [[obj2 objectForKey:@"order"] intValue]){
            
            return (NSComparisonResult)NSOrderedAscending;
        }
        return NSOrderedSame;
    }];
    
    [newOrderArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSMutableDictionary *config = [newOrderArray objectAtIndex:idx];
        BOOL isInLeft = [[config objectForKey:@"IsInTop"] boolValue];
        if (isInLeft) {
            [array addObject:config];
        }
        //        array
    }];
    return array;
}

//得到顶部的菜单 字符串的形式
-(NSMutableArray *)eeModalListConfig_topMenus_StringEntiry{
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *topmenus = [self eeModalListConfig_topMenus];
    
    [topmenus enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [array addObject:[obj objectForKey:@"Title2"]];
    }];
    return array;
}


//根据MarkID获取ModalConfig
-(NSMutableDictionary *)ee_getOneConfigByMarkID:(MarkID)markid{
    
    __block NSMutableDictionary *find;
    
    [eeModalListConfig enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSMutableDictionary *config = [eeModalListConfig objectAtIndex:idx];
        
        MarkID curMarkID = [[config objectForKey:@"MarkID"] intValue];
        
        if (curMarkID == markid) {
            find = config;
        }
        
    }];
    
    return find;
}







@end
