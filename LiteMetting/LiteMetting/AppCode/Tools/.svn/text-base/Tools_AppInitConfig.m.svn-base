//
//  Tools_AppInitConfig.m
//  LiteMetting
//
//  Created by hong pai on 13-1-24.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "Tools_AppInitConfig.h"
#import "EETools_File.h"

@implementation Tools_AppInitConfig


- (id)init
{
    self = [super init];
    if (self) {
        BOOL isexist = [[NSFileManager defaultManager] fileExistsAtPath:EE_APP_Infor_Path];
        if (!isexist) {
            NSString *filepath = [[NSBundle mainBundle] pathForResource:@"config_appinfor" ofType:@"plist"];
            BOOL issuccess = [[NSFileManager defaultManager] copyItemAtPath:filepath toPath:EE_APP_Infor_Path error:nil];
            if (!issuccess) {
                trace(@"--------------初始化文件  copy 失败----------");
            }
        }
    }
    return self;
}

+(NSDictionary *)ee_getConfig{
    NSDictionary *config = [NSDictionary dictionaryWithContentsOfFile:EE_APP_Infor_Path];
    NSAssert(config!=nil, @"得到初始化数据为空");
    
    return config;
}









-(void)ee_refreshData{
    //TODO 从服务器上面刷新初始化数据
}

@end
