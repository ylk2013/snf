//
//  Tools_TableRefreshHistory.m
//  LiteMetting
//
//  Created by hong pai on 13-1-25.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "Tools_TableRefreshHistory.h"

@implementation Tools_TableRefreshHistory


+(NSMutableDictionary *)ee_getConfig{
    NSMutableDictionary *dictionary;
    BOOL isexist = [[NSFileManager defaultManager] fileExistsAtPath:EE_TableRefreshHistory];
    if (!isexist) {
        dictionary = [NSMutableDictionary dictionary];
        [dictionary writeToFile:EE_TableRefreshHistory atomically:YES];
    }
    
    dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:EE_TableRefreshHistory];
    
    return dictionary;
}

+(void)ee_addOneRrefreshHistoryToLocal_ModalConfig:(NSDictionary *)modalConfig{
    NSMutableDictionary *dictionary = [Tools_TableRefreshHistory ee_getConfig];
    
    [dictionary setValue:([NSDate date]) forKey:[modalConfig objectForKey:@"MarkID"]];
    
    [dictionary writeToFile:EE_TableRefreshHistory atomically:YES];
}

+(BOOL)ee_checkIsNeesToRefreshTable_ModalConfig:(NSDictionary *)modalConfig{
    
    NSMutableDictionary *dictionary = [Tools_TableRefreshHistory ee_getConfig];
    
    NSDate *history = [dictionary objectForKey:[modalConfig objectForKey:@"MarkID"]];
    
    if (history==nil) {
        return YES;
    }
    
    NSDate *now = [NSDate date];
    
    float second = [now timeIntervalSinceDate:history];
    
    trace(@"%f",second);
    
    if (second > 5*60) {
        return YES;
    }
    return NO;
}

@end
