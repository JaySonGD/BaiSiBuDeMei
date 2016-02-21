//
//  CZCommentItem.h
//  BaiSibuDeMei
//
//  Created by czljcb on 16/1/31.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CZUserItem;
@interface CZCommentItem : NSObject

@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong)  CZUserItem *user;

@end
