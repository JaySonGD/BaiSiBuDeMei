//
//  UITextField+Placeholder.m
//  BaiSibuDeMei
//
//  Created by czljcb on 16/1/22.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import "UITextField+Placeholder.h"

#import <objc/message.h>

@implementation UITextField (Placeholder)




-(void)setPlaceHolderColor:(UIColor *)placeHolderColor
{
    UILabel *placeHolder = [self valueForKeyPath:@"_placeholderLabel"];
    placeHolder.textColor = placeHolderColor;
    
    objc_setAssociatedObject(self, @"placeHolderColor", placeHolderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)placeHolderColor
{
    return  objc_getAssociatedObject(self, @"placeHolderColor");
}


- (void)cz_setPlaceholder:(NSString *)placeholder
{
    [self cz_setPlaceholder:placeholder];
    self.placeHolderColor = self.placeHolderColor;
}


+ (void)load
{
    Method setPlaceholderMethod = class_getInstanceMethod(self, @selector(setPlaceholder:));
    Method cz_setPlaceholder = class_getInstanceMethod(self, @selector(cz_setPlaceholder:));
    
    // 交互方法
    method_exchangeImplementations(setPlaceholderMethod, cz_setPlaceholder);
}

@end
