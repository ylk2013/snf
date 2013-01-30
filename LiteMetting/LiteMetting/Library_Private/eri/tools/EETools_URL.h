//
//  EETools_URL.h
//  AZSharePoint
//
//  Created by pai hong on 12-11-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EETools_URL : NSObject

+(NSString *)ee_getHostName:(NSString *)url;
+(NSString *)ee_getHost_endString:(NSString *)url;

+(NSString *)ee_getLastFlieNameInURL:(NSString *)url;

+(NSString *)ee_replaceLastFlieNameInUrl:(NSString *)URL newFlieName:(NSString *)newFlieName;

+(NSString *)ee_getExtName:(NSString *)filename;
@end
