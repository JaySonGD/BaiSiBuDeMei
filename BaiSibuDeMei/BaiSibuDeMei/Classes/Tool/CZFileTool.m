//
//  CZFileTool.m
//  BaiSibuDeMei
//
//  Created by czljcb on 16/1/23.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import "CZFileTool.h"

@implementation CZFileTool

+ (void)deleteDirectoryPath:(NSString *)directoryPath complete:(void (^)(void)) complete
{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSFileManager *mgr = [NSFileManager defaultManager];
        
        BOOL isDirectory;
        BOOL isExists = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
        
        if ( !isDirectory && !isExists)
        {
            //抛出异常
            NSException *exc = [NSException exceptionWithName:@"NSInternalInconsistencyException" reason:@"输入路径有误" userInfo:nil];
            //抛出异常
            [exc raise];
        }
        // 获取文件夹里所有文件
        NSArray *subpaths = [mgr subpathsAtPath:directoryPath];
        
        // 遍历所有的文件
        for (NSString *subpath in subpaths) {
            // 拼接文件全路径
            NSString *filePath = [directoryPath stringByAppendingPathComponent:subpath];
            
            [mgr removeItemAtPath:filePath error:nil];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (complete)
            {
                complete();
            }
        });
        
        //[mgr createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:NULL];
        
        
    });
    
    
}

+ (void)getSizeWithDirectoryPath:(NSString *)directoryPath complete:(void (^)(NSInteger)) complete
{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSFileManager *mgr = [NSFileManager defaultManager];
        NSArray *subArray =  [mgr subpathsAtPath:directoryPath];
        
        BOOL isDirectory;
        BOOL isExists = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
        
        if ( !isDirectory || !isExists)
        {
            //抛出异常
            NSException *exc = [NSException exceptionWithName:@"NSInternalInconsistencyException" reason:@"输入路径有误" userInfo:nil];
            //抛出异常
            [exc raise];
        }
        
        NSInteger totalSize = 0;
        for (NSString *path in subArray)
        {
            NSString *subPath = [directoryPath stringByAppendingPathComponent:path];
            BOOL isDirectory;
            BOOL isExists = [mgr fileExistsAtPath:subPath isDirectory:&isDirectory];
            if (/*[subPath containsString:@"DS"] ||*/ !isExists || isDirectory) continue;
            
            NSDictionary *fileSizepath =  [mgr attributesOfItemAtPath:subPath error:NULL];
            totalSize += [fileSizepath fileSize];
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (complete)
            {
                complete(totalSize);
            }
        });
        
        
    });
    
    
    
}


//单个文件的大小
+ (long long) fileSizeAtPath:(NSString*) filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    
    BOOL isDirectory;
    BOOL isExists = [manager fileExistsAtPath:filePath isDirectory:&isDirectory];
    
    if (isExists && !isDirectory){
        
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
//遍历文件夹获得文件夹大小，返回多少M
+ (void) folderSizeAtPath:(NSString*) folderPath complete:(void (^)(NSInteger size)) complete

{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSFileManager* manager = [NSFileManager defaultManager];
        if (![manager fileExistsAtPath:folderPath]) return ;
        NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
        NSString* fileName;
        long long folderSize = 0;
        while ((fileName = [childFilesEnumerator nextObject]) != nil)
        {
            
            NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
            folderSize += [self fileSizeAtPath:fileAbsolutePath];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (complete)
            {
                complete(folderSize);
            }
            
        });
    });
    
    
    
}
@end
