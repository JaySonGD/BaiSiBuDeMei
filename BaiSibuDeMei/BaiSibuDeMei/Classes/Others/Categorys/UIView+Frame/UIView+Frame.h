//
//  UIView+Frame.h
//  18 . 彩票
//
//  Created by czljcb on 15/12/16.
//  Copyright © 2015年 czljcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

/** 分类属性 */
@property(nonatomic,assign) CGFloat centerX;
/** 分类属性 */
@property(nonatomic,assign) CGFloat centerY;
/** 分类属性 */
@property(nonatomic,assign) CGFloat x;
/** 分类属性 */
@property(nonatomic,assign) CGFloat y;
/** 分类属性 */
@property(nonatomic,assign) CGFloat width;
/** 分类属性 */
@property(nonatomic,assign) CGFloat height;
/** 分类属性 */
@property(nonatomic,assign) CGSize  size;

/**
 *  获取左上角横坐标
 *
 *  @return 坐标值
 */
@property(nonatomic,assign) CGFloat left;

/**
 *  获取左上角纵坐标
 *
 *  @return 坐标值
 */
@property(nonatomic,assign) CGFloat top;

/**
 *  获取视图右下角横坐标
 *
 *  @return 坐标值
 */
@property(nonatomic,assign) CGFloat right;

/**
 *  获取视图右下角纵坐标
 *
 *  @return 坐标值
 */
@property(nonatomic,assign) CGFloat bottom;

/**
 *	@brief	删除所有子对象
 */
- (void)removeAllSubviews;

/**
 *  快速修改对象的单个属性值
 *
 *  @param view  要修改的view、imageView、button、...
 *  @param key   要修改的属性，例如：@"x",@"y",@"w",@"h"
 *  @param value 被修改属性的新值
 */
- (void)frameSet:(NSString *)key value:(CGFloat)value;

/**
 *  快速修改对象的多个属性值
 *
 *  @param view   要修改的view、imageView、button、...
 *  @param key1   要修改的属性1，例如：@"x",@"y",@"w",@"h"
 *  @param value1 属性1的新值
 *  @param key2   要修改的属性2，例如：@"x",@"y",@"w",@"h"
 *  @param value2 属性2的新值
 */
- (void)frameSet:(NSString *)key1 value1:(CGFloat)value1 key2:(NSString *)key2 value2:(CGFloat)value2;

/**
 *  从 bundle 加载一个 view
 *
 *  @param className 类名称
 *
 *  @return 返回一个 view
 */
+ (instancetype)viewFromXib;

@end
