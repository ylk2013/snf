//
//  NSDictionary+Extras.m
//  Libaray
//
//  Created by pai hong on 12-6-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSDictionary+EEExtras.h"

@implementation NSDictionary (EEExtras)

#pragma mark ————————   NSData --> NSDictionary————————

+ (NSDictionary *)ee_dictionaryWithContentsOfData:(NSData *)data {
    CFPropertyListRef plist =  CFPropertyListCreateFromXMLData(kCFAllocatorDefault, (CFDataRef)data,
                                                               kCFPropertyListImmutable,
                                                               NULL);
    if(plist == nil) return nil;
    if ([(id)plist isKindOfClass:[NSDictionary class]]) {
        return [(NSDictionary *)plist autorelease];
    }
    else {
        CFRelease(plist);
        return nil;
    }
}
@end
