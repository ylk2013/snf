//
//  SqliteTools.m
//  LiteMetting
//
//  Created by hong pai on 13-1-23.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "SqliteTools.h"
#import "FMDatabase.h"

#define PageNum 20 

@implementation SqliteTools

+(SqliteTools *)shareInstacne{
    static SqliteTools *instance = nil;
    @synchronized(self){
        if (!instance) {
            instance = [[SqliteTools alloc] init];
        }
    }
    return instance;
}




#pragma mark - 得到news数据 -

-(NSMutableArray *)ee_getNewsListByMarkID:(int)markid{
    track();
    trace(@"-------------------------------------------------");
    trace(@"---function:ee_getNewsListByModalType----------");
    trace(@"-------------query sqlite, ModalType：%d",markid);
    NSMutableArray *array = [NSMutableArray array];
    
    FMDatabase *db = [FMDatabase databaseWithPath:EE_SqlitePath] ;
    
    if (![db open]) {
        trace(@"---------------Could not open db");
        return NULL;
    }
    
    NSString *str = [NSString stringWithFormat:@"select * from News where type='%d' order by SID desc limit 0,%d",markid,PageNum];
    
    trace(@"-------------query:%@",str);
    FMResultSet *rs = [db executeQuery:str];
    
    while ([rs next]) {
        NSMutableDictionary *oneNews = [NSMutableDictionary dictionary];
        [oneNews setValue:[rs stringForColumn:@"id"] forKey:@"id"];
        [oneNews setValue:[rs stringForColumn:@"SID"] forKey:@"SID"];
        [oneNews setValue:[rs stringForColumn:@"NewsIcon"] forKey:@"NewsIcon"];
        [oneNews setValue:[rs stringForColumn:@"NewsTitle"] forKey:@"NewsTitle"];
        [oneNews setValue:[rs stringForColumn:@"NewsSummery"] forKey:@"NewsSummery"];
        [oneNews setValue:[rs stringForColumn:@"NewsTime"] forKey:@"NewsTime"];
        [oneNews setValue:[rs stringForColumn:@"NewsContent"] forKey:@"NewsContent"];
        [oneNews setValue:[rs stringForColumn:@"RecordTime"] forKey:@"RecordTime"];
        [oneNews setValue:[rs stringForColumn:@"Type"] forKey:@"Type"];
        [oneNews setValue:[rs stringForColumn:@"IsReaded"] forKey:@"IsReaded"];
        
        [array addObject:oneNews];
    }
    
    trace(@"---------------！查询baike数据库，得到了 %d条数据----------",[array count]);
    
    // close the result set.
    // it'll also close when it's dealloc'd, but we're closing the database before
    // the autorelease pool closes, so sqlite will complain about it.
    [rs close];
    trace(@"-------------------------------------------------");
    return array;
}

-(NSString *)ee_getJsonNewsDetail_SID:(NSInteger)SID andMarkID:(NSInteger)markid{
    track();
    trace(@"-------------------------------------------------");
    trace(@"---function:ee_getNewsDetail_NewsSID----------");
    trace(@"-------------query sqlite, newsSID:%d modalType:%d",SID,markid);
    
    FMDatabase *db = [FMDatabase databaseWithPath:EE_SqlitePath] ;
    
    if (![db open]) {
        trace(@"---------------Could not open db");
        return NULL;
    }
    
    NSString *str = [NSString stringWithFormat:@"select * from News where SID='%d' and type='%d' ",SID,markid];
    
    trace(@"-------------query:%@",str);
    FMResultSet *rs = [db executeQuery:str];
    
    NSString *jsonFile = nil;
    if ([rs next]) {
        jsonFile = [rs stringForColumn:@"NewsContent"];
    }
    
    trace(@"---------------！查询数据库，得到jsonFile:%@----------",jsonFile);
    
    // close the result set.
    // it'll also close when it's dealloc'd, but we're closing the database before
    // the autorelease pool closes, so sqlite will complain about it.
    [rs close];
    trace(@"-------------------------------------------------");
    
    return jsonFile;
}



-(BOOL )ee_updateJsonNewsDetail_SID:(NSInteger)SID  type:(NSInteger)type jsonFileName:(NSString *)fileName{
    
    track();
    trace(@"-------------------------------------------------");
    trace(@"---function:ee_updateJsonExpretDetail_SID----------");
    trace(@"-------------udpate sqlite, jsonFileName：%@",fileName);
    
    FMDatabase *db = [FMDatabase databaseWithPath:EE_SqlitePath] ;
    
    if (![db open]) {
        trace(@"---------------Could not open db");
        return NO;
    }
    
    NSString *str = [NSString stringWithFormat:@"UPDATE News SET NewsContent=%@ WHERE SID=%d and type=%d",fileName,SID,type];
    trace(@"-------------query:%@",str);
    
    //BOOL isSuccess = [db executeUpdate:@"update News set Type=1 where id=?",([NSString stringWithFormat:@"%d",kid])];
    BOOL isSuccess = [db executeUpdate:@"UPDATE News SET NewsContent=? WHERE SID=? and type=?",fileName,[NSNumber numberWithInt:SID],[NSNumber numberWithInt:type]];
    
    trace(@"---------------！更新json name - %@ ----------",isSuccess?@"成功":@"失败");
    trace(@"-------------------------------------------------");
    return isSuccess;
}

-(int)ee_getNewsMax_SID:(NSInteger)markid{
    int max = [self getMaxFromTable:@"News" markid:markid];
    return max;
}

-(void)ee_setNewsReaded:(BOOL)isReaded Id:(int)kid{
    track();
    trace(@"-------------------------------------------------");
    trace(@"---function:ee_setNewsReaded----------");
    trace(@"-------------udpate sqlite, isReaded：%d",isReaded);
    
    FMDatabase *db = [FMDatabase databaseWithPath:EE_SqlitePath] ;
    
    if (![db open]) {
        trace(@"---------------Could not open db");
        return;
    }
    
    NSString *str = [NSString stringWithFormat:@"UPDATE News SET IsReaded=%@ WHERE id=%d",[NSNumber numberWithBool:isReaded],kid];
    trace(@"-------------query:%@",str);
    
    //BOOL isSuccess = [db executeUpdate:@"update News set Type=1 where id=?",([NSString stringWithFormat:@"%d",kid])];
    BOOL isSuccess = [db executeUpdate:@"UPDATE News SET IsReaded=? WHERE id=?",[NSNumber numberWithBool:isReaded],[NSNumber numberWithInt:kid]];
    trace(@"---------------！更新可读状态 - %@ ----------",isSuccess?@"成功":@"失败");
    trace(@"-------------------------------------------------");
}

-(void)ee_insertRowsInToTable_News:(NSMutableArray *)lists{
    //database executeUpdate:@"insert into user values (?,?,?)",nameTextField.text,genderTextField.text,ageTextField.text
    track();
    trace(@"-------------------------------------------------");
    trace(@"---function:ee_insertRowsInToTable_News----------");
    trace(@"-------------udpate sqlite, lists.length：%d",lists.count);
    
    FMDatabase *db = [FMDatabase databaseWithPath:EE_SqlitePath] ;
    
    if (![db open]) {
        trace(@"---------------Could not open db");
        return;
    }
    
    [lists enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {

        NSString *ss = [NSString stringWithFormat:@"insert into News (SID,NewsIcon,NewsTitle,NewsSummery,NewsTime,NewsContent,Type,RecordTime,IsReaded) values (%@,%@,%@,%@,%@,%@,%@,%@,%@)", 
                        [NSNumber numberWithInt:([[obj objectForKey:@"id"] intValue])],
                        [obj objectForKey:@"newsIcon"],
                        [obj objectForKey:@"newsTitle"],
                        [obj objectForKey:@"newsSummery"],
                        [obj objectForKey:@"newsTime"],
                        [obj objectForKey:@"newsContent"],
                        [obj objectForKey:@"type"],
                        [obj objectForKey:@"recordTime"],
                        [NSNumber numberWithBool:NO]
                        ];
        trace(@"%@",ss);
        
        
        
//        BOOL isSuccess = [db executeUpdate:@"insert into News (SID,NewsIcon,NewsTitle,NewsSummery,NewsTime,NewsContent,Type,RecordTime,IsReaded) values (?,?,?,?,?,?,?,?,?)",
//                          [NSNumber numberWithInt:([[obj objectForKey:@"id"] intValue])],
//                          [obj objectForKey:@"NewsIcon"],
//                          [obj objectForKey:@"NewsTitle"],
//                          [obj objectForKey:@"NewsSummery"],
//                          [obj objectForKey:@"NewsTime"],
//                          [obj objectForKey:@"NewsContent"],
//                          [obj objectForKey:@"Type"],
//                          [obj objectForKey:@"RecordTime"],
//                          [NSNumber numberWithBool:NO]
//                          ];
        BOOL isSuccess = [db executeUpdate:@"insert into News (SID,NewsIcon,NewsTitle,NewsSummery,NewsTime,NewsContent,Type,RecordTime,IsReaded) values (?,?,?,?,?,?,?,?,?)",
                          [NSNumber numberWithInt:([[obj objectForKey:@"id"] intValue])],
                          [obj objectForKey:@"newsIcon"],
                          [obj objectForKey:@"newsTitle"],
                          [obj objectForKey:@"newsSummery"],
                          [obj objectForKey:@"newsTime"],
                          [obj objectForKey:@"newsContent"],
                          [obj objectForKey:@"type"],
                          [obj objectForKey:@"recordTime"],
                          [NSNumber numberWithBool:NO]
                          ];
        
        trace(@"---------------！插入状态 id:%@  %@ ----------",[obj objectForKey:@"id"],isSuccess?@"成功":@"失败");
    }];
    
    trace(@"-------------------------------------------------");
}


#pragma mark - 专家 -
-(int)ee_getExpertMax_SID:(MarkID)markid{
    
    int max = [self getMaxFromTable:@"Speakers" markid:markid];
    return max;
    
}

-(NSString *)ee_getJsonExpretDetail_SID:(NSInteger)SID{
    track();
    trace(@"-------------------------------------------------");
    trace(@"---function:ee_getExpretDetail_SID----------");
    trace(@"-------------query sqlite, SID:%d",SID);
    
    FMDatabase *db = [FMDatabase databaseWithPath:EE_SqlitePath] ;
    
    if (![db open]) {
        trace(@"---------------Could not open db");
        return NULL;
    }
    
    NSString *str = [NSString stringWithFormat:@"select * from Speakers where SID='%d' ",SID];
    
    trace(@"-------------query:%@",str);
    FMResultSet *rs = [db executeQuery:str];
    
    NSString *jsonFile = nil;
    if ([rs next]) {
        jsonFile = [rs stringForColumn:@"SpeakerDetail"];
    }
    
    trace(@"---------------！查询数据库，得到jsonFile:%@----------",jsonFile);
    
    // close the result set.
    // it'll also close when it's dealloc'd, but we're closing the database before
    // the autorelease pool closes, so sqlite will complain about it.
    [rs close];
    trace(@"-------------------------------------------------");
    
    return jsonFile;
}



-(BOOL )ee_updateJsonExpretDetail_SID:(NSInteger)SID jsonFileName:(NSString *)fileName{
    
    track();
    trace(@"-------------------------------------------------");
    trace(@"---function:ee_updateJsonExpretDetail_SID----------");
    trace(@"-------------udpate sqlite, jsonFileName：%@",fileName);
    
    FMDatabase *db = [FMDatabase databaseWithPath:EE_SqlitePath] ;
    
    if (![db open]) {
        trace(@"---------------Could not open db");
        return NO;
    }
    
    NSString *str = [NSString stringWithFormat:@"UPDATE Speakers SET SpeakerDetail=%@ WHERE SID=%d",fileName,SID];
    trace(@"-------------query:%@",str);
    
    //BOOL isSuccess = [db executeUpdate:@"update News set Type=1 where id=?",([NSString stringWithFormat:@"%d",kid])];
    BOOL isSuccess = [db executeUpdate:@"UPDATE Speakers SET SpeakerDetail=? WHERE SID=?",fileName,[NSNumber numberWithInt:SID]];
    
    trace(@"---------------！更新json name - %@ ----------",isSuccess?@"成功":@"失败");
    trace(@"-------------------------------------------------");
    return isSuccess;
}

-(NSMutableArray *)ee_getExpertListByMarkID:(int)markid{
    track();
    trace(@"-------------------------------------------------");
    trace(@"---function:ee_getExpertListByMarkID----------");
    trace(@"-------------query sqlite, ModalType：%d",markid);
    NSMutableArray *array = [NSMutableArray array];
    
    FMDatabase *db = [FMDatabase databaseWithPath:EE_SqlitePath] ;
    
    if (![db open]) {
        trace(@"---------------Could not open db");
        return NULL;
    }
    
    NSString *str = [NSString stringWithFormat:@"select * from Speakers order by SID desc limit 0,%d",PageNum];
    
    trace(@"-------------query:%@",str);
    FMResultSet *rs = [db executeQuery:str];
    
    while ([rs next]) {
        NSMutableDictionary *oneNews = [NSMutableDictionary dictionary];
        [oneNews setValue:[rs stringForColumn:@"id"] forKey:@"id"];
        [oneNews setValue:[rs stringForColumn:@"SID"] forKey:@"SID"];
        [oneNews setValue:[rs stringForColumn:@"SpeakerName"] forKey:@"SpeakerName"];
        [oneNews setValue:[rs stringForColumn:@"SpeakerSummery"] forKey:@"SpeakerSummery"];
        [oneNews setValue:[rs stringForColumn:@"SpeakerImage"] forKey:@"SpeakerImage"];
        [oneNews setValue:[rs stringForColumn:@"SpeakerCalled"] forKey:@"SpeakerCalled"];
        [oneNews setValue:[rs stringForColumn:@"SpeakerDetail"] forKey:@"SpeakerDetail"];
        [oneNews setValue:[rs stringForColumn:@"RecordTime"] forKey:@"RecordTime"];
        [oneNews setValue:[rs stringForColumn:@"IsReaded"] forKey:@"IsReaded"];
        
        [array addObject:oneNews];
    }
    
    trace(@"---------------！查询baike数据库，得到了 %d条数据----------",[array count]);
    
    // close the result set.
    // it'll also close when it's dealloc'd, but we're closing the database before
    // the autorelease pool closes, so sqlite will complain about it.
    [rs close];
    trace(@"-------------------------------------------------");
    return array;
}

-(void)ee_setExpertReaded:(BOOL)isReaded Id:(int)kid{
    
    track();
    trace(@"-------------------------------------------------");
    trace(@"---function:ee_setExpertReaded----------");
    trace(@"-------------udpate sqlite, isReaded：%d",isReaded);
    
    FMDatabase *db = [FMDatabase databaseWithPath:EE_SqlitePath] ;
    
    if (![db open]) {
        trace(@"---------------Could not open db");
        return;
    }
    
    NSString *str = [NSString stringWithFormat:@"UPDATE Speakers SET IsReaded=%@ WHERE id=%d",[NSNumber numberWithBool:isReaded],kid];
    trace(@"-------------query:%@",str);
    
    //BOOL isSuccess = [db executeUpdate:@"update News set Type=1 where id=?",([NSString stringWithFormat:@"%d",kid])];
    BOOL isSuccess = [db executeUpdate:@"UPDATE Speakers SET IsReaded=? WHERE id=?",[NSNumber numberWithBool:isReaded],[NSNumber numberWithInt:kid]];
    trace(@"---------------！更新可读状态 - %@ ----------",isSuccess?@"成功":@"失败");
    trace(@"-------------------------------------------------");

}

-(void)ee_insertRowsInToTable_Expert:(NSMutableArray *)lists{
    //database executeUpdate:@"insert into user values (?,?,?)",nameTextField.text,genderTextField.text,ageTextField.text
    track();
    trace(@"-------------------------------------------------");
    trace(@"---function:ee_insertRowsInToTable_Speakers----------");
    trace(@"-------------udpate sqlite, lists.length：%d",lists.count);
    
    FMDatabase *db = [FMDatabase databaseWithPath:EE_SqlitePath] ;
    
    if (![db open]) {
        trace(@"---------------Could not open db");
        return;
    }
    
    [lists enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSString *ss = [NSString stringWithFormat:@"insert into Speakers (SID,SpeakerName,SpeakerSummery,SpeakerImage,SpeakerCalled,SpeakerDetail,RecordTime,IsReaded) values (%@,%@,%@,%@,%@,%@,%@,%@)",
                        [NSNumber numberWithInt:([[obj objectForKey:@"id"] intValue])],
                        [obj objectForKey:@"speakerName"],
                        [obj objectForKey:@"speakerSummery"],
                        [obj objectForKey:@"speakerImage"],
                        [obj objectForKey:@"speakerCalled"],
                        [obj objectForKey:@"speakerDetail"],
                        [obj objectForKey:@"recordTime"],
                        [NSNumber numberWithBool:NO]
                        ];
        trace(@"%@",ss);
        
        
        
        BOOL isSuccess = [db executeUpdate:@"insert into Speakers (SID,SpeakerName,SpeakerSummery,SpeakerImage,SpeakerCalled,SpeakerDetail,RecordTime,IsReaded) values  (?,?,?,?,?,?,?,?)",
                          [NSNumber numberWithInt:([[obj objectForKey:@"id"] intValue])],
                          [obj objectForKey:@"speakerName"],
                          [obj objectForKey:@"speakerSummery"],
                          [obj objectForKey:@"speakerImage"],
                          [obj objectForKey:@"speakerCalled"],
                          [obj objectForKey:@"speakerDetail"],
                          [obj objectForKey:@"recordTime"],
                          [NSNumber numberWithBool:NO]
                          ];
        
        trace(@"---------------！插入状态 id:%@  %@ ----------",[obj objectForKey:@"id"],isSuccess?@"成功":@"失败");
    }];
    
    trace(@"-------------------------------------------------");
}


#pragma mark - 日程 -
-(int)ee_getSchedulMax_SID:(MarkID)markid{
    
    int max = [self getMaxFromTable:@"Schedule" markid:markid];
    
    return max;
}

-(NSString *)ee_getJsonSchedulDetail_SID:(NSInteger)SID{
    track();
    trace(@"-------------------------------------------------");
    trace(@"---function:ee_getExpretDetail_SID----------");
    trace(@"-------------query sqlite, SID:%d",SID);
    
    FMDatabase *db = [FMDatabase databaseWithPath:EE_SqlitePath] ;
    
    if (![db open]) {
        trace(@"---------------Could not open db");
        return NULL;
    }
    
    NSString *str = [NSString stringWithFormat:@"select * from Schedule where SID='%d' ",SID];
    
    trace(@"-------------query:%@",str);
    FMResultSet *rs = [db executeQuery:str];
    
    NSString *jsonFile = nil;
    if ([rs next]) {
        jsonFile = [rs stringForColumn:@"ScheduleDetail"];
    }
    
    trace(@"---------------！查询数据库，得到jsonFile:%@----------",jsonFile);
    
    // close the result set.
    // it'll also close when it's dealloc'd, but we're closing the database before
    // the autorelease pool closes, so sqlite will complain about it.
    [rs close];
    trace(@"-------------------------------------------------");
    
    return jsonFile;
}




-(BOOL )ee_updateJsonScheduleDetail_SID:(NSInteger)SID jsonFileName:(NSString *)fileName{
    
    track();
    trace(@"-------------------------------------------------");
    trace(@"---function:ee_updateJsonScheduleDetail_SID----------");
    trace(@"-------------udpate sqlite, jsonFileName：%@",fileName);
    
    FMDatabase *db = [FMDatabase databaseWithPath:EE_SqlitePath] ;
    
    if (![db open]) {
        trace(@"---------------Could not open db");
        return NO;
    }
    
    NSString *str = [NSString stringWithFormat:@"UPDATE Schedule SET ScheduleDetail=%@ WHERE SID=%d",fileName,SID];
    trace(@"-------------query:%@",str);
    
    BOOL isSuccess = [db executeUpdate:@"UPDATE Schedule SET ScheduleDetail=? WHERE SID=?",fileName,[NSNumber numberWithInt:SID]];
//    BOOL isSucc2ss = [db executeUpdate:@"UPDATE Schedule SET ScheduleDetail=? WHERE SID=?",fileName,[NSNumber numberWithInt:SID]];
    
    trace(@"---------------！更新json name - %@ ----------",isSuccess?@"成功":@"失败");
    trace(@"-------------------------------------------------");
    return isSuccess;
}


-(NSMutableArray *)ee_getMeetScheduleListByMarkID:(int)markid{
    track();
    trace(@"-------------------------------------------------");
    trace(@"---function:ee_getNewsListByModalType----------");
    trace(@"-------------query sqlite, ModalType：%d",markid);
    NSMutableArray *array = [NSMutableArray array];
    
    FMDatabase *db = [FMDatabase databaseWithPath:EE_SqlitePath] ;
    
    if (![db open]) {
        trace(@"---------------Could not open db");
        return NULL;
    }
    
    NSString *str = [NSString stringWithFormat:@"select * from Schedule order by SID desc limit 0,%d",PageNum];
    
    trace(@"-------------query:%@",str);
    FMResultSet *rs = [db executeQuery:str];
    
    while ([rs next]) {
        NSMutableDictionary *oneNews = [NSMutableDictionary dictionary];
        [oneNews setValue:[rs stringForColumn:@"id"] forKey:@"id"];
        [oneNews setValue:[rs stringForColumn:@"SID"] forKey:@"SID"];
        [oneNews setValue:[rs stringForColumn:@"ScheduleGroupName"] forKey:@"ScheduleGroupName"];
        [oneNews setValue:[rs stringForColumn:@"ScheduleName"] forKey:@"ScheduleName"];
        [oneNews setValue:[rs stringForColumn:@"ScheduleSummery"] forKey:@"ScheduleSummery"];
        [oneNews setValue:[rs stringForColumn:@"ScheduleBeginTime"] forKey:@"ScheduleBeginTime"];
        [oneNews setValue:[rs stringForColumn:@"ScheduleEndTime"] forKey:@"ScheduleEndTime"];
        [oneNews setValue:[rs stringForColumn:@"RecordTime"] forKey:@"RecordTime"];
        [oneNews setValue:[rs stringForColumn:@"IsReaded"] forKey:@"IsReaded"];
        [oneNews setValue:[rs stringForColumn:@"IsFavorite"] forKey:@"IsFavorite"];
        [oneNews setValue:@"专家名称" forKey:@"SpeakerName"];
        
        [array addObject:oneNews];
    }
    
    trace(@"---------------！查询baike数据库，得到了 %d条数据----------",[array count]);
    
    // close the result set.
    // it'll also close when it's dealloc'd, but we're closing the database before
    // the autorelease pool closes, so sqlite will complain about it.
    [rs close];
    trace(@"-------------------------------------------------");
    return array;
}

-(void)ee_setScheduleReaded:(BOOL)isReaded Id:(int)kid{
    
    
    track();
    trace(@"-------------------------------------------------");
    trace(@"---function:ee_setExpertReaded----------");
    trace(@"-------------udpate sqlite, isReaded：%d",isReaded);
    
    FMDatabase *db = [FMDatabase databaseWithPath:EE_SqlitePath] ;
    
    if (![db open]) {
        trace(@"---------------Could not open db");
        return;
    }
    
    NSString *str = [NSString stringWithFormat:@"UPDATE Schedule SET IsReaded=%@ WHERE id=%d",[NSNumber numberWithBool:isReaded],kid];
    trace(@"-------------query:%@",str);
    
    //BOOL isSuccess = [db executeUpdate:@"update News set Type=1 where id=?",([NSString stringWithFormat:@"%d",kid])];
    BOOL isSuccess = [db executeUpdate:@"UPDATE Schedule SET IsReaded=? WHERE id=?",[NSNumber numberWithBool:isReaded],[NSNumber numberWithInt:kid]];
    trace(@"---------------！更新可读状态 - %@ ----------",isSuccess?@"成功":@"失败");
    trace(@"-------------------------------------------------");
}



-(void)ee_insertRowsInToTable_Schedule:(NSMutableArray *)lists{
    track();
    trace(@"-------------------------------------------------");
    trace(@"---function:ee_insertRowsInToTable_Schedule----------");
    trace(@"-------------udpate sqlite, lists.length：%d",lists.count);
    
    FMDatabase *db = [FMDatabase databaseWithPath:EE_SqlitePath] ;
    
    if (![db open]) {
        trace(@"---------------Could not open db");
        return;
    }
    
    [lists enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSString *ss = [NSString stringWithFormat:@"insert into Schedule (SID,ScheduleGroupName,ScheduleName,ScheduleSummery,ScheduleBeginTime,ScheduleEndTime,RecordTime,IsReaded,IsFavorite) values (%@,%@,%@,%@,%@,%@,%@,%@,%@)",
                        [NSNumber numberWithInt:([[obj objectForKey:@"id"] intValue])],
                        [obj objectForKey:@"scheduleGroupName"],
                        [obj objectForKey:@"scheduleName"],
                        [obj objectForKey:@"scheduleSummery"],
                        [obj objectForKey:@"scheduleBeginTime"],
                        [obj objectForKey:@"scheduleEndTime"],
                        [obj objectForKey:@"recordTime"],
                        [NSNumber numberWithBool:NO],
                        [NSNumber numberWithBool:NO]
                        ];
        trace(@"%@",ss);
        
        
        
        BOOL isSuccess = [db executeUpdate:@"insert into Schedule (SID,ScheduleGroupName,ScheduleName,ScheduleSummery,ScheduleBeginTime,ScheduleEndTime,RecordTime,IsReaded,IsFavorite) values (?,?,?,?,?,?,?,?,?)",
                          [NSNumber numberWithInt:([[obj objectForKey:@"id"] intValue])],
                          [obj objectForKey:@"scheduleGroupName"],
                          [obj objectForKey:@"scheduleName"],
                          [obj objectForKey:@"scheduleSummery"],
                          [obj objectForKey:@"scheduleBeginTime"],
                          [obj objectForKey:@"scheduleEndTime"],
                          [obj objectForKey:@"recordTime"],
                          [NSNumber numberWithBool:NO],
                          [NSNumber numberWithBool:NO]
                          ];
        
        trace(@"---------------！插入状态 id:%@  %@ ----------",[obj objectForKey:@"id"],isSuccess?@"成功":@"失败");
    }];
    
    trace(@"-------------------------------------------------");
}












#pragma mark - 共同 -

-(int)getMaxFromTable:(NSString *)tableName markid:(MarkID)markid{
    
    track();
    trace(@"-------------------------------------------------");
    trace(@"---function:ee_getNewsMax_SID----------");
    trace(@"-------------query tablename:%@ modalType:%d",tableName,markid);
    
    FMDatabase *db = [FMDatabase databaseWithPath:EE_SqlitePath] ;
    
    if (![db open]) {
        trace(@"---------------Could not open db");
        return 0;
    }
    
    NSString *sqlString = @"";
    if (markid == MarkID_Expert || markid == MarkID_MeetSchedul) {
        sqlString = [NSString stringWithFormat:@"select max(SID) as maxid from %@ ",tableName];
    }else{
        sqlString = [NSString stringWithFormat:@"select max(SID) as maxid from %@ where type='%d' ",tableName,markid];
    }
    
    
    trace(@"-------------query:%@",sqlString);
    FMResultSet *rs = [db executeQuery:sqlString];
    
    int maxSid = 0;
    if ([rs next]) {
        maxSid = [[rs stringForColumn:@"maxid"] intValue];
    }
    
    trace(@"---------------！查询数据库，得到maxSid:%d----------",maxSid);
    
    // close the result set.
    // it'll also close when it's dealloc'd, but we're closing the database before
    // the autorelease pool closes, so sqlite will complain about it.
    [rs close];
    trace(@"-------------------------------------------------");
    
    return maxSid;
}

@end
