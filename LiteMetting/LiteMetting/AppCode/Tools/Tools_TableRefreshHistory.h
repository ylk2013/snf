//
//  Tools_TableRefreshHistory.h
//  LiteMetting
//
//  Created by hong pai on 13-1-25.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools_TableRefreshHistory : NSObject




+(NSMutableDictionary *)ee_getConfig;
+(void)ee_addOneRrefreshHistoryToLocal_ModalConfig:(NSDictionary *)modalConfig;
+(BOOL)ee_checkIsNeesToRefreshTable_ModalConfig:(NSDictionary *)modalConfig;


@end
