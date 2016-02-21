//
//  CZFileTool.h
//  BaiSibuDeMei
//
//  Created by czljcb on 16/1/23.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZFileTool : NSObject

+ (void)deleteDirectoryPath:(NSString *)directoryPath complete:(void (^)(void)) complete
;
+ (void)getSizeWithDirectoryPath:(NSString *)directoryPath complete:(void (^)(NSInteger size)) complete
;
+ (long long) fileSizeAtPath:(NSString*) filePath
;
+ (void) folderSizeAtPath:(NSString*) folderPath complete:(void (^)(NSInteger size)) complete;


@end
