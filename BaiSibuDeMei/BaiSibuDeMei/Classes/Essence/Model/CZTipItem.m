//
//  CZTipItem.m
//  BaiSibuDeMei
//
//  Created by czljcb on 16/1/28.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZTipItem.h"
#import "CZCommentItem.h"
#import "CZUserItem.h"

#import <MJExtension.h>

@implementation CZTipItem


#pragma mark **************************************************************************************************
#pragma mark NSDictionary --> Model
+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"top_cmt": [CZCommentItem class],
             };
}

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"small_image":@"image0",
             @"large_image":@"image1" ,
             @"middle_image":@"image2"
             };
}

#pragma mark **************************************************************************************************
#pragma mark 对应cell的高度

- (CGFloat)cellHeight
{
    if (_cellHeight) return _cellHeight;
    
    _cellHeight += 55;//顶部 10 + 35 +10
    
    CGSize textMaxSize = CGSizeMake(iPhoneSize.width - 2 * 10, MAXFLOAT);
    
    CGSize textSize = [_text boundingRectWithSize:textMaxSize
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{
                                                    NSFontAttributeName :     [UIFont systemFontOfSize:15]
                                                    } context:nil
                       ].size;
    
    _cellHeight += textSize.height + 10; // text + 10
    
    if ([_type integerValue] != TopicTypeWord)
    {        
        CGFloat height = [_height integerValue] * (iPhoneSize.width - 2 * 10) / [_width integerValue];
        
        if (height >= iPhoneSize.height)
        {
            _cellHeight  += (iPhoneSize.width - 2 * 10) * 9 / 16 + 10;
        }
        else
        {
            _cellHeight += height + 10;
        }
    }
    
    if (_top_cmt.count)
    {
        
        CGSize cmtSize = [[NSString stringWithFormat:@"%@:%@",[_top_cmt lastObject].user.username ,[_top_cmt lastObject].content] boundingRectWithSize:textMaxSize
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{
                                                       NSFontAttributeName :     [UIFont systemFontOfSize:13]
                                                       } context:nil
                          ].size;
        _cellHeight += 20 + cmtSize.height + 10; //cmt + 10
    }

    _cellHeight += 41 + 5;  // 底部 + 5;
    return _cellHeight;
}

#pragma mark **************************************************************************************************
#pragma mark 时间处理
- (NSString *)created_at
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";

    NSDate *createdAtDate = [formatter dateFromString:_created_at];
    
    if (createdAtDate.isYear)
    {
        if (createdAtDate.isToday)
        {
            if (createdAtDate.isHour)
            {
                if (createdAtDate.isMinute)
                {
                    return @"刚刚";
                }
                else
                {
                    formatter.dateFormat = @"mm";
                    
                    NSString *createdAtStr = [formatter stringFromDate:createdAtDate];
                    NSString *nowStr = [formatter stringFromDate:[NSDate date]];
                    
                    return [NSString stringWithFormat:@"%zd 分钟前",([nowStr integerValue] - [createdAtStr integerValue])];
                }
            }
            else
            {
                formatter.dateFormat = @"HH";
                
                NSString *createdAtStr = [formatter stringFromDate:createdAtDate];
                NSString *nowStr = [formatter stringFromDate:[NSDate date]];
                
                return [NSString stringWithFormat:@"%zd 小时前",([nowStr integerValue] - [createdAtStr integerValue])];
            }
            
        }
        else
        {
            if (createdAtDate.isYesterday)
            {
                formatter.dateFormat = @"HH:mm:ss";
                return [NSString stringWithFormat:@"咋天 %@", [formatter stringFromDate:createdAtDate]];
            }
            else
            {
                formatter.dateFormat = @"MM-dd HH:mm:ss";
                return [formatter stringFromDate:createdAtDate];
            }
        }
    }
    else
    {
        return _created_at;
        
    }
    
    
}

#pragma mark **************************************************************************************************
#pragma mark voicetime

- (NSString *)voicetime
{
    NSString *minute = [NSString stringWithFormat:@"%02zd",[_voicetime integerValue]/60 ];
    NSString *second = [NSString stringWithFormat:@"%02zd",[_voicetime integerValue]%60 ];
    
    return [NSString stringWithFormat:@" %@:%@ ",minute,second];
}

#pragma mark **************************************************************************************************
#pragma mark videotime

- (NSString *)videotime
{
    NSString *minute = [NSString stringWithFormat:@"%02zd",[_videotime integerValue]/60 ];
    NSString *second = [NSString stringWithFormat:@"%02zd",[_videotime integerValue]%60 ];
    
    return [NSString stringWithFormat:@" %@:%@ ",minute,second];
}


#pragma mark **************************************************************************************************
#pragma mark playcount

- (NSString *)playcount
{
    return [NSString stringWithFormat:@" %@次播放 ",_playcount];
}

@end
