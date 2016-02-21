//
//  SandBoxPaths.m
//  CreateImage
//
//  Created by czljcb on 15/12/24.
//  Copyright © 2015年 czljcb. All rights reserved.
//

#import "SandBoxPaths.h"

@implementation SandBoxPaths
// 得到沙盒主目录
+ (NSString *)homePath
{
    return NSHomeDirectory() ;
}

// 得到documents文件夹目录
+ (NSString *)documentPath
{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject  ;
}

// 得到document文件夹下的指定文件的路径
+ (NSString *)documentAbsolutePath : (NSString *)fileName
{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:fileName] ;
}

// 得到library文件夹目录
+ (NSString *)libraryPath
{
    return NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject ;
}


// 得到Cache文件夹目录
+ (NSString *)cachePath
{
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject ;
}

// 得到temp文件夹目录
+ (NSString *)tempPath
{
    return NSTemporaryDirectory() ;
}
@end
