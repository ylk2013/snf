//
//  EETools_URL.m
//  AZSharePoint
//
//  Created by pai hong on 12-11-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EETools_URL.h"
#import "NSString+EEExtras.h"

@implementation EETools_URL

+(NSString *)ee_getHostName:(NSString *)url{
    if (![url hasPrefix:@"http://"]) {
        trace(@"------url 不是以 http://开头-------");
        return nil;
    }
    NSRange indexOfTwoXie = [url rangeOfString:@"//"];
    NSString *end = [url substringFromIndex:(indexOfTwoXie.location+indexOfTwoXie.length)];
    NSRange indexofNexXie = [end rangeOfString:@"/"];
    NSString *shortSite = [url substringToIndex:(indexOfTwoXie.location+indexOfTwoXie.length+indexofNexXie.location+1)];
    
    return shortSite;
}

+(NSString *)ee_getHost_endString:(NSString *)url{
    
    NSString *shortSite = [EETools_URL ee_getHostName:url];
    
    if (shortSite == nil) {
        return nil;
    }
    
    NSString *FileQianZhui = [url stringByReplacingOccurrencesOfString:shortSite withString:@""];
    
    return FileQianZhui;
}

//得到url里面的最后一个文件名称
+(NSString *)ee_getLastFlieNameInURL:(NSString *)url{
    NSString *trimURL = [url ee_trim];

    NSRange ranget = [trimURL rangeOfString:@"/" options:NSBackwardsSearch];
    NSAssert(ranget.length != 0,@"替换文件名的时候出现错误1  EETools_URL.m");
    
    NSString *filename = [url substringFromIndex:ranget.location+1];
    NSAssert(filename != nil,@"替换文件名的时候出现错误2  EETools_URL.m");   
    return filename;
}

+(NSString *)ee_replaceLastFlieNameInUrl:(NSString *)URL newFlieName:(NSString *)newFlieName{
    NSRange ranget = [URL rangeOfString:@"/" options:NSBackwardsSearch];
    NSAssert(ranget.length != 0,@"替换文件名的时候出现错误 3 EETools_URL.m");
    
    NSString *frontPart = [URL substringToIndex:ranget.location];
    trace(@"%@",frontPart);
    NSString *result = [frontPart stringByAppendingString:newFlieName];
    return result;
}

//得到扩展名
+(NSString *)ee_getExtName:(NSString *)filename{
    NSString *trimFileName = [filename ee_trim];
    NSArray *array = [trimFileName componentsSeparatedByString:@"."];
    if ([array count]<=0) {
        return nil;
    }
    return  [array objectAtIndex:([array count]-1)];
}











@end
