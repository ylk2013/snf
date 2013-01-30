//
//  Tools_GetAllModalListConfig.h
//  LiteMetting
//
//  Created by hong pai on 13-1-20.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools_GetAllModalListConfig : NSObject{
    NSMutableArray *eeModalListConfig;
}

@property(nonatomic,retain)NSMutableArray *eeModalListConfig;

+(Tools_GetAllModalListConfig *)shareInstance;

-(NSMutableArray *)eeModalListConfig_leftMenus;

-(NSMutableArray *)eeModalListConfig_topMenus;
-(NSMutableArray *)eeModalListConfig_topMenus_StringEntiry;

-(NSMutableDictionary *)ee_getOneConfigByMarkID:(MarkID)markid;
@end
