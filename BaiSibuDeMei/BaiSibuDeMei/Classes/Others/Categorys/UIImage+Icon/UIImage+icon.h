//
//  UIImage+icon.h
//  18 . 彩票
//
//  Created by czljcb on 15/12/16.
//  Copyright © 2015年 czljcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (icon)

/**
 *  生成一张圆形带边框的图片
 *
 *  @param
 */
+ (UIImage *)imageWithBorderW:(CGFloat)borderWH andBorderColor:(UIColor *)color andImageName:(NSString *)imageName;

//+ (UIImage *)iconWithIcon:(NSString *)iconName andSpacing:(float)spacing andColor:(UIColor *)color;

+ (UIImage *)imageWithBorderW:(CGFloat)borderWH andBorderColor:(UIColor *)color andImage:(UIImage *)image
;
@end
