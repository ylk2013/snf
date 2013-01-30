//
//  ArrayTools.h
//  SecretSMS
//
//  Created by pai hong on 12-7-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EETools_Array : NSObject

+(NSMutableArray *)tools_ramdom:(NSMutableArray *)ballArray;

+(NSMutableArray *)ee_getGroupNames:(NSMutableArray *)allArray key:(NSString *)key;
+(NSMutableArray *)ee_groupArrays:(NSMutableArray *)allArray keys:(NSMutableArray *)keys key:(NSString *)key;

+(NSMutableArray *)ee_sortArray_String:(NSMutableArray *)allArray isDesc:(BOOL)isDesc;
+(NSMutableArray *)ee_sortArray_Object:(NSMutableArray *)allArray key:(NSString *)key isDesc:(BOOL)isDesc;

@end
