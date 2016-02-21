//
//  CZTagSubItem.h
//  BaiSibuDeMei
//
//  Created by czljcb on 16/1/21.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZTagSubItem : NSObject



//    @[
//      @{
//          @"image_list" : @"http://img.spriteapp.cn/ugc/2016/01/20/163321_13294.jpg",
//          @"theme_id" : @"10212",
//          @"theme_name" : @"网友大拜年",
//          @"is_sub" : @(0),
//          @"is_default" : @(0),
//          @"sub_number" : @"700",
//          }
//      ];

@property (nonatomic, strong) NSString *image_list;

@property (nonatomic, strong) NSNumber *sub_number;

@property (nonatomic, strong) NSString *theme_name;

@end
