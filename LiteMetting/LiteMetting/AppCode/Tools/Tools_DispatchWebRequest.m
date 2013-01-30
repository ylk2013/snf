//
//  Tools_DispatchWebRquest.m
//  LiteMetting
//
//  Created by hong pai on 13-1-24.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "Tools_DispatchWebRequest.h"
#import "SqliteTools.h"
#import "WebServiceTools.h"
#import "SBJson.h"

@implementation Tools_DispatchWebRequest



#pragma mark - 得到本地数据列表 -
#pragma mark -得到数据列表 -

//获取本地数据列表
+(NSMutableArray *)ee_dispatchGetLocalSqliteList:(NSDictionary *)_modalconfig{
    //得到该类型本地最大ID值
    MarkID markid = [[_modalconfig objectForKey:@"MarkID"] intValue];
    NSMutableArray *allLists;
    if (markid == MarkID_Expert ) {//专家
        allLists = [[SqliteTools shareInstacne] ee_getExpertListByMarkID:markid];
    }else if(markid == MarkID_MeetSchedul ){//日程
        allLists = [[SqliteTools shareInstacne] ee_getMeetScheduleListByMarkID:markid];
    }else{
        allLists = [[SqliteTools shareInstacne] ee_getNewsListByMarkID:markid];
    }

    return allLists;
}

#pragma mark - 服务器，得到数据列表 -
//得到服务器数据列表
+(WebServiceTools *)ee_dispatchGetWebServerListRequest:(NSDictionary *)_modalconfig delegate:(id)delegate finish:(SEL)_finished failed:(SEL)_failed {
    //得到该类型本地最大ID值
    MarkID markid = [[_modalconfig objectForKey:@"MarkID"] intValue];
    int maxid = 0;
    
    WebServiceTools *webserv = [[WebServiceTools alloc] init];
    
    NSMutableDictionary *dictinary = [NSMutableDictionary dictionary];
    if (markid == MarkID_Expert ) {//专家
        trace(@"--------------请求专家信息 --> 获取列表信息 %d",markid);
        maxid = [[SqliteTools shareInstacne] ee_getExpertMax_SID:markid];
        //参数
        [dictinary setValue:@"GetSpeakerList" forKey:@"method"];
        
    }else if(markid == MarkID_MeetSchedul ){//日程
        trace(@"--------------请求日程 --> 获取列表信息 %d",markid);
        maxid = [[SqliteTools shareInstacne] ee_getSchedulMax_SID:markid];
        //参数
        [dictinary setValue:@"GetScheduleList" forKey:@"method"];
        
    }else{
        trace(@"--------------请求新闻列表 --> 获取列表信息 %d",markid);
        maxid = [[SqliteTools shareInstacne] ee_getNewsMax_SID:markid];
        //参数
        [dictinary setValue:@"GetNewsList" forKey:@"method"];
        
    }
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:[NSString stringWithFormat:@"%d",maxid] forKey:@"maxid"];
    [parameter setValue:[NSString stringWithFormat:@"%d",markid] forKey:@"type"];
    
    [dictinary setValue:parameter forKey:@"attachment"];
    
    NSString *postring = [dictinary JSONRepresentation];
    
    trace(@"%@",postring);
    
    [webserv.request setPostValue:postring forKey:@"paramter"];
    [webserv ee_execute_delegate:delegate finishSEL:_finished FailedSEL:_failed];
    
    return webserv;
}


#pragma mark - 服务器，得到数据详情 -
//得到服务器detail
+(WebServiceTools *)ee_dispatchGetWebDetailRequest:(NSDictionary *)_modalconfig cellConfig:(NSDictionary *)cellConfig delegate:(id)delegate finish:(SEL)_finished failed:(SEL)_failed {
    MarkID markid = [[_modalconfig objectForKey:@"MarkID"] intValue];
    
    WebServiceTools *webserv = [[WebServiceTools alloc] init];
    
    NSMutableDictionary *dictinary = [NSMutableDictionary dictionary];
    if (markid == MarkID_Expert ) {//专家
        trace(@"--------------请求专家信息 --> 获取列表detail %d",markid);
        //参数
        [dictinary setValue:@"GetSpeakerDetail" forKey:@"method"];
    }else if(markid == MarkID_MeetSchedul ){//日程
        trace(@"--------------请求日程 --> 获取列表detail %d",markid);
        //参数
        [dictinary setValue:@"GetScheduleDetail" forKey:@"method"];
    }else{
        trace(@"--------------请求新闻列表 --> 获取列表detail %d",markid);
        //参数
        [dictinary setValue:@"GetNewsDetail" forKey:@"method"];
    }
    
    
    
    NSString *sid = [cellConfig objectForKey:@"SID"];
    
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:sid                                 forKey:@"id"];
    [parameter setValue:[NSNumber numberWithInt:markid]     forKey:@"type"];
    
    [dictinary setValue:parameter forKey:@"attachment"];
    NSString *postring = [dictinary JSONRepresentation];
    trace(@"%@",postring);
    
    [webserv.request setPostValue:postring forKey:@"paramter"];
    
    [webserv ee_execute_delegate:delegate finishSEL:_finished FailedSEL:_failed];
    
    return webserv;
}


#pragma mark - 本地 设置 已读 -
//得到服务器数据列表
+(void)ee_dispatchSetArticleReadState_modalconfig:(NSDictionary *)_modalconfig artID:(int)localId{
    //得到该类型本地最大ID值
    MarkID markid = [[_modalconfig objectForKey:@"MarkID"] intValue];
    
    if (markid == MarkID_Expert ) {//专家
        trace(@"--------------请求专家信息 --> 设置已读状态 %d",markid);
        [[SqliteTools shareInstacne] ee_setExpertReaded:YES Id:localId];
    }else if(markid == MarkID_MeetSchedul ){//日程
        trace(@"--------------请求日程 --> 设置已读状态 %d",markid);
        [[SqliteTools shareInstacne] ee_setScheduleReaded:YES Id:localId];
    }else{
        trace(@"--------------请求新闻列表 --> 设置已读状态 %d",markid);
        [[SqliteTools shareInstacne] ee_setNewsReaded:YES Id:localId];
    }
}


#pragma mark - 本地 吧新数据保存进sql数据库 -
+(void)ee_dispatchInsertNewDataInToSqlite:(NSMutableArray *)newlists modalConfig:(NSDictionary *)_modalconfig {
    //得到该类型本地最大ID值
    MarkID markid = [[_modalconfig objectForKey:@"MarkID"] intValue];
    
    if (markid == MarkID_Expert ) {//专家
        trace(@"--------------请求专家信息 --> 插入新的数据 %d",markid);
        [[SqliteTools shareInstacne] ee_insertRowsInToTable_Expert:newlists];
    }else if(markid == MarkID_MeetSchedul ){//日程
        trace(@"--------------请求日程 --> 插入新的数据 %d",markid);
        [[SqliteTools shareInstacne] ee_insertRowsInToTable_Schedule:newlists];
    }else{
        trace(@"--------------请求新闻列表 --> 插入新的数据 %d",markid);
        [[SqliteTools shareInstacne] ee_insertRowsInToTable_News:newlists];
    }
}


#pragma mark - 本地 得到detail配置文件的信息 -
+(NSString *)ee_dispatchGetDetailJSonFile_modalConfig:(NSDictionary *)_modalconfig SID:(int)SID{
    MarkID markid = [[_modalconfig objectForKey:@"MarkID"] intValue];
    
    NSString *jsonFile = @"";
    if (markid == MarkID_Expert ) {//专家
        trace(@"--------------请求专家信息 --> 得到detail %d",markid);
        jsonFile = [[SqliteTools shareInstacne] ee_getJsonExpretDetail_SID:SID ];
    }else if(markid == MarkID_MeetSchedul ){//日程
        trace(@"--------------请求日程 --> 得到detail %d",markid);
        jsonFile = [[SqliteTools shareInstacne] ee_getJsonSchedulDetail_SID:SID];
    }else{
        trace(@"--------------请求新闻列表 --> 得到detail %d",markid);
        jsonFile = [[SqliteTools shareInstacne] ee_getJsonNewsDetail_SID:SID andMarkID:markid];
    }
    return jsonFile;
}

#pragma mark - 本地 更新detail文件名 ，成json文件名称 -
+(BOOL)ee_dispatch_updateDetalJsonFileName:(NSDictionary *)_modalconfig SID:(int)SID jsonFileName:(NSString *)jsonfilename{
    MarkID markid = [[_modalconfig objectForKey:@"MarkID"] intValue];
    
    BOOL isUpdateSuccess;
    if (markid == MarkID_Expert ) {//专家
        trace(@"--------------请求专家信息 --> 更新detail文件名 %d",markid);
        isUpdateSuccess = [[SqliteTools shareInstacne] ee_updateJsonExpretDetail_SID:SID jsonFileName:jsonfilename];
    }else if(markid == MarkID_MeetSchedul ){//日程
        trace(@"--------------请求日程 --> 更新detail文件名 %d",markid);
        isUpdateSuccess = [[SqliteTools shareInstacne] ee_updateJsonScheduleDetail_SID:SID jsonFileName:jsonfilename];
    }else{
        trace(@"--------------请求新闻列表 --> 更新detail文件名 %d",markid);
        isUpdateSuccess = [[SqliteTools shareInstacne] ee_updateJsonNewsDetail_SID:SID type:markid jsonFileName:jsonfilename];
    }
    return isUpdateSuccess;
}





@end
