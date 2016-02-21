//
//  UIBarButtonItem+Custom.h
//  BaiSibuDeMei
//
//  Created by czljcb on 16/1/19.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Custom)
+ (instancetype)barButtonTiemWithNormalImage:(UIImage *)normalImage
                            highlightedImage:(UIImage *)highlightedImage
                                   addTarget:(id)target
                                      action:(SEL)action;



+ (instancetype)barButtonTiemWithNormalImage:(UIImage *)normalImage
                               selectedImage:(UIImage *)selectedImage
                                   addTarget:(id)target
                                      action:(SEL)action;

@end
