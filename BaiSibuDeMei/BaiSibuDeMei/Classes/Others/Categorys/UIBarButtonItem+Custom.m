//
//  UIBarButtonItem+Custom.m
//  BaiSibuDeMei
//
//  Created by czljcb on 16/1/19.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import "UIBarButtonItem+Custom.h"

@implementation UIBarButtonItem (Custom)

+ (instancetype)barButtonTiemWithNormalImage:(UIImage *)normalImage
                            highlightedImage:(UIImage *)highlightedImage
                                   addTarget:(id)target
                                      action:(SEL)action
{
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage: normalImage forState:UIControlStateNormal];
    [leftBtn setImage: highlightedImage forState:UIControlStateHighlighted];
    [leftBtn addTarget:target action:(action) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn sizeToFit];
    UIView *contentView = [[UIView alloc] initWithFrame:leftBtn.bounds];
    [contentView addSubview:leftBtn];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:contentView];
    return barButton;
}


+ (instancetype)barButtonTiemWithNormalImage:(UIImage *)normalImage
                            selectedImage:(UIImage *)selectedImage
                                   addTarget:(id)target
                                      action:(SEL)action
{
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage: normalImage forState:UIControlStateNormal];
    [leftBtn setImage: selectedImage forState:UIControlStateSelected];
    [leftBtn addTarget:target action:(action) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn sizeToFit];
    UIView *contentView = [[UIView alloc] initWithFrame:leftBtn.bounds];
    [contentView addSubview:leftBtn];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:contentView];
    return barButton;
}

@end
