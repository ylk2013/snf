//
//  Tools_DispatchWebRquest.h
//  LiteMetting
//
//  Created by hong pai on 13-1-24.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceTools.h"

@interface Tools_DispatchWebRequest : NSObject

+(NSMutableArray *)ee_dispatchGetLocalSqliteList:(NSDictionary *)_modalconfig;


+(WebServiceTools *)ee_dispatchGetWebServerListRequest:(NSDictionary *)_modalconfig delegate:(id)delegate finish:(SEL)_finished failed:(SEL)_failed ;
+(WebServiceTools *)ee_dispatchGetWebDetailRequest:(NSDictionary *)_modalconfig cellConfig:(NSDictionary *)cellConfig delegate:(id)delegate finish:(SEL)_finished failed:(SEL)_failed ;

+(void)ee_dispatchSetArticleReadState_modalconfig:(NSDictionary *)_modalconfig artID:(int)localId;

+(void)ee_dispatchInsertNewDataInToSqlite:(NSMutableArray *)newlists modalConfig:(NSDictionary *)_modalconfig;

+(NSString *)ee_dispatchGetDetailJSonFile_modalConfig:(NSDictionary *)_modalconfig SID:(int)SID;

+(BOOL)ee_dispatch_updateDetalJsonFileName:(NSDictionary *)_modalconfig SID:(int)SID jsonFileName:(NSString *)jsonfilename;


@end
