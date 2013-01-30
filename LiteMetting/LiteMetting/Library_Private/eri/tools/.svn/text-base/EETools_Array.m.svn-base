//
//  ArrayTools.m
//  SecretSMS
//
//  Created by pai hong on 12-7-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EETools_Array.h"

@implementation EETools_Array

//打乱数组
+(NSMutableArray *)tools_ramdom:(NSMutableArray *)ballArray{
    
    for (int x = 0; x < [ballArray count]; x++) {
        int randInt = (arc4random() % ([ballArray count] - x)) + x;
        
        [ballArray exchangeObjectAtIndex:x withObjectAtIndex:randInt];
    }
    
    return ballArray;
}



//根据数组中Object某一个字段进行分类
+(NSMutableArray *)ee_getGroupNames:(NSMutableArray *)allArray key:(NSString *)key{
    NSMutableArray *keyArray = [NSMutableArray array];
    
    int i = 0;
    
    while (YES && [allArray count]!=0) {
        NSDictionary *obj = [allArray objectAtIndex:i];
        NSString *value = [obj objectForKey:key];
        
        BOOL isInFindedArray = NO;
        int keyLength = [keyArray count];
        for (int j=0; j<keyLength; j++) {
            NSString *findedKey = [keyArray objectAtIndex:j];
            if ([value localizedCaseInsensitiveCompare:findedKey] == NSOrderedSame) {
                isInFindedArray = YES;
                break;
            }
        }
        //没有发现就增加
        if (!isInFindedArray) {
            [keyArray addObject:value];
        }
        //+1
        i++;
        //中断
        if (i>=[allArray count]) {
            break;
        }
    }
    
    return keyArray;
}


//根据字段数组，对数组进行分类
+(NSMutableArray *)ee_groupArrays:(NSMutableArray *)allArray keys:(NSMutableArray *)keys key:(NSString *)key{
    NSMutableArray *groupArrays = [NSMutableArray array];
    
    int allLen = [allArray count];
    for (int ki=0; ki<[keys count]; ki++) {
        NSString *keyValue = [keys objectAtIndex:ki];
        
        NSMutableDictionary *groupDictionary = [NSMutableDictionary dictionary];
        [groupDictionary setValue:keyValue forKey:@"keyName"];
        
        NSMutableArray *items = [NSMutableArray array];
        
        for (int i=0; i<allLen; i++) {
            NSDictionary *obj = [allArray objectAtIndex:i];
            NSString *value = [obj objectForKey:key];
            
            if ([keyValue localizedCaseInsensitiveCompare:value] == NSOrderedSame) {
                [items addObject:obj];
            }
        }
        
        [groupDictionary setValue:items forKey:@"items"];
        
        [groupArrays addObject:groupDictionary];
    }
    
    
    return groupArrays;
}




//排列数组  Ascending：升序    Descending：降序

+(NSMutableArray *)ee_sortArray_String:(NSMutableArray *)allArray isDesc:(BOOL)isDesc{
    
    NSArray *newAllArray = [allArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if (obj1 > obj2) {
            if (isDesc) {
                return (NSComparisonResult)NSOrderedDescending;
            }else{
                return (NSComparisonResult)NSOrderedAscending;
            }
        }
        if (obj1 < obj2){
            if (isDesc) {
                return (NSComparisonResult)NSOrderedAscending;
            }else{
                return (NSComparisonResult)NSOrderedDescending;
            }
        }
        return NSOrderedSame;
    }];
    
    return [NSMutableArray arrayWithArray:newAllArray];
}

+(NSMutableArray *)ee_sortArray_Object:(NSMutableArray *)allArray key:(NSString *)key isDesc:(BOOL)isDesc{
    
    NSArray *newAllArray = [allArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if ([[obj1 objectForKey:key] intValue] < [[obj2 objectForKey:@"order"] intValue]) {
            if (isDesc) {
                return (NSComparisonResult)NSOrderedDescending;
            }else{
                return (NSComparisonResult)NSOrderedAscending;
            }
        }
        if ([[obj1 objectForKey:key] intValue] > [[obj2 objectForKey:@"order"] intValue]){
            if (isDesc) {
                return (NSComparisonResult)NSOrderedAscending;
            }else{
                return (NSComparisonResult)NSOrderedDescending;
            }
        }
        return NSOrderedSame;
    }];
    
    return [NSMutableArray arrayWithArray:newAllArray];
}
































@end
