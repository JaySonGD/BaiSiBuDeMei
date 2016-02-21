//
//  UIView+Frame.m
//  18 . 彩票
//
//  Created by czljcb on 15/12/16.
//  Copyright © 2015年 czljcb. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
/**
 
 分类
 */

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setY:(CGFloat)y
{
    CGRect frameT = self.frame;
    frameT.origin.y = y;
    self.frame = frameT;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setX:(CGFloat)x
{
    CGRect frameT = self.frame;
    frameT.origin.x = x;
    self.frame = frameT;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

-(void)setWidth:(CGFloat)width
{
    CGRect frameT = self.frame;
    frameT.size.width = width;
    self.frame = frameT;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frameT = self.frame;
    frameT.size.height = height;
    self.frame = frameT;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect frameT = self.frame;
    frameT.size = size;
    self.frame = frameT;
}

- (CGSize)size
{
    return self.frame.size;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}



- (CGFloat)top
{
    return self.frame.origin.y;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}





- (void)removeAllSubviews
{
    while (self.subviews.count)
    {
        UIView *child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (void)frameSet:(NSString *)key value:(CGFloat)value
{
    CGRect rect = self.frame;
    
    if ([@"x" isEqualToString:key]) {
        rect.origin.x = value;
        
    } else if ([@"y" isEqualToString:key]) {
        rect.origin.y = value;
        
    } else if ([@"w" isEqualToString:key]) {
        rect.size.width = value;
        
    } else if ([@"h" isEqualToString:key]) {
        rect.size.height = value;
    }
    
    self.frame = rect;
}

- (void)frameSet:(NSString *)key1 value1:(CGFloat)value1 key2:(NSString *)key2 value2:(CGFloat)value2
{
    [self frameSet:key1 value:value1];
    [self frameSet:key2 value:value2];
}

/**
 *  从 bundle 加载一个 view
 *
 *  @param name 名字
 *
 *  @return 返回一个 view
 */
+ (instancetype)viewFromXib
{
    NSString *className = NSStringFromClass([self class]);
    id object = [[[NSBundle mainBundle]loadNibNamed:className owner:nil options:nil]lastObject];
    if ([object isKindOfClass:[self class]]) {
        return object;
    }
    return  nil;
}

@end
