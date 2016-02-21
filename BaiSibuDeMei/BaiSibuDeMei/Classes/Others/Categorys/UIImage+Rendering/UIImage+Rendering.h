//
//  UIImage+Rendering.h
//  18 . 彩票
//
//  Created by czljcb on 15/12/16.
//  Copyright © 2015年 czljcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Rendering)

/**
 *  返回一张不渲染的图片
 *
 *  @param imageName   要修改的imageName
 */
+ (UIImage *)imageWithRendering:(NSString *)imageName;
@end
