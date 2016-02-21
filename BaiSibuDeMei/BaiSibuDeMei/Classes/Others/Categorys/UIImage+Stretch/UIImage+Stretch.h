//
//  UIImage+Stretch.h
//  18 . 彩票
//
//  Created by czljcb on 15/12/18.
//  Copyright © 2015年 czljcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Stretch)

/**
 *  生成一张只拉伸中间一点的图片
 *
 *  @param
 */
+ (UIImage *)imageStretchWithImage:(UIImage *)image;

+ (UIImage *)imageStretchWithImage:(UIImage *)image LeftCapWidth:(CGFloat)width topCapHeight:(CGFloat) height;
@end
