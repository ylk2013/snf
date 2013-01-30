//
//  FileTools.m
//  Signature
//
//  Created by pai hong on 12-6-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

/**
 --得到文件的最新修改日期
 */

#import "EETools_File.h"

#include <sys/stat.h>
#include <dirent.h>

@implementation EETools_File


+(NSString *)tools_getFilePathInAppBundle_filename:(NSString *)filname ext:(NSString *)type{
    NSString *path = [[NSBundle mainBundle] pathForResource:filname ofType:type];
    return path;
}

// --得到文件的最新修改日期
+(NSString *)tools_getFileLastestUpdateTime:(NSString *)filePath{
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    
    NSDate *createDate = [NSDate date];
    
    [fileURL getResourceValue:&createDate forKey:@"NSURLAttributeModificationDateKey"error:nil];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *result = [df stringFromDate:createDate];
    [df release];
    
    return  result;
}

+(void)ee_deleteAllFlies_inOneFolder:(NSString *)folder{
    //NSHomeDirectory()
    NSArray *allFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:folder error:nil];
    int len = [allFiles count];
    
    for (int i=0; i<len; i++) {
        NSString *filename =  [allFiles objectAtIndex:i];        
        NSString *completePath = [folder stringByAppendingPathComponent:filename];
        trace(@"fliepath %@",completePath);

        BOOL result = [[NSFileManager defaultManager] removeItemAtPath:completePath error:nil];
        trace(@"---------------del file in Inbox %@",result?@"success":@"failed");
    }
}
//+ (long long)ee_fileSize:(NSString *)filePath {
//    struct stat st;
//    if (lstat([filePath cStringUsingEncoding:NSUTF8StringEncoding], &st) == 0) {
//        return st.st_size;
//    }
//    return 0;
//}
//
//+(long long)ee_folderSize:(const char *)folderPath {
//    long long folderSize = 0;
//    DIR* dir = opendir(folderPath);
//    if (dir == NULL) { 
//        return 0;
//    }
//    struct dirent* child;
//    while ((child = readdir(dir)) != NULL) {
//        if (child->d_type == DT_DIR 
//            && (child->d_name[0] == '.' && child->d_name[1] == 0)) {
//            continue;
//        }
//        
//        if (child->d_type == DT_DIR 
//            && (child->d_name[0] == '.' && child->d_name[1] == '.' && child->d_name[2] == 0)) {
//            continue;
//        }
//        
//        int folderPathLength = strlen(folderPath);
//        char childPath[1024];
//        stpcpy(childPath, folderPath);
//        if (folderPath[folderPathLength - 1] != '/'){
//            childPath[folderPathLength] = '/';
//            folderPathLength++;
//        }
//        
//        stpcpy(childPath + folderPathLength, child->d_name);
//        childPath[folderPathLength + child->d_namlen] = 0;
//        if (child->d_type == DT_DIR){
//            folderSize += [self folderSize:childPath];
//            struct stat st;
//            if (lstat(childPath, &st) == 0) {
//                folderSize += st.st_size;
//            }
//        } else if (child->d_type == DT_REG || child->d_type == DT_LNK){
//            struct stat st;
//            if (lstat(childPath, &st) == 0) {
//                folderSize += st.st_size;
//            }
//        }
//    }
//    
//    return folderSize;
//}

//完全使用unix c函数

+(long long)ee_fileSizeForDir:(NSString*)path{
   return  [EETools_File folderSize:[path cStringUsingEncoding:NSUTF8StringEncoding]];
}
+ (long long)folderSize:(const char *)folderPath {
    long long folderSize = 0;
    DIR* dir = opendir(folderPath);
    if (dir == NULL) { 
        return 0;
    }
    struct dirent* child;
    while ((child = readdir(dir)) != NULL) {
        if (child->d_type == DT_DIR 
            && (child->d_name[0] == '.' && child->d_name[1] == 0)) {
            continue;
        }
        
        if (child->d_type == DT_DIR 
            && (child->d_name[0] == '.' && child->d_name[1] == '.' && child->d_name[2] == 0)) {
            continue;
        }
        
        int folderPathLength = strlen(folderPath);
        char childPath[1024];
        stpcpy(childPath, folderPath);
        if (folderPath[folderPathLength - 1] != '/'){
            childPath[folderPathLength] = '/';
            folderPathLength++;
        }
        
        stpcpy(childPath + folderPathLength, child->d_name);
        childPath[folderPathLength + child->d_namlen] = 0;
        if (child->d_type == DT_DIR){
            folderSize += [self folderSize:childPath];
            struct stat st;
            if (lstat(childPath, &st) == 0) {
                folderSize += st.st_size;
            }
        } else if (child->d_type == DT_REG || child->d_type == DT_LNK){
            struct stat st;
            if (lstat(childPath, &st) == 0) {
                folderSize += st.st_size;
            }
        }
    }
    
    return folderSize;
}

@end


@implementation EETools_File(Private)
@end