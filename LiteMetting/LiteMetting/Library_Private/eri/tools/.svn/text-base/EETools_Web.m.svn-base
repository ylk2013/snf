//
//  EETools_Web.m
//  LiteMetting
//
//  Created by hong pai on 13-1-23.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "EETools_Web.h"
#import "Reachability.h"

@implementation EETools_Web

//是否有网络连接
+(BOOL)ee_isHasConnection{
    
    if([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] == kNotReachable && [Reachability reachabilityForInternetConnection] == kNotReachable){
        trace(@"---------没有网络连接-------");
        return NO;
    }
    trace(@"---------有网络连接  %d  %d-------",[[Reachability reachabilityForLocalWiFi] currentReachabilityStatus],[[Reachability reachabilityForInternetConnection] currentReachabilityStatus]);
    return YES;
}

@end
