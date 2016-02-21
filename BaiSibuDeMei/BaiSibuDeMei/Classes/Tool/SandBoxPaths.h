//
//  SandBoxPaths.h
//  CreateImage
//
//  Created by czljcb on 15/12/24.
//  Copyright © 2015年 czljcb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SandBoxPaths : NSObject
// 得到沙盒主目录
+ (NSString *)homePath;
// 得到documents文件夹目录
+ (NSString *)documentPath;
// 得到document文件夹下的指定文件的路径
+ (NSString *)documentAbsolutePath : (NSString *)fileName;
// 得到library文件夹目录
+ (NSString *)libraryPath;
// 得到Cache文件夹目录
+ (NSString *)cachePath;
// 得到temp文件夹目录
+ (NSString *)tempPath;
@end
