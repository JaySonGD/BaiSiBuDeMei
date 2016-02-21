//
//  UIImage+icon.m
//  18 . 彩票
//
//  Created by czljcb on 15/12/16.
//  Copyright © 2015年 czljcb. All rights reserved.
//

#import "UIImage+icon.h"

@implementation UIImage (icon)


+ (UIImage *)imageWithBorderW:(CGFloat)borderWH andBorderColor:(UIColor *)color andImage:(UIImage *)image
{
    
    
    //1.加载图片
    //UIImage *image = [UIImage imageNamed:imageName];
    
    //2.开启一个位图上下文(W = imageW + 2 * border H = imageH + 2 * border)
    CGSize size = CGSizeMake(image.size.width + 2 * borderWH, image.size.height + 2 * borderWH);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    //3.绘制一个圆形的形状.
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    [color set];
    [path fill];
    //4.设置一个小圆,并设置成裁剪区域
    path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderWH, borderWH, image.size.width, image.size.height)];
    //把路径设置成裁剪区域
    [path addClip];
    //5.把图片绘制到上下文当中.
    [image drawAtPoint:CGPointMake(borderWH, borderWH)];
    //6.从上下文当中生成一张图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //7.关闭上下文.
    UIGraphicsEndImageContext();
    
    NSData *data = UIImagePNGRepresentation(newImage);
    
    [data writeToFile:@"/users/czljcb/desktop/cz.png" atomically:YES];
    
    return newImage;
    
}

+ (UIImage *)imageWithBorderW:(CGFloat)borderWH andBorderColor:(UIColor *)color andImageName:(NSString *)imageName
{
    

    //1.加载图片
    UIImage *image = [UIImage imageNamed:imageName];
    
    //2.开启一个位图上下文(W = imageW + 2 * border H = imageH + 2 * border)
    CGSize size = CGSizeMake(image.size.width + 2 * borderWH, image.size.height + 2 * borderWH);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    //3.绘制一个圆形的形状.
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    [color set];
    [path fill];
    //4.设置一个小圆,并设置成裁剪区域
    path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderWH, borderWH, image.size.width, image.size.height)];
    //把路径设置成裁剪区域
    [path addClip];
    //5.把图片绘制到上下文当中.
    [image drawAtPoint:CGPointMake(borderWH, borderWH)];
    //6.从上下文当中生成一张图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //7.关闭上下文.
    UIGraphicsEndImageContext();
    
    NSData *data = UIImagePNGRepresentation(newImage);
    
    [data writeToFile:@"/users/czljcb/desktop/cz.png" atomically:YES];
    
    return newImage;
    
}


+(UIImage *)iconWithIcon:(NSString *)iconName andSpacing:(float)spacing andColor:(UIColor *)color;
{
    UIImage *icon = [UIImage imageNamed:iconName];
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(icon.size.width + spacing, icon.size.height + spacing), NO, 0.0);
    //
    CGContextRef trf = UIGraphicsGetCurrentContext();
    
    CGContextAddEllipseInRect(trf, CGRectMake(0, 0, icon.size.width + spacing, icon.size.height + spacing));
    
    [color set];
    CGContextFillPath(trf);
    
    CGContextAddEllipseInRect(trf, CGRectMake(spacing * 0.5, spacing * 0.5, icon.size.width  , icon.size.height ));
    CGContextClip(trf);
    [icon drawInRect:CGRectMake(spacing * 0.5, spacing * 0.5, icon.size.width  , icon.size.height )];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *data = UIImagePNGRepresentation(image);
    
    [data writeToFile:@"/users/czljcb/desktop/cz.png" atomically:YES];
    
    return image;
}

@end
