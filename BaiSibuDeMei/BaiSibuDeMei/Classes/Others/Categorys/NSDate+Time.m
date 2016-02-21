//
//  NSDate+Time.m
//  BaiSibuDeMei
//
//  Created by czljcb on 16/2/1.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import "NSDate+Time.h"

@implementation NSDate (Time)

- (BOOL)isYesterday
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    NSString *dayStr = [formatter stringFromDate:self];
    NSString *nowDayStr = [formatter stringFromDate:[NSDate date]];
    
    NSDate *day = [formatter dateFromString:dayStr];
    NSDate *nowDay = [formatter dateFromString:nowDayStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    //    NSCalendarUnitYear               = kCFCalendarUnitYear,
    //    NSCalendarUnitMonth              = kCFCalendarUnitMonth,
    //    NSCalendarUnitDay                = kCFCalendarUnitDay,
    //    NSCalendarUnitHour               = kCFCalendarUnitHour,
    //    NSCalendarUnitMinute             = kCFCalendarUnitMinute,
    //    NSCalendarUnitSecond             = kCFCalendarUnitSecond,
    
    NSDateComponents *components = [calendar components:unit fromDate:day toDate:nowDay options:0];
    
    
    return (components.day == 1);
}

- (BOOL)isMinute
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    
    NSString *minute = [formatter stringFromDate:self];
    NSString *nowMinute = [formatter stringFromDate:[NSDate date]];
    
    return [minute isEqualToString:nowMinute];
}

- (BOOL)isHour
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH";
    
    NSString *hour = [formatter stringFromDate:self];
    NSString *nowHour = [formatter stringFromDate:[NSDate date]];
    
    return [hour isEqualToString:nowHour];
}


- (BOOL)isToday
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    NSString *today = [formatter stringFromDate:self];
    NSString *nowToday = [formatter stringFromDate:[NSDate date]];
    return [today isEqualToString:nowToday];
}


- (BOOL)isYear
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy";
    
    NSString *year = [formatter stringFromDate:self];
    NSString *nowYear = [formatter stringFromDate:[NSDate date]];
    return [year isEqualToString:nowYear];
}

@end
