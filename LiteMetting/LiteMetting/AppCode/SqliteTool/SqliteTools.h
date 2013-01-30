//
//  SqliteTools.h
//  LiteMetting
//
//  Created by hong pai on 13-1-23.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//



#import <Foundation/Foundation.h>

@interface SqliteTools : NSObject{
    
}

+(SqliteTools *)shareInstacne;


#pragma mark - news -
-(NSMutableArray *)ee_getNewsListByMarkID:(int)modalType;

-(NSString *)ee_getJsonNewsDetail_SID:(NSInteger)SID andMarkID:(NSInteger)markid;
-(NSString *)ee_getJsonExpretDetail_SID:(NSInteger)SID;
-(NSString *)ee_getJsonSchedulDetail_SID:(NSInteger)SID;

-(int)ee_getNewsMax_SID:(NSInteger)markid;

-(int)ee_getExpertMax_SID:(MarkID)markid;

-(int)ee_getSchedulMax_SID:(MarkID)markid;

-(NSMutableArray *)ee_getExpertListByMarkID:(int)markid;
-(NSMutableArray *)ee_getMeetScheduleListByMarkID:(int)markid;

-(void)ee_setNewsReaded:(BOOL)isReaded Id:(int)kid;
-(void)ee_setExpertReaded:(BOOL)isReaded Id:(int)kid;
-(void)ee_setScheduleReaded:(BOOL)isReaded Id:(int)kid;

-(void)ee_insertRowsInToTable_News:(NSMutableArray *)lists;
-(void)ee_insertRowsInToTable_Expert:(NSMutableArray *)lists;
-(void)ee_insertRowsInToTable_Schedule:(NSMutableArray *)lists;
    

-(BOOL )ee_updateJsonScheduleDetail_SID:(NSInteger)SID jsonFileName:(NSString *)fileName;
-(BOOL )ee_updateJsonExpretDetail_SID:(NSInteger)SID jsonFileName:(NSString *)fileName;
-(BOOL )ee_updateJsonNewsDetail_SID:(NSInteger)SID  type:(NSInteger)type jsonFileName:(NSString *)fileName;


@end
