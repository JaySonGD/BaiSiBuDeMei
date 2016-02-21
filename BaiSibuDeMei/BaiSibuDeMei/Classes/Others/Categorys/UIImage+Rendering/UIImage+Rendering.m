//
//  UIImage+Rendering.m
//  18 . 彩票
//
//  Created by czljcb on 15/12/16.
//  Copyright © 2015年 czljcb. All rights reserved.
//

#import "UIImage+Rendering.h"

@implementation UIImage (Rendering)
+ (UIImage *)imageWithRendering:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
@end
